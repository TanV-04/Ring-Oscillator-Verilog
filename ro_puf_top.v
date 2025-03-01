module ro_puf_top (
    input clk,
    input reset,
    input start,
    output reg [3:0] puf_response,
    output reg done
);
    wire enable;
    wire [1:0] pair_select;
    wire ro1, ro2, ro3, ro4, ro5, ro6, ro7, ro8;
    wire [31:0] count1, count2;
    wire bit0, bit1, bit2, bit3;

    controller ctrl (
        .clk(clk),
        .reset(reset),
        .start(start),
        .enable(enable),
        .pair_select(pair_select),
        .done(done)
    );
    ring_oscillator RO1 (.ro_out(ro1));
    ring_oscillator RO2 (.ro_out(ro2));
    ring_oscillator RO3 (.ro_out(ro3));
    ring_oscillator RO4 (.ro_out(ro4));
    ring_oscillator RO5 (.ro_out(ro5));
    ring_oscillator RO6 (.ro_out(ro6));
    ring_oscillator RO7 (.ro_out(ro7));
    ring_oscillator RO8 (.ro_out(ro8));
	 
	     frequency_counter FC1 (
        .clk(clk),
        .enable(enable),
        .ro_signal((pair_select == 0) ? ro1 : (pair_select == 1) ? ro3 : (pair_select == 2) ? ro5 : ro7),
        .count(count1)
    );
    frequency_counter FC2 (
        .clk(clk),
        .enable(enable),
        .ro_signal((pair_select == 0) ? ro2 : (pair_select == 1) ? ro4 : (pair_select == 2) ? ro6 : ro8),
        .count(count2)
    );
	 
	 comparator COMP0 (.count1(count1), .count2(count2), .result(bit0));
    comparator COMP1 (.count1(count1), .count2(count2), .result(bit1));
    comparator COMP2 (.count1(count1), .count2(count2), .result(bit2));
    comparator COMP3 (.count1(count1), .count2(count2), .result(bit3));
	 
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            puf_response <= 4'b0000;
            done <= 0;
        end else if (enable) begin
            case (pair_select)
                2'b00: puf_response[0] <= bit0;
                2'b01: puf_response[1] <= bit1;
                2'b10: puf_response[2] <= bit2;
                2'b11: puf_response[3] <= bit3;
            endcase
        end
    end
endmodule
