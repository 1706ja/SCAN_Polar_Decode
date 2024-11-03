// N : Codelength, P: Parallelism, Q : Quantization bit-width
module SCAN2 #(
    parameter N = 1024,
    P = 32,
    Q = 6
) (
    input clk,
    input rst,
    input channel, // 1 : decoding, 0 : reading LLR inputs
    input [Q-1:0] in_LLR,
    output [N-1:0] decoded_bits
);
    reg [15:0] R_program_counter; // starts at -2, +1 for each clk while channel = 1

    // Control Signals: W_xxx : this clk, before : 1 clk before, delay : 1 clk after , next : 2 clks after
    wire [3:0] W_opcode,W_opcode_before,W_opcode_next, W_opcode_delay; // operation type
    wire [10:0] W_Nv,W_Nv_before,W_Nv_next; // operation layer, one hot code
    wire [6:0] W_channel_count;// address for reading LLR inputs
    wire [12:0] W_bit_count; // how many bits have been decoded
    // This two parts are quite tricky
    wire [5:0] W_part_count, W_part_count_next; //
    wire [9:0] W_address, W_address_next, W_address_before;
    
    wire [P*Q-1:0] W_channel_soft;

    wire W_channel_buffer_ready,W_bit_output_flag;    // Ready
    wire frozen1, frozen2;// input of frozen rom

    wire [2*P*Q-1:0] W_PE_data_out, W_PE_data_out_before, W_alpha, W_a_o; // outputs
    wire [P*Q-1:0] W_beta_l,W_beta_r,W_beta_l_out,W_beta_r_out, W_a_l,W_a_r, W_a_l_o, W_a_r_o;
    wire [P*Q-1:0] W_PE_result_soft;

    wire  [Q-1:0]W_hard_bit_out_1,W_hard_bit_out_2;

    always @(posedge clk)
    begin
        if(rst||!channel)
        begin
            R_program_counter <= -2;
        end
        else
        begin    
            R_program_counter <= R_program_counter + 1;
        end
    end
    // operation types
    localparam TYPE1     = 4'b0000; // alpha
    localparam TYPE2     = 4'b0001; // alpha
    localparam BOTTOM    = 4'b0010; // beta (only leaf nodes)
    localparam TYPE3     = 4'b0011; // beta
    localparam IDLE      = 4'b1011; // I do not understand why there is such a thing, 
                                    // but without it, the whole module collapse
    
    assign W_bit_output_flag = (W_opcode == BOTTOM); // When a leaf node is encountered, we read into decode_bits buffer


    // For channel LLR input
    channel_buffer #(.P(P),.Q(Q)) buffer (.channel_LLR(in_LLR), .channel(channel), .clk(clk), .rst(rst)
    , .channel_set_LLR(W_channel_soft), .buffer_ready(W_channel_buffer_ready), .O_channel_count(W_channel_count));

    // control unit
    opcode #(.P(P)) control   (.I_program_counter(R_program_counter), .clk(clk), .rst(rst), .O_Nv(W_Nv), .O_Nv_before(W_Nv_before), .O_opcode_delay(W_opcode_delay),
    .O_Nv_next(W_Nv_next), .O_address(W_address), .O_address_next(W_address_next), .channel(channel),
    .O_part_count(W_part_count), .O_part_count_next(W_part_count_next),
    .O_opcode(W_opcode), .O_opcode_before(W_opcode_before), .O_opcode_next(W_opcode_next),.O_bit_count(W_bit_count));

    // This is for adding bypass
    choose #(.P(P), .Q(Q)) cho (.rst(rst), .a_l(W_a_l_o), .a_r(W_a_r_o), .b_l(W_beta_l_out), .b_r(W_beta_r_out), .pe_o(W_PE_data_out), .pe_o_before(W_PE_data_out_before)
    , .I_Nv(W_Nv), .channel_cnt(W_part_count), .opcode(W_opcode), .opcode_before(W_opcode_before), .opcode_delay(W_opcode_delay), .a_l_o(W_a_l), .a_r_o(W_a_r), .b_l_o(W_beta_l), .b_r_o(W_beta_r));

    // Processing unit
    PE #(.P(P), .Q(Q)) ALU(.clk(clk), .rst(rst), .a_l(W_a_l), .a_r(W_a_r), .b_l(W_beta_l), .b_r(W_beta_r), .op_type(W_opcode_delay), 
    .type1(frozen1), .type2(frozen2), .o(W_PE_data_out), .o_before(W_PE_data_out_before), .u_type1(W_hard_bit_out_1), .u_type2(W_hard_bit_out_2)) ;

    // Storage. Consist of 4 main blocks:
    // ram_a : Ram for alpha, (N-2) * Q bits
    // ram_b : Ram for beta_left, (N/2-2) * Q bits
    // ram_b1 : Ram for beta_right, (Nn/2) * Q bits
    // frozen_rom : Where are the frozen bits?
    storage #(.P(P), .Q(Q), .N(N)) storage(.clk(clk), .rst(rst), .I_Nv(W_Nv), .I_Nv_next(W_Nv_next), .counter(W_part_count),
    .counter_next(W_part_count_next), .address1(W_address), .address1_next(W_address_next), .op_type(W_opcode), .op_type_next(W_opcode_next), 
    .PE_data(W_PE_data_out), .channel(channel), .W_channel(W_channel_soft), .channel_count(W_channel_count), .O_bit_count(W_bit_count),
    .alpha_l(W_a_l_o), .alpha_r(W_a_r_o), .beta_out_l(W_beta_l_out), .beta_out_r(W_beta_r_out), .o1(frozen1), .o2(frozen2), .channel_ready(W_channel_buffer_ready));

    Decoded_Bits_Buffer #(.P(P),.Q(Q),.N(N)) dbb(.I_hard_bit_out({W_hard_bit_out_2[Q-1],W_hard_bit_out_1[Q-1]}),
   .I_output_bits_flag(W_bit_output_flag),
   .O_output_bits(decoded_bits),.clk(clk),.rst(rst));
endmodule