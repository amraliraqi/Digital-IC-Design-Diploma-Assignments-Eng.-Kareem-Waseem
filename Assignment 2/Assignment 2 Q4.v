`timescale 1ns/1ps
module q4_dut #(parameter N=4)
     (
     	input [N-1:0] A,B,
     	input [1:0] op,
     	input enable,
     	output reg a, b, c, d, e, f, g
     	);
      wire [N-1:0] result ;
      q3_dut #(.N(N)) dut (A, B, op, result) ;

      always @(*) begin
      	if(~enable)
      	  { a, b, c, d, e, f, g} = 0;
      	else 
      	  case(result)
      	   0: { a, b, c, d, e, f, g}=1111110;
      	   1: { a, b, c, d, e, f, g}=0110000;
      	   2: { a, b, c, d, e, f, g}=1101101;
      	   3: { a, b, c, d, e, f, g}=1111001;
      	   4: { a, b, c, d, e, f, g}=0110011;
      	   5: { a, b, c, d, e, f, g}=1011011;
      	   6: { a, b, c, d, e, f, g}=1011111;
      	   7: { a, b, c, d, e, f, g}=1110000;
      	   8: { a, b, c, d, e, f, g}=1111111;
      	   9: { a, b, c, d, e, f, g}=1111011;
      	   10:{ a, b, c, d, e, f, g}=1110111;
      	   11:{ a, b, c, d, e, f, g}=0011111;
      	   12:{ a, b, c, d, e, f, g}=1001110;
      	   13:{ a, b, c, d, e, f, g}=0111101;
      	   14:{ a, b, c, d, e, f, g}=1001111;
      	   15:{ a, b, c, d, e, f, g}=1000111;
      	  endcase 
      end
endmodule


module q4_tb #(parameter N=4) ();
        reg [N-1:0] A,B ;
     	reg [1:0] op ;
     	reg enable ;
     	wire a_dut, b_dut, c_dut, d_dut, e_dut, f_dut, g_dut;
     	reg a_exp, b_exp, c_exp, d_exp, e_exp, f_exp, g_exp;

     	wire [6:0] display_dut, display_exp ;
     	assign display_dut = {a_dut, b_dut, c_dut, d_dut, e_dut, f_dut, g_dut};
     	assign display_exp = {a_exp, b_exp, c_exp, d_exp, e_exp, f_exp, g_exp};

     	q4_dut #(.N(N)) dut (A, B, op, enable, a_dut, b_dut, c_dut, d_dut, e_dut, f_dut, g_dut) ;

     	initial begin
     		#0  A=4; B=1; op=1; enable=1; {a_exp, b_exp, c_exp, d_exp, e_exp, f_exp, g_exp}=1011011;
     		#10 A=3; B=13; op=1; enable=1; {a_exp, b_exp, c_exp, d_exp, e_exp, f_exp, g_exp}=1000111;
     		#10 A=6; B=5; op=2; enable=1; {a_exp, b_exp, c_exp, d_exp, e_exp, f_exp, g_exp}=0110000;
     		#10 A=0; B=10; op=1; enable=1; {a_exp, b_exp, c_exp, d_exp, e_exp, f_exp, g_exp}=1110111;
     		#10 A=12; B=6; op=0; enable=1; {a_exp, b_exp, c_exp, d_exp, e_exp, f_exp, g_exp}=1101101;
     		#10 A=14; B=11; op=3; enable=0; {a_exp, b_exp, c_exp, d_exp, e_exp, f_exp, g_exp}=0000000;
     		#10 $stop;

     	end

     	initial 
     	  $monitor("A=%b, B=%b, op=%b, enable=%b, display_dut=%b, display_exp=%b", A, B, op, enable, display_dut, display_exp) ;

endmodule     	  


