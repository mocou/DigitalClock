module HourRemind(
	current_clock_min,
	hour_remind
);
	input [6:0] current_clock_min;
	output hour_remind;
	
	assign hour_remind=(current_clock_min==0);
endmodule