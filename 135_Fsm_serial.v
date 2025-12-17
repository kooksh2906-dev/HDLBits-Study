module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output	reg	done
); 
    localparam	START=4'd0,DATA0=4'd1,DATA1=4'd2,DATA2=4'd3,DATA3=4'd4,DATA4=4'd5,
    			DATA5=4'd6,DATA6=4'd7,DATA7=4'd8,STOP=4'd9,DONE=4'd10,IDLE=4'd11;
    reg	[3:0]	state, next_state;
    
    always@(posedge clk) begin
        if(reset)
            state <= START;
        else
            state <= next_state;
    end
    
    always@(*) begin
        casex({state,in})
            {START,1'b0}	:	next_state = DATA0;//receive start bit
            {START,1'b1}	:	next_state = START;//until receive start bit
            {DATA0,1'bx}	:	next_state = DATA1;
            {DATA1,1'bx}	:	next_state = DATA2;
            {DATA2,1'bx}	:	next_state = DATA3;
            {DATA3,1'bx}	:	next_state = DATA4;
            {DATA4,1'bx}	:	next_state = DATA5;
            {DATA5,1'bx}	:	next_state = DATA6;
            {DATA6,1'bx}	:	next_state = DATA7;
            {DATA7,1'bx}	:	next_state = STOP;
            {STOP,1'b0}		:	next_state = IDLE;//receive stop bit
            {STOP,1'b1}		:	next_state = DONE;//no receive stop bit
            {DONE,1'b0}		:	next_state = DATA0;//equal to state 'START'
            {DONE,1'b1}		:	next_state = START;//equal to state 'START'
            {IDLE,1'b0}		:	next_state = IDLE;//until receive stop bit
            {IDLE,1'b1}		:	next_state = START;
            default			:	next_state = state;
        endcase
    end
    
    always@(*) begin
        case(state)
            DONE	:	done = 1'b1;
            default	:	done = 1'b0;
        endcase
    end
                
endmodule