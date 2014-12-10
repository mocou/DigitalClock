module DigitalClock(
	clk,

	rst_clock,
	rst_alarm,
	rst_stopwatch,

	//手动校时控制开关
	is_manual_set,

	//数字钟工作模式控制开关
	tube_for,

	//校时按钮
	sw_hour,
	sw_min,

	//秒表使能信号
	stopwatch_start,

	//闹铃输出
	alarm,

	//整点报时输出
	hour_remind,

	//数码管输出
	//高三位为选择端
	tube_11bit
	);
	input clk,rst_clock,rst_alarm,rst_stopwatch,is_manual_set,sw_hour,sw_min,stopwatch_start;
	input [1:0] tube_for;
	output alarm,hour_remind;
	output [10:0] tube_11bit;
	wire [6:0] clock_hour_count,
				clock_min_count,
				clock_sec_count,
				stopwatch_min_count,
				stopwatch_sec_count,
				stopwatch_hundredth_sec_count,
				alarm_hour_count,
				alarm_min_count,
				alarm_sec_count;

	wire clock_hour_set,
		  clock_min_set,
		  alarm_hour_set,
		  alarm_min_set;
	wire [6:0] display_hour,
			display_min,
			display_sec;

	//时钟模块实例
	Clock clock(
		.clk(clk),
		.rst(rst_clock),
		.is_manual_set(is_manual_set),
		.min_set(clock_min_set),
		.hour_set(clock_hour_set),
		.sec_count(clock_sec_count),
		.min_count(clock_min_count),
		.hour_count(clock_hour_count)
		);
	//整点报时模块实例
	HourRemind hrmd(
		.current_clock_min(clock_min_count),
		.hour_remind(hour_remind)
		);
	//闹钟模块实例
	Alarm alm(
		.rst_alarm(rst_alarm),
		.min_set(alarm_min_set),
		.hour_set(alarm_hour_set),
		.current_clock_min(clock_min_count),
		.current_clock_hour(clock_hour_count),
		.sec_count(alarm_sec_count),
		.min_count(alarm_min_count),
		.hour_count(alarm_hour_count),
		.alarm(alarm)
		);
	//秒表模块实例
	Stopwatch stpwatch(
		.clk(clk),
		.rst_stopwatch(rst_stopwatch),
		.start(stopwatch_start),
		.one_hundredth_sec_count(stopwatch_hundredth_sec_count),
		.sec_count(stopwatch_sec_count),
		.min_count(stopwatch_min_count)
		);
	//工作模式控制模块
	ModeControl modectrl(
		.is_manual_set(is_manual_set),
		.tube_for(tube_for),
		.clock_hour_count(clock_hour_count),
		.clock_min_count(clock_min_count),
		.clock_sec_count(clock_sec_count),
		.stopwatch_min_count(stopwatch_min_count),
		.stopwatch_sec_count(stopwatch_sec_count),
		.stopwatch_hundredth_sec_count(stopwatch_hundredth_sec_count),
		.alarm_hour_count(alarm_hour_count),
		.alarm_min_count(alarm_min_count),
		.alarm_sec_count(alarm_sec_count),
		.clock_hour_set(clock_hour_set),
		.clock_min_set(clock_min_set),
		.alarm_hour_set(alarm_hour_set),
		.alarm_min_set(alarm_min_set),
		.sw_hour(~sw_hour),
		.sw_min(~sw_min),
		.display_hour(display_hour),
		.display_min(display_min),
		.display_sec(display_sec)
		);
	//数码管显示控制模块
	TubeControl tbctrl(
		.clk(clk),
		.display_hour(display_hour),
		.display_min(display_min),
		.display_sec(display_sec),
		.tube_11bit(tube_11bit)
		);
endmodule