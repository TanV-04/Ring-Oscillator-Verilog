module comparator (
    input [31:0] count1,
    input [31:0] count2,
    output reg result
);
    always @(*) begin
        result = (count1 > count2) ? 1 : 0;
    end
endmodule
