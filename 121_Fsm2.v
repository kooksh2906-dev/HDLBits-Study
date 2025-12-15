module top_module(
    input clk,
    input areset,    // Asynchronous reset to OFF
    input j,
    input k,
    output reg	out); //  

    localparam OFF=1'b0, ON=1'b1; 
    reg state, next_state;
    reg	out_keep;

    always @(*) begin
        // State transition logic
        casex({state,j,k})
            {OFF,2'b0x}	:	next_state = OFF;
            {OFF,2'b1x}	:	next_state = ON;
            {ON,2'bx0}	:	next_state = ON;
            {ON,2'bx1}	:	next_state = OFF;
            default		:	next_state = state;
        endcase
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if(areset)
            state <= OFF;
        else
            state <= next_state;
    end

    // Output logic
    // assign out = (state == ...);
    always@(*) begin
        case(state)
            OFF		:	out = 1'b0;
            ON		:	out = 1'b1;
            default	:	out = out_keep;
        endcase
    end
     
// reg for saving right before a clk-cycle state out to handle error state
// it dosen't matter using sequential logic, because it save right before a clk-cycle
// data, so these data can be used for current state(assume error state case) with
// combinational output logic 
    always@(posedge clk, posedge areset) begin
        if(areset)
            out_keep <= 1'b0;
        else
            out_keep <= out;
    end

endmodule