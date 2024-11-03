module PE #(
    parameter
    P = 128,
    Q = 6
) (
    input [P*Q-1:0] a_l,
    input [P*Q-1:0] a_r,
    input [P*Q-1:0] b_l, // beta_left
    input [P*Q-1:0] b_r, //beta_right
    input type1,
    input type2,
    input [3:0] op_type, // operation type
    input clk,
    input rst,
    output [2*P*Q-1:0] o, // output
    output [2*P*Q-1:0] o_before,
    output [Q-1:0]u_type1, // output of layer 0 of lamda (llr_l)
    output [Q-1:0]u_type2 // output of layer 0 of lamda (llr_l)
);
    localparam TYPE1FUN     = 4'b0000;
    localparam TYPE2FUN     = 4'b0001;
    localparam BOTTOMFUN    = 4'b0010;
    localparam TYPE3FUN     = 4'b0011;
    localparam CEIL = {1'b0,{(Q-1){1'b1}}};


    wire w, w1, w2; //enable

    wire [2*Q-1:0] bottom; // bottom result
    wire [P*Q-1:0] a,b,c,d; // input of PE
    reg [2*P*Q-1:0] out, out_before; // output
    wire [Q-1:0] a1,b1,c1,d1; // io of bottom
    wire [Q-1:0] e1,f1,g1,h1;// io of bottom
    reg [Q-1:0] t1, t2;
    wire [2*P*Q-1:0] out1;


    assign o_before = out_before;

    assign w2 = (op_type==TYPE2FUN||op_type==TYPE3FUN);
    assign w1 = (op_type==TYPE1FUN||op_type==TYPE3FUN);
    assign w = (op_type == BOTTOMFUN);



            /* 
        Type 1: out = min(a_l, (a_r + b_r))
        Type 2: out = min(a_l, b_l) + a_r
        Type 3_1: out = min(b_l, (a_r + b_r)) 
        Type 3_2: out = min(a_l, b_l) + b_r    
        */
        /*
        What we did:
        min(a, b + c) 
        min(a, d) + b
        */
    assign a = w ? 0 : ((op_type==TYPE1FUN) ? (a_l) : (b_l));
    assign b = w ? 0 : ((op_type==TYPE3FUN) ? (b_r) : (a_r));
    assign c = w ? 0 : ((op_type==TYPE3FUN) ? (a_r) : (b_r));
    assign d = w ? 0 : a_l;
    assign a1 = w ? a_l[Q-1:0] : 0;
    assign b1 = w ? a_r[Q-1:0] :0;
    assign c1 = w ? (type1 ? 0 : CEIL) : 0;
    assign d1 = w ? (type2 ? 0 : CEIL) : 0;



    always @ (posedge clk) begin
        if (rst) begin
            out <= 0;
            out_before <= 0;
            t1 <= 0;
            t2 <= 0;
        end
        else begin
            out[2*Q-1:0] <= (op_type==BOTTOMFUN)? bottom : out1[2*Q-1:0];
            out[2*P*Q-1:2*Q] <= (op_type==BOTTOMFUN)? 0 : out1[2*P*Q-1:2*Q];
            out_before <= out;
            t1 <= e1;
            t2 <= f1;
        end
    end
    assign o =  out;
    assign u_type1 = t1; // lamda bottom
    assign u_type2 = t2; // lamda bottom
    assign bottom[Q-1:0] = g1;
    assign bottom[2*Q-1:Q] = h1;
    PE_cal #(.WIDTH(Q),.P(P)) PE_cal (.a(a),.b(b),.c(c),.d(d),.w1(w1),.w2(w2),.out(out1));
    PE_bottom #(.WIDTH(Q)) PE_bottom(.L_0_0(e1),.L_0_1(f1),.L_1_0(a1),.L_1_1(b1),.R_0_0(c1),.R_0_1(d1),.R_1_0(g1),.R_1_1(h1));


endmodule