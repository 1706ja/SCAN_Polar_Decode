//data is stored in lower bits
module ram_a #(
    parameter
    Q = 6,
    P = 128,
    N = 1024
) (
    input [P*Q-1:0] a_in, // input data
    input [4:0] layer_r, // read layer
    input [4:0] layer_w, // write layer
    input [5:0] cnta, // write count
    input [4:0] cntb, //read count
    input w_en, //write enable
    input r_en,
    input clk,
    input rst,
    output [P*Q-1:0] a_out_left, // alpha out left
    output [P*Q-1:0] a_out_right // alpha out right
);

    //10 layer registers for read and write
    reg [N*Q-1:0] a_10; // 1024
    reg [N*Q/2-1:0] a_9; // 512
    reg [N*Q/4-1:0] a_8; // 256
    reg [N*Q/8-1:0] a_7; // 128
    reg [N*Q/16-1:0] a_6; // 64
    reg [32*Q-1:0] a_5; // 32
    reg [16*Q-1:0] a_4; // 16
    reg [8*Q-1:0] a_3; // 8
    reg [4*Q-1:0] a_2; // 4
    reg [2*Q-1:0] a_1; // 2
    reg [P*Q-1:0] r_right, r_left;
    wire [4:0] addr_r, addr_w;

      assign addr_r = cntb + 1;
    assign addr_w = cnta + 1;

    assign a_out_left = r_left;
    assign a_out_right = r_right;

    always @ (posedge clk) begin
        if (rst) begin
            a_10 <= 0;
            a_9 <= 0;
            a_8 <= 0;
            a_7 <= 0;
            a_6 <= 0;
            a_5 <= 0;
            a_4 <= 0;
            a_3 <= 0;
            a_2 <= 0;
            a_1 <= 0;
            r_left <= 0;
            r_right <= 0;
        end
        else begin
            // write
            if (w_en) begin
                case (layer_w) 
