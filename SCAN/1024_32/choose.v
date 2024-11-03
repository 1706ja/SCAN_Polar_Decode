/* This module is for adding bypass
  Storage read data 2 clks prior to PE, thus errors can occur
  Mainly there are three types of data needing to be bypassed directly from pe_output
  of the clk before:
  1. The operation before only takes one clk
  2. The operation before only takes two clks
  3. The operation before takes 4 clks, but it is the end of the operation
  Say output when clk = 0, 1, 2, 3
  write occurs at 1, 2, 3, 4
  next operation read at clk 2, 3 -> error
  2 reads 0, 2
  3 reads 1, 3
*/
module choose #(
  parameter P = 32,
  Q = 6
) (
  input rst,
  input [P*Q-1:0] a_l,
  input [P*Q-1:0] a_r,
  input [P*Q-1:0] b_l,
  input [P*Q-1:0] b_r,
  input [2*P*Q-1:0] pe_o, // Two seperate datas at [P*Q-1:0] and [2*P*Q-1:0]
  input [2*P*Q-1:0] pe_o_before,
  input [10:0]I_Nv,
  input [4:0] channel_cnt,
  input [3:0] opcode_before,
  input [3:0] opcode,
  input [3:0] opcode_delay,
  output [P*Q-1:0] a_l_o,
  output [P*Q-1:0] a_r_o,
  output [P*Q-1:0] b_l_o,
  output [P*Q-1:0] b_r_o
);
  localparam WIDTH = P << 2 ;
  localparam DEPTH = P << 3;
  localparam TYPE1FUN     = 4'b0000;
  localparam TYPE2FUN     = 4'b0001;
  localparam BOTTOMFUN    = 4'b0010;
  localparam TYPE3FUN     = 4'b0011;


  wire alpha_enl, alpha_enr, beta_enl1, beta_enl2, beta_enr;
  wire en_1, en_2, en_3 ,en_4, en_5, en_6;

  reg [P*Q-1:0] W_a_l, W_a_r, W_b_l, W_b_r;

  wire optype1, optype2, optype3, optype4;

  assign optype1 = (opcode == TYPE1FUN);
  assign optype2 = (opcode == TYPE2FUN);
  assign optype3 = (opcode_delay == TYPE2FUN);

  assign optype4 = (opcode_before == TYPE1FUN);
  // assign optype5 = (opcode_before == TYPE2FUN);

  assign en_1 = (I_Nv < WIDTH);
  assign en_2 = (I_Nv == WIDTH );
  assign en_3 = (I_Nv == DEPTH);
  // assign
  assign en_4 = (channel_cnt == 1);
  assign en_5 = (channel_cnt == 3);
  assign en_6 = (channel_cnt == 0);

  assign alpha_enl = (optype1||optype2) && ((en_1)||(en_2&&en_4));
  assign alpha_enr = (optype1||optype2) && ((en_1)||(en_2)||(en_3&&en_5));
  assign beta_enl1 = (optype2) && (en_6) && (en_2||en_3);
  assign beta_enl2 = (!(optype1||optype2)) && (en_1||(en_2&&en_4)) && (optype3);
  assign beta_enr = (!(optype1||optype2)) && (en_1||en_2) && (!optype3);


  assign a_l_o = alpha_enl ? W_a_l : a_l;
  assign a_r_o = alpha_enr ? W_a_r : a_r;
  assign b_l_o = (beta_enl1||beta_enl2) ? W_b_l : b_l;
  assign b_r_o = beta_enr ? W_b_r : b_r;


  always @(*) begin
    if(rst) begin
      W_a_l <= 0;
      W_a_r <= 0;
      W_b_l <= 0;
      W_b_r <= 0;
    end
    else begin
      case (I_Nv)
        256 : begin
          W_a_r <= optype4 ? pe_o_before[P*Q-1:0] : pe_o_before[2*P*Q-1:P*Q];

          // W_a_r <= en_4 ? (optype1 ? pe_o[P*Q-1:0] : pe_o[2*P*Q-1:P*Q]) : 
          // (optype4 ? pe_o_before[P*Q-1:0] : pe_o_before[2*P*Q-1:P*Q]);

          W_b_l <= pe_o_before[P*Q-1:0];
          // W_b_r <= pe_o_before[P*Q-1:0];
        end
        128 : begin
          W_a_l <= optype4 ? (pe_o_before[P*Q-1:0]) : (pe_o_before[2*P*Q-1:P*Q]);
          // W_a_l[P*Q-1:32*Q] <= 0;
          W_a_r <= optype1 ? (pe_o[P*Q-1:0]) : (pe_o[2*P*Q-1:P*Q]);    
          // W_a_r[P*Q-1:32*Q] <= 0;

          W_b_l <= en_6 ? pe_o_before[2*P*Q-1:P*Q] : pe_o[P*Q-1:0];
          W_b_r <= en_6 ? pe_o_before[2*P*Q-1:P*Q] : pe_o[P*Q-1:0];
          // W_b_l[P*Q-1:32*Q] <= pe_o[(P+32)*Q-1:P*Q];
          // W_b_r[32*Q-1:0] <= pe_o[32*Q-1:0];
          // W_b_r[P*Q-1:32*Q] <= pe_o[(P+32)*Q-1:P*Q];   
        end
        64 : begin
          W_a_l[16*Q-1:0] <= optype1 ? (pe_o[16*Q-1:0]) : (pe_o[(P+16)*Q-1:P*Q]);
          W_a_l[P*Q-1:16*Q] <= 0;
          W_a_r[16*Q-1:0] <= optype1 ? (pe_o[32*Q-1:16*Q]) : (pe_o[(P+32)*Q-1:(P+16)*Q]);    
          W_a_r[P*Q-1:16*Q] <= 0;

          W_b_l <=  pe_o[P*Q-1:0];
          // W_b_l[P*Q-1:32*Q] <= pe_o[(P+32)*Q-1:P*Q];
          W_b_r <= pe_o[P*Q-1:0];
          // W_b_r[P*Q-1:32*Q] <= pe_o[(P+32)*Q-1:P*Q];   
        end
        32 : begin
          W_a_l[8*Q-1:0] <= optype1 ? (pe_o[8*Q-1:0]) : (pe_o[(P+8)*Q-1:P*Q] );
          W_a_l[64*Q-1:8*Q] <= 0;
          W_a_r[8*Q-1:0] <= optype1 ? (pe_o[16*Q-1:8*Q]) : (pe_o[(P+16)*Q-1:(P+8)*Q]);    
          W_a_r[64*Q-1:8*Q] <= 0;    

          W_b_l[16*Q-1:0] <=  (pe_o[16*Q-1:0]);
          W_b_l[32*Q-1:16*Q] <= (pe_o[P*Q+16*Q-1:P*Q]);
          W_b_r[16*Q-1:0] <= (pe_o[16*Q-1:0]);
          W_b_r[32*Q-1:16*Q] <=  (pe_o[P*Q+16*Q-1:P*Q]);
          // W_b_l[P*Q-1:32*Q] <= 0;
          // W_b_r[P*Q-1:32*Q] <= 0; 
        end
        16 : begin
          W_a_l[4*Q-1:0] <= optype1 ? (pe_o[4*Q-1:0]) : ( pe_o[(P+4)*Q-1:P*Q]);
          W_a_l[64*Q-1:4*Q] <= 0;
          W_a_r[4*Q-1:0] <= optype1 ? (pe_o[8*Q-1:4*Q]) : (pe_o[(P+8)*Q-1:(P+4)*Q]);    
          W_a_r[64*Q-1:4*Q] <= 0;     

          W_b_l[8*Q-1:0] <=  (pe_o[8*Q-1:0]);
          W_b_l[16*Q-1:8*Q] <=   (pe_o[(P+8)*Q-1:P*Q]);
          W_b_r[8*Q-1:0] <= (pe_o[8*Q-1:0]);  
          W_b_r[16*Q-1:8*Q] <= (pe_o[(P+8)*Q-1:P*Q]) ; 
          W_b_l[P*Q-1:16*Q] <= 0;
          W_b_r[P*Q-1:16*Q] <= 0;           
        end
        8 : begin
          W_a_l[2*Q-1:0] <= optype1 ? (pe_o[2*Q-1:0]) : ( pe_o[(P+2)*Q-1:P*Q] );
          W_a_l[P*Q-1:2*Q] <= 0;
          W_a_r[2*Q-1:0] <= optype1 ? (pe_o[4*Q-1:2*Q]) : (pe_o[(P+4)*Q-1:(P+2)*Q]);    
          W_a_r[P*Q-1:2*Q] <= 0;  

          W_b_l[4*Q-1:0] <=  (pe_o[4*Q-1:0]);
          W_b_l[8*Q-1:4*Q] <=   (pe_o[(P+4)*Q-1:128*Q]);
          W_b_r[4*Q-1:0] <=  (pe_o[4*Q-1:0]);
          W_b_r[8*Q-1:4*Q] <=  (pe_o[(P+4)*Q-1:128*Q]); 
          W_b_l[P*Q-1:8*Q] <= 0;
          W_b_r[P*Q-1:8*Q] <= 0;           
        end
        4 : begin
          W_a_l[Q-1:0] <= optype1 ? (pe_o[1*Q-1:0]) : (pe_o[(P+1)*Q-1:P*Q]);
          W_a_l[64*Q-1:Q] <= 0;
          W_a_r[Q-1:0] <= optype1 ? (pe_o[2*Q-1:1*Q]) : (pe_o[P*Q-1:(P+1)*Q] );    
          W_a_r[P*Q-1:Q] <= 0;     

          W_b_l[2*Q-1:0] <=   (pe_o[2*Q-1:0]);
          W_b_l[4*Q-1:2*Q] <=  (pe_o[(P+2)*Q-1:P*Q]);
          W_b_r[2*Q-1:0] <= (pe_o[2*Q-1:0]);
          W_b_r[4*Q-1:2*Q] <= (pe_o[(P+2)*Q-1:P*Q]); 
          W_b_l[P*Q-1:4*Q] <= 0;
          W_b_r[P*Q-1:4*Q] <= 0;             
        end
        2 : begin  //BOTTOM!
          W_b_l[2*Q-1:0] <= pe_o[2*Q-1:0];
          W_b_r[2*Q-1:0] <= pe_o[2*Q-1:0]; 
          W_b_l[P*Q-1:2*Q] <= 0;
          W_b_r[P*Q-1:2*Q] <= 0;              
        end
          default: begin
            W_a_l <= 0;
            W_a_r <= 0;
            W_b_l <= 0;
            W_b_r <= 0;
            end 
      endcase
    end

  end



  
endmodule