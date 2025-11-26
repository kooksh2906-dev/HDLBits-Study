module full_adder(
	input	wire		a,b,cin,
    output	wire		cout,sum
);
    assign {cout,sum} = a+b+cin;

endmodule

module top_module( 
    input [2:0] a, b,
    input cin,
    output [2:0] cout,
    output [2:0] sum );
/*
    //version1
    full_adder u0(.a(a[0]), .b(b[0]), .cin(cin), .cout(cout[0]), .sum(sum[0]));
    full_adder u1(.a(a[1]), .b(b[1]), .cin(cout[0]), .cout(cout[1]), .sum(sum[1]));
    full_adder u2(.a(a[2]), .b(b[2]), .cin(cout[1]), .cout(cout[2]), .sum(sum[2]));
*/   
    //version2
    assign {cout[0],sum[0]} = a[0]+b[0]+cin;
    assign {cout[1],sum[1:0]} = {a[1],1'b0}+{b[1],1'b0}+{cout[0],sum[0]};
    assign {cout[2],sum} = {a[2],2'b0}+{b[2],2'b0}+{cout[1],sum[1:0]};
    
endmodule