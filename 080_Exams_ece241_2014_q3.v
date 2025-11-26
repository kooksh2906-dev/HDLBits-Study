module top_module (
    input c,
    input d,
    output [3:0] mux_in
); 
    wire	VCC, GND;
    
    assign VCC = 1'b1;
	assign GND = 1'b0;
    
    assign mux_in[0] = c|d;
    assign mux_in[1] = GND;
    assign mux_in[2] = ~d;
    assign mux_in[3] = c&d;
    

endmodule