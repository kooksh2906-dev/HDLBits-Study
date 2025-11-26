module top_module(
    input a,
    input b,
    input c,
    output out  ); 

    always@(*) begin
        casex({a,b,c})
            3'b000	:	out = 1'b0;
            3'b100	:	out = 1'b1;
            3'bx01	:	out = 1'b1;
            3'bx10	:	out = 1'b1;
            3'bx11	:	out = 1'b1;
            default	:	out = 1'bx;
        endcase
    end
    
endmodule