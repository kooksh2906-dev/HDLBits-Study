module top_module(
    input clk,
    input reset,    // Synchronous reset to OFF
    input j,
    input k,
    output out); //  

    parameter OFF=1'b0, ON=1'b1; 
    reg state, next_state;

    always @(*) begin
        // State transition logic
        casex({state,j,k})
            {OFF,1'b0,1'bx}	:	next_state = OFF;
            {OFF,1'b1,1'bx}	:	next_state = ON;
            {ON,1'bx,1'b0}	:	next_state = ON;
            {ON,1'bx,1'b1}	:	next_state = OFF;
            default			:	next_state = state;
        endcase
    end

    always @(posedge clk) begin
        // State flip-flops with synchronous reset
        if(reset)
            state <= OFF;
        else
            state <= next_state;
    end

    // Output logic
    assign out = state ? 1'b1: 1'b0;

endmodule