//data is stored in lower bits
module ram_b #(
    parameter
    Q = 6,
    P = 32,
    N = 1024
) (
    input [2*P*Q-1:0] b_in, // input data
    input [4:0] layer_r, // read layers
    input [4:0] layer_w, // write layer
    input [4:0] cnta, // write count
    input [4:0] cntb, //read count
    input w_en, //write enable
    input r_en, //read enable
    input clk,
    input rst,
    output [P*Q-1:0] b_out
);

    //10 layer registers for read and write
    reg [N*Q/4-1:0] b_8; // 256
    reg [N*Q/8-1:0] b_7; // 128
    reg [N*Q/16-1:0] b_6; // 64
    reg [32*Q-1:0] b_5; // 32
    reg [16*Q-1:0] b_4; // 16
    reg [8*Q-1:0] b_3; // 8
    reg [4*Q-1:0] b_2; // 4
    reg [2*Q-1:0] b_1; // 2
    reg [P*Q-1:0] r;

    assign b_out = r;
    wire [3:0] addr_r, addr_w;
    assign addr_r = cntb + 1;
    assign addr_w = cnta + 1;
    always @ (posedge clk) begin
        if (rst) begin
            b_8 <= 0;
            b_7 <= 0;
            b_6 <= 0;
            b_5 <= 0;
            b_4 <= 0;
            b_3 <= 0;
            b_2 <= 0;
            b_1 <= 0;
            r <= 0;
        end
        
        
        //data write
        else begin
            // write
            if (w_en) begin
                case (layer_w) 
