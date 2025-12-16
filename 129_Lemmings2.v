module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output	reg	walk_left,
    output	reg	walk_right,
    output	reg	aaah 
);
    localparam LEFT=2'd0, RIGHT=2'd1, FALL_LEFT=2'd2, FALL_RIGHT=2'd3;
    reg	[1:0]	state, next_state;
    reg	[2:0]	last_walk;
    
    always@(posedge clk, posedge areset) begin
        if(areset)
            state <= LEFT;
        else
            state <= next_state;
    end
    
    always@(*) begin
        casex({state,ground,bump_left,bump_right})
            //LEFT
            {LEFT,3'b0xx}		:	next_state = FALL_LEFT;
            {LEFT,3'b10x}		:	next_state = LEFT;
            {LEFT,3'b11x}		:	next_state = RIGHT;
            //RIGHT
            {RIGHT,3'b0xx}		:	next_state = FALL_RIGHT;
            {RIGHT,3'b1x0}		:	next_state = RIGHT;
            {RIGHT,3'b1x1}		:	next_state = LEFT;
            //FALL_LEFT
            {FALL_LEFT,3'b0xx}	:	next_state = FALL_LEFT;
            {FALL_LEFT,3'b1xx}	:	next_state = LEFT;
            //FALL_RIGHT
            {FALL_RIGHT,3'b0xx}	:	next_state = FALL_RIGHT;
            {FALL_RIGHT,3'b1xx}	:	next_state = RIGHT;
            default				:	next_state = state;
        endcase
    end

    always@(*) begin
        case(state)
            LEFT		:	{aaah,walk_left,walk_right} = 3'b010;
            RIGHT		:	{aaah,walk_left,walk_right} = 3'b001;
            FALL_LEFT	:	{aaah,walk_left,walk_right} = 3'b100;
            FALL_RIGHT	:	{aaah,walk_left,walk_right} = 3'b100;
            default		:	{aaah,walk_left,walk_right} = last_walk;
        endcase
    end
    
    always@(posedge clk, posedge areset) begin
        if(areset)
            last_walk <= 3'b010;
        else
            last_walk <= {aaah,walk_left,walk_right};
    end
    
endmodule