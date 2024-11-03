`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/10/26 11:35:37
// Design Name: 
// Module Name: channel_buffer
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


module channel_buffer #(parameter Q = 6,parameter P = 32)
(
input [Q-1:0] channel_LLR,
input channel,
input clk,
input rst,
                    
output [P*Q-1:0] channel_set_LLR,
output buffer_ready,
output [5:0] O_channel_count
);
    
    reg [P*Q-1:0] buffer;
    reg [7:0] counter;
    reg [5:0] channel_count;
    reg flag;
    
    assign O_channel_count = channel_count;
    
    always @(posedge clk) begin
        if(rst) begin
            buffer <= 0; counter<=0; flag <= 0; channel_count <= 0;
        end else begin
            if(buffer_ready) begin
                channel_count <= channel_count + 1;
            end
            if(channel==0) begin
                buffer[P*Q-1:(P-1)*Q] <= channel_LLR;
                buffer[ 4 : 0 ] <= buffer[ 9 : 5 ];
                buffer[ 9 : 5 ] <= buffer[ 14 : 10 ];
                buffer[ 14 : 10 ] <= buffer[ 19 : 15 ];
                buffer[ 19 : 15 ] <= buffer[ 24 : 20 ];
                buffer[ 24 : 20 ] <= buffer[ 29 : 25 ];
                buffer[ 29 : 25 ] <= buffer[ 34 : 30 ];
                buffer[ 34 : 30 ] <= buffer[ 39 : 35 ];
                buffer[ 39 : 35 ] <= buffer[ 44 : 40 ];
                buffer[ 44 : 40 ] <= buffer[ 49 : 45 ];
                buffer[ 49 : 45 ] <= buffer[ 54 : 50 ];
                buffer[ 54 : 50 ] <= buffer[ 59 : 55 ];
                buffer[ 59 : 55 ] <= buffer[ 64 : 60 ];
                buffer[ 64 : 60 ] <= buffer[ 69 : 65 ];
                buffer[ 69 : 65 ] <= buffer[ 74 : 70 ];
                buffer[ 74 : 70 ] <= buffer[ 79 : 75 ];
                buffer[ 79 : 75 ] <= buffer[ 84 : 80 ];
                buffer[ 84 : 80 ] <= buffer[ 89 : 85 ];
                buffer[ 89 : 85 ] <= buffer[ 94 : 90 ];
                buffer[ 94 : 90 ] <= buffer[ 99 : 95 ];
                buffer[ 99 : 95 ] <= buffer[ 104 : 100 ];
                buffer[ 104 : 100 ] <= buffer[ 109 : 105 ];
                buffer[ 109 : 105 ] <= buffer[ 114 : 110 ];
                buffer[ 114 : 110 ] <= buffer[ 119 : 115 ];
                buffer[ 119 : 115 ] <= buffer[ 124 : 120 ];
                buffer[ 124 : 120 ] <= buffer[ 129 : 125 ];
                buffer[ 129 : 125 ] <= buffer[ 134 : 130 ];
                buffer[ 134 : 130 ] <= buffer[ 139 : 135 ];
                buffer[ 139 : 135 ] <= buffer[ 144 : 140 ];
                buffer[ 144 : 140 ] <= buffer[ 149 : 145 ];
                buffer[ 149 : 145 ] <= buffer[ 154 : 150 ];
                buffer[ 154 : 150 ] <= buffer[ 159 : 155 ];


                if(counter<P-1) begin
                    counter <= counter + 1;
                    flag <= 0;
                end else begin
                    counter <= 0;
                    flag <= 1;
                end
            end
        end
    end
    assign channel_set_LLR = buffer;
    assign buffer_ready = flag;
endmodule
