`timescale 1ns/1ps
module T_FF (
	input T, clk, rst_n,
	output Q, Q_n
	);

      reg Q_reg, Q_next ;

      always @(posedge clk or negedge rst_n)
        if(~rst_n)
          Q_reg <= 1'b0;
        else 
          Q_reg <= Q_next ;

       assign Q_next = T ? ~Q_reg: Q_reg ;
       assign Q = Q_reg;
       assign Q_n = ~Q_reg;

endmodule

module T_FF_tb ();

  reg T, clk, rst_n ;
  wire Q, Q_n ;

  T_FF T_FF (T, clk, rst_n, Q, Q_n) ;

  initial begin
  	clk=1'b1;
  	forever
  	#10 clk=~clk;
  end           

  initial begin
  	rst_n=0;
  	T=0;
  	repeat(2) @(negedge clk) ;
  	rst_n=1;
  	repeat(5) @(negedge clk) ;
  	T=1;
  	repeat(7) @(negedge clk) ;
  	$stop;
  end

endmodule  

