module d_ff(
	input	wire	clk,d,//set,clr,
    output	reg		q//,qbar
);

    always@(posedge clk) begin
        q<=d;
    end
    
endmodule
        
module top_module (
    input clk,
    input x,
    output z
); 

    wire			exor2,and2,or2;
    reg		[2:0]	q = 3'b000;
    
    assign exor2 = q[0]^x;
    assign and2 = (~q[1])&x;
    assign or2 = (~q[2])|x;
    assign z = ~(|q);
    
    d_ff	u0(.clk(clk), .d(exor2), /*.set(), .clr(),*/ .q(q[0]));
    d_ff	u1(.clk(clk), .d(and2), /*.set(), .clr(),*/ .q(q[1]));
    d_ff	u2(.clk(clk), .d(or2), /*.set(), .clr(),*/ .q(q[2]));
    
endmodule