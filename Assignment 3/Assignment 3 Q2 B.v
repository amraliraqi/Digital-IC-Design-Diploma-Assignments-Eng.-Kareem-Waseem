`timescale 1ns/1ps
module D_FF (
	input D, clk, rst_n,
	output Q, Q_n
	);

      reg Q_reg, Q_next;
      
      always@(posedge clk or negedge rst_n)
        if(~rst_n)
          Q_reg<=0;
        else 
          Q_reg<=Q_next;

      assign Q_next = D;
      assign Q = Q_reg;
      assign Q_n = ~Q_reg;

endmodule

module D_FF_tb () ;

        reg D, clk, rst_n ;
        wire Q, Q_n ;
        D_FF D_FF (D, clk, rst_n, Q, Q_n) ;

        initial begin
        	clk=1;
        	forever
        	#10 clk=~clk;
        end

        initial begin
        	rst_n=0;
        	repeat(5) begin
        		D=$random;
        		@(negedge clk) ;
        	end
        	rst_n=1;
        	repeat(10) begin
        		D=$random;
        		@(negedge clk) ;
        	end
        	$stop;
        end
endmodule
