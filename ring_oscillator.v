module ring_oscillator (
    output wire ro_out
);
    wire w1, w2, w3, w4, w5;
    assign w1 = ~w5;
    assign w2 = ~w1;
    assign w3 = ~w2;
    assign w4 = ~w3;
    assign w5 = ~w4;
    assign ro_out = w5;
endmodule
