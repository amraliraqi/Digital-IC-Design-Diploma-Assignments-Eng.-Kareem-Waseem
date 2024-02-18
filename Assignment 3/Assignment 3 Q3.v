`timescale 1ns/1ps
module ripple_counter (
	input clk, rst_n,
	output [3:0] out
	);

    wire [3:0] qn ;
    wire clk1, clk2, clk3, clk4 ;

    D_FF ff1 (qn[0], clk, rst_n,  clk1, qn[0]);
    D_FF ff2 (qn[1], clk1, rst_n, clk2, qn[1]);
    D_FF ff3 (qn[2], clk2, rst_n, clk3, qn[2]);
    D_FF ff4 (qn[3], clk3, rst_n, clk4, qn[3]);

    assign out = qn;

endmodule


module ripple_counter_tb ();
  reg clk, rst_n ;
  wire [3:0] out ;
  ripple_counter dut (clk, rst_n, out) ;

  initial begin
  	clk=0;
  	forever
  	#10 clk=~clk;
  end
 
  initial begin
  	rst_n=0;
  	repeat(2) @(negedge clk) ;
  	rst_n=1;
  	repeat(50) @(negedge clk) ;
  	$stop;
  end     
endmodule

