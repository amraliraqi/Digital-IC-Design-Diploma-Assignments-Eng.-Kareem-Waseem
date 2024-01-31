module q1 
    (
     input A, B, C, D, E, F,
     input sel,
     output Out, Out_bar
	);

	  wire out_and, out_xnor ;

	  assign out_and = A & B & C ;             // describes the AND gate
	  assign out_xnor = ~(D ^ E ^ F) ;        // describes the XNOR gate
	  assign Out = sel ? out_xnor : out_and; //describes the Multiplexer
	  assign Out_bar = ~Out ;               // describes the inverter

endmodule
