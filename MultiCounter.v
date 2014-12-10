module MultiCounter(
	//前级进位信号
	pre_carry_flag,
	//手动进位信号
	manual_carry_flag,
	rst,
	//计数器工作在的模值
	//0--模60
	//1--模24
	//2--模100
	mode,
	
	//计数器计满进位
	carry_flag,
	
	//计数器当前值
	count,
	
	//工作状态
	//0--普通计时
	//1--校时
	is_manual_set,
);
	input pre_carry_flag,manual_carry_flag,rst;
	input [1:0] mode;
	input is_manual_set;
	output carry_flag;
	output [6:0] count;
	reg [6:0] count;
	wire drive;

	//设置驱动源
	//前级脉冲或者手动脉冲
	assign drive=is_manual_set?manual_carry_flag:pre_carry_flag;

	always @(posedge drive or negedge rst)
		if(!rst) 
			count<=0;	
		else
		case(mode)
			0:
				begin
					if(count!=59)
						begin
							count<=count+1;
						end
					else
						begin
							count<=0;
						end
				end
			1:
				begin
					if(count!=23)
						begin
							count<=count+1;
						end
					else
						begin												
							count<=0;
						end
				end
			2:
				begin
					if(count!=99)
						begin
							count<=count+1;
						end
					else
						begin												
							count<=0;
						end
				end
		endcase

	assign carry_flag=(count==0);
	
			
endmodule