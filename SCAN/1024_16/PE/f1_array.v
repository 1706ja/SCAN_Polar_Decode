`timescale 1ns / 1ps

module f1_array #(parameter Q = 10, P = 64)(
    input [P*Q-1:0]a,
    input [P*Q-1:0]b,
    input [P*Q-1:0]c,
    input enable,
    output [P*Q-1:0]d
);

    localparam CEIL = {1'b0,{(Q-1){1'b1}}};
	localparam FLOR = {1'b1,{(Q-1){1'b0}}};
    wire [P*Q-1:0]W_bcsum;
    assign d = enable ? W_bcsum : 0; // If enable -> we do pe, else : bypass 0
    genvar i;
    generate
        for (i = 0; i<P ; i=i+1 ) begin: f1_array
            f1 #(.WIDTH(Q)) f1(.a(a[(i+1)*Q-1:i*Q]),.b(b[(i+1)*Q-1:i*Q]),.c(c[(i+1)*Q-1:i*Q]),.d(W_bcsum[(i+1)*Q-1:i*Q])); // d = min(a, b + c)
        end
    endgenerate


endmodule