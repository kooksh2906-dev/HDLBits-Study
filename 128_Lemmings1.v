module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    output	reg	walk_left,
    output	reg	walk_right
); //  

    // parameter LEFT=0, RIGHT=1,...
	localparam LEFT = 1'd0, RIGHT = 1'd1;
    reg state, next_state;
    reg	[1:0]	last_walk;

    always @(*) begin
        // State transition logic
        casex({state,bump_left,bump_right})
            {LEFT,2'b0x}	:	next_state = LEFT;
            {LEFT,2'b1x}	:	next_state = RIGHT;
            {RIGHT,2'bx0}	:	next_state = RIGHT;
            {RIGHT,2'bx1}	:	next_state = LEFT;
            default			:	next_state = state;
        endcase
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if(areset)
            state <= LEFT;
        else
            state <= next_state;
    end

    // Output logic
    // assign walk_left = (state == ...);
    // assign walk_right = (state == ...);
    always@(*) begin
        case(state)
            LEFT	:	{walk_left,walk_right} = 2'b10;
            RIGHT	:	{walk_left,walk_right} = 2'b01;
            default	:	{walk_left,walk_right} = last_walk;
        endcase
    end
    
    always@(*) begin
        if(areset)
            last_walk <= 2'b10;
        else
            last_walk <= {walk_left,walk_right};
    end

endmodule