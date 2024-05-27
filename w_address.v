// Address Generator
module w_address (
    input [3:0] u_type_w,
    input [10:0] layer_w,
    output reg [4:0] w_a, // write alpha
    output reg [4:0] w_b // write beta
);

    localparam TYPE1  = 4'b0000;
    localparam TYPE2  = 4'b0001;
    localparam BOTTOM = 4'b0010;
    localparam TYPE3  = 4'b0011;

    wire [4:0] qwq;

    always @ (*) begin
        if (u_type_w == TYPE1 || u_type_w == TYPE2) begin
            case (layer_w)
                1024: w_a <= 9; // read alpa rom
                512: w_a <= 8;
                256: w_a <= 7;
                128: w_a <= 6;
                64: w_a <= 5;
                32: w_a <= 4;
                16: w_a <= 3;
                8: w_a <= 2;
                4: w_a <= 1;
                default: w_a <= 0;
            endcase
            w_b <= 0;
        end 
        else if (u_type_w == TYPE3) begin
            case (layer_w)
                512: w_b <= 9;
                256: w_b <= 8;
                128: w_b <= 7;
                64: w_b <= 6;
                32: w_b <= 5;
                16: w_b <= 4;
                8: w_b <= 3;
                4: w_b <= 2;
                default: w_b <= 0;
            endcase
            w_a <= 0;
        end 
        else begin
            w_a <= 0;
            w_b <= 1;
        end
    end

endmodule




