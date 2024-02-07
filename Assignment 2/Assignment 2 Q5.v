module q5 (
	input d, en, clk,
	output reg q
	);

       always @(posedge clk)
       	if (en)
       		q <= d ;
       	else 
       		q <= q ;
   
endmodule