module ram_btop #(
  parameter N = 1024,
  P = 64,
  Q = 6
) (
    input [2*P*Q-1:0] b_in, // input data
    input [3:0] cnta, // write count
    input [3:0] cntb, //read count
    input w_en, //write enable
    input r_en, //read enable
    input clk,
    input rst,
    output [P*Q-1:0] b_out
);
  localparam WIDTH = P*Q;
  localparam bitwidth = P*Q/16;
  localparam DEPTH = N*Q/4;
  reg [N*Q/2-1:0] b_top;
  reg [P*Q-1:0] r;


  // assign cntb*WIDTH = cntb * WIDTH;
  // assign cnta*WIDTH = cnta * WIDTH;
  assign b_out = r;
  always @ (posedge clk) begin
    if (rst) begin
      b_top <= 0;
      r <= 0;
    end
    else begin
      if (w_en) begin
        b_top[cnta*WIDTH+bitwidth-1-:bitwidth] <= b_in[bitwidth-1-:bitwidth];
        b_top[cnta*WIDTH+bitwidth*2-1-:bitwidth] <= b_in[bitwidth*2-1-:bitwidth];
        b_top[cnta*WIDTH+bitwidth*3-1-:bitwidth] <= b_in[bitwidth*3-1-:bitwidth];
        b_top[cnta*WIDTH+bitwidth*4-1-:bitwidth] <= b_in[bitwidth*4-1-:bitwidth];
        b_top[cnta*WIDTH+bitwidth*5-1-:bitwidth] <= b_in[bitwidth*5-1-:bitwidth];
        b_top[cnta*WIDTH+bitwidth*6-1-:bitwidth] <= b_in[bitwidth*6-1-:bitwidth];
        b_top[cnta*WIDTH+bitwidth*7-1-:bitwidth] <= b_in[bitwidth*7-1-:bitwidth];
        b_top[cnta*WIDTH+bitwidth*8-1-:bitwidth] <= b_in[bitwidth*8-1-:bitwidth];
        b_top[cnta*WIDTH+bitwidth*9-1-:bitwidth] <= b_in[bitwidth*9-1-:bitwidth];
        b_top[cnta*WIDTH+bitwidth*10-1-:bitwidth] <= b_in[bitwidth*10-1-:bitwidth];
        b_top[cnta*WIDTH+bitwidth*11-1-:bitwidth] <= b_in[bitwidth*11-1-:bitwidth];
        b_top[cnta*WIDTH+bitwidth*12-1-:bitwidth] <= b_in[bitwidth*12-1-:bitwidth];
        b_top[cnta*WIDTH+bitwidth*13-1-:bitwidth] <= b_in[bitwidth*13-1-:bitwidth];
        b_top[cnta*WIDTH+bitwidth*14-1-:bitwidth] <= b_in[bitwidth*14-1-:bitwidth];
        b_top[cnta*WIDTH+bitwidth*15-1-:bitwidth] <= b_in[bitwidth*15-1-:bitwidth];
        b_top[cnta*WIDTH+bitwidth*16-1-:bitwidth] <= b_in[bitwidth*16-1-:bitwidth];


        b_top[DEPTH+cnta*WIDTH+bitwidth-1-:bitwidth] <= b_in[WIDTH+bitwidth-1-:bitwidth];
        b_top[DEPTH+cnta*WIDTH+bitwidth*2-1-:bitwidth] <= b_in[WIDTH+bitwidth*2-1-:bitwidth];
        b_top[DEPTH+cnta*WIDTH+bitwidth*3-1-:bitwidth] <= b_in[WIDTH+bitwidth*3-1-:bitwidth];
        b_top[DEPTH+cnta*WIDTH+bitwidth*4-1-:bitwidth] <= b_in[WIDTH+bitwidth*4-1-:bitwidth];
        b_top[DEPTH+cnta*WIDTH+bitwidth*5-1-:bitwidth] <= b_in[WIDTH+bitwidth*5-1-:bitwidth];
        b_top[DEPTH+cnta*WIDTH+bitwidth*6-1-:bitwidth] <= b_in[WIDTH+bitwidth*6-1-:bitwidth];
        b_top[DEPTH+cnta*WIDTH+bitwidth*7-1-:bitwidth] <= b_in[WIDTH+bitwidth*7-1-:bitwidth];
        b_top[DEPTH+cnta*WIDTH+bitwidth*8-1-:bitwidth] <= b_in[WIDTH+bitwidth*8-1-:bitwidth];  
        b_top[DEPTH+cnta*WIDTH+bitwidth*9-1-:bitwidth] <= b_in[WIDTH+bitwidth*9-1-:bitwidth];
        b_top[DEPTH+cnta*WIDTH+bitwidth*10-1-:bitwidth] <= b_in[WIDTH+bitwidth*10-1-:bitwidth];
        b_top[DEPTH+cnta*WIDTH+bitwidth*11-1-:bitwidth] <= b_in[WIDTH+bitwidth*11-1-:bitwidth];
        b_top[DEPTH+cnta*WIDTH+bitwidth*12-1-:bitwidth] <= b_in[WIDTH+bitwidth*12-1-:bitwidth];
        b_top[DEPTH+cnta*WIDTH+bitwidth*13-1-:bitwidth] <= b_in[WIDTH+bitwidth*13-1-:bitwidth];
        b_top[DEPTH+cnta*WIDTH+bitwidth*14-1-:bitwidth] <= b_in[WIDTH+bitwidth*14-1-:bitwidth];
        b_top[DEPTH+cnta*WIDTH+bitwidth*15-1-:bitwidth] <= b_in[WIDTH+bitwidth*15-1-:bitwidth];
        b_top[DEPTH+cnta*WIDTH+bitwidth*16-1-:bitwidth] <= b_in[WIDTH+bitwidth*16-1-:bitwidth];        
      end

      if (r_en) begin
        r[bitwidth-1-:bitwidth] <= b_top[cntb*WIDTH+bitwidth-1-:bitwidth];
        r[bitwidth*2-1-:bitwidth] <= b_top[cntb*WIDTH+bitwidth*2-1-:bitwidth];
        r[bitwidth*3-1-:bitwidth] <= b_top[cntb*WIDTH+bitwidth*3-1-:bitwidth];
        r[bitwidth*4-1-:bitwidth] <= b_top[cntb*WIDTH+bitwidth*4-1-:bitwidth];
        r[bitwidth*5-1-:bitwidth] <= b_top[cntb*WIDTH+bitwidth*5-1-:bitwidth];
        r[bitwidth*6-1-:bitwidth] <= b_top[cntb*WIDTH+bitwidth*6-1-:bitwidth];
        r[bitwidth*7-1-:bitwidth] <= b_top[cntb*WIDTH+bitwidth*7-1-:bitwidth];
        r[bitwidth*8-1-:bitwidth] <= b_top[cntb*WIDTH+bitwidth*8-1-:bitwidth];
        r[bitwidth*9-1-:bitwidth] <= b_top[cntb*WIDTH+bitwidth*9-1-:bitwidth];
        r[bitwidth*10-1-:bitwidth] <= b_top[cntb*WIDTH+bitwidth*10-1-:bitwidth];
        r[bitwidth*11-1-:bitwidth] <= b_top[cntb*WIDTH+bitwidth*11-1-:bitwidth];
        r[bitwidth*12-1-:bitwidth] <= b_top[cntb*WIDTH+bitwidth*12-1-:bitwidth];
        r[bitwidth*13-1-:bitwidth] <= b_top[cntb*WIDTH+bitwidth*13-1-:bitwidth];
        r[bitwidth*14-1-:bitwidth] <= b_top[cntb*WIDTH+bitwidth*14-1-:bitwidth];
        r[bitwidth*15-1-:bitwidth] <= b_top[cntb*WIDTH+bitwidth*15-1-:bitwidth];
        r[bitwidth*16-1-:bitwidth] <= b_top[cntb*WIDTH+bitwidth*16-1-:bitwidth];
      end
      else begin
        r <= 0;
      end

    end
  end
  
endmodule