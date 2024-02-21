`timescale 1ns/1ps
module ALSU_tb ();
    reg clk, rst;
    reg [2:0] A, B;
	reg [2:0] opcode;
	reg cin, serial_in;
	reg direction;
	reg red_op_A, red_op_B;
	reg bypass_A, bypass_B;
	wire [5:0] out;
	wire [15:0] leds;

	ALSU #("A","ON") dut (clk, rst, A, B, opcode, cin, serial_in,
		direction, red_op_A, red_op_B, bypass_A, bypass_B, out, leds) ;

	initial begin
		clk=0;
		forever
		  #10 clk=~clk;
	end	

	initial begin
		rst=1;
		A = 0;
	  	B = 0;
	  	opcode= 0;
	  	cin= 0;
	  	serial_in= 0;
	  	direction= 0;
	  	red_op_A= 0;
	  	red_op_B= 0;
	  	bypass_A= 0;
	  	bypass_B= 0;
		@(negedge clk) ;
		rst=0;
		@(negedge clk);
		repeat(100) begin
		 A = $random;
	  	 B = $random;
	  	 opcode= $random;
	  	 cin= $random;
	  	 serial_in= $random;
	  	 direction= $random;
	  	 red_op_A= $random;
	  	 red_op_B= $random;
	  	 bypass_A= $random;
	  	 bypass_B= $random;
	  	 #20;
		end
		$stop;
	end 
endmodule
