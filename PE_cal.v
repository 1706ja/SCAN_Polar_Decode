// We devide 4 inputs as a, b, c, d for simplicity in operation
// Type1 : P*Q-1:0
// Type2 : 2*P*Q-1:P*Q
// Type3 : Everything
`timescale 1ns / 1ps
module PE_cal #(parameter WIDTH = 6, P = 64)(
    input [P*WIDTH-1:0] a,//alpha left (left child)
    input [P*WIDTH-1:0] b,//alpha right (right child)
    input [P*WIDTH-1:0] c,//beta left (left child)
    input [P*WIDTH-1:0] d,//beta right (right child)
    input w1, //enable for f1
    input w2, //enable for f2
    output [2*P*WIDTH-1:0] out
    );
    wire [P*WIDTH-1:0] o1, o2;
    f1_array #(.Q(WIDTH),.P(P)) ff1(.enable(w1),.a(a),.b(b),.c(c),.d(o1)); // w1 -> o1 = min(a, b + c), !w1 -> 0
    f2_array #(.Q(WIDTH),.P(P)) ff2(.enable(w2),.a(a),.b(d),.c(b),.d(o2)); // o2 = min(a, d) + b, !w1 -> 0 
    assign out[2*P*WIDTH-1:P*WIDTH] = o2;
    assign out[P*WIDTH-1:0] = o1;
endmodule