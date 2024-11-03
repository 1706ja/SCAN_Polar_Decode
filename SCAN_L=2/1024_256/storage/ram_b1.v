
module ram_b1 #(
  parameter P = 256,
  Q = 6,
  N = 1024
) (
    input [2*P*Q-1:0] b_in, // input data
    input [4:0] layer_r, // read layer
    input [4:0] layer_w, // write layer
    input [3:0] cnta, // write count
    input [3:0] cntb, //read count
    input [8:0] r_address, // read r_r_address
    input [8:0] w_address, // write r_r_address
    input w_en, //write enable
    input r_en, //read enable
    input clk,
    input rst,
    output [P*Q-1:0] b_out
);


  reg [512*Q-1:0] b8; 
  reg [512*Q-1:0] b7;
  reg [512*Q-1:0] b6; 
  reg [512*Q-1:0] b5;
  reg [512*Q-1:0] b4; 
  reg [512*Q-1:0] b3;
  reg [512*Q-1:0] b2; 
  reg [512*Q-1:0] b1; 

  // declaration of rams
  reg [P*Q-1:0] r; //output reg
  wire en_r, en_w;
  wire [8:0] addr_r, addr_r2;
  wire [8:0] addr_w, addr_w2;


  assign en_r = (layer_r > 6);
  assign en_w = (layer_w > 6);
  assign addr_r = en_r ? 
                  ((layer_r==8)? ((r_address << 2) + (1+cntb) ) :
                  ((layer_r==7)? ((r_address << 1) + (1+cntb)) :
                  ((r_address) + (1+cntb)) )) 
                  : 0;
  assign addr_r2 = en_r ?  0 : (r_address + 1);
  assign addr_w = en_w ? 
                  ((layer_w==8)? ((w_address << 2) + (1+cnta) ) :
                  ((layer_w==7)? ((w_address << 1) + (1+cnta)) :
                  ((w_address) + (1+cnta)) )) 
                  : 0;
  assign addr_w2 = en_w ?  0 : (w_address+1) ;                

    assign b_out = r;

  always @(posedge clk) begin
    if(rst) begin
      b8 <= 0; // 256
      b7 <= 0; // 128
      b6 <= 0; // 64
      b5 <= 0; // 32
      b4 <= 0; // 16
      b3 <= 0; // 8 
      b2 <= 0; // 4
      b1 <= 0; // 2
      r <= 0;
    end

    else begin
      if (w_en) begin
        case (layer_w)
8 : begin
b8[addr_w2*256*Q-224*Q-1-:32*Q] <= b_in[32*Q-1-:32*Q];
b8[addr_w2*256*Q-96*Q-1-:32*Q] <= b_in[P*Q+32*Q-1-:32*Q];
b8[addr_w2*256*Q-192*Q-1-:32*Q] <= b_in[64*Q-1-:32*Q];
b8[addr_w2*256*Q-64*Q-1-:32*Q] <= b_in[P*Q+64*Q-1-:32*Q];
b8[addr_w2*256*Q-160*Q-1-:32*Q] <= b_in[96*Q-1-:32*Q];
b8[addr_w2*256*Q-32*Q-1-:32*Q] <= b_in[P*Q+96*Q-1-:32*Q];
b8[addr_w2*256*Q-128*Q-1-:32*Q] <= b_in[128*Q-1-:32*Q];
b8[addr_w2*256*Q-1-:32*Q] <= b_in[P*Q+128*Q-1-:32*Q];
end
7 : begin
b7[addr_w2*128*Q-96*Q-1-:32*Q] <= b_in[32*Q-1-:32*Q];
b7[addr_w2*128*Q-32*Q-1-:32*Q] <= b_in[P*Q+32*Q-1-:32*Q];
b7[addr_w2*128*Q-64*Q-1-:32*Q] <= b_in[64*Q-1-:32*Q];
b7[addr_w2*128*Q-1-:32*Q] <= b_in[P*Q+64*Q-1-:32*Q];
end
6 : begin
b6[addr_w2*64*Q-32*Q-1-:32*Q]<= b_in[32*Q-1-:32*Q];
b6[addr_w2*64*Q-1-:32*Q]<= b_in[P*Q+32*Q-1-:32*Q];
end
5 : begin
b5[addr_w2*32*Q-16*Q-1-:16*Q]<= b_in[16*Q-1-:16*Q];
b5[addr_w2*32*Q-1-:16*Q]<= b_in[P*Q+16*Q-1-:16*Q];
end
4 : begin
b4[addr_w2*16*Q-8*Q-1-:8*Q]<= b_in[8*Q-1-:8*Q];
b4[addr_w2*16*Q-1-:8*Q]<= b_in[P*Q+8*Q-1-:8*Q];
end
3 : begin
b3[addr_w2*8*Q-4*Q-1-:4*Q]<= b_in[4*Q-1-:4*Q];
b3[addr_w2*8*Q-1-:4*Q]<= b_in[P*Q+4*Q-1-:4*Q];
end
2 : begin
b2[addr_w2*4*Q-2*Q-1-:2*Q]<= b_in[2*Q-1-:2*Q];
b2[addr_w2*4*Q-1-:2*Q]<= b_in[P*Q+2*Q-1-:2*Q];
end
1 : begin
b1[addr_w2*2*Q-1-:2*Q]<= b_in[2*Q-1:0];
end
endcase       
            end      

            if(r_en) begin
                 // read  
            case (layer_r)
