`timescale 1ns/1ps
module latch
 (
	input CLR_n, D, G,
	output reg Q
	);
      
      always @(*)
        if(~CLR_n)
          Q <= 1'b0;
        else if(G)
          Q <= D ;

endmodule            

module latch_tb ();

  reg CLR_n, D, G ;
  wire Q ;
  latch latch (CLR_n, D, G, Q) ;

  initial begin
  	CLR_n=1'b0;
  	forever
  	#10 CLR_n=~CLR_n ;
  end

  initial begin
  	G=1'b1;
  	repeat(5) begin
  		D=$random ;
  		@(posedge CLR_n) ;
  	end
  	#4 G=1'b0;
  	repeat(5) begin
  		D=$random ;
  		@(posedge CLR_n) ;
  	end
  	$stop ;

  end
endmodule

