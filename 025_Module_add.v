module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);

wire	cin0;
wire	[15:0]	sum0,sum1;    
    
add16 u0(
    .a(a[15:0]),
    .b(b[15:0]),
    .cin(1'b0),
    .sum(sum0),
    .cout(cin0) 
);
    
add16 u1(
    .a(a[31:16]),
    .b(b[31:16]),
    .cin(cin0),
    .sum(sum1),
    .cout() 
);    
    
assign sum = {sum1,sum0};

endmodule