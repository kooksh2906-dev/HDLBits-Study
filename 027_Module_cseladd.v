module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);

wire		cout;
wire	[15:0]	sum0,sum1,sum1_a,sum1_b;
    
add16	u0(.a(a[15:0]), .b(b[15:0]), .cin(1'b0), .sum(sum0), .cout(cout));
add16	u1_a(.a(a[31:16]), .b(b[31:16]), .cin(1'b0), .sum(sum1_a), .cout());
add16	u1_b(.a(a[31:16]), .b(b[31:16]), .cin(1'b1), .sum(sum1_b), .cout());
 
assign sum1 = cout ? sum1_b : sum1_a;
assign sum = {sum1,sum0};
    
endmodule