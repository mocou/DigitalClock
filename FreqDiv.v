module FreqDiv(clk,clk_out);
	input            clk ;
	wire            clk ;
	output clk_out;
	reg        [6:0]    count ;
	reg clk_out ;
	always @ ( posedge clk)
    	begin
			count=count+1;
         if ( count == 99 )
				begin
            	clk_out <= 1;
					count=0;
            end
         else 
				clk_out<=0;
    	end
endmodule