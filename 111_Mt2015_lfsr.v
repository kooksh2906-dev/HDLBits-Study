module	sub_module(
	input	wire		clk,L,R,Q_in,
    output	reg			Q
);
    reg	Q_next;
    
    always@(*) begin
        if(L)
            Q_next = R;
        else
            Q_next = Q_in;
    end
      
    always@(posedge clk) begin
		Q <= Q_next;
    end
    
endmodule
            
module top_module (
	input [2:0] SW,      // R
	input [1:0] KEY,     // L and clk
	output [2:0] LEDR);  // Q
    
    wire	exor_LEDR12;
    
    assign exor_LEDR12 = LEDR[1]^LEDR[2];

    sub_module	u0(.clk(KEY[0]), .L(KEY[1]), .R(SW[0]), .Q_in(LEDR[2]), .Q(LEDR[0]));
    sub_module	u1(.clk(KEY[0]), .L(KEY[1]), .R(SW[1]), .Q_in(LEDR[0]), .Q(LEDR[1]));
    sub_module	u2(.clk(KEY[0]), .L(KEY[1]), .R(SW[2]), .Q_in(exor_LEDR12), .Q(LEDR[2]));
        
endmodule