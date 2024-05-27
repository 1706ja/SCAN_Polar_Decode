/*
layer is from n to 0, where n = log2(N)
for a given layer i, the size of each node is 2^i,
the number of the nodes is 2^(n-i)
*/
module storage #(
    parameter 
    N = 1024,
    P = 64,
    Q =6
) (
    input clk,
    input rst,
    input [12:0] O_bit_count,
    input [10:0] I_Nv, // layer
    input [10:0] I_Nv_next, //next clock
    input [3:0] counter, // count of bits in one operation
    input [3:0] counter_next, //next clock
    input [9:0] address1, // Address
    input [9:0] address1_next, //next clock
    input [3:0] op_type, // operation type
    input [3:0] op_type_next, //next clock
    input [2*P*Q-1:0] PE_data, // data from alg element
    input channel, // channel = 0 -> initialization of top layer lamda
                   // channel = 1 -> PE output
    input [P*Q-1:0] W_channel, // initialization of channel input
    input [4:0] channel_count,
    input channel_ready,
    output [P*Q-1:0] alpha_l, // lamda output
    output [P*Q-1:0] alpha_r,
    output [P*Q-1:0] beta_out_l, // beta output
    output [P*Q-1:0] beta_out_r,
    output o1, // frozen rom output 
    output o2 // frozen rom output
);
    // read is for next clock
    // write is for this clock (now)

    // Function Types
    localparam TYPE1FUN     = 4'b0000; // This is for lamda_i_2*k
    localparam TYPE2FUN     = 4'b0001; // This is for lamda_i_2*k+1
    localparam BOTTOMFUN    = 4'b0010; // This is for beta_i_j, where i > 1
    localparam TYPE3FUN     = 4'b0011; // This is for beta_1_j

    wire [4:0] counter1;
    wire [P*Q-1:0] r_alpha_l, r_alpha_r; // alpha_out
    wire [P*Q-1:0] r_beta_l, r_beta_r, r_beta_t; // beta_out
    wire [4:0] layer_r_a, layer_r_b; // read layer
    wire [4:0] layer_w_a1, layer_w_b, layer_w_a; // write layer
    wire [P*Q-1:0] alpha_in; // write data alpha
    wire [2*P*Q-1:0] beta_in_left, beta_in_right, beta_in_top; // write data beta, left is beta 2, right is beta 1
    wire [12:0] decode_buffer, decode_buffer2;
    wire r_en_a, r_en_t, r_en_b, w_en_a, w_en_b1, w_en_b2, r_en_b2, r;
    wire [8:0] r_address1, w_address1;
    





    wire a1, b1, c1, d1, e1;
    wire a2, b2, c2, d2, e2;
    // r_en_a : read of beta 1 (N/2) * (n-1), from layer 1 to layer n-1
    // r_en_b : read of beta 2  N/2 - 2, from layer 1 to layer n-2
    // r_en_b2 : read of frozen rom that store the address of frozen bits
    // w_en_a : write of alpha
    // w_en_b1 : write of beta 1
    // w_en_b2 : write of beta 2
    // for the top layer of beta : n - 1, even if counter = 1, we still store it in r_en_a

    // here are some precomputations for simplicity in expression
    assign a1 = (op_type==TYPE1FUN);
    assign b1 = (I_Nv==(N/2));
    assign c1 = (op_type==TYPE2FUN);
    assign d1 = (op_type==TYPE3FUN);
    assign e1 = (op_type==BOTTOMFUN);

    assign a2 = (op_type_next==TYPE1FUN);
    assign b2 = (I_Nv_next==N);
    assign c2 = (op_type_next==TYPE2FUN);
    assign d2 = (op_type_next==TYPE3FUN);
    assign e2 = (op_type_next==BOTTOMFUN);
    // thats all

    assign decode_buffer = O_bit_count;
    
    assign r_address1 = (a2||d2) ? address1_next : 0;
    assign w_address1 = (e1||d1) ? address1[9:1] : 0 ;
    
    // set the inputs data for the three rams
    assign alpha_in = channel ? (  (a1) ? (PE_data[P*Q-1:0]) 
    : ( (c1) ? (PE_data[2*P*Q-1:P*Q]) : (0) ))  : W_channel ; // if channel is 0, the input is setted to channel input
    assign beta_in_right = ((d1||e1)&&((address1[0])&&(!b1))) ? PE_data : 0; // already changed! horray!
    assign beta_in_left = ((d1||e1)&&(!address1[0])&&(!b1)) ? PE_data : 0;
    assign beta_in_top = (b1) ? PE_data : 0;
    // read and write enable
    assign r_en_a = (channel)&&((d2)||(a2&&!b2));
    assign r_en_b = (channel)&&((d2)||(c2&&!b2));
    assign r_en_b2 = (channel);
    assign r_en_t = (channel) && (b2); 
    assign w_en_a = ((channel)&&(a1||c1))||(channel_ready);
    assign w_en_b1 = (channel)&&(d1||e1)&&(address1[0])&&(!b1);
    assign w_en_b2 = (channel)&&(!b1)&&(d1||e1)&&(!address1[0]);
    assign w_en_t = (channel) && (d1||e1) && (b1);

    // output
    assign alpha_l = channel ? r_alpha_l : 0;
    assign alpha_r = channel ? r_alpha_r :0;
    assign beta_out_l = r ? r_beta_t : r_beta_l;
    assign beta_out_r = r ? r_beta_t : r_beta_r;
    
    // Generate read and write layers from I_Nv and operation type
