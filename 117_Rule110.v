module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q
);
    integer i;
    
    reg	[511:0]	next_q;
    
    always@(*) begin
        case({q[511],q[510]})
            2'd0	:	next_q[511] = 1'b0;
            2'd1	:	next_q[511] = 1'b1;
            2'd2	:	next_q[511] = 1'b1;
            2'd3	:	next_q[511] = 1'b1;
            default	:	next_q[511] = q[511];
        endcase
    end

    always@(*) begin
        for(i=1; i<511; i=i+1) begin
            case({q[i+1],q[i],q[i-1]})
                3'd0	:	next_q[i] = 1'b0;
                3'd1	:	next_q[i] = 1'b1;
                3'd2	:	next_q[i] = 1'b1;
                3'd3	:	next_q[i] = 1'b1;
                3'd4	:	next_q[i] = 1'b0;
                3'd5	:	next_q[i] = 1'b1;
                3'd6	:	next_q[i] = 1'b1;
                3'd7	:	next_q[i] = 1'b0;
                default	:	next_q[i] = q[i];
            endcase
        end
    end
        
    always@(*) begin
        case({q[1],q[0]})
            2'b00	:	next_q[0] = 1'b0;
            2'b01	:	next_q[0] = 1'b1;
            2'b10	:	next_q[0] = 1'b0;
            2'b11	:	next_q[0] = 1'b1;
            default	:	next_q[0] = q[0];
        endcase
    end
        
    always@(posedge clk) begin
        if(load)
            q <= data;
        else
            q <= next_q;
    end
    
endmodule