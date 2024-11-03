module ram_b #(
    parameter
    Q = 6,
    P = 16,
    N = 1024
) (
    input [2*P*Q-1:0] b_in, // input data
    input [4:0] layer_r, // read layers
    input [4:0] layer_w, // write layer
    input [5:0] cnta, // write count
    input [5:0] cntb, //read count
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
b_8[addr_w*P*Q-14*Q-1-:2*Q] <= b_in[2*Q-1-:2*Q];
b_8[addr_w*P*Q+114*Q-1-:2*Q] <= b_in[P*Q+2*Q-1-:2*Q];
b_8[addr_w*P*Q-12*Q-1-:2*Q] <= b_in[4*Q-1-:2*Q];
b_8[addr_w*P*Q+116*Q-1-:2*Q] <= b_in[P*Q+4*Q-1-:2*Q];
b_8[addr_w*P*Q-10*Q-1-:2*Q] <= b_in[6*Q-1-:2*Q];
b_8[addr_w*P*Q+118*Q-1-:2*Q] <= b_in[P*Q+6*Q-1-:2*Q];
b_8[addr_w*P*Q-8*Q-1-:2*Q] <= b_in[8*Q-1-:2*Q];
b_8[addr_w*P*Q+120*Q-1-:2*Q] <= b_in[P*Q+8*Q-1-:2*Q];
b_8[addr_w*P*Q-6*Q-1-:2*Q] <= b_in[10*Q-1-:2*Q];
b_8[addr_w*P*Q+122*Q-1-:2*Q] <= b_in[P*Q+10*Q-1-:2*Q];
b_8[addr_w*P*Q-4*Q-1-:2*Q] <= b_in[12*Q-1-:2*Q];
b_8[addr_w*P*Q+124*Q-1-:2*Q] <= b_in[P*Q+12*Q-1-:2*Q];
b_8[addr_w*P*Q-2*Q-1-:2*Q] <= b_in[14*Q-1-:2*Q];
b_8[addr_w*P*Q+126*Q-1-:2*Q] <= b_in[P*Q+14*Q-1-:2*Q];
b_8[addr_w*P*Q-1-:2*Q] <= b_in[16*Q-1-:2*Q];
b_8[addr_w*P*Q+128*Q-1-:2*Q] <= b_in[P*Q+16*Q-1-:2*Q];
end
7 : begin
b_7[addr_w*P*Q-14*Q-1-:2*Q] <= b_in[2*Q-1-:2*Q];
b_7[addr_w*P*Q+50*Q-1-:2*Q] <= b_in[P*Q+2*Q-1-:2*Q];
b_7[addr_w*P*Q-12*Q-1-:2*Q] <= b_in[4*Q-1-:2*Q];
b_7[addr_w*P*Q+52*Q-1-:2*Q] <= b_in[P*Q+4*Q-1-:2*Q];
b_7[addr_w*P*Q-10*Q-1-:2*Q] <= b_in[6*Q-1-:2*Q];
b_7[addr_w*P*Q+54*Q-1-:2*Q] <= b_in[P*Q+6*Q-1-:2*Q];
b_7[addr_w*P*Q-8*Q-1-:2*Q] <= b_in[8*Q-1-:2*Q];
b_7[addr_w*P*Q+56*Q-1-:2*Q] <= b_in[P*Q+8*Q-1-:2*Q];
b_7[addr_w*P*Q-6*Q-1-:2*Q] <= b_in[10*Q-1-:2*Q];
b_7[addr_w*P*Q+58*Q-1-:2*Q] <= b_in[P*Q+10*Q-1-:2*Q];
b_7[addr_w*P*Q-4*Q-1-:2*Q] <= b_in[12*Q-1-:2*Q];
b_7[addr_w*P*Q+60*Q-1-:2*Q] <= b_in[P*Q+12*Q-1-:2*Q];
b_7[addr_w*P*Q-2*Q-1-:2*Q] <= b_in[14*Q-1-:2*Q];
b_7[addr_w*P*Q+62*Q-1-:2*Q] <= b_in[P*Q+14*Q-1-:2*Q];
b_7[addr_w*P*Q-1-:2*Q] <= b_in[16*Q-1-:2*Q];
b_7[addr_w*P*Q+64*Q-1-:2*Q] <= b_in[P*Q+16*Q-1-:2*Q];
end
6 : begin
b_6[addr_w*P*Q-14*Q-1-:2*Q] <= b_in[2*Q-1-:2*Q];
b_6[addr_w*P*Q+18*Q-1-:2*Q] <= b_in[P*Q+2*Q-1-:2*Q];
b_6[addr_w*P*Q-12*Q-1-:2*Q] <= b_in[4*Q-1-:2*Q];
b_6[addr_w*P*Q+20*Q-1-:2*Q] <= b_in[P*Q+4*Q-1-:2*Q];
b_6[addr_w*P*Q-10*Q-1-:2*Q] <= b_in[6*Q-1-:2*Q];
b_6[addr_w*P*Q+22*Q-1-:2*Q] <= b_in[P*Q+6*Q-1-:2*Q];
b_6[addr_w*P*Q-8*Q-1-:2*Q] <= b_in[8*Q-1-:2*Q];
b_6[addr_w*P*Q+24*Q-1-:2*Q] <= b_in[P*Q+8*Q-1-:2*Q];
b_6[addr_w*P*Q-6*Q-1-:2*Q] <= b_in[10*Q-1-:2*Q];
b_6[addr_w*P*Q+26*Q-1-:2*Q] <= b_in[P*Q+10*Q-1-:2*Q];
b_6[addr_w*P*Q-4*Q-1-:2*Q] <= b_in[12*Q-1-:2*Q];
b_6[addr_w*P*Q+28*Q-1-:2*Q] <= b_in[P*Q+12*Q-1-:2*Q];
b_6[addr_w*P*Q-2*Q-1-:2*Q] <= b_in[14*Q-1-:2*Q];
b_6[addr_w*P*Q+30*Q-1-:2*Q] <= b_in[P*Q+14*Q-1-:2*Q];
b_6[addr_w*P*Q-1-:2*Q] <= b_in[16*Q-1-:2*Q];
b_6[addr_w*P*Q+32*Q-1-:2*Q] <= b_in[P*Q+16*Q-1-:2*Q];
end
5 : begin
b_5[2*Q-1-:2*Q] <= b_in[2*Q-1-:2*Q];
b_5[18*Q-1-:2*Q] <= b_in[P*Q+2*Q-1-:2*Q];
b_5[4*Q-1-:2*Q] <= b_in[4*Q-1-:2*Q];
b_5[20*Q-1-:2*Q] <= b_in[P*Q+4*Q-1-:2*Q];
b_5[6*Q-1-:2*Q] <= b_in[6*Q-1-:2*Q];
b_5[22*Q-1-:2*Q] <= b_in[P*Q+6*Q-1-:2*Q];
b_5[8*Q-1-:2*Q] <= b_in[8*Q-1-:2*Q];
b_5[24*Q-1-:2*Q] <= b_in[P*Q+8*Q-1-:2*Q];
b_5[10*Q-1-:2*Q] <= b_in[10*Q-1-:2*Q];
b_5[26*Q-1-:2*Q] <= b_in[P*Q+10*Q-1-:2*Q];
b_5[12*Q-1-:2*Q] <= b_in[12*Q-1-:2*Q];
b_5[28*Q-1-:2*Q] <= b_in[P*Q+12*Q-1-:2*Q];
b_5[14*Q-1-:2*Q] <= b_in[14*Q-1-:2*Q];
b_5[30*Q-1-:2*Q] <= b_in[P*Q+14*Q-1-:2*Q];
b_5[16*Q-1-:2*Q] <= b_in[16*Q-1-:2*Q];
b_5[32*Q-1-:2*Q] <= b_in[P*Q+16*Q-1-:2*Q];
end
4 : begin
b_4[2*Q-1-:2*Q] <= b_in[2*Q-1-:2*Q];
b_4[10*Q-1-:2*Q] <= b_in[P*Q+2*Q-1-:2*Q];
b_4[4*Q-1-:2*Q] <= b_in[4*Q-1-:2*Q];
b_4[12*Q-1-:2*Q] <= b_in[P*Q+4*Q-1-:2*Q];
b_4[6*Q-1-:2*Q] <= b_in[6*Q-1-:2*Q];
b_4[14*Q-1-:2*Q] <= b_in[P*Q+6*Q-1-:2*Q];
b_4[8*Q-1-:2*Q] <= b_in[8*Q-1-:2*Q];
b_4[16*Q-1-:2*Q] <= b_in[P*Q+8*Q-1-:2*Q];
end
3 : begin
b_3[2*Q-1-:2*Q] <= b_in[2*Q-1-:2*Q];
b_3[6*Q-1-:2*Q] <= b_in[P*Q+2*Q-1-:2*Q];
b_3[4*Q-1-:2*Q] <= b_in[4*Q-1-:2*Q];
b_3[8*Q-1-:2*Q] <= b_in[P*Q+4*Q-1-:2*Q];
end
2 : begin
b_2[2*Q-1:0]<= b_in[2*Q-1:0];
b_2[4*Q-1:2*Q]<= b_in[18*Q-1:16*Q];
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
r[2*Q-1-:2*Q] <= b_8[addr_r*P*Q-14*Q-1-:2*Q];
r[4*Q-1-:2*Q] <= b_8[addr_r*P*Q-12*Q-1-:2*Q];
r[6*Q-1-:2*Q] <= b_8[addr_r*P*Q-10*Q-1-:2*Q];
r[8*Q-1-:2*Q] <= b_8[addr_r*P*Q-8*Q-1-:2*Q];
r[10*Q-1-:2*Q] <= b_8[addr_r*P*Q-6*Q-1-:2*Q];
r[12*Q-1-:2*Q] <= b_8[addr_r*P*Q-4*Q-1-:2*Q];
r[14*Q-1-:2*Q] <= b_8[addr_r*P*Q-2*Q-1-:2*Q];
r[16*Q-1-:2*Q] <= b_8[addr_r*P*Q-1-:2*Q];
end
7 : begin
r[2*Q-1-:2*Q] <= b_7[addr_r*P*Q-14*Q-1-:2*Q];
r[4*Q-1-:2*Q] <= b_7[addr_r*P*Q-12*Q-1-:2*Q];
r[6*Q-1-:2*Q] <= b_7[addr_r*P*Q-10*Q-1-:2*Q];
r[8*Q-1-:2*Q] <= b_7[addr_r*P*Q-8*Q-1-:2*Q];
r[10*Q-1-:2*Q] <= b_7[addr_r*P*Q-6*Q-1-:2*Q];
r[12*Q-1-:2*Q] <= b_7[addr_r*P*Q-4*Q-1-:2*Q];
r[14*Q-1-:2*Q] <= b_7[addr_r*P*Q-2*Q-1-:2*Q];
r[16*Q-1-:2*Q] <= b_7[addr_r*P*Q-1-:2*Q];
end
6 : begin
r[2*Q-1-:2*Q] <= b_6[addr_r*P*Q-14*Q-1-:2*Q];
r[4*Q-1-:2*Q] <= b_6[addr_r*P*Q-12*Q-1-:2*Q];
r[6*Q-1-:2*Q] <= b_6[addr_r*P*Q-10*Q-1-:2*Q];
r[8*Q-1-:2*Q] <= b_6[addr_r*P*Q-8*Q-1-:2*Q];
r[10*Q-1-:2*Q] <= b_6[addr_r*P*Q-6*Q-1-:2*Q];
r[12*Q-1-:2*Q] <= b_6[addr_r*P*Q-4*Q-1-:2*Q];
r[14*Q-1-:2*Q] <= b_6[addr_r*P*Q-2*Q-1-:2*Q];
r[16*Q-1-:2*Q] <= b_6[addr_r*P*Q-1-:2*Q];
end
5 : begin
r[2*Q-1-:2*Q] <= b_5[addr_r*P*Q-14*Q-1-:2*Q];
r[4*Q-1-:2*Q] <= b_5[addr_r*P*Q-12*Q-1-:2*Q];
r[6*Q-1-:2*Q] <= b_5[addr_r*P*Q-10*Q-1-:2*Q];
r[8*Q-1-:2*Q] <= b_5[addr_r*P*Q-8*Q-1-:2*Q];
r[10*Q-1-:2*Q] <= b_5[addr_r*P*Q-6*Q-1-:2*Q];
r[12*Q-1-:2*Q] <= b_5[addr_r*P*Q-4*Q-1-:2*Q];
r[14*Q-1-:2*Q] <= b_5[addr_r*P*Q-2*Q-1-:2*Q];
r[16*Q-1-:2*Q] <= b_5[addr_r*P*Q-1-:2*Q];
end
4 : begin
r[2*Q-1-:2*Q] <= b_4[2*Q-1-:2*Q];
r[4*Q-1-:2*Q] <= b_4[4*Q-1-:2*Q];
r[6*Q-1-:2*Q] <= b_4[6*Q-1-:2*Q];
r[8*Q-1-:2*Q] <= b_4[8*Q-1-:2*Q];
r[10*Q-1-:2*Q] <= b_4[10*Q-1-:2*Q];
r[12*Q-1-:2*Q] <= b_4[12*Q-1-:2*Q];
r[14*Q-1-:2*Q] <= b_4[14*Q-1-:2*Q];
r[16*Q-1-:2*Q] <= b_4[16*Q-1-:2*Q];
end
3 : begin
r[2*Q-1-:2*Q] <= b_3[2*Q-1-:2*Q];
r[4*Q-1-:2*Q] <= b_3[4*Q-1-:2*Q];
r[6*Q-1-:2*Q] <= b_3[6*Q-1-:2*Q];
r[8*Q-1-:2*Q] <= b_3[8*Q-1-:2*Q];
r[16*Q-1:8*Q] <= 0;
end
2 : begin
r[2*Q-1-:2*Q] <= b_2[2*Q-1-:2*Q];
r[4*Q-1-:2*Q] <= b_2[4*Q-1-:2*Q];
r[16*Q-1:4*Q] <= 0;
end
1 : begin
r[2*Q-1:0] <= b_1;
r[16*Q-1:2*Q] <= 0;
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