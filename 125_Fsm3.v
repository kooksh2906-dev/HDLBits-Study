module top_module(
    input clk,
    input in,
    input areset,
    output reg	out
); //
    reg	[1:0]	state, next_state;
    
    localparam A=2'd0, B=2'd1, C=2'd2, D=2'd3;
    reg	out_keep;
    
    // State transition logic
    always@(*) begin
        case({state,in})
            {A,1'b0}	:	next_state = A;
            {A,1'b1}	:	next_state = B;
            {B,1'b0}	:	next_state = C;
            {B,1'b1}	:	next_state = B;
            {C,1'b0}	:	next_state = A;
            {C,1'b1}	:	next_state = D;
            {D,1'b0}	:	next_state = C;
            {D,1'b1}	:	next_state = B;
            default		:	next_state = state;
        endcase
    end

    // State flip-flops with asynchronous reset
    always@(posedge clk, posedge areset) begin
        if(areset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    always@(*) begin
        case(state)
            A		:	out = 1'b0;
            B		:	out = 1'b0;
            C		:	out = 1'b0;
            D		:	out = 1'b1;
            default	:	out = out_keep;
        endcase
    end
    
    always@(posedge clk, posedge areset) begin
        if(areset)
            out_keep <= 1'b0;
        else
            out_keep <= out;
    end
    
endmodule