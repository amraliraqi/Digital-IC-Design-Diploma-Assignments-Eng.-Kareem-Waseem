`timescale 1ns/1ps

module q2_dut
         (
         	input  d0, d1, d2, d3, d4, d5, d6, d7, d8, d9,  
         	output  reg y0, y1, y2, y3
         	);

        always @(*)
          case ({d9, d8, d7, d6, d5, d4, d3, d2, d1, d0})
             10'b0000000010 :  {y3, y2, y1, y0} = 4'd1;
             10'b0000000100 :  {y3, y2, y1, y0} = 4'd2;
             10'b0000001000 :  {y3, y2, y1, y0} = 4'd3;
             10'b0000010000 :  {y3, y2, y1, y0} = 4'd4;
             10'b0000100000 :  {y3, y2, y1, y0} = 4'd5;
             10'b0001000000 :  {y3, y2, y1, y0} = 4'd6;
             10'b0010000000 :  {y3, y2, y1, y0} = 4'd7;
             10'b0100000000 :  {y3, y2, y1, y0} = 4'd8;
             10'b1000000000 :  {y3, y2, y1, y0} = 4'd9;
             default        :  {y3, y2, y1, y0} = 4'd0;
          endcase
endmodule





module q2_tb ();
     reg  d0, d1, d2, d3, d4, d5, d6, d7, d8, d9 ;  
     wire y0_dut, y1_dut, y2_dut, y3_dut ;
     reg y0_exp, y1_exp, y2_exp, y3_exp ;

     wire [9:0] D;
     wire [3:0] Y_dut ;
     wire [3:0] Y_exp ;

     assign D = {d9, d8, d7, d6, d5, d4, d3, d2, d1, d0};
     assign Y_dut = {y3_dut, y2_dut, y1_dut, y0_dut};
     assign Y_exp = {y3_exp, y2_exp, y1_exp, y0_exp};

     q2_dut dut (d0, d1, d2, d3, d4, d5, d6, d7, d8, d9, y0_dut, y1_dut, y2_dut, y3_dut) ;

     initial begin
       #0   {d9, d8, d7, d6, d5, d4, d3, d2, d1, d0}= 10'b0000000010 ; {y3_exp, y2_exp, y1_exp, y0_exp}=4'd1;
       #10  {d9, d8, d7, d6, d5, d4, d3, d2, d1, d0}= 10'b0000000100 ; {y3_exp, y2_exp, y1_exp, y0_exp}=4'd2;
       #10  {d9, d8, d7, d6, d5, d4, d3, d2, d1, d0}= 10'b1000001000 ; {y3_exp, y2_exp, y1_exp, y0_exp}=4'd0;
       #10  {d9, d8, d7, d6, d5, d4, d3, d2, d1, d0}= 10'b0000010000 ; {y3_exp, y2_exp, y1_exp, y0_exp}=4'd4;
       #10  {d9, d8, d7, d6, d5, d4, d3, d2, d1, d0}= 10'b0000100000 ; {y3_exp, y2_exp, y1_exp, y0_exp}=4'd5;
       #10  {d9, d8, d7, d6, d5, d4, d3, d2, d1, d0}= 10'b0001000000 ; {y3_exp, y2_exp, y1_exp, y0_exp}=4'd6;
       #10  {d9, d8, d7, d6, d5, d4, d3, d2, d1, d0}= 10'b0010001100 ; {y3_exp, y2_exp, y1_exp, y0_exp}=4'd0;
       #10  {d9, d8, d7, d6, d5, d4, d3, d2, d1, d0}= 10'b0100000000 ; {y3_exp, y2_exp, y1_exp, y0_exp}=4'd8;
       #10  {d9, d8, d7, d6, d5, d4, d3, d2, d1, d0}= 10'b1011110001 ; {y3_exp, y2_exp, y1_exp, y0_exp}=4'd0;
       $stop ;
     end

     initial 
       $monitor("D=%b, Y_dut=%b, Y_exp=%b", D, Y_dut, Y_exp) ;
endmodule       
     






