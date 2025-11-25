module top_module ( input clk, input d, output q );

wire	q1,q0;
    
my_dff u0( 
    .clk(clk),
    .d(d),
    .q(q0)
);    
    
my_dff u1( 
    .clk(clk),
    .d(q0),
    .q(q1)
);   

my_dff u2( 
    .clk(clk),
    .d(q1),
    .q(q)
);   

endmodule