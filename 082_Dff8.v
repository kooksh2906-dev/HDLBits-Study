module d_ff(
	input	wire		clk,
    input	wire		d,
    output	wire		q
);
    always@(posedge clk) begin
        q<=d;
    end
endmodule

module top_module (
    input clk,
    input [7:0] d,
    output [7:0] q
);

    genvar i;
    generate
        for(i=0; i<8; i=i+1) begin: u
            d_ff DUT (.clk(clk), .d(d[i]), .q(q[i]));
        end
    endgenerate
    
endmodule