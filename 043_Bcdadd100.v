module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );

    wire	[98:0]	carry;
    
    bcd_fadd u0(.a(a[3:0]), .b(b[3:0]), .cin(cin), .cout(carry[0]), .sum(sum[3:0]));
    
    genvar j;
    generate
        for(j=1; j<99; j=j+1) begin: u
            bcd_fadd DUT (.a(a[j*4+3 : j*4]), .b(b[j*4+3 : j*4]), .cin(carry[j-1]), .cout(carry[j]), .sum(sum[j*4+3 : j*4]));
        end
    endgenerate
    
    bcd_fadd u99(.a(a[399:396]), .b(b[399:396]), .cin(carry[98]), .cout(cout), .sum(sum[399:396]));        
        
endmodule