8 : begin
b_8[addr_w*P*Q-28*Q-1-:4*Q] <= b_in[4*Q-1-:4*Q];
b_8[128*Q+addr_w*P*Q-28*Q-1-:4*Q] <= b_in[P*Q+4*Q-1-:4*Q];
b_8[addr_w*P*Q-24*Q-1-:4*Q] <= b_in[8*Q-1-:4*Q];
b_8[128*Q+addr_w*P*Q-24*Q-1-:4*Q] <= b_in[P*Q+8*Q-1-:4*Q];
b_8[addr_w*P*Q-20*Q-1-:4*Q] <= b_in[12*Q-1-:4*Q];
b_8[128*Q+addr_w*P*Q-20*Q-1-:4*Q] <= b_in[P*Q+12*Q-1-:4*Q];
b_8[addr_w*P*Q-16*Q-1-:4*Q] <= b_in[16*Q-1-:4*Q];
b_8[128*Q+addr_w*P*Q-16*Q-1-:4*Q] <= b_in[P*Q+16*Q-1-:4*Q];
b_8[addr_w*P*Q-12*Q-1-:4*Q] <= b_in[20*Q-1-:4*Q];
b_8[128*Q+addr_w*P*Q-12*Q-1-:4*Q] <= b_in[P*Q+20*Q-1-:4*Q];
b_8[addr_w*P*Q-8*Q-1-:4*Q] <= b_in[24*Q-1-:4*Q];
b_8[128*Q+addr_w*P*Q-8*Q-1-:4*Q] <= b_in[P*Q+24*Q-1-:4*Q];
b_8[addr_w*P*Q-4*Q-1-:4*Q] <= b_in[28*Q-1-:4*Q];
b_8[128*Q+addr_w*P*Q-4*Q-1-:4*Q] <= b_in[P*Q+28*Q-1-:4*Q];
b_8[addr_w*P*Q-0*Q-1-:4*Q] <= b_in[32*Q-1-:4*Q];
b_8[128*Q+addr_w*P*Q-0*Q-1-:4*Q] <= b_in[P*Q+32*Q-1-:4*Q];
end
7 : begin
b_7[addr_w*P*Q-28*Q-1-:4*Q] <= b_in[4*Q-1-:4*Q];
b_7[64*Q+addr_w*P*Q-28*Q-1-:4*Q] <= b_in[P*Q+4*Q-1-:4*Q];
b_7[addr_w*P*Q-24*Q-1-:4*Q] <= b_in[8*Q-1-:4*Q];
b_7[64*Q+addr_w*P*Q-24*Q-1-:4*Q] <= b_in[P*Q+8*Q-1-:4*Q];
b_7[addr_w*P*Q-20*Q-1-:4*Q] <= b_in[12*Q-1-:4*Q];
b_7[64*Q+addr_w*P*Q-20*Q-1-:4*Q] <= b_in[P*Q+12*Q-1-:4*Q];
b_7[addr_w*P*Q-16*Q-1-:4*Q] <= b_in[16*Q-1-:4*Q];
b_7[64*Q+addr_w*P*Q-16*Q-1-:4*Q] <= b_in[P*Q+16*Q-1-:4*Q];
b_7[addr_w*P*Q-12*Q-1-:4*Q] <= b_in[20*Q-1-:4*Q];
b_7[64*Q+addr_w*P*Q-12*Q-1-:4*Q] <= b_in[P*Q+20*Q-1-:4*Q];
b_7[addr_w*P*Q-8*Q-1-:4*Q] <= b_in[24*Q-1-:4*Q];
b_7[64*Q+addr_w*P*Q-8*Q-1-:4*Q] <= b_in[P*Q+24*Q-1-:4*Q];
b_7[addr_w*P*Q-4*Q-1-:4*Q] <= b_in[28*Q-1-:4*Q];
b_7[64*Q+addr_w*P*Q-4*Q-1-:4*Q] <= b_in[P*Q+28*Q-1-:4*Q];
b_7[addr_w*P*Q-0*Q-1-:4*Q] <= b_in[32*Q-1-:4*Q];
b_7[64*Q+addr_w*P*Q-0*Q-1-:4*Q] <= b_in[P*Q+32*Q-1-:4*Q];
end
6 : begin
b_6[4*Q-1-:4*Q] <= b_in[4*Q-1-:4*Q];
b_6[36*Q-1-:4*Q] <= b_in[P*Q+4*Q-1-:4*Q];
b_6[8*Q-1-:4*Q] <= b_in[8*Q-1-:4*Q];
b_6[40*Q-1-:4*Q] <= b_in[P*Q+8*Q-1-:4*Q];
b_6[12*Q-1-:4*Q] <= b_in[12*Q-1-:4*Q];
b_6[44*Q-1-:4*Q] <= b_in[P*Q+12*Q-1-:4*Q];
b_6[16*Q-1-:4*Q] <= b_in[16*Q-1-:4*Q];
b_6[48*Q-1-:4*Q] <= b_in[P*Q+16*Q-1-:4*Q];
b_6[20*Q-1-:4*Q] <= b_in[20*Q-1-:4*Q];
b_6[52*Q-1-:4*Q] <= b_in[P*Q+20*Q-1-:4*Q];
b_6[24*Q-1-:4*Q] <= b_in[24*Q-1-:4*Q];
b_6[56*Q-1-:4*Q] <= b_in[P*Q+24*Q-1-:4*Q];
b_6[28*Q-1-:4*Q] <= b_in[28*Q-1-:4*Q];
b_6[60*Q-1-:4*Q] <= b_in[P*Q+28*Q-1-:4*Q];
b_6[32*Q-1-:4*Q] <= b_in[32*Q-1-:4*Q];
b_6[64*Q-1-:4*Q] <= b_in[P*Q+32*Q-1-:4*Q];
end
5 : begin
b_5[4*Q-1-:4*Q] <= b_in[4*Q-1-:4*Q];
b_5[20*Q-1-:4*Q] <= b_in[P*Q+4*Q-1-:4*Q];
b_5[8*Q-1-:4*Q] <= b_in[8*Q-1-:4*Q];
b_5[24*Q-1-:4*Q] <= b_in[P*Q+8*Q-1-:4*Q];
b_5[12*Q-1-:4*Q] <= b_in[12*Q-1-:4*Q];
b_5[28*Q-1-:4*Q] <= b_in[P*Q+12*Q-1-:4*Q];
b_5[16*Q-1-:4*Q] <= b_in[16*Q-1-:4*Q];
b_5[32*Q-1-:4*Q] <= b_in[P*Q+16*Q-1-:4*Q];
end
4 : begin
b_4[4*Q-1-:4*Q] <= b_in[4*Q-1-:4*Q];
b_4[12*Q-1-:4*Q] <= b_in[P*Q+4*Q-1-:4*Q];
b_4[8*Q-1-:4*Q] <= b_in[8*Q-1-:4*Q];
b_4[16*Q-1-:4*Q] <= b_in[P*Q+8*Q-1-:4*Q];
end
3 : begin
b_3[4*Q-1:0]<= b_in[4*Q-1:0];
b_3[8*Q-1:4*Q]<= b_in[36*Q-1:32*Q];
end
2 : begin
b_2[2*Q-1:0]<= b_in[2*Q-1:0];
b_2[4*Q-1:2*Q]<= b_in[34*Q-1:32*Q];
end
1 : begin
b_1<= b_in[2*Q-1:0];
end
endcase       
            end      
            
            if(r_en) begin
                 // read  
            case (layer_r)
