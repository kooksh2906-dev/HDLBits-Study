module top_module(
    input clk,
    input in,
    input reset,
    output out
); //
    reg	[1:0]	state,next_state;
    wire		VCC,GND;
    
    assign GND = 1'b0;
    assign VCC = 1'b1;
    
    localparam A=2'd0, B=2'd1, C=2'd2, D=2'd3;
    // State transition logic
    always@(*) begin
        case({state,in})
            {A,1'b0}	:	next_state = A;
            {A,1'b1}	:	next_state = B;
            {B,1'b0}	:	next_state = C;
            {B,1'b1}	:	next_state = B;
            {C,1'b0}	:	next_state = A;
            {C,1'b1}	:	next_state = D;
            {D,1'b0}	:	next_state = C;
            {D,1'b1}	:	next_state = B;
            default		:	next_state = state;
        endcase
    end

    // State flip-flops with synchronous reset
    always@(posedge clk) begin
        if(reset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    always@(*) begin
        case(state)
            A		:	out = GND;
            B		:	out = GND;
            C		:	out = GND;
            D		:	out = VCC;
            default	:	out = GND;
        endcase
    end

endmodule