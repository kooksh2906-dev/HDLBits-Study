module top_module( 
    input [2:0] in,
    output [1:0] out 
);
    
    wire	[2:0]	and_out;
    
    assign and_out = in & 3'b111;
    assign out = and_out[2]+and_out[1]+and_out[0];

endmodule