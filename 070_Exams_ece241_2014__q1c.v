module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
); //
    wire	[8:0]	total;
    wire			cout,cflow;	
    // assign s = ...
    // assign overflow = ...
    assign {cflow,s[6:0]} = a[6:0]+b[6:0];
    assign {cout,s} = {a[7],7'b0}+{b[7],7'b0}+{cflow,s[6:0]};
    
    assign overflow = (({cout,cflow} == 2'b01)^({cout,cflow} == 2'b10))? 1'b1: 1'b0; 
    
endmodule