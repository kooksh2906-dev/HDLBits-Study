module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output reg	done
); //
    localparam IDLE=2'd0, BYTE1=2'd1, BYTE2=2'd2, BYTE3=2'd3;
    reg	[1:0]	state, next_state;
    reg			last_data;
    
    always@(posedge clk) begin
        if(reset)
            last_data <= 1'b0;
        else
            last_data <= done;
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
            IDLE	:	done = 1'b0;
            BYTE1	:	done = 1'b0;
            BYTE2	:	done = 1'b0;
            BYTE3	:	done = 1'b1;
            default	:	done = last_data;
        endcase
    end

endmodule