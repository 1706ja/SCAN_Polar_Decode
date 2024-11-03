// Address Generator
module r_address (
    input [3:0] u_type_r,
    input [10:0] layer_r,
    output reg [4:0] r_a, // read alpha
    output reg [4:0] r_b // read beta
);

    localparam TYPE1  = 4'b0000;
    localparam TYPE2  = 4'b0001;
    localparam BOTTOM = 4'b0010;
    localparam TYPE3  = 4'b0011;

    wire [4:0] qwq;

    always @ (*) begin
        if (u_type_r == TYPE1 || u_type_r == TYPE2) begin
            case (layer_r)
                1024: r_a <= 10; // read alpa rom
                512: r_a <= 9;
                256: r_a <= 8;
                128: r_a <= 7;
                64: r_a <= 6;
                32: r_a <= 5;
                16: r_a <= 4;
                8: r_a <= 3;
                4: r_a <= 2;
                default: r_a <= 0;
            endcase

            case (layer_r)
                1024: r_b <= 9; // read alpa rom
                512: r_b <= 8;
                256: r_b <= 7;
                128: r_b <= 6;
                64: r_b <= 5;
                32: r_b <= 4;
                16: r_b <= 3;
                8: r_b <= 2;
                4: r_b <= 1;
                default: r_b <= 0;
            endcase
        end 
        else if (u_type_r == TYPE3) begin
            case (layer_r)
                512: r_a <= 9;
                256: r_a <= 8;
                128: r_a <= 7;
                64: r_a <= 6;
                32: r_a <= 5;
                16: r_a <= 4;
                8: r_a <= 3;
                4: r_a <= 2;
                default: r_a <= 0;
            endcase

            case (layer_r)
                512: r_b <= 8;
                256: r_b <= 7;
                128: r_b <= 6;
                64: r_b <= 5;
                32: r_b <= 4;
                16: r_b <= 3;
                8: r_b <= 2;
                4: r_b <= 1;
                default: r_b <= 0;
            endcase
        end 
        else begin
            r_a <= 1;
            r_b <= 10;
        end
    end

endmodule




