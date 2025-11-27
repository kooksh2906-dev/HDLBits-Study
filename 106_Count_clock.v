//solution 1
//top/sub module structure

module fast(
	input	wire		clk, reset, ena,
    output	reg	[3:0]	q
);
    always@(posedge clk) begin
        if(reset)
            q <= 4'd0;
        else begin
            if(ena)
                q <= (q==4'd9)? 4'd0: q+1'b1;
            else
                q<= q;
        end
    end
       
endmodule

module slow(
	input	wire		clk, reset, ena,
    output	reg	[3:0]	q
);
    always@(posedge clk) begin
        if(reset)
            q <= 4'd0;
        else begin
            if(ena)
                q <= (q==4'd5)? 4'd0: q+1'b1;
            else
                q<= q;
        end
    end
       
endmodule

module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 
    
    wire	[4:0]	enable;
    
    assign enable[0] = (ena && (ss[3:0] == 4'd9))? 1'b1: 1'b0;
    assign enable[1] = (ena && (ss[7:4] == 4'd5)&&(ss[3:0] == 4'd9))? 1'b1: 1'b0;
    assign enable[2] = (ena && (mm[3:0] == 4'd9)&&(ss[7:4] == 4'd5)&&(ss[3:0] == 4'd9))? 1'b1: 1'b0;
    assign enable[3] = (ena && (mm[7:4] == 4'd5)&&(mm[3:0] == 4'd9)&&(ss[7:4] == 4'd5)&&(ss[3:0] == 4'd9))? 1'b1: 1'b0;
    assign enable[4] = (ena && (hh[3:0] == 4'd9)&&(mm[7:4] == 4'd5)&&(mm[3:0] == 4'd9)&&(ss[7:4] == 4'd5)&&(ss[3:0] == 4'd9))? 1'b1: 1'b0;

    always@(posedge clk) begin //fast_h,hh[3:0]
        if(reset)
            hh[3:0] <= 4'd2;
        else begin
            if(enable[3]) begin
            	hh[3:0] <= (hh[3:0]==4'd9)? 4'd0: hh[3:0]+1'b1;
            	if(((hh[7:4] == 4'd1)&&(hh[3:0] == 4'd2)))
                    hh[3:0] <= 4'd1;// 12:59:59 -> 01:00:00
            end
            else
                hh[3:0] <= hh[3:0];
        end
    end
    
    always@(posedge clk) begin//slow_h,hh[7:4]
        if(reset) begin
            pm <= 1'b0;
            hh[7:4] <= 4'd1;
        end
        else begin
            if(enable[4])//09:59:59 -> 10:00:00
                hh[7:4] <= (hh[7:4]==4'd1)? 4'd0: hh[7:4]+1'b1;
            else if(((hh[7:4] == 4'd1)&&(hh[3:0] == 4'd2)&&(mm[7:4] == 4'd5)&&(mm[3:0] == 4'd9)&&(ss[7:4] == 4'd5)&&(ss[3:0] == 4'd9)))
                hh[7:4] <= 4'd0;// 12:59:59 -> 01:00:00
            else if(((hh[7:4] == 4'd1)&&(hh[3:0] == 4'd1)&&(mm[7:4] == 4'd5)&&(mm[3:0] == 4'd9)&&(ss[7:4] == 4'd5)&&(ss[3:0] == 4'd9)))
                pm <= ~pm;// 11:59:59 -> 12:00:00
            else
                hh[7:4] <= hh[7:4];
        end
    end
    
    fast	fast_s(.clk(clk), .reset(reset), .ena(ena), .q(ss[3:0])); //maximum = 9
    slow	slow_s(.clk(clk), .reset(reset), .ena(enable[0]), .q(ss[7:4])); //maximum = 5
    fast	fast_m(.clk(clk), .reset(reset), .ena(enable[1]), .q(mm[3:0])); //maximum = 9
    slow	slow_m(.clk(clk), .reset(reset), .ena(enable[2]), .q(mm[7:4])); //maximum = 5

/*
//solution2
//use only top module, don't need above sub module

    always@(posedge clk) begin
        if(reset) begin
            {hh,mm,ss} <= 24'h12_00_00;
            pm <= 1'b0;
        end
        else if(ena) begin
            ss[3:0] <= (ss[3:0] == 4'h9)? 4'h0: ss[3:0]+1'b1;
            if(ss[3:0] == 4'h9) begin //am 00:00:0_
                ss[7:4] <= (ss[7:4] == 4'h5)? 4'h0: ss[7:4]+1'b1;
                if(ss[7:4] == 4'h5) begin //am 00:00:_0
                    mm[3:0] <= (mm[3:0] == 4'h9)? 4'h0: mm[3:0]+1'b1;
                    if(mm[3:0] == 4'h9) begin //am 00:0_:00
                        mm[7:4] <= (mm[7:4] == 4'h5)? 4'h0: mm[7:4]+1'b1;
                        if(mm[7:4] == 4'h5) begin //am 00:_0:00
                            hh[3:0] <= (hh[3:0] == 4'h9)? 4'h0: hh[3:0]+1'b1;
                            if(hh == 8'h12) begin // I think setting priority of hour block by using if and else if, instead of continuously using if and if ...
                                hh <= 8'h01;
                            end
                            else if(hh == 8'h11) begin
                                pm <= ~pm;
                            end
                            else if(hh[3:0] == 4'h9) begin
                                hh[7:4] <= (hh[7:4] == 4'h1)? 4'h0: hh[7:4]+1'b1;
                            end
                        end
                    end
                end
            end
        end
        else
        {hh,mm,ss} <= {hh,mm,ss};
    end
          
*/

endmodule