module Flipflop #(parameter FF_TYPE="DFF") 
    (
    input D, clk, rst_n,
	output Q, Q_n
	);

	generate
		if(FF_TYPE=="TFF")
		  T_FF T_FF (D, clk, rst_n, Q, Q_n) ;
		else
		  D_FF D_FF (D, clk, rst_n, Q, Q_n) ;  
		
	endgenerate
endmodule