8 : begin
r[4*Q-1-:4*Q] <= b_8[addr_r*P*Q-28*Q-1-:4*Q];
r[8*Q-1-:4*Q] <= b_8[addr_r*P*Q-24*Q-1-:4*Q];
r[12*Q-1-:4*Q] <= b_8[addr_r*P*Q-20*Q-1-:4*Q];
r[16*Q-1-:4*Q] <= b_8[addr_r*P*Q-16*Q-1-:4*Q];
r[20*Q-1-:4*Q] <= b_8[addr_r*P*Q-12*Q-1-:4*Q];
r[24*Q-1-:4*Q] <= b_8[addr_r*P*Q-8*Q-1-:4*Q];
r[28*Q-1-:4*Q] <= b_8[addr_r*P*Q-4*Q-1-:4*Q];
r[32*Q-1-:4*Q] <= b_8[addr_r*P*Q-0*Q-1-:4*Q];
end
7 : begin
r[4*Q-1-:4*Q] <= b_7[addr_r*P*Q-28*Q-1-:4*Q];
r[8*Q-1-:4*Q] <= b_7[addr_r*P*Q-24*Q-1-:4*Q];
r[12*Q-1-:4*Q] <= b_7[addr_r*P*Q-20*Q-1-:4*Q];
r[16*Q-1-:4*Q] <= b_7[addr_r*P*Q-16*Q-1-:4*Q];
r[20*Q-1-:4*Q] <= b_7[addr_r*P*Q-12*Q-1-:4*Q];
r[24*Q-1-:4*Q] <= b_7[addr_r*P*Q-8*Q-1-:4*Q];
r[28*Q-1-:4*Q] <= b_7[addr_r*P*Q-4*Q-1-:4*Q];
r[32*Q-1-:4*Q] <= b_7[addr_r*P*Q-0*Q-1-:4*Q];
end
6 : begin
r[4*Q-1-:4*Q] <= b_6[addr_r*P*Q-28*Q-1-:4*Q];
r[8*Q-1-:4*Q] <= b_6[addr_r*P*Q-24*Q-1-:4*Q];
r[12*Q-1-:4*Q] <= b_6[addr_r*P*Q-20*Q-1-:4*Q];
r[16*Q-1-:4*Q] <= b_6[addr_r*P*Q-16*Q-1-:4*Q];
r[20*Q-1-:4*Q] <= b_6[addr_r*P*Q-12*Q-1-:4*Q];
r[24*Q-1-:4*Q] <= b_6[addr_r*P*Q-8*Q-1-:4*Q];
r[28*Q-1-:4*Q] <= b_6[addr_r*P*Q-4*Q-1-:4*Q];
r[32*Q-1-:4*Q] <= b_6[addr_r*P*Q-0*Q-1-:4*Q];
end
5 : begin
r[4*Q-1-:4*Q] <= b_5[4*Q-1-:4*Q];
r[8*Q-1-:4*Q] <= b_5[8*Q-1-:4*Q];
r[12*Q-1-:4*Q] <= b_5[12*Q-1-:4*Q];
r[16*Q-1-:4*Q] <= b_5[16*Q-1-:4*Q];
r[20*Q-1-:4*Q] <= b_5[20*Q-1-:4*Q];
r[24*Q-1-:4*Q] <= b_5[24*Q-1-:4*Q];
r[28*Q-1-:4*Q] <= b_5[28*Q-1-:4*Q];
r[32*Q-1-:4*Q] <= b_5[32*Q-1-:4*Q];
end
4 : begin
r[4*Q-1-:4*Q] <= b_4[4*Q-1-:4*Q];
r[8*Q-1-:4*Q] <= b_4[8*Q-1-:4*Q];
r[12*Q-1-:4*Q] <= b_4[12*Q-1-:4*Q];
r[16*Q-1-:4*Q] <= b_4[16*Q-1-:4*Q];
r[32*Q-1:16*Q] <= 0;
end
3 : begin
r[4*Q-1-:4*Q] <= b_3[4*Q-1-:4*Q];
r[8*Q-1-:4*Q] <= b_3[8*Q-1-:4*Q];
r[32*Q-1:8*Q] <= 0;
end
2 : begin
r[4*Q-1:0] <= b_2;
r[32*Q-1:4*Q] <= 0;
end
1 : begin
r[2*Q-1:0] <= b_1;
r[32*Q-1:2*Q] <= 0;
end
default: begin
            r <= 0;
        end
           endcase
            end
           else begin
                  r <= 0;
           end
        end
    end
    
endmodule

