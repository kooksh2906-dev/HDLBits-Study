module top_module( 
    input [3:0] in,
    output [2:0] out_both,	//	3bit
    output [3:1] out_any,	//3bit
    output [3:0] out_different );	// 4bit

    always@(*) begin
        casex(in)
            4'b0000 : {out_both,out_any,out_different} = 10'b0000000000;
            4'b0001 : {out_both,out_any,out_different} = 10'b0000011001;
            4'b0010 : {out_both,out_any,out_different} = 10'b0000110011;
            4'b0011 : {out_both,out_any,out_different} = 10'b0010111010;
            4'b0100 : {out_both,out_any,out_different} = 10'b0001100110;
            4'b0101 : {out_both,out_any,out_different} = 10'b0001111111;
            4'b0110 : {out_both,out_any,out_different} = 10'b0101110101;
            4'b0111 : {out_both,out_any,out_different} = 10'b0111111100;
            4'b1000 : {out_both,out_any,out_different} = 10'b0001001100;
            4'b1001 : {out_both,out_any,out_different} = 10'b0001010101;
            4'b1010 : {out_both,out_any,out_different} = 10'b0001111111;
            4'b1011 : {out_both,out_any,out_different} = 10'b0011110110;
            4'b1100 : {out_both,out_any,out_different} = 10'b1001101010;
            4'b1101 : {out_both,out_any,out_different} = 10'b1001110011;
            4'b1110 : {out_both,out_any,out_different} = 10'b1101111001;
            4'b1111 : {out_both,out_any,out_different} = 10'b1111110000;
            default : {out_both,out_any,out_different} = 10'bxxxxxxxxxx;
        endcase
    end
    
endmodule