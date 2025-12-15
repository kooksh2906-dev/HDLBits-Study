module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q 
);
    integer i, j, k, l, m;
    
    reg		[255:0]				q_next;
    reg		[15:0][15:0]		q_array;
    reg		[3:0]		neighbors[0:255];

    // convert 1d array vector to 2d array vector    
    always@(*)begin
        for(k=0; k<16; k=k+1) begin
            for(l=0; l<16; l=l+1) begin
                q_array[k][l] = q[16*k+l];
            end
        end
    end
                
    always@(*) begin 
        for(i=1; i<15; i=i+1) begin    
 //bottom
            neighbors[i]	=	q_array[1][i+1]		+q_array[1][i]	+q_array[1][i-1]
            					+q_array[0][i+1]					+q_array[0][i-1]
								+q_array[15][i+1]	+q_array[15][i]	+q_array[15][i-1];
//top
            neighbors[i+240]	=	q_array[0][i+1]		+q_array[0][i]	+q_array[0][i-1] 
									+q_array[15][i+1]					+q_array[15][i-1] 
									+q_array[14][i+1]	+q_array[14][i]	+q_array[14][i-1];    
//left
            neighbors[16*i+15]	=	q_array[i+1][0]		+q_array[i+1][15]	+q_array[i+1][14]	 
            						+q_array[i][0]							+q_array[i][14]
									+q_array[i-1][0]	+q_array[i-1][15]	+q_array[i-1][14];    
//right
            neighbors[16*i]	=	q_array[i+1][1]		+q_array[i+1][0]	+q_array[i+1][15]
            					+q_array[i][1]							+q_array[i][15]
								+q_array[i-1][1]	+q_array[i-1][0]	+q_array[i-1][15];
//center                  
            for(j=1; j<15; j=j+1) begin
                neighbors[16*i+j]	=	q_array[i+1][j+1]	+q_array[i+1][j]	+q_array[i+1][j-1]
										+q_array[i][j+1]						+q_array[i][j-1]
										+q_array[i-1][j+1]	+q_array[i-1][j]	+q_array[i-1][j-1];
            end
        end
    
// each corner
        neighbors[0] =		q_array[15][1]	+q_array[15][0]	+q_array[15][15]
        					+q_array[0][1]					+q_array[0][15]
        					+q_array[1][1]	+q_array[1][0]	+q_array[1][15];

        neighbors[15] =		q_array[15][0]	+q_array[15][15]	+q_array[15][14]
        					+q_array[0][0]						+q_array[0][14]
        					+q_array[1][0]	+q_array[1][15]		+q_array[1][14];

        neighbors[240] =	q_array[14][1]	+q_array[14][0]		+q_array[14][15]
        					+q_array[15][1]						+q_array[15][15]
       						+q_array[0][1]	+q_array[0][0]		+q_array[0][15];

        neighbors[255] =	q_array[14][0]	+q_array[14][15]	+q_array[14][14]
       						+q_array[15][0]						+q_array[15][14]
        					+q_array[0][0]	+q_array[0][15]		+q_array[0][14];
    end
    
    always@(*) begin
        for(m=0; m<256; m=m+1) begin
            case(neighbors[m])
                4'd0	:	q_next[m] = 1'b0;
                4'd1	:	q_next[m] = 1'b0;
                4'd2	:	q_next[m] = q[m];
                4'd3	:	q_next[m] = 1'b1;
                4'd4	:	q_next[m] = 1'b0;
                4'd5	:	q_next[m] = 1'b0;
                4'd6	:	q_next[m] = 1'b0;
                4'd7	:	q_next[m] = 1'b0;
                4'd8	:	q_next[m] = 1'b0;
                default	:	q_next[m] = q[m];
            endcase
        end
    end
    
    always@(posedge clk) begin
        if(load)
            q <= data;
        else
            q <= q_next;
    end

endmodule