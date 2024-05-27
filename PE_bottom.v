`timescale 1ns / 1ps

module PE_bottom #(parameter WIDTH = 6)(
    input [WIDTH-1:0]L_1_0,
    input [WIDTH-1:0]L_1_1,
    input [WIDTH-1:0]R_0_0,
    input [WIDTH-1:0]R_0_1,
    output [WIDTH-1:0]L_0_0,
    output [WIDTH-1:0]L_0_1,
    output [WIDTH-1:0]R_1_0,
    output [WIDTH-1:0]R_1_1
);

    f1 #(.WIDTH(WIDTH)) f00(.a(L_1_0),.b(L_1_1),.c(R_0_1),.d(L_0_0));
    f2 #(.WIDTH(WIDTH)) f01(.a(L_1_0),.b(R_0_0),.c(L_1_1),.d(L_0_1));
    f1 #(.WIDTH(WIDTH)) f10(.a(R_0_0),.b(R_0_1),.c(L_1_1),.d(R_1_0));
    f2 #(.WIDTH(WIDTH)) f11(.a(R_0_0),.b(L_1_0),.c(R_0_1),.d(R_1_1));

endmodule