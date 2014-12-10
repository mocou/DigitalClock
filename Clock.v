module Clock(
	clk,
	rst,
	is_manual_set,

	//手动设置时分秒
	min_set,
	hour_set,

	//时分秒二进制输出
	sec_count,
	min_count,
	hour_count
	//数码管输出,高三位选择数码管,10 9 8 7 6 5 4 3 2 1 0
	//tube_11bit

	//输出整点脉冲
	//hour_carry_flag
);
	input clk,rst,is_manual_set,min_set,hour_set;
	output [6:0] sec_count,min_count,hour_count;
//	output hour_carry_flag;
	wire clk_1Hz;
	FreqDiv fDiv1(.clk(clk),.clk_out(clk_1Hz));

	wire sec_carry_flag,min_carry_flag,hour_carry_flag;
	MultiCounter mc_sec(.pre_carry_flag(clk_1Hz),.manual_carry_flag(0),.rst(rst),.mode(0),.carry_flag(sec_carry_flag),.count(sec_count),.is_manual_set(is_manual_set));
	MultiCounter mc_min(.pre_carry_flag(sec_carry_flag),.manual_carry_flag(min_set),.rst(rst),.mode(0),.carry_flag(min_carry_flag),.count(min_count),.is_manual_set(is_manual_set));
	MultiCounter mc_hour(.pre_carry_flag(min_carry_flag),.manual_carry_flag(hour_set),.rst(rst),.mode(1),.carry_flag(hour_carry_flag),.count(hour_count),.is_manual_set(is_manual_set));

endmodule