module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output 	reg dfr
); 
/*    
	// method1 - use 4 states
	// in this case, make dfr's state reg separately, so this method is so annoying
    reg	[1:0]	state, next_state;

    
    localparam st_0 = 2'd0, st_1 = 2'd1, st_2 = 2'd2, st_3 = 2'd3; 
    
    always@(posedge clk) begin
        if(reset)
            state <= st_0;
        else
            state <= next_state;
    end
    
    always@(*) begin
        casex({state,s})
            {st_0,3'b000}	:	next_state = st_0;
            {st_0,3'b001}	:	next_state = st_1;
            {st_1,3'b000}	:	next_state = st_0;//dfr
            {st_1,3'b001}	:	next_state = st_1;//dfr
            {st_1,3'b011}	:	next_state = st_2;
            {st_2,3'b001}	:	next_state = st_1;//dfr
            {st_2,3'b011}	:	next_state = st_2;//dfr
            {st_2,3'b111}	:	next_state = st_3;
            {st_3,3'b011}	:	next_state = st_2;//dfr
            {st_3,3'b111}	:	next_state = st_3;
            default			:	next_state = state;
        endcase
    end
 
    always@(*) begin
        case(state)
            st_0	:	{fr3,fr2,fr1} = 3'b111;
            st_1	:	{fr3,fr2,fr1} = 3'b011;
            st_2	:	{fr3,fr2,fr1} = 3'b001;
            st_3	:	{fr3,fr2,fr1} = 3'b000;
            default	:	{fr3,fr2,fr1} = 3'b000;
        endcase
    end

    always@(posedge clk) begin
        if(reset)
            dfr <= 1'b1;
        else begin
            if(state < next_state)
                dfr <= 1'b0;
            else if(state > next_state)
                dfr <= 1'b1;
            else
                dfr <= dfr;
        end
    end
*/
    //method2 - use 6 states which is upper and lower each other considering dfr
    //assumed that moves a only one state up or down, and maintaing
    // state name meaning _0 -> dfr is 0, _1 -> dfr is 1   
    localparam A1 = 3'd0, B0 = 3'd1, B1 = 3'd2, C0 = 3'd3, C1 = 3'd4, D0 = 3'd5;
    reg	[3:0]	state, next_state, out_keep;
    
    always@(posedge clk) begin
        if(reset)
            state <= A1;
        else
            state <= next_state;
    end
    
    always@(*) begin
        casex({state,s})
            //A
            {A1,3'bxx0}	:	next_state = A1;
            {A1,3'bxx1}	:	next_state = B0;
            //B
            {B0,3'bxx0}	:	next_state = A1;
            {B0,3'bx01}	:	next_state = B0;
            {B0,3'bx11}	:	next_state = C0;
            {B1,3'bxX0}	:	next_state = A1;
            {B1,3'bx01}	:	next_state = B1;
            {B1,3'bx11}	:	next_state = C0;
            //C
            {C0,3'bx01}	:	next_state = B1;
            {C0,3'b011}	:	next_state = C0;
            {C0,3'b111}	:	next_state = D0;
            {C1,3'bx01}	:	next_state = B1;
            {C1,3'b011}	:	next_state = C1;
            {C1,3'b111}	:	next_state = D0;
            //D
            {D0,3'b011}	:	next_state = C1;
            {D0,3'b111}	:	next_state = D0;
            default		:	next_state = state;
        endcase
    end
    
    always@(*) begin
        case(state)
            A1		:	{fr1,fr2,fr3,dfr} = 4'b1111;
            B0		:	{fr1,fr2,fr3,dfr} = 4'b1100;
            B1		:	{fr1,fr2,fr3,dfr} = 4'b1101;
            C0		:	{fr1,fr2,fr3,dfr} = 4'b1000;
            C1		:	{fr1,fr2,fr3,dfr} = 4'b1001;
            D0		:	{fr1,fr2,fr3,dfr} = 4'b0000;
            default	:	{fr1,fr2,fr3,dfr} = out_keep;
        endcase
    end
    
    always@(posedge clk) begin
        if(reset)
            out_keep <= 4'b1111;
        else
            out_keep <= {fr1,fr2,fr3,dfr};
    end

endmodule