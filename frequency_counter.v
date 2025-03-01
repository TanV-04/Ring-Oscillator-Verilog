module frequency_counter (
    input clk,
    input enable,
    input ro_signal,
    output reg [31:0] count
);
    always @(posedge clk) begin
        if (!enable)
            count <= 0;
        else if (ro_signal)
            count <= count + 1;
    end
endmodule
