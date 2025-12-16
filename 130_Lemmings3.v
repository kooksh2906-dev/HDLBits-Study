module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output	reg	walk_left,
    output	reg	walk_right,
    output	reg	aaah,
    output	reg	digging 
);
    localparam	LEFT=3'd0 , RIGHT=3'd1, DIG_LEFT=3'd2,
    			DIG_RIGHT=3'd3, FALL_LEFT=3'd4, FALL_RIGHT=3'd5;
    reg	[2:0]	state, next_state;
    reg	[3:0]	last_walk;
    
    always@(posedge clk, posedge areset) begin
        if(areset)
            state <= LEFT;
        else
            state <= next_state;
    end
    
    always@(*) begin
        casex({state,ground,dig,bump_left,bump_right})
            //LEFT
            {LEFT,4'b0xxx}			:	next_state = FALL_LEFT;
            {LEFT,4'b100x}			:	next_state = LEFT;
            {LEFT,4'b101x}			:	next_state = RIGHT;
            {LEFT,4'b11xx}			:	next_state = DIG_LEFT;
            //RIGHT
            {RIGHT,4'b0xxx}			:	next_state = FALL_RIGHT;
            {RIGHT,4'b10x0}			:	next_state = RIGHT;
            {RIGHT,4'b10x1}			:	next_state = LEFT;
            {RIGHT,4'b11xx}			:	next_state = DIG_RIGHT;
            //DIG_LEFT
            {DIG_LEFT,4'b0xxx}		:	next_state = FALL_LEFT;
            {DIG_LEFT,4'b11xx}		:	next_state = DIG_LEFT;
            //DIG_RIGHT
            {DIG_RIGHT,4'b0xxx}		:	next_state = FALL_RIGHT;
            {DIG_RIGHT,4'b11xx}		:	next_state = DIG_RIGHT;
            //FALL_LEFT
            {FALL_LEFT,4'b0xxx}		:	next_state = FALL_LEFT;
            {FALL_LEFT,4'b1xxx}		:	next_state = LEFT;
            //FALL_RIGHT
            {FALL_RIGHT,4'b0xxx}	:	next_state = FALL_RIGHT;
            {FALL_RIGHT,4'b1xxx}	:	next_state = RIGHT;
            default					:	next_state = state;
        endcase
    end
    
    always@(*) begin
        case(state)
            LEFT		:	{aaah,digging,walk_left,walk_right} = 4'b0010;
            RIGHT		:	{aaah,digging,walk_left,walk_right} = 4'b0001;
            DIG_LEFT	:	{aaah,digging,walk_left,walk_right} = 4'b0100;
            DIG_RIGHT	:	{aaah,digging,walk_left,walk_right} = 4'b0100;
            FALL_LEFT	:	{aaah,digging,walk_left,walk_right} = 4'b1000;
            FALL_RIGHT	:	{aaah,digging,walk_left,walk_right} = 4'b1000;
            default		:	{aaah,digging,walk_left,walk_right} = last_walk;
        endcase
    end
    
    always@(posedge clk, posedge areset) begin
        if(areset)
            last_walk <= 4'b0010;
        else
            last_walk <= {aaah,digging,walk_left,walk_right};
    end
    
endmodule