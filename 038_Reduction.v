module top_module (
    input [7:0] in,
    output parity); 

    always@(*) begin
        if(~^in)
            parity = 1'b0;
        else
            parity = 1'b1;
    end
            
endmodule