module top_module (
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output [15:0] q
);

    always@(posedge clk) begin
        if(!resetn)
            q<=16'b0;
        else begin
            if(byteena == 2'b10)
                q[15:8]<=d[15:8];
            else if(byteena == 2'b01)
                q[7:0]<=d[7:0];
            else if(byteena == 2'b11)
                q<=d;
            else
                q<=q;
        end
    end
    
endmodule