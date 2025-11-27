module top_module (
    input clk,
    input reset,        // Synchronous active-high reset
    output [3:0] q);
/*
//solution1
    always@(posedge clk) begin
        if(reset)
            q<=4'b0;
        else begin
            q<=q+1'b1;
            if(q == 4'd9)
            	q<=4'b0;
    		end
    end
*/  
//solution2
    always@(posedge clk) begin
        if(reset)
            q<=4'b0;
        else
            q<=(q == 4'd9)? 4'b0: q+1'b1;
    end
    
endmodule