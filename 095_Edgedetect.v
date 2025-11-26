module detect(
	input wire		clk,
    input wire 		in,
    output reg	 	pedge
);
    reg		q;
     
    always@(posedge clk) begin
        q<=in;
    end  
	
    always@(posedge clk) begin
        case({q,in})
            2'b01	:	pedge<=1'b1;
            default	:	pedge<=1'b0;
        endcase
    end
endmodule

module top_module (
    input clk,
    input [7:0] in,
    output reg	[7:0] pedge
);

    genvar i;
    generate
        for(i=0; i<8; i=i+1) begin:	u
            detect	DUT( .clk(clk), .in(in[i]), .pedge(pedge[i]));
        end
    endgenerate
    
endmodule