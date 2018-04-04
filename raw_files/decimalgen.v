

// numbers go from 0 to 255
module genbin(HEX0, HEX1, HEX2, HEX6, HEX7, SW, clk50, reset, KEY2);
	output [6:0] HEX0;
	output [6:0] HEX1;
	output [6:0] HEX2;
	
	output [6:0] HEX6;
	output [6:0] HEX7;
	output reset;
	
	input clk50;
	input [17:0] SW;
	input KEY2;
	
	// represents the decimal numbers
	reg [3:0] h0 = 4'd1;
	reg [3:0] h1 = 4'd0;
	reg [3:0] h2 = 4'd0;
	
	// represents the current state of the game
	reg [7:0] state = 8'd0;
	
	// represents the score output
	reg [3:0] score1 = 4'd0;
	reg [3:0] score2 = 4'd0;
	
	// reset button
	assign reset = !KEY2;

	always @(posedge clk50)
	begin
		// zero out all numerical numbers, and restore default decimal number
		if (!KEY2) begin
			state = 8'd0;
			score1 = 4'd0;
			score2 = 4'd0;
			h0 = 4'd1;
			h1 = 4'd0;
			h2 = 4'd0;
		end
		// if the decimal number matches, and if the current state matches also (this allows for repeated decimal numbers, if desired)
		else if (SW[7:0] == 8'd1 && state == 8'd0) begin
			// change the decimal number to the next one
			h0 = 4'd8;
			h1 = 4'd8;
			h2 = 4'd1;
			// change state and increment score
			state = state + 1'd1;
			score1 = score1 + 1'd1;
		end
		else if (SW[7:0] == 8'd188 && state == 8'd1) begin
			h0 = 4'd9;
			h1 = 4'd0;
			h2 = 4'd2;
			state = state + 1'd1;
			score1 = score1 + 1'd1;
		end
		else if (SW[7:0] == 8'd209 && state == 8'd2) begin
			h0 = 4'd2;
			h1 = 4'd1;
			h2 = 4'd2;
			state = state + 1'd1;
			score1 = score1 + 1'd1;
		end
		else if (SW[7:0] == 8'd212 && state == 8'd3) begin
			h0 = 4'd9;
			h1 = 4'd5;
			h2 = 4'd0;
			state = state + 1'd1;
			score1 = score1 + 1'd1;
		end
		else if (SW[7:0] == 8'd59 && state == 8'd4) begin
			h0 = 4'd5;
			h1 = 4'd1;
			h2 = 4'd1;
			state = state + 1'd1;
			score1 = score1 + 1'd1;
		end
		else if (SW[7:0] == 8'd115 && state == 8'd5) begin
			h0 = 4'd4;
			h1 = 4'd0;
			h2 = 4'd1;
			state = state + 1'd1;
			score1 = score1 + 1'd1;
		end
		else if (SW[7:0] == 8'd104 && state == 8'd6) begin
			h0 = 4'd0;
			h1 = 4'd4;
			h2 = 4'd2;
			state = state + 1'd1;
			score1 = score1 + 1'd1;
		end
		else if (SW[7:0] == 8'd240 && state == 8'd7) begin
			h0 = 4'd3;
			h1 = 4'd3;
			h2 = 4'd0;
			state = state + 1'd1;
			score1 = score1 + 1'd1;
		end
		else if (SW[7:0] == 8'd33 && state == 8'd8) begin
			h0 = 4'd7;
			h1 = 4'd8;
			h2 = 4'd1;
			state = state + 1'd1;
			score1 = score1 + 1'd1;
		end
		else if (SW[7:0] == 8'd187 && state == 8'd9) begin
			h0 = 4'd1;
			h1 = 4'd1;
			h2 = 4'd0;
			state = state + 1'd1;
			score1 = 1'd0;
			score2 = 1'd1;
		end
		else if (SW[7:0] == 8'd11 && state == 8'd10) begin
			h0 = 4'd3;
			h1 = 4'd6;
			h2 = 4'd0;
			state = state + 1'd1;
			score1 = score1 + 1'd1;
		end
		else if (SW[7:0] == 8'd63 && state == 8'd11) begin
			h0 = 4'd4;
			h1 = 4'd3;
			h2 = 4'd1;
			state = state + 1'd1;
			score1 = score1 + 1'd1;
		end
		else if (SW[7:0] == 8'd134 && state == 8'd12) begin
			h0 = 4'd3;
			h1 = 4'd3;
			h2 = 4'd1;
			state = state + 1'd1;
			score1 = score1 + 1'd1;
		end
		else if (SW[7:0] == 8'd133 && state == 8'd13) begin
			h0 = 4'd4;
			h1 = 4'd6;
			h2 = 4'd1;
			state = state + 1'd1;
			score1 = score1 + 1'd1;
		end
		else if (SW[7:0] == 8'd164 && state == 8'd14) begin
			h0 = 4'd1;
			h1 = 4'd7;
			h2 = 4'd1;
			state = state + 1'd1;
			score1 = score1 + 1'd1;
		end
		else if (SW[7:0] == 8'd171 && state == 8'd15) begin
			h0 = 4'd5;
			h1 = 4'd8;
			h2 = 4'd1;
			state = state + 1'd1;
			score1 = score1 + 1'd1;
		end
		else if (SW[7:0] == 8'd185 && state == 8'd16) begin
			h0 = 4'd5;
			h1 = 4'd9;
			h2 = 4'd0;
			state = state + 1'd1;
			score1 = score1 + 1'd1;
		end
		else if (SW[7:0] == 8'd95 && state == 8'd17) begin
			h0 = 4'd0;
			h1 = 4'd9;
			h2 = 4'd1;
			state = state + 1'd1;
			score1 = score1 + 1'd1;
		end
		else if (SW[7:0] == 8'd190 && state == 8'd18) begin
			h0 = 4'd2;
			h1 = 4'd2;
			h2 = 4'd2;
			state = state + 1'd1;
			score1 = score1 + 1'd1;
		end
		else if (SW[7:0] == 8'd222 && state == 8'd19) begin
			h0 = 4'd5;
			h1 = 4'd3;
			h2 = 4'd0;
			state = state + 1'd1;
			score1 = 1'd0;
			score2 = score2 + 1'd1;
		end
		else if (SW[7:0] == 8'd35 && state == 8'd20) begin
			h0 = 4'd5;
			h1 = 4'd4;
			h2 = 4'd2;
			state = state + 1'd1;
			score1 = score1 + 1'd1;
		end
	end
	
	
	
	// displays the decimal numbers
	hex_display(h0, HEX0);
	hex_display(h1, HEX1);
	hex_display(h2, HEX2);
	
	// displays the score
	hex_display(score2, HEX7);
	hex_display(score1, HEX6);
endmodule

