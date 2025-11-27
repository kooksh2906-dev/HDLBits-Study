//I usually prefer using hierarchical top-sub module methode
//solution1

module bcd_count(
	input	wire		clk,reset,enable,
    output	reg	[3:0]	q
);
    always@(posedge clk) begin
        if(reset)
            q <= 4'd0;
        else if(enable)
            q <= (q==4'd9)? 1'b0: q+1'b1;
        else
            q <= q;
    end
    
endmodule

module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);

    wire	enable;
    
    assign enable = 1'b1;
    assign ena[1] = (q[3:0] == 4'd9)? 1'b1: 1'b0;
    assign ena[2] = ((q[3:0] == 4'd9) && (q[7:4] == 4'd9))? 1'b1: 1'b0;
    assign ena[3] = ((q[3:0] == 4'd9)&&(q[7:4] == 4'd9)&&(q[11:8] == 4'd9))? 1'b1: 1'b0;
    
    bcd_count	u0(.clk(clk), .reset(reset), .enable(enable), .q(q[3:0]));
    bcd_count	u1(.clk(clk), .reset(reset), .enable(ena[1]), .q(q[7:4]));
    bcd_count	u2(.clk(clk), .reset(reset), .enable(ena[2]), .q(q[11:8]));
    bcd_count	u3(.clk(clk), .reset(reset), .enable(ena[3]), .q(q[15:12]));
/*  
//solution2
    assign ena[1] = (q[3:0] == 4'h9)? 1'b1: 1'b0;
    assign ena[2] = ((q[7:4] == 4'h9)&&(q[3:0] == 4'h9))? 1'b1: 1'b0;
    assign ena[3] = ((q[11:8] == 4'h9)&&(q[7:4] == 4'h9)&&(q[3:0] == 4'h9))? 1'b1: 1'b0;
    
    
    always@(posedge clk) begin
        if(reset)
            q <= 16'h0;
        else begin
            q[3:0]<=(q[3:0] == 4'h9)? 4'h0: q[3:0]+1'b1;
            if(ena[1] == 1'b1) begin
                q[7:4]<=(q[7:4] == 4'h9)? 4'h0: q[7:4]+1'b1;
                if(ena[2]==1'b1) begin
                    q[11:8]<=(q[11:8] == 4'h9)? 4'h0: q[11:8]+1'b1;
                    if(ena[3]==1'b1)
                        q[15:12]<=(q[15:12] == 4'h9)? 4'h0: q[15:12]+1'b1;
                end
            end
        end
    end
    
*/
    
endmodule