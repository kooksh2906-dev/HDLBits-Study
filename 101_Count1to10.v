module top_module (
    input clk,
    input reset,
    output [3:0] q);
/*
//soluion1
    always@(posedge clk) begin
        if(reset || (q == 4'd10))
            q<= 4'd1;
        else
            q<=q+1'b1;
    end
*/  
//solution2
    always@(posedge clk) begin
        if(reset)
            q <= 4'd1;
        else
            q <= (q == 4'd10)? 4'd1: q+1'd1;
    end

endmodule