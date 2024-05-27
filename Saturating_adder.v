`timescale 1ns / 1ps

// Saturating Adder
module saturating_adder #(parameter WIDTH = 6)
(
	input  [WIDTH-1:0] a,
	input  [WIDTH-1:0] b,
	output [WIDTH-1:0] out
);

	localparam CEIL = {1'b0,{(WIDTH-1){1'b1}}};
	localparam FLOR = {1'b1,{(WIDTH-1){1'b0}}};
	
	wire [WIDTH-1:0] sum;
	wire e1, e2;
	assign sum = a + b;
	assign e1 = a[WIDTH-1] ^ b[WIDTH-1];
	assign e2 = sum[WIDTH-1] ^ a[WIDTH-1];
	
    
  assign out = (e1)?(sum):((e2)?((b[WIDTH-1])?(FLOR):(CEIL)):(sum));
		
endmodule 