//    address address (.u_type_r(op_type_next),.u_type_w(op_type),.layer_r(I_Nv_next),
//                    .layer_w(I_Nv),.r_a(layer_r_a),.w_a(layer_w_a1),.r_b(layer_r_b),.w_b(layer_w_b));
                    
     r_address r_address(.u_type_r(op_type_next), .layer_r(I_Nv_next),
                    .r_a(layer_r_a),.r_b(layer_r_b));
                    
     w_address w_address(.u_type_w(op_type), .layer_w(I_Nv),
                    .w_a(layer_w_a1),.w_b(layer_w_b));

    assign layer_w_a = channel ? layer_w_a1 : 10;
    assign counter1 = channel ? counter : channel_count;
    // ram alpha
    // write layers : 10 to 1, only 10 when channel = 0
    // read layers : 10 to 1, only 1 when operation is bottom
    ram_a #(.P(P),.Q(Q),.N(N)) ram_a (.a_in(alpha_in), .layer_r(layer_r_a), .layer_w(layer_w_a), .r_en(r_en_b2), 
    .cnta(counter1), .cntb(counter_next), .w_en(w_en_a), .clk(clk), .rst(rst), .a_out_left(r_alpha_l), .a_out_right(r_alpha_r));


    // ram beta 1
    // write layers : 9 to 1
    // read layers : 9 to 1
    ram_b1 #(.P(P),.Q(Q),.N(N)) ram_b1 (.b_in(beta_in_right), .layer_r(layer_r_b), .layer_w(layer_w_b), .cnta(counter), 
    .cntb(counter_next), .r_address(r_address1), .w_address(w_address1), .w_en(w_en_b1), .r_en(r_en_a), .clk(clk), 
    .rst(rst), .b_out(r_beta_r));



    // ram beta 2
    // write layers : 8 to 1
    // read layers : 8 to 1
    ram_b #(.P(P),.Q(Q),.N(N)) ram_b (.b_in(beta_in_left), .layer_r(layer_r_b), .layer_w(layer_w_b), .cnta(counter), 
    .cntb(counter_next), .w_en(w_en_b2), .r_en(r_en_b), .clk(clk), .rst(rst), .b_out(r_beta_l));


    ram_btop #(.P(P), .Q(Q), .N(N))   u_ram_btop (
    .b_in                    ( beta_in_top    ),
    .cnta                    ( counter    ),
    .cntb                    ( counter_next   ),
    .w_en                    ( w_en_t    ),
    .r_en                    ( r_en_t    ),
    .clk                     ( clk     ),
    .rst                     ( rst     ),
    .b_out                   ( r_beta_t   ),
    .wn                      (r)
);
    // frozen rom
    frozen_rom frozen_rom (.clk(clk), .in_bit_index(decode_buffer), .en(e2), .frozen1(o1), .frozen2(o2));
endmodule