10 : begin
a_10[addr_w*P*Q-28*Q-1-:4*Q] <= a_in[4*Q-1-:4*Q];
a_10[addr_w*P*Q-24*Q-1-:4*Q] <= a_in[8*Q-1-:4*Q];
a_10[addr_w*P*Q-20*Q-1-:4*Q] <= a_in[12*Q-1-:4*Q];
a_10[addr_w*P*Q-16*Q-1-:4*Q] <= a_in[16*Q-1-:4*Q];
a_10[addr_w*P*Q-12*Q-1-:4*Q] <= a_in[20*Q-1-:4*Q];
a_10[addr_w*P*Q-8*Q-1-:4*Q] <= a_in[24*Q-1-:4*Q];
a_10[addr_w*P*Q-4*Q-1-:4*Q] <= a_in[28*Q-1-:4*Q];
a_10[addr_w*P*Q-0*Q-1-:4*Q] <= a_in[32*Q-1-:4*Q];
end
9 : begin
a_9[addr_w*P*Q-28*Q-1-:4*Q] <= a_in[4*Q-1-:4*Q];
a_9[addr_w*P*Q-24*Q-1-:4*Q] <= a_in[8*Q-1-:4*Q];
a_9[addr_w*P*Q-20*Q-1-:4*Q] <= a_in[12*Q-1-:4*Q];
a_9[addr_w*P*Q-16*Q-1-:4*Q] <= a_in[16*Q-1-:4*Q];
a_9[addr_w*P*Q-12*Q-1-:4*Q] <= a_in[20*Q-1-:4*Q];
a_9[addr_w*P*Q-8*Q-1-:4*Q] <= a_in[24*Q-1-:4*Q];
a_9[addr_w*P*Q-4*Q-1-:4*Q] <= a_in[28*Q-1-:4*Q];
a_9[addr_w*P*Q-0*Q-1-:4*Q] <= a_in[32*Q-1-:4*Q];
end
8 : begin
a_8[addr_w*P*Q-28*Q-1-:4*Q] <= a_in[4*Q-1-:4*Q];
a_8[addr_w*P*Q-24*Q-1-:4*Q] <= a_in[8*Q-1-:4*Q];
a_8[addr_w*P*Q-20*Q-1-:4*Q] <= a_in[12*Q-1-:4*Q];
a_8[addr_w*P*Q-16*Q-1-:4*Q] <= a_in[16*Q-1-:4*Q];
a_8[addr_w*P*Q-12*Q-1-:4*Q] <= a_in[20*Q-1-:4*Q];
a_8[addr_w*P*Q-8*Q-1-:4*Q] <= a_in[24*Q-1-:4*Q];
a_8[addr_w*P*Q-4*Q-1-:4*Q] <= a_in[28*Q-1-:4*Q];
a_8[addr_w*P*Q-0*Q-1-:4*Q] <= a_in[32*Q-1-:4*Q];
end
7 : begin
a_7[addr_w*P*Q-28*Q-1-:4*Q] <= a_in[4*Q-1-:4*Q];
a_7[addr_w*P*Q-24*Q-1-:4*Q] <= a_in[8*Q-1-:4*Q];
a_7[addr_w*P*Q-20*Q-1-:4*Q] <= a_in[12*Q-1-:4*Q];
a_7[addr_w*P*Q-16*Q-1-:4*Q] <= a_in[16*Q-1-:4*Q];
a_7[addr_w*P*Q-12*Q-1-:4*Q] <= a_in[20*Q-1-:4*Q];
a_7[addr_w*P*Q-8*Q-1-:4*Q] <= a_in[24*Q-1-:4*Q];
a_7[addr_w*P*Q-4*Q-1-:4*Q] <= a_in[28*Q-1-:4*Q];
a_7[addr_w*P*Q-0*Q-1-:4*Q] <= a_in[32*Q-1-:4*Q];
end
6 : begin
a_6[addr_w*P*Q-28*Q-1-:4*Q] <= a_in[4*Q-1-:4*Q];
a_6[addr_w*P*Q-24*Q-1-:4*Q] <= a_in[8*Q-1-:4*Q];
a_6[addr_w*P*Q-20*Q-1-:4*Q] <= a_in[12*Q-1-:4*Q];
a_6[addr_w*P*Q-16*Q-1-:4*Q] <= a_in[16*Q-1-:4*Q];
a_6[addr_w*P*Q-12*Q-1-:4*Q] <= a_in[20*Q-1-:4*Q];
a_6[addr_w*P*Q-8*Q-1-:4*Q] <= a_in[24*Q-1-:4*Q];
a_6[addr_w*P*Q-4*Q-1-:4*Q] <= a_in[28*Q-1-:4*Q];
a_6[addr_w*P*Q-0*Q-1-:4*Q] <= a_in[32*Q-1-:4*Q];
end
5 : begin
a_5[4*Q-1-:4*Q] <= a_in[4*Q-1-:4*Q];
a_5[8*Q-1-:4*Q] <= a_in[8*Q-1-:4*Q];
a_5[12*Q-1-:4*Q] <= a_in[12*Q-1-:4*Q];
a_5[16*Q-1-:4*Q] <= a_in[16*Q-1-:4*Q];
a_5[20*Q-1-:4*Q] <= a_in[20*Q-1-:4*Q];
a_5[24*Q-1-:4*Q] <= a_in[24*Q-1-:4*Q];
a_5[28*Q-1-:4*Q] <= a_in[28*Q-1-:4*Q];
a_5[32*Q-1-:4*Q] <= a_in[32*Q-1-:4*Q];
end
4 : begin
a_4[4*Q-1-:4*Q] <= a_in[4*Q-1-:4*Q];
a_4[8*Q-1-:4*Q] <= a_in[8*Q-1-:4*Q];
a_4[12*Q-1-:4*Q] <= a_in[12*Q-1-:4*Q];
a_4[16*Q-1-:4*Q] <= a_in[16*Q-1-:4*Q];
end
3 : begin
a_3[4*Q-1-:4*Q] <= a_in[4*Q-1-:4*Q];
a_3[8*Q-1-:4*Q] <= a_in[8*Q-1-:4*Q];
end
2 : begin
a_2<= a_in[4*Q-1:0];
end
1 : begin
a_1<= a_in[2*Q-1:0];
end
endcase       
            end      
            
            if(r_en) begin
                 // read  
            case (layer_r)
