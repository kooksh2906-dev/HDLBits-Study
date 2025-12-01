module MUXDFF (
	input	wire		clk, R, E, L, w, Q_in,
    output	reg			Q
);
    always@(posedge clk) begin
        casex({E,L})
            2'b00	:	Q <= Q_in;
            2'bx1	:	Q <= R;
            2'b10	:	Q <= w;
            default	:	Q <= 1'bx;
        endcase
    end
    
endmodule

module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); //
    MUXDFF	u0(.clk(KEY[0]), .R(SW[0]), .E(KEY[1]), .L(KEY[2]), .w(LEDR[1]), .Q_in(LEDR[0]), .Q(LEDR[0]));
    MUXDFF	u1(.clk(KEY[0]), .R(SW[1]), .E(KEY[1]), .L(KEY[2]), .w(LEDR[2]), .Q_in(LEDR[1]), .Q(LEDR[1]));
    MUXDFF	u2(.clk(KEY[0]), .R(SW[2]), .E(KEY[1]), .L(KEY[2]), .w(LEDR[3]), .Q_in(LEDR[2]), .Q(LEDR[2]));
    MUXDFF	u3(.clk(KEY[0]), .R(SW[3]), .E(KEY[1]), .L(KEY[2]), .w(KEY[3]), .Q_in(LEDR[3]), .Q(LEDR[3]));
    
endmodule