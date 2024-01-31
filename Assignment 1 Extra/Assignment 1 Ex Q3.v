module q3 (
	input A, B, C,
	output F
	);

         wire out_xor, out_xnor;

         assign out_xor = A ^ B;            //describes XOR Gate
         assign out_xnor = B ~^ C;          //describes XNOR Gate
         assign F = out_xor & out_xnor & C; //describes 3 inputs AND Gate
endmodule

