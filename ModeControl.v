module ModeControl(
	//时钟调时模式开关
	is_manual_set,

	//数码管工作对象输入
	tube_for,

	//当前时钟输入
	clock_hour_count,
	clock_min_count,
	clock_sec_count,

	//秒表输入
	stopwatch_min_count,
	stopwatch_sec_count,
	stopwatch_hundredth_sec_count,

	//闹钟值输入
	alarm_hour_count,
	alarm_min_count,
	alarm_sec_count,

	//时钟设置源输入
	clock_hour_set,
	clock_min_set,

	//闹钟设置源输入
	alarm_hour_set,
	alarm_min_set,

	//调时对象输入
	sw_hour,
	sw_min,

	//数码管工作对象输出
	display_hour,
	display_min,
	display_sec
	);
	input is_manual_set;
	input [1:0] tube_for;

	//定义tube_for参数含义
	parameter CLOCK=0,
			  STOPWATCH=1,
			  ALARM=2;
	input [6:0] clock_hour_count,
				clock_min_count,
				clock_sec_count,
				stopwatch_min_count,
				stopwatch_sec_count,
				stopwatch_hundredth_sec_count,
				alarm_hour_count,
				alarm_min_count,
				alarm_sec_count;


	input sw_hour,sw_min;

	output clock_hour_set,
		  clock_min_set,
		  alarm_hour_set,
		  alarm_min_set;
	reg clock_hour_set,
		  clock_min_set,
		  alarm_hour_set,
		  alarm_min_set;

	output [6:0] display_hour,display_min,display_sec;
	reg [6:0] display_hour,display_min,display_sec;
	always @(*) 
		begin
			case (tube_for)
				CLOCK:
					begin
						display_sec<=clock_sec_count;
						display_min<=clock_min_count;
						display_hour<=clock_hour_count;
						if(is_manual_set)
							begin
								clock_min_set<=sw_min;
								clock_hour_set<=sw_hour;
							end
						else
							begin
								clock_min_set<=0;
								clock_hour_set<=0;
							end
					end

				STOPWATCH:
					begin
						display_sec<=stopwatch_hundredth_sec_count;
						display_min<=stopwatch_sec_count;
						display_hour<=stopwatch_min_count;
					end
				
				ALARM:
					begin
						display_sec<=alarm_sec_count;
						display_min<=alarm_min_count;
						display_hour<=alarm_hour_count;
						alarm_min_set<=sw_min;
						alarm_hour_set<=sw_hour;
					end
				default:
					begin
						display_sec<=0;
						display_min<=0;
						display_hour<=0;
						clock_min_set<=0;
						clock_hour_set<=0;
						alarm_hour_set<=0;
						alarm_min_set<=0;
					end
			endcase
		end

endmodule