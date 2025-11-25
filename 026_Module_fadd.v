//add16 is provided, but add1 is not provided
//so, we use add16 with instanciation,
//we must write the add1(1-bit full-adder) module
module add1 ( input a, input b, input cin, output sum, output cout);

assign {cout,sum} = a+b+cin; 

endmodule

module top_module (
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);

wire	[15:0]	sum0,sum1;
wire		c;

add16	u0(.a(a[15:0]), .b(b[15:0]), .cin(1'b0), .sum(sum0), .cout(c));
add16	u1(.a(a[31:16]), .b(b[31:16]), .cin(c), .sum(sum1), .cout());

assign sum = {sum1,sum0};
    
endmodule