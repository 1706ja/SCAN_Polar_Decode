
//data is stored in lower bits
module ram_b #(
    parameter
    Q = 6,
    P = 128,
    N = 1024
) (
    input [2*P*Q-1:0] b_in, // input data
    input [4:0] layer_r, // read layers
    input [4:0] layer_w, // write layer
    input [3:0] cnta, // write count
    input [3:0] cntb, //read count
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
b_8[16*Q-1-:16*Q] <= b_in[16*Q-1-:16*Q];
b_8[144*Q-1-:16*Q] <= b_in[P*Q+16*Q-1-:16*Q];
b_8[32*Q-1-:16*Q] <= b_in[32*Q-1-:16*Q];
b_8[160*Q-1-:16*Q] <= b_in[P*Q+32*Q-1-:16*Q];
b_8[48*Q-1-:16*Q] <= b_in[48*Q-1-:16*Q];
b_8[176*Q-1-:16*Q] <= b_in[P*Q+48*Q-1-:16*Q];
b_8[64*Q-1-:16*Q] <= b_in[64*Q-1-:16*Q];
b_8[192*Q-1-:16*Q] <= b_in[P*Q+64*Q-1-:16*Q];
b_8[80*Q-1-:16*Q] <= b_in[80*Q-1-:16*Q];
b_8[208*Q-1-:16*Q] <= b_in[P*Q+80*Q-1-:16*Q];
b_8[96*Q-1-:16*Q] <= b_in[96*Q-1-:16*Q];
b_8[224*Q-1-:16*Q] <= b_in[P*Q+96*Q-1-:16*Q];
b_8[112*Q-1-:16*Q] <= b_in[112*Q-1-:16*Q];
b_8[240*Q-1-:16*Q] <= b_in[P*Q+112*Q-1-:16*Q];
b_8[128*Q-1-:16*Q] <= b_in[128*Q-1-:16*Q];
b_8[256*Q-1-:16*Q] <= b_in[P*Q+128*Q-1-:16*Q];
end
7 : begin
b_7[16*Q-1-:16*Q] <= b_in[16*Q-1-:16*Q];
b_7[80*Q-1-:16*Q] <= b_in[P*Q+16*Q-1-:16*Q];
b_7[32*Q-1-:16*Q] <= b_in[32*Q-1-:16*Q];
b_7[96*Q-1-:16*Q] <= b_in[P*Q+32*Q-1-:16*Q];
b_7[48*Q-1-:16*Q] <= b_in[48*Q-1-:16*Q];
b_7[112*Q-1-:16*Q] <= b_in[P*Q+48*Q-1-:16*Q];
b_7[64*Q-1-:16*Q] <= b_in[64*Q-1-:16*Q];
b_7[128*Q-1-:16*Q] <= b_in[P*Q+64*Q-1-:16*Q];
end
6 : begin
b_6[16*Q-1-:16*Q] <= b_in[16*Q-1-:16*Q];
b_6[48*Q-1-:16*Q] <= b_in[P*Q+16*Q-1-:16*Q];
b_6[32*Q-1-:16*Q] <= b_in[32*Q-1-:16*Q];
b_6[64*Q-1-:16*Q] <= b_in[P*Q+32*Q-1-:16*Q];
end
5 : begin
b_5[16*Q-1:0]<= b_in[16*Q-1:0];
b_5[32*Q-1:16*Q]<= b_in[144*Q-1:128*Q];
end
4 : begin
b_4[8*Q-1:0]<= b_in[8*Q-1:0];
b_4[16*Q-1:8*Q]<= b_in[136*Q-1:128*Q];
end
3 : begin
b_3[4*Q-1:0]<= b_in[4*Q-1:0];
b_3[8*Q-1:4*Q]<= b_in[132*Q-1:128*Q];
end
2 : begin
b_2[2*Q-1:0]<= b_in[2*Q-1:0];
b_2[4*Q-1:2*Q]<= b_in[130*Q-1:128*Q];
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
r[16*Q-1-:16*Q] <= b_8[addr_r*P*Q-112*Q-1-:16*Q];
r[32*Q-1-:16*Q] <= b_8[addr_r*P*Q-96*Q-1-:16*Q];
r[48*Q-1-:16*Q] <= b_8[addr_r*P*Q-80*Q-1-:16*Q];
r[64*Q-1-:16*Q] <= b_8[addr_r*P*Q-64*Q-1-:16*Q];
r[80*Q-1-:16*Q] <= b_8[addr_r*P*Q-48*Q-1-:16*Q];
r[96*Q-1-:16*Q] <= b_8[addr_r*P*Q-32*Q-1-:16*Q];
r[112*Q-1-:16*Q] <= b_8[addr_r*P*Q-16*Q-1-:16*Q];
r[128*Q-1-:16*Q] <= b_8[addr_r*P*Q-1-:16*Q];
end
7 : begin
r[16*Q-1-:16*Q] <= b_7[16*Q-1-:16*Q];
r[32*Q-1-:16*Q] <= b_7[32*Q-1-:16*Q];
r[48*Q-1-:16*Q] <= b_7[48*Q-1-:16*Q];
r[64*Q-1-:16*Q] <= b_7[64*Q-1-:16*Q];
r[80*Q-1-:16*Q] <= b_7[80*Q-1-:16*Q];
r[96*Q-1-:16*Q] <= b_7[96*Q-1-:16*Q];
r[112*Q-1-:16*Q] <= b_7[112*Q-1-:16*Q];
r[128*Q-1-:16*Q] <= b_7[128*Q-1-:16*Q];

end
6 : begin
r[16*Q-1-:16*Q] <= b_6[16*Q-1-:16*Q];
r[32*Q-1-:16*Q] <= b_6[32*Q-1-:16*Q];
r[48*Q-1-:16*Q] <= b_6[48*Q-1-:16*Q];
r[64*Q-1-:16*Q] <= b_6[64*Q-1-:16*Q];
r[128*Q-1:64*Q] <= 0;
end
5 : begin
r[16*Q-1-:16*Q] <= b_5[16*Q-1-:16*Q];
r[32*Q-1-:16*Q] <= b_5[32*Q-1-:16*Q];
r[128*Q-1:32*Q] <= 0;
end
4 : begin
r[16*Q-1:0] <= b_4;
r[128*Q-1:16*Q] <= 0;
end
3 : begin
r[8*Q-1:0] <= b_3;
r[128*Q-1:8*Q] <= 0;
end
2 : begin
r[4*Q-1:0] <= b_2;
r[128*Q-1:4*Q] <= 0;
end
1 : begin
r[2*Q-1:0] <= b_1;
r[128*Q-1:2*Q] <= 0;
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

