`timescale 1ns/1ps
module Flipflop_tb_1 () ;
        reg D, clk, rst_n ;
        wire Q_dut, Q_n_dut ;
        wire Q_ref, Q_n_ref ;
        
        Flipflop #(.FF_TYPE("DFF")) dut (D, clk, rst_n, Q_dut, Q_n_dut) ;
        D_FF ref (D, clk, rst_n, Q_ref, Q_n_ref) ;

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

        always@(*)
          if(Q_dut != Q_ref) begin
            $display("Error") ;
            $stop;
          end
endmodule


module Flipflop_tb_2 () ;
        
  reg T, clk, rst_n ;
  wire Q_dut, Q_n_dut ;
  wire Q_ref, Q_n_ref ;
        
  Flipflop #(.FF_TYPE("TFF")) dut (T, clk, rst_n, Q_dut, Q_n_dut) ; 
  T_FF ref (T, clk, rst_n, Q_ref, Q_n_ref) ;

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

  always@(*)
   if(Q_dut != Q_ref) begin
      $display("Error") ;
      $stop;
    end

endmodule  


         