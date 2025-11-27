module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
); //
    wire	[3:0]	Q2,Q1,Q0;	
   
    assign c_enable[0] = 1'b1;
    assign c_enable[1] = (Q0 == 4'd9)? 1'b1: 1'b0;
    assign c_enable[2] = ((Q0 == 4'd9) && (Q1 == 4'd9))? 1'b1: 1'b0;
    assign OneHertz = ((Q0 == 4'd9) && (Q1 == 4'd9) && (Q2 == 4'd9))? 1'b1: 1'b0;
    
    bcdcount counter0 (.clk(clk), .reset(reset), .enable(c_enable[0]), .Q(Q0));
    bcdcount counter1 (.clk(clk), .reset(reset), .enable(c_enable[1]), .Q(Q1));
    bcdcount counter2 (.clk(clk), .reset(reset), .enable(c_enable[2]), .Q(Q2));

endmodule