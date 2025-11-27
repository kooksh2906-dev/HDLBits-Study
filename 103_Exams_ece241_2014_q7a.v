module top_module (
    input clk,
    input reset,
    input enable,
    output [3:0] Q,
    output c_enable,
    output c_load,
    output [3:0] c_d
); // design 1 to 12 counter by using count4 initiation
    
	assign c_d = 4'b1;
    assign c_enable = enable;
    assign c_load = reset || (enable && Q == 4'd12);
    
    count4 the_counter (clk, c_enable, c_load, c_d , Q);

endmodule