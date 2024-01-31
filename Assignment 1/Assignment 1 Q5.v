module q5
        (
        	input [3:0] A, B,
        	output A_greaterthan_B,
        	output A_equals_B,
        	output A_lessthan_B
        	);
        assign A_greaterthan_B = A>B ? 1'b1 : 1'b0 ;
        assign A_equals_B = A==B ? 1'b1 : 1'b0 ;
        assign A_lessthan_B = A<B ? 1'b1 : 1'b0 ;

endmodule        

