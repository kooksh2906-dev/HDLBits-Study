module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done
); //
    localparam IDLE=2'd0, BYTE1=2'd1, BYTE2=2'd2, BYTE3=2'd3;
    reg	[1:0]	state, next_state;
    reg	[24:0]	last_data;
    reg	[7:0]	byte3, byte2, byte1;
    
    // FSM from fsm_ps2
    always@(posedge clk) begin
        if(reset)
            last_data <= 25'b0;
        else
            last_data <= {done,out_bytes};
    end

    // State transition logic (combinational)
    always@(*) begin
        casex({state,in[3]})
            {IDLE,1'b0}		:	next_state = IDLE;
            {IDLE,1'b1}		:	next_state = BYTE1;
            {BYTE1,1'bx}	:	next_state = BYTE2;
            {BYTE2,1'bx}	:	next_state = BYTE3;
            {BYTE3,1'b0}	:	next_state = IDLE;
            {BYTE3,1'b1}	:	next_state = BYTE1;
            default			:	next_state = state;
        endcase
    end

    // State flip-flops (sequential)
    always@(posedge clk) begin
        if(reset)
            state <= IDLE;
        else
            state <= next_state;
    end
 
    // Output logic
    always@(*) begin
        case(state)
            IDLE	:	{done,out_bytes} = 25'b0;
            BYTE1	:	{done,out_bytes} = 25'b0;
            BYTE2	:	{done,out_bytes} = 25'b0;
            BYTE3	:	{done,out_bytes} = {1'b1,byte1,byte2,byte3};
            default	:	{done,out_bytes} = last_data;
        endcase
    end

    // New: Datapath to store incoming bytes.
    always@(posedge clk) begin
        if(reset)
            byte1 <= 8'b0;
        else
            byte1 <= ((state==IDLE)||(state==BYTE3))? in: byte1;
    end
    
    always@(posedge clk) begin
        if(reset)
            byte2 <= 8'b0;
        else
            byte2 <= (state==BYTE1)? in: byte2;
    end
    
    always@(posedge clk) begin
        if(reset)
            byte3 <= 8'b0;
        else
            byte3 <= (state==BYTE2)? in: byte3;
    end
   
endmodule