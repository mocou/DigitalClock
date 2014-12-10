module TubeControl (
	clk,

	display_hour,
	display_min,
	display_sec,

	tube_11bit
	);
	input clk;
	input [6:0] display_hour,display_min,display_sec;
	output [10:0] tube_11bit;
	reg [10:0] tube_11bit;

	wire [7:0] display_hour_bcd,
			   display_min_bcd,
			   display_sec_bcd;
	wire [7:0] display_hour_bcd_high,
			   display_hour_bcd_low,
			   display_min_bcd_high,
			   display_min_bcd_low,
			   display_sec_bcd_high,
			   display_sec_bcd_low;

	Bin2Bcd btb_hour(
			.data_in(display_hour),
			.data_out(display_hour_bcd)
		);
	Bin2Bcd btb_min(
			.data_in(display_min),
			.data_out(display_min_bcd)
		);
	Bin2Bcd btb_sec(
			.data_in(display_sec),
			.data_out(display_sec_bcd)
		);

	TubeDecoder td_hour_high(
			.decimal_value(display_hour_bcd[7:4]),
			.tube_value(display_hour_bcd_high)
		);
	TubeDecoder td_hour_low(
			.decimal_value(display_hour_bcd[3:0]),
			.tube_value(display_hour_bcd_low)
		);
	TubeDecoder td_min_high(
			.decimal_value(display_min_bcd[7:4]),
			.tube_value(display_min_bcd_high)
		);
	TubeDecoder td_min_low(
			.decimal_value(display_min_bcd[3:0]),
			.tube_value(display_min_bcd_low)
		);
	TubeDecoder td_sec_high(
			.decimal_value(display_sec_bcd[7:4]),
			.tube_value(display_sec_bcd_high)
		);
	TubeDecoder td_sec_low(
			.decimal_value(display_sec_bcd[3:0]),
			.tube_value(display_sec_bcd_low)
		);

	always @(posedge clk)
		begin
			if(tube_11bit[10:8]<8) begin
				tube_11bit[10:8]<=tube_11bit[10:8]+1;
			end
			else
				tube_11bit[10:8]<=0;
		end
	always @(tube_11bit[10:8])
		case (tube_11bit[10:8])
			0:tube_11bit[7:0]<=display_hour_bcd_high;
			1:tube_11bit[7:0]<=display_hour_bcd_low;
			2:tube_11bit[7:0]<=8'H40;
			3:tube_11bit[7:0]<=display_min_bcd_high;
			4:tube_11bit[7:0]<=display_min_bcd_low;
			5:tube_11bit[7:0]<=8'H40;
			6:tube_11bit[7:0]<=display_sec_bcd_high;
			7:tube_11bit[7:0]<=display_sec_bcd_low;
			default:tube_11bit[7:0]<=8'H3F;
		endcase
endmodule