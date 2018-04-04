

module b58proj(LEDR, LEDG, HEX0, HEX1, HEX2, HEX4, HEX5, HEX6, HEX7, SW, KEY, CLOCK_50);
	output [17:0] LEDR;
	output [7:0] LEDG;
	// comment the three out for the sequences game
	output [6:0] HEX0;
	output [6:0] HEX1;
	output [6:0] HEX2;
	
	output [6:0] HEX4;
	output [6:0] HEX5;
	output [6:0] HEX6;
	output [6:0] HEX7;
	
	input CLOCK_50;
	input [17:0] SW;
	input [3:0] KEY;
	wire reset;

	// this displays the counter and accepts resets
	timer(HEX4, HEX5, clktimer, reset);
	
	wire clk100;
	wire clktimer;
	wire num = 4'h9;
	
	reducer1(clk100, clktimer);
	reducer100(CLOCK_50, clk100);
	
	
	genbin(HEX0, HEX1, HEX2, HEX6, HEX7, SW[17:0], CLOCK_50, reset, KEY[2]);
	//sequence(LEDR[17:0], clktimer, LEDG[1:0], SW[17:0], HEX6, HEX7, KEY[3], KEY[2], CLOCK_50, reset);
endmodule

module reducer1(clk100, clktimer);
	input clk100;
	output reg clktimer;
	
	reg [6:0] counter;
	
	always @(posedge clk100)
	begin
		if (counter == 7'b1100100) begin
			counter <= 0;
			clktimer <= 1;
		end
		else begin
			counter <= counter + 1'b1;
			clktimer <= 0;
		end
	end
	
endmodule

// [reduced] will have a posedge of 100 times per second
module reducer100(clk, reduced);
	input clk;
	output reg reduced;
	
	reg [18:0] counter;
	
	always @(posedge clk)
	begin
		if (counter == 19'b1111010000100100000)
		begin
			counter <= 0;
			reduced <= 1;
		end
		else begin
			reduced <= 0;
			counter <= counter + 1'b1;
		end
	end
	
endmodule




module timer(HEX4, HEX5, clk, reset);
	output [6:0] HEX4;
	output [6:0] HEX5;
	input reset;
	input clk;
	
	// state1 is least sig number, state2 is most (digit-10)
	reg [3:0] state1;
	reg [3:0] state2;
	
	// timer defaults to 60 seconds
	always @(posedge clk or posedge reset)
	begin
		if (reset) begin
			state1 = 4'd0;
			state2 = 4'd6;
		end
		// counts down
		else if (state1 != 4'd0)
			state1 = state1 - 4'd1;
		// decrements 10-digit
		else if (state2 != 4'd0 && state1 == 4'd0) begin
			state1 = 4'd9;
			state2 = state2 - 4'd1;
		end
	end
	
	
	hex_display(state1, HEX4);
	hex_display(state2, HEX5);	
endmodule


// credit to CSCB58 webpage: http://www.utsc.utoronto.ca/~bharrington/cscb58/labs/hex_display.v
module hex_display(IN, OUT);
    input [3:0] IN;
	 output reg [7:0] OUT;
	 
	 always @(*)
	 begin
		case(IN[3:0])
			4'b0000: OUT = 7'b1000000;
			4'b0001: OUT = 7'b1111001;
			4'b0010: OUT = 7'b0100100;
			4'b0011: OUT = 7'b0110000;
			4'b0100: OUT = 7'b0011001;
			4'b0101: OUT = 7'b0010010;
			4'b0110: OUT = 7'b0000010;
			4'b0111: OUT = 7'b1111000;
			4'b1000: OUT = 7'b0000000;
			4'b1001: OUT = 7'b0011000;
			4'b1010: OUT = 7'b0001000;
			4'b1011: OUT = 7'b0000011;
			4'b1100: OUT = 7'b1000110;
			4'b1101: OUT = 7'b0100001;
			4'b1110: OUT = 7'b0000110;
			4'b1111: OUT = 7'b0001110;
			
			default: OUT = 7'b0111111;
		endcase

	end
endmodule


