module q5 (
	input A,B,
	input Ainvert, Binvert, CarryIn,
	input [1:0] Operation,
	output Carryout, Result 
	);

        wire Amux, Bmux, ANDout, ORout, Adderout ;

        assign Amux = Ainvert ? ~A : A ;
        assign Bmux = Binvert ? ~B : B ;

        and (ANDout, Amux, Bmux) ;
        or  (ORout, Amux, Bmux) ;

        assign {Carryout, Adderout} = Amux + Bmux + CarryIn ;

        assign Result = Operation==2'b00 ? ANDout :
                        Operation==2'b01 ? ORout :
                        Operation==2'b10 ? Adderout : 1'bx ;

 endmodule                       
