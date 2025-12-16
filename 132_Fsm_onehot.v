module top_module(
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output reg	out1,
    output reg	out2
);
    localparam s0=0, s1=1, s2=2, s3=3, s4=4, s5=5, s6=6, s7=7, s8=8, s9=9;
    
    assign next_state[s0] = (state[s0]&(~in)) | (state[s1]&(~in)) | (state[s2]&(~in)) | (state[s3]&(~in)) | 
        (state[s4]&(~in)) | (state[s7]&(~in)) | (state[s8]&(~in)) | (state[s9]&(~in));
    assign next_state[s1] = (state[s0]&(in)) | (state[s8]&(in)) | (state[s9]&(in));
    assign next_state[s2] = (state[s1]&(in));
    assign next_state[s3] = (state[s2]&(in));
    assign next_state[s4] = (state[s3]&(in));
    assign next_state[s5] = (state[s4]&(in));
    assign next_state[s6] = (state[s5]&(in));
    assign next_state[s7] = (state[s6]&(in)) | (state[s7]&(in));
    assign next_state[s8] = (state[s5]&(~in));
    assign next_state[s9] = (state[s6]&(~in));
    
   
    assign out1 = ((state[9] == 1'b1) || (state[8] == 1'b1))? 1'b1: 1'b0;
    assign out2 = ((state[9] == 1'b1) || (state[7] == 1'b1))? 1'b1: 1'b0;


    
endmodule