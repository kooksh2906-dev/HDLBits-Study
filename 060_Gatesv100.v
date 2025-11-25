module top_module( 
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different );

    integer i;
    
    always@(*) begin
        for(i=0; i<99; i=i+1) begin
            if(in[i+1]&in[i])
                out_both[i] = 1'b1;
            else
                out_both[i] = 1'b0;
        end
    end
    
    always@(*) begin
        for(i=1; i<100; i=i+1) begin
            if(in[i]|in[i-1])
                out_any[i] = 1'b1;
            else
                out_any[i] = 1'b0;
        end
    end
    
    always@(*) begin
        out_different[99] = in[0]^in[99];
        for(i=0; i<99; i=i+1) begin
            if(in[i+1]^in[i])
                out_different[i] = 1'b1;
            else
                out_different[i] = 1'b0;
        end
    end
    
endmodule