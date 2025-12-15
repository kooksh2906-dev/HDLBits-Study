module top_module(
    input in,
    input [1:0] state,
    output [1:0] next_state,
    output reg	out); //

    localparam A=2'd0, B=2'd1, C=2'd2, D=2'd3;
    reg	out_keep;

    // State transition logic: next_state = f(state, in)
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
        
    // Output logic:  out = f(state) for a Moore state machine
    //assign out = (state == D)? 1'b1: 1'b0; 
    always@(*) begin
        case(state)
            A		:	out = 1'b0;
            B		:	out = 1'b0;
            C		:	out = 1'b0;
            D		:	out = 1'b1;
            default	:	out = out_keep;
        endcase
    end
    
    always@(*) begin
        out_keep = out;
    end

endmodule