// d = min(a, b + c)
`timescale 1ns / 1ps

module f1 #(parameter WIDTH = 6)(
    input [WIDTH-1:0]a,
    input [WIDTH-1:0]b,
    input [WIDTH-1:0]c,
    output [WIDTH-1:0]d
);

    localparam CEIL = {1'b0,{(WIDTH-1){1'b1}}};
	localparam FLOR = {1'b1,{(WIDTH-1){1'b0}}};
    wire [WIDTH-1:0] W_bcsum;

    saturating_adder #(.WIDTH(WIDTH)) add(.a(b),.b(c),.out(W_bcsum)); //sum
    minsum #(.WIDTH(WIDTH)) f(.a(a),.b(W_bcsum),.c(d)); //min
endmodule