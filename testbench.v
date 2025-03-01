`timescale 1ns / 1ps

module testbench;
    reg clk, reset, start;
    wire [3:0] puf_response;
    wire done;

    ro_puf_top dut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .puf_response(puf_response),
        .done(done)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Stimulus
    initial begin
        reset = 1;
        start = 0;
        // Apply Reset for initial 20ns
        #20 reset = 0;

        // Apply start signal
        #10 start = 1;
        #20 start = 0;

        // Wait until done goes high
        wait (done == 1);

        // Display PUF Response
        $display("PUF Response = %b", puf_response);
        $stop;
    end
endmodule
