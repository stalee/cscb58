


module sequence(LEDR, clk, LEDG, SW, HEX6, HEX7, KEY3, KEY2, clk50, reset);
   output [17:0] LEDR;
	output [1:0] LEDG;
	input [17:0] SW;
	input KEY3;
	input KEY2;
	input clk50;
	output [6:0] HEX6;
	output [6:0] HEX7;
	output reset;
	
	reg internal_reset;
	
	// reset button
	assign reset = !KEY2;
   input clk;
	reg green_led = 0;
	
	
	// The initial LED state
   reg [3:0] binary_state = 4'b0000; // 3
   
	// 0010 0001 1000 0100
	reg [15:0] storage = 16'b0;
	reg [15:0] user_input = 16'b0;
	
	reg [7:0] game_state = 8'd0;
	
	reg [3:0] score1 = 4'd0;
	reg [3:0] score2 = 4'd0;
	
	// if the start button has been pressed
	reg pressed = 0;
	
	// a latch for the clock
	reg have_run = 0;
	

	// Go through the other states then allow input
	always @(posedge clk50)
	begin
		if (clk && !have_run) begin
			have_run = 1;
			// checks the current state of the game (all unique) before allowing the binary state checks
			// this allows multiple sequences that are the same, if desired, as the game_state provides the uniqueness
			if (game_state == 8'd0) begin
				
				if (binary_state == 4'b0100) begin // start
					storage[3:0] = binary_state;
					green_led = 1;	
					binary_state = 4'b0000;
				end	
				
				else if (binary_state == 4'b1000) begin // 2
					storage[7:4] = binary_state;
					binary_state = 4'b0100;
				end
				
				else if (binary_state == 4'b0001) begin // 1
					storage[11:8] = binary_state;
					binary_state = 4'b1000;
				end
			
				else if (binary_state == 4'b0010) begin  // 4
					storage[15:12] = binary_state; 
					binary_state = 4'b0001;
				end
				
				else if (binary_state == 4'b0000 && pressed && !green_led) begin // 3
					binary_state = 4'b0010;
					pressed = 0;
				end
			end
			
			// sequence 2
			else if (game_state == 8'd1) begin
				if (binary_state == 4'b0001) begin // start
					storage[3:0] = binary_state;
					green_led = 1;	
					binary_state = 4'b0000;
				end	
				
				else if (binary_state == 4'b0010) begin // 4
					storage[7:4] = binary_state;
					binary_state = 4'b0001;
				end
				
				else if (binary_state == 4'b0100) begin // 3
					storage[11:8] = binary_state;
					binary_state = 4'b0010;
				end
			
				else if (binary_state == 4'b1000) begin  // 2
					storage[15:12] = binary_state; 
					binary_state = 4'b0100;
				end
				
				else if (binary_state == 4'b0000 && !green_led) begin //1
					binary_state = 4'b1000;
					pressed = 0;
				end
			end
			
			// sequence 3
			else if (game_state == 8'd2) begin
				if (binary_state == 4'b1000) begin // start
					storage[3:0] = binary_state;
					green_led = 1;	
					binary_state = 4'b0000;
				end	
				
				else if (binary_state == 4'b0100) begin // 1
					storage[7:4] = binary_state;
					binary_state = 4'b1000;
				end
				
				else if (binary_state == 4'b0010) begin // 2
					storage[11:8] = binary_state;
					binary_state = 4'b0100;
				end
			
				else if (binary_state == 4'b0001) begin  // 3
					storage[15:12] = binary_state; 
					binary_state = 4'b0010;
				end
				
				else if (binary_state == 4'b0000 && !green_led) begin // 4
					binary_state = 4'b0001;
					pressed = 0;
				end
			end
			
			// sequence 4
			else if (game_state == 8'd3) begin
				if (binary_state == 4'b0100) begin // start
					storage[3:0] = binary_state;
					green_led = 1;	
					binary_state = 4'b0000;
				end	
				
				else if (binary_state == 4'b0010) begin // 2
					storage[7:4] = binary_state;
					binary_state = 4'b0100;
				end
				
				else if (binary_state == 4'b0001) begin // 3
					storage[11:8] = binary_state;
					binary_state = 4'b0010;
				end
			
				else if (binary_state == 4'b1000) begin  // 4
					storage[15:12] = binary_state; 
					binary_state = 4'b0001;
				end
				
				else if (binary_state == 4'b0000 && !green_led) begin // 1
					binary_state = 4'b1000;
					pressed = 0;
				end
			end

			// sequence 5
			else if (game_state == 8'd4) begin
				if (binary_state == 4'b0001) begin // start
					storage[3:0] = binary_state;
					green_led = 1;	
					binary_state = 4'b0000;
				end	
				
				else if (binary_state == 4'b1000) begin // 4
					storage[7:4] = binary_state;
					binary_state = 4'b0001;
				end
				
				else if (binary_state == 4'b0010) begin // 1
					storage[11:8] = binary_state;
					binary_state = 4'b1000;
				end
			
				else if (binary_state == 4'b0100) begin  // 3
					storage[15:12] = binary_state; 
					binary_state = 4'b0010;
				end
				
				else if (binary_state == 4'b0000 && !green_led) begin // 2
					binary_state = 4'b0100;
					pressed = 0;
				end
			end
			
			// sequence 6
			else if (game_state == 8'd5) begin
				if (binary_state == 4'b0100) begin // start
					storage[3:0] = binary_state;
					green_led = 1;	
					binary_state = 4'b0000;
				end	
				
				else if (binary_state == 4'b0001) begin // 2
					storage[7:4] = binary_state;
					binary_state = 4'b0100;
				end
				
				else if (binary_state == 4'b1000) begin // 4
					storage[11:8] = binary_state;
					binary_state = 4'b0001;
				end
			
				else if (binary_state == 4'b0010) begin  // 1
					storage[15:12] = binary_state; 
					binary_state = 4'b1000;
				end
				
				else if (binary_state == 4'b0000 && !green_led) begin // 3
					binary_state = 4'b0010;
					pressed = 0;
				end
			end
			
			// sequence 7
			else if (game_state == 8'd6) begin
				if (binary_state == 4'b1000) begin // start
					storage[3:0] = binary_state;
					green_led = 1;	
					binary_state = 4'b0000;
				end	
				
				else if (binary_state == 4'b0010) begin // 1
					storage[7:4] = binary_state;
					binary_state = 4'b1000;
				end
				
				else if (binary_state == 4'b0001) begin // 3
					storage[11:8] = binary_state;
					binary_state = 4'b0010;
				end
			
				else if (binary_state == 4'b0100) begin  // 4
					storage[15:12] = binary_state; 
					binary_state = 4'b0001;
				end
				
				else if (binary_state == 4'b0000 && !green_led) begin // 2
					binary_state = 4'b0100;
					pressed = 0;
				end
			end
			
			// sequence 8
			else if (game_state == 8'd7) begin
				if (binary_state == 4'b0010) begin // start
					storage[3:0] = binary_state;
					green_led = 1;	
					binary_state = 4'b0000;
				end	
				
				else if (binary_state == 4'b0001) begin // 3
					storage[7:4] = binary_state;
					binary_state = 4'b0010;
				end
				
				else if (binary_state == 4'b0100) begin // 4
					storage[11:8] = binary_state;
					binary_state = 4'b0001;
				end
			
				else if (binary_state == 4'b1000) begin  // 2
					storage[15:12] = binary_state; 
					binary_state = 4'b0100;
				end
				
				else if (binary_state == 4'b0000 && !green_led) begin // 1
					binary_state = 4'b1000;
					pressed = 0;
				end
			end
			
			// sequence 9
			else if (game_state == 8'd8) begin
				if (binary_state == 4'b0100) begin // start
					storage[3:0] = binary_state;
					green_led = 1;	
					binary_state = 4'b0000;
				end	
				
				else if (binary_state == 4'b1000) begin // 2
					storage[7:4] = binary_state;
					binary_state = 4'b0100;
				end
				
				else if (binary_state == 4'b0010) begin // 1
					storage[11:8] = binary_state;
					binary_state = 4'b1000;
				end
			
				else if (binary_state == 4'b0001) begin  // 3
					storage[15:12] = binary_state; 
					binary_state = 4'b0010;
				end
				
				else if (binary_state == 4'b0000 && !green_led) begin // 4
					binary_state = 4'b0001;
					pressed = 0;
				end
			end
		
		end
		
		if (!clk)
			have_run = 0;
		
		if (!KEY3)
			pressed = 1;
		
		if (!KEY2)
			internal_reset = 1;
		
		if (internal_reset) begin
			binary_state = 4'b0000;
			game_state = 8'd0;
			storage = 16'b0;
			green_led = 0;
			score1 = 4'd0;
			score2 = 4'd0;
			have_run = 0;
			pressed = 0;
			internal_reset = 0;
		end
		
		if (SW[10]) begin
			if (user_input == storage && storage != 16'b0) begin
				green_led = 0;
				game_state = game_state + 1'd1;
				storage = 16'b0;
			end
		end
   end


	always @(posedge SW[10])
	begin
		if (green_led) begin
			user_input = user_input << 4;
			user_input[3:0] = SW[3:0]; 
		end
	end
	
	assign LEDG[0] = green_led;
	assign LEDR[3:0] = binary_state;
	
	hex_display(game_state, HEX6);
	hex_display(score2, HEX7);
endmodule

