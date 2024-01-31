module q4 (
	input [2:0] A,
	output out
	);

       assign out = A==4'b0010 || A==4'b0011 || A==4'b0101 || A==4'b111 ? 1'b1 : 1'b0 ;

endmodule


