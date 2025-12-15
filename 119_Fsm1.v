module top_module(
    input clk,
    input areset,    // Asynchronous reset to state B
    input in,
    output reg	out);//  

    localparam A=1'b0, B=1'b1; 
    reg state, next_state;
    reg	out_keep;

    always @(*) begin    // This is a combinational always block
        // State transition logic
        case({state,in})
            {A,1'b0}	:	next_state = B;
            {A,1'b1}	:	next_state = A;
            {B,1'b0}	:	next_state = A;
            {B,1'b1}	:	next_state = B;
            default		:	next_state = state;//case maintaining current state for error
        endcase
    end

    always @(posedge clk, posedge areset) begin    // This is a sequential always block
        // State flip-flops with asynchronous reset
        if(areset)
            state <= B;
        else
            state <= next_state;
    end

    // Output logic
    // assign out = (state == ...);
    // assign out = (state == A)? 1'b0: 1'b1;
    always@(*) begin
        case(state)
            A		:	out = 1'b0;
            B		:	out	= 1'b1;
            default	:	out = out_keep;//case maintaining current state for error
        endcase
    end
    
    always@(posedge clk) begin
        out_keep <= out;
    end
            
endmodule