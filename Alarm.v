module Alarm(
	//clk,
	rst_alarm,

	min_set,
	hour_set,

	//时钟时间
	current_clock_min,
	current_clock_hour,

	//闹钟时间
	sec_count,
	min_count, 
	hour_count,

	alarm
	);
	input rst_alarm,min_set,hour_set;
	input [6:0] current_clock_min,current_clock_hour;
	output [6:0] sec_count,min_count,hour_count;
	output alarm;

	wire sec_carry_flag,min_carry_flag,hour_carry_flag;
	MultiCounter alarm_mc_sec(.pre_carry_flag(0),.manual_carry_flag(0),.rst(rst_alarm),.mode(0),.carry_flag(sec_carry_flag),.count(sec_count),.is_manual_set(1));
	MultiCounter alarm_mc_min(.pre_carry_flag(sec_carry_flag),.manual_carry_flag(min_set),.rst(rst_alarm),.mode(0),.carry_flag(min_carry_flag),.count(min_count),.is_manual_set(1));
	MultiCounter alarm_mc_hour(.pre_carry_flag(min_carry_flag),.manual_carry_flag(hour_set),.rst(rst_alarm),.mode(1),.carry_flag(hour_carry_flag),.count(hour_count),.is_manual_set(1));

	assign alarm=((min_count==current_clock_min)&&(hour_count==current_clock_hour));

endmodule