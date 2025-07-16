module MUX_4_to_1(
    input       in1,
    input       in2,
    input       in3,
    input       in4,
    input [1:0] sel,
    output      out
);
    always@(*) begin
        case(sel)
            2'b00 : out = in1;
            2'b01 : out = in2;
            2'b10 : out = in3;
            2'b11 : out = in4;
            default : out = 0;
        endcase
    end
endmodule
