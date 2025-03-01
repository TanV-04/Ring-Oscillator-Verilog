module controller (
    input clk,
    input reset,
    input start,
    output reg enable,
    output reg [1:0] pair_select,
    output reg done
);

    // Example FSM (you need to complete this)
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            enable <= 0;
            pair_select <= 0;
            done <= 0;
        end else begin
            // Implement proper FSM here
            // This is a placeholder
            if (start) begin
                enable <= 1;
                pair_select <= 0;  // First pair
            end
            // Cycle through pairs and finally set done=1
        end
    end
endmodule
