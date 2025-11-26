module edge_capture (
    input clk,
    input reset,
    input  in,
    output	reg	 out
);
    reg	d_last;
    
    always@(posedge clk) begin
        d_last<=in;
    end
    
    always@(posedge clk) begin
        if(reset)
            out<=1'b0;
        else begin
            case({in,d_last})
                2'b01	:	out<=1'b1;
                default	:	out<=out;
            endcase
        end
    end
    
endmodule
                


module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output	reg	[31:0] out
);

    genvar i;
    generate
        for(i=0; i<32; i=i+1) begin: u
            edge_capture DUT (.clk(clk), .reset(reset), .in(in[i]), .out(out[i])); 
        end
    endgenerate
    
endmodule