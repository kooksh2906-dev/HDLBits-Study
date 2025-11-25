module top_module (
    input ring,
    input vibrate_mode,
    output ringer,       // Make sound
    output motor         // Vibrate
);

    assign ringer  = (vibrate_mode == 1'b1) ? 1'b0: ((ring == 1'b1)? 1'b1: 1'b0);
    assign motor = vibrate_mode & ring;

endmodule