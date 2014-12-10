module Stopwatch(
	clk,
	rst_stopwatch,

	//秒表使能信号
	start,

	//百分之一秒、秒、分钟输出
	one_hundredth_sec_count,
	sec_count,
	min_count
	);
	input clk,rst_stopwatch,start;
	output [6:0] one_hundredth_sec_count,sec_count,min_count;
	wire clk_100Hz;
	FreqDiv_100Hz fDiv100(.clk(clk),.clk_out(clk_100Hz));

	wire one_hundredth_sec_carry_flag,sec_carry_flag,min_carry_flag;
	MultiCounter stopwatch_mc_one_hundredth_sec(.pre_carry_flag(clk_100Hz),.manual_carry_flag(0),.rst(rst_stopwatch),.mode(2),.carry_flag(one_hundredth_sec_carry_flag),.count(one_hundredth_sec_count),.is_manual_set(~start));
	MultiCounter stopwatch_mc_sec(.pre_carry_flag(one_hundredth_sec_carry_flag),.manual_carry_flag(0),.rst(rst_stopwatch),.mode(0),.carry_flag(sec_carry_flag),.count(sec_count),.is_manual_set(~start));
	MultiCounter stopwatch_mc_min(.pre_carry_flag(sec_carry_flag),.manual_carry_flag(0),.rst(rst_stopwatch),.mode(0),.carry_flag(min_carry_flag),.count(min_count),.is_manual_set(~start));
	
endmodule