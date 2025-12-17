module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output	wire	[7:0]	out_byte,
    output	wire			done
); //
    localparam	START=4'd0,DATA0=4'd1,DATA1=4'd2,DATA2=4'd3,DATA3=4'd4,DATA4=4'd5,
    			DATA5=4'd6,DATA6=4'd7,DATA7=4'd8,STOP=4'd9,DONE=4'd10,IDLE=4'd11;
    reg	[3:0]	state, next_state;
    reg	[7:0]	last_byte;
    
    // Use FSM from Fsm_serial
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
            //DONE	:	{done,out_byte} = {1'b1,last_byte};//method1
            DONE	:	{done,out_byte} = {1'b1,data};//method2
            default	:	{done,out_byte} = 9'b0;
        endcase
    end
                
    // New: Datapath to latch input bits.
/*  
	//method1 - using a shift register
	wire	enable;
    assign	enable = ((state==DATA0)||(state==DATA1)||(state==DATA2)||(state==DATA3)||
                      (state==DATA4)||(state==DATA5)||(state==DATA6)||(state==DATA7))?
        			1'b1: 1'b0;
    
    always@(posedge clk) begin
        if(reset)
            last_byte <= 8'b0;
        else
            last_byte <= (enable)? {in,last_byte[7:1]}: last_byte;
    end
*/
    //method2 - using each data stored register
    wire	[7:0]	data;
    
    always@(posedge clk) begin
        if(reset)
            last_byte <= 8'b0;
        else
            last_byte <= data;
    end
    
    assign data[7] = (state==DATA7)? in: last_byte[7];
    assign data[6] = (state==DATA6)? in: last_byte[6];
    assign data[5] = (state==DATA5)? in: last_byte[5];
    assign data[4] = (state==DATA4)? in: last_byte[4];
    assign data[3] = (state==DATA3)? in: last_byte[3];
    assign data[2] = (state==DATA2)? in: last_byte[2];
    assign data[1] = (state==DATA1)? in: last_byte[1];
    assign data[0] = (state==DATA0)? in: last_byte[0];

endmodule