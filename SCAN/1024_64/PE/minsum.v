`timescale 1ns / 1ps

module minsum #(parameter WIDTH = 6)(
    input [WIDTH-1:0]a,
    input [WIDTH-1:0]b,
    output [WIDTH-1:0]c
);
    localparam CEIL = {1'b0,{(WIDTH-1){1'b1}}};
	localparam FLOR = {1'b1,{(WIDTH-1){1'b0}}};
    wire [WIDTH-1:0] W_nega, W_negb, W_absa, W_absb, W_absmin;
    wire W_sign;
    assign W_nega = (a==FLOR)?(CEIL):(-a);//-a
    assign W_absa = (a[WIDTH-1])?(W_nega):(a);//|a|
    assign W_negb = (b==FLOR)?(CEIL):(-b);//-b
    assign W_absb = (b[WIDTH-1])?(W_negb):(b);//|b|
    assign W_absmin = (W_absa>W_absb)?(W_absb):(W_absa);
    assign W_sign = a[WIDTH-1] ^ b[WIDTH-1];//sgn(a)*sgn(b)
    assign c = (W_sign)?(-W_absmin):(W_absmin);

endmodule