module bcd_adder(
    input	wire	[3:0]	a,b,
    input	wire			cin,
    output	wire			cout,
    output	wire	[3:0]	sum
);
    wire	[4:0]	sum_5, cout_5;
    
    assign cout_5 = (a+b+cin)/4'd10;
    assign cout = cout_5[0];
    assign sum_5 = (a+b+cin)%4'd10;
    assign sum = sum_5[3:0];
    
endmodule

module top_module ( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum );

    wire		carry2, carry1, carry0;
    
    bcd_adder u0(.a(a[3:0]), .b(b[3:0]), .cin(cin), .cout(carry0), .sum(sum[3:0]));
    bcd_adder u1(.a(a[7:4]), .b(b[7:4]), .cin(carry0), .cout(carry1), .sum(sum[7:4]));
    bcd_adder u2(.a(a[11:8]), .b(b[11:8]), .cin(carry1), .cout(carry2), .sum(sum[11:8]));
    bcd_adder u3(.a(a[15:12]), .b(b[15:12]), .cin(carry2), .cout(cout), .sum(sum[15:12]));
       
endmodule