10 : begin
r_left[4*Q-1-:4*Q] <= a_10[addr_r*P*Q-28*Q-1-:4*Q];
r_right[4*Q-1-:4*Q] <= a_10[512*Q + (addr_r+1)*P*Q-28*Q-1-:4*Q];
r_left[8*Q-1-:4*Q] <= a_10[addr_r*P*Q-24*Q-1-:4*Q];
r_right[8*Q-1-:4*Q] <= a_10[512*Q + (addr_r+1)*P*Q-24*Q-1-:4*Q];
r_left[12*Q-1-:4*Q] <= a_10[addr_r*P*Q-20*Q-1-:4*Q];
r_right[12*Q-1-:4*Q] <= a_10[512*Q + (addr_r+1)*P*Q-20*Q-1-:4*Q];
r_left[16*Q-1-:4*Q] <= a_10[addr_r*P*Q-16*Q-1-:4*Q];
r_right[16*Q-1-:4*Q] <= a_10[512*Q + (addr_r+1)*P*Q-16*Q-1-:4*Q];
r_left[20*Q-1-:4*Q] <= a_10[addr_r*P*Q-12*Q-1-:4*Q];
r_right[20*Q-1-:4*Q] <= a_10[512*Q + (addr_r+1)*P*Q-12*Q-1-:4*Q];
r_left[24*Q-1-:4*Q] <= a_10[addr_r*P*Q-8*Q-1-:4*Q];
r_right[24*Q-1-:4*Q] <= a_10[512*Q + (addr_r+1)*P*Q-8*Q-1-:4*Q];
r_left[28*Q-1-:4*Q] <= a_10[addr_r*P*Q-4*Q-1-:4*Q];
r_right[28*Q-1-:4*Q] <= a_10[512*Q + (addr_r+1)*P*Q-4*Q-1-:4*Q];
r_left[32*Q-1-:4*Q] <= a_10[addr_r*P*Q-0*Q-1-:4*Q];
r_right[32*Q-1-:4*Q] <= a_10[512*Q + (addr_r+1)*P*Q-0*Q-1-:4*Q];
end
9 : begin
r_left[4*Q-1-:4*Q] <= a_9[addr_r*P*Q-28*Q-1-:4*Q];
r_right[4*Q-1-:4*Q] <= a_9[256*Q + (addr_r+1)*P*Q-28*Q-1-:4*Q];
r_left[8*Q-1-:4*Q] <= a_9[addr_r*P*Q-24*Q-1-:4*Q];
r_right[8*Q-1-:4*Q] <= a_9[256*Q + (addr_r+1)*P*Q-24*Q-1-:4*Q];
r_left[12*Q-1-:4*Q] <= a_9[addr_r*P*Q-20*Q-1-:4*Q];
r_right[12*Q-1-:4*Q] <= a_9[256*Q + (addr_r+1)*P*Q-20*Q-1-:4*Q];
r_left[16*Q-1-:4*Q] <= a_9[addr_r*P*Q-16*Q-1-:4*Q];
r_right[16*Q-1-:4*Q] <= a_9[256*Q + (addr_r+1)*P*Q-16*Q-1-:4*Q];
r_left[20*Q-1-:4*Q] <= a_9[addr_r*P*Q-12*Q-1-:4*Q];
r_right[20*Q-1-:4*Q] <= a_9[256*Q + (addr_r+1)*P*Q-12*Q-1-:4*Q];
r_left[24*Q-1-:4*Q] <= a_9[addr_r*P*Q-8*Q-1-:4*Q];
r_right[24*Q-1-:4*Q] <= a_9[256*Q + (addr_r+1)*P*Q-8*Q-1-:4*Q];
r_left[28*Q-1-:4*Q] <= a_9[addr_r*P*Q-4*Q-1-:4*Q];
r_right[28*Q-1-:4*Q] <= a_9[256*Q + (addr_r+1)*P*Q-4*Q-1-:4*Q];
r_left[32*Q-1-:4*Q] <= a_9[addr_r*P*Q-0*Q-1-:4*Q];
r_right[32*Q-1-:4*Q] <= a_9[256*Q + (addr_r+1)*P*Q-0*Q-1-:4*Q];
end
8 : begin
r_left[4*Q-1-:4*Q] <= a_8[addr_r*P*Q-28*Q-1-:4*Q];
r_right[4*Q-1-:4*Q] <= a_8[128*Q + (addr_r+1)*P*Q-28*Q-1-:4*Q];
r_left[8*Q-1-:4*Q] <= a_8[addr_r*P*Q-24*Q-1-:4*Q];
r_right[8*Q-1-:4*Q] <= a_8[128*Q + (addr_r+1)*P*Q-24*Q-1-:4*Q];
r_left[12*Q-1-:4*Q] <= a_8[addr_r*P*Q-20*Q-1-:4*Q];
r_right[12*Q-1-:4*Q] <= a_8[128*Q + (addr_r+1)*P*Q-20*Q-1-:4*Q];
r_left[16*Q-1-:4*Q] <= a_8[addr_r*P*Q-16*Q-1-:4*Q];
r_right[16*Q-1-:4*Q] <= a_8[128*Q + (addr_r+1)*P*Q-16*Q-1-:4*Q];
r_left[20*Q-1-:4*Q] <= a_8[addr_r*P*Q-12*Q-1-:4*Q];
r_right[20*Q-1-:4*Q] <= a_8[128*Q + (addr_r+1)*P*Q-12*Q-1-:4*Q];
r_left[24*Q-1-:4*Q] <= a_8[addr_r*P*Q-8*Q-1-:4*Q];
r_right[24*Q-1-:4*Q] <= a_8[128*Q + (addr_r+1)*P*Q-8*Q-1-:4*Q];
r_left[28*Q-1-:4*Q] <= a_8[addr_r*P*Q-4*Q-1-:4*Q];
r_right[28*Q-1-:4*Q] <= a_8[128*Q + (addr_r+1)*P*Q-4*Q-1-:4*Q];
r_left[32*Q-1-:4*Q] <= a_8[addr_r*P*Q-0*Q-1-:4*Q];
r_right[32*Q-1-:4*Q] <= a_8[128*Q + (addr_r+1)*P*Q-0*Q-1-:4*Q];
end
7 : begin
r_left[4*Q-1-:4*Q] <= a_7[addr_r*P*Q-28*Q-1-:4*Q];
r_right[4*Q-1-:4*Q] <= a_7[64*Q + (addr_r+1)*P*Q-28*Q-1-:4*Q];
r_left[8*Q-1-:4*Q] <= a_7[addr_r*P*Q-24*Q-1-:4*Q];
r_right[8*Q-1-:4*Q] <= a_7[64*Q + (addr_r+1)*P*Q-24*Q-1-:4*Q];
r_left[12*Q-1-:4*Q] <= a_7[addr_r*P*Q-20*Q-1-:4*Q];
r_right[12*Q-1-:4*Q] <= a_7[64*Q + (addr_r+1)*P*Q-20*Q-1-:4*Q];
r_left[16*Q-1-:4*Q] <= a_7[addr_r*P*Q-16*Q-1-:4*Q];
r_right[16*Q-1-:4*Q] <= a_7[64*Q + (addr_r+1)*P*Q-16*Q-1-:4*Q];
r_left[20*Q-1-:4*Q] <= a_7[addr_r*P*Q-12*Q-1-:4*Q];
r_right[20*Q-1-:4*Q] <= a_7[64*Q + (addr_r+1)*P*Q-12*Q-1-:4*Q];
r_left[24*Q-1-:4*Q] <= a_7[addr_r*P*Q-8*Q-1-:4*Q];
r_right[24*Q-1-:4*Q] <= a_7[64*Q + (addr_r+1)*P*Q-8*Q-1-:4*Q];
r_left[28*Q-1-:4*Q] <= a_7[addr_r*P*Q-4*Q-1-:4*Q];
r_right[28*Q-1-:4*Q] <= a_7[64*Q + (addr_r+1)*P*Q-4*Q-1-:4*Q];
r_left[32*Q-1-:4*Q] <= a_7[addr_r*P*Q-0*Q-1-:4*Q];
r_right[32*Q-1-:4*Q] <= a_7[64*Q + (addr_r+1)*P*Q-0*Q-1-:4*Q];
end
6 : begin
r_left[4*Q-1-:4*Q] <= a_6[4*Q-1-:4*Q];
r_right[4*Q-1-:4*Q] <= a_6[36*Q-1-:4*Q];
r_left[8*Q-1-:4*Q] <= a_6[8*Q-1-:4*Q];
r_right[8*Q-1-:4*Q] <= a_6[40*Q-1-:4*Q];
r_left[12*Q-1-:4*Q] <= a_6[12*Q-1-:4*Q];
r_right[12*Q-1-:4*Q] <= a_6[44*Q-1-:4*Q];
r_left[16*Q-1-:4*Q] <= a_6[16*Q-1-:4*Q];
r_right[16*Q-1-:4*Q] <= a_6[48*Q-1-:4*Q];
r_left[20*Q-1-:4*Q] <= a_6[20*Q-1-:4*Q];
r_right[20*Q-1-:4*Q] <= a_6[52*Q-1-:4*Q];
r_left[24*Q-1-:4*Q] <= a_6[24*Q-1-:4*Q];
r_right[24*Q-1-:4*Q] <= a_6[56*Q-1-:4*Q];
r_left[28*Q-1-:4*Q] <= a_6[28*Q-1-:4*Q];
r_right[28*Q-1-:4*Q] <= a_6[60*Q-1-:4*Q];
r_left[32*Q-1-:4*Q] <= a_6[32*Q-1-:4*Q];
r_right[32*Q-1-:4*Q] <= a_6[64*Q-1-:4*Q];
end
5 : begin
r_left[4*Q-1-:4*Q] <= a_5[4*Q-1-:4*Q];
r_right[4*Q-1-:4*Q] <= a_5[20*Q-1-:4*Q];
r_left[8*Q-1-:4*Q] <= a_5[8*Q-1-:4*Q];
r_right[8*Q-1-:4*Q] <= a_5[24*Q-1-:4*Q];
r_left[12*Q-1-:4*Q] <= a_5[12*Q-1-:4*Q];
r_right[12*Q-1-:4*Q] <= a_5[28*Q-1-:4*Q];
r_left[16*Q-1-:4*Q] <= a_5[16*Q-1-:4*Q];
r_right[16*Q-1-:4*Q] <= a_5[32*Q-1-:4*Q];
r_left[32*Q-1:16*Q] <= 0;
r_left[32*Q-1:16*Q] <= 0;
end
4 : begin
r_left[4*Q-1-:4*Q] <= a_4[4*Q-1-:4*Q];
r_right[4*Q-1-:4*Q] <= a_4[12*Q-1-:4*Q];
r_left[8*Q-1-:4*Q] <= a_4[8*Q-1-:4*Q];
r_right[8*Q-1-:4*Q] <= a_4[16*Q-1-:4*Q];
r_left[32*Q-1:8*Q] <= 0;
r_left[32*Q-1:8*Q] <= 0;
end
3 : begin
r_left[4*Q-1:0] <= a_3;
r_right[4*Q-1:0] <= a_3;
r_left[32*Q-1:4*Q] <= 0;
r_right[32*Q-1:4*Q] <= 0;
end
2 : begin
r_left[2*Q-1:0] <= a_2;
r_right[2*Q-1:0] <= a_2;
r_left[32*Q-1:2*Q] <= 0;
r_right[32*Q-1:2*Q] <= 0;
end
1 : begin
r_left[1*Q-1:0] <= a_1;
r_right[1*Q-1:0] <= a_1;
r_left[32*Q-1:1*Q] <= 0;
r_right[32*Q-1:1*Q] <= 0;
end
default: begin
            r_left <= 0;
            r_right <= 0;
        end
           endcase
            end
           else begin
                  r_left <= 0;
                  r_right <= 0;
           end
         end
    end

    
endmodule

