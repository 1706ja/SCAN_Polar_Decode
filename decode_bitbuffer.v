`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/10/26 11:56:36
// Design Name: 
// Module Name: decode_bits_buffer
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module Decoded_Bits_Buffer#(parameter P=64,parameter Q=6,parameter N=1024)(
    I_hard_bit_out,
    // I_Nv,
    // I_opcode,
    I_output_bits_flag,
    O_output_bits,
    clk,
    rst
    );
        
    input   [1:0]   I_hard_bit_out;
    // input   [10:0]  I_Nv;
    // input   [3:0]   I_opcode;
    input           I_output_bits_flag,clk,rst;
    output  [N-1:0] O_output_bits;
    
    wire [N-1:0] W_x_out;
    reg [N-1:0] R_bits_buffer;

    assign O_output_bits = R_bits_buffer;
    genvar i;
    generate
    for(i=1;i<N/2+1;i=i+1) begin:buffer
            always@(posedge clk) 
        begin
        if (I_output_bits_flag) begin
            

        if (i==N/2) begin
            R_bits_buffer[ 1022 ]<=(I_output_bits_flag?(I_hard_bit_out[0]?1:0):R_bits_buffer[ 1022 ]);
            R_bits_buffer[ 1023 ]<=(I_output_bits_flag?(I_hard_bit_out[1]?1:0):R_bits_buffer[ 1023 ]);
        end
        else begin
            R_bits_buffer[2*i-2] <=(I_output_bits_flag?R_bits_buffer[2*i]:R_bits_buffer[2*i-2]);
            R_bits_buffer[2*i-1] <=(I_output_bits_flag?R_bits_buffer[2*i+1]:R_bits_buffer[2*i-1]);
        end
        end    
        end

    end
    endgenerate
    always @(posedge I_output_bits_flag)
    begin

    end
    
    
    
   
endmodule