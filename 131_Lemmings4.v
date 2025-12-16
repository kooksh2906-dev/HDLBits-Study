module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging 
);
    localparam	LEFT=3'd0 , RIGHT=3'd1, DIG_LEFT=3'd2, DIG_RIGHT=3'd3,
    			FALL_LEFT=3'd4, FALL_RIGHT=3'd5, OOPS=3'd6;
    reg	[2:0]	state, next_state;
    reg	[3:0]	last_walk;
    reg	[9:0]	cnt;
    wire		flag_fall;
    
    //flag to move to OOPS state
    //Comparing to the counter block below, you may ask,
    //"When ground is 1, counter becomes 0, so isn't the same for flag?"
    //However, while the counter block is sequential logic, 
    //the flag is combinational logic.
    //So the flag captures the counter value for the current clock-cycle,
    //and on the next clock-cycle the counter will be 0.
    assign flag_fall = ((ground == 1'b1)&&(cnt > 10'd20))? 1'b1: 1'b0;
    
    always@(posedge clk, posedge areset) begin
        if(areset)
            cnt <= 10'b0;
        else
            cnt <= (ground == 1'b0)? cnt+1'b1: 10'b0;
    end
    
    always@(posedge clk, posedge areset) begin
        if(areset)
            state <= LEFT;
        else
            state <= next_state;
    end
    
    always@(*) begin
        casex({state,flag_fall,ground,dig,bump_left,bump_right})
            //LEFT
            {LEFT,5'bx0xxx}			:	next_state = FALL_LEFT;
            {LEFT,5'bx100x}			:	next_state = LEFT;
            {LEFT,5'bx101x}			:	next_state = RIGHT;
            {LEFT,5'bx11xx}			:	next_state = DIG_LEFT;
            //RIGHT
            {RIGHT,5'bx0xxx}		:	next_state = FALL_RIGHT;
            {RIGHT,5'bx10x0}		:	next_state = RIGHT;
            {RIGHT,5'bx10x1}		:	next_state = LEFT;
            {RIGHT,5'bx11xx}		:	next_state = DIG_RIGHT;
            //DIG_LEFT
            {DIG_LEFT,5'bx0xxx}		:	next_state = FALL_LEFT;
            {DIG_LEFT,5'bx11xx}		:	next_state = DIG_LEFT;
            //DIG_RIGHT
            {DIG_RIGHT,5'bx0xxx}	:	next_state = FALL_RIGHT;
            {DIG_RIGHT,5'bx11xx}	:	next_state = DIG_RIGHT;
            //FALL_LEFT
            {FALL_LEFT,5'b00xxx}	:	next_state = FALL_LEFT;
            {FALL_LEFT,5'b01xxx}	:	next_state = LEFT;
            {FALL_LEFT,5'b1xxxx}	:	next_state = OOPS;
            //FALL_RIGHT
            {FALL_RIGHT,5'b00xxx}	:	next_state = FALL_RIGHT;
            {FALL_RIGHT,5'b01xxx}	:	next_state = RIGHT;
            {FALL_RIGHT,5'b1xxxx}	:	next_state = OOPS;
            //OOPS
            {OOPS,5'bxxxxx}			:	next_state = OOPS;
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
            OOPS		:	{aaah,digging,walk_left,walk_right} = 4'b0000;
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