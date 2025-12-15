module top_module(
    input in,
    input [3:0] state,
    output [3:0] next_state,
    output out); //

    wire		VCC,GND;
    
    localparam A=2'd0, B=2'd1, C=2'd2, D=2'd3;
    
    assign VCC = 1'b1;
    assign GND = 1'b0;

    // State transition logic: Derive an equation for each state flip-flop.
    assign next_state[A] = (state[A]&(~in)) | (state[C]&(~in));
    assign next_state[B] = (state[A]&(in)) | (state[B]&(in)) | (state[D]&(in));
    assign next_state[C] = (state[B]&(~in)) | (state[D]&(~in));
    assign next_state[D] = state[C]&(in);

    // Output logic: 
    assign out = (state == 4'h8) | (state == 4'h9) | (state == 4'hA) | (state == 4'hB) |
        (state == 4'hC) | (state == 4'hD) | (state == 4'hE) | (state == 4'hF) ? VCC: GND; // 4'b1xxx => 1'b1

endmodule