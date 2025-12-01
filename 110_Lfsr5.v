module top_module(
    input clk,
    input reset,    // Active-high synchronous reset to 5'h1
    output [4:0] q
); 
    wire	qxor_5, qxor_3;
    assign qxor_5 = q[0];//always q[0], because 1^0->1, 0^0->0, so q[0]^1'b0 ->q[0] 
    assign qxor_3 = q[3] ^ q[0];
    
    always@(posedge clk) begin
        if(reset)
            q <= 5'h1;
        else
            q <= {qxor_5,q[4],qxor_3,q[2],q[1]};
    end
 
endmodule