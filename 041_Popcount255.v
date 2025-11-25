module top_module( 
    input [254:0] in,
    output reg	[7:0] out 
);

    integer i,j;
    reg	[254:0] and0;

   always@(*) begin
        out = 8'b0;
        for(i=0; i<255; i=i+1) begin
            and0[i] = in[i]&1'b1;
            out = out + and0[i];
        end
    end

endmodule