8 : begin
r[32*Q-1-:32*Q] <= b8[addr_r2*256*Q-224*Q-1-:32*Q];
r[64*Q-1-:32*Q] <= b8[addr_r2*256*Q-192*Q-1-:32*Q];
r[96*Q-1-:32*Q] <= b8[addr_r2*256*Q-160*Q-1-:32*Q];
r[128*Q-1-:32*Q] <= b8[addr_r2*256*Q-128*Q-1-:32*Q];
r[160*Q-1-:32*Q] <= b8[addr_r2*256*Q-96*Q-1-:32*Q];
r[192*Q-1-:32*Q] <= b8[addr_r2*256*Q-64*Q-1-:32*Q];
r[224*Q-1-:32*Q] <= b8[addr_r2*256*Q-32*Q-1-:32*Q];
r[256*Q-1-:32*Q] <= b8[addr_r2*256*Q-1-:32*Q];
end
7 : begin
r[32*Q-1-:32*Q] <= b7[addr_r2*128*Q-96*Q-1-:32*Q];
r[64*Q-1-:32*Q] <= b7[addr_r2*128*Q-64*Q-1-:32*Q];
r[96*Q-1-:32*Q] <= b7[addr_r2*128*Q-32*Q-1-:32*Q];
r[128*Q-1-:32*Q] <= b7[addr_r2*128*Q-1-:32*Q];
r[256*Q-1:128*Q] <= 0;
end
6 : begin
r[32*Q-1-:32*Q] <= b6[addr_r2*64*Q-32*Q-1-:32*Q];
r[64*Q-1-:32*Q] <= b6[addr_r2*64*Q-1-:32*Q];
r[256*Q-1:64*Q] <= 0;
end
5 : begin
r[32*Q-1:0] <= b5[addr_r2*32*Q-1-:32*Q];
r[256*Q-1:32*Q] <= 0;
end
4 : begin
r[16*Q-1:0] <= b4[addr_r2*16*Q-1-:16*Q];
r[256*Q-1:16*Q] <= 0;
end
3 : begin
r[8*Q-1:0] <= b3[addr_r2*8*Q-1-:8*Q];
r[256*Q-1:8*Q] <= 0;
end
2 : begin
r[4*Q-1:0] <= b2[addr_r2*4*Q-1-:4*Q];
r[256*Q-1:4*Q] <= 0;
end
1 : begin
r[2*Q-1:0] <= b1[addr_r2*2*Q-1-:2*Q];
r[256*Q-1:2*Q] <= 0;
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