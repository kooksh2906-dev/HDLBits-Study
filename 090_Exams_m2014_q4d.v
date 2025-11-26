module top_module (
    input clk,
    input in, 
    output out
);

	wire d;
    reg	q;
    
    assign d = in^out;
    assign out = q;
    
    always@(posedge clk) begin
        q<=d;
    end
       
endmodule