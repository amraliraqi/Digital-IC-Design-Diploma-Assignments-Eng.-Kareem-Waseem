`timescale 1ns/1ps
module q3_dut #(parameter N=4)
     (
     	input [N-1:0] a,b,
     	input [1:0] op,
     	output reg [N-1:0] result
     	);
  
           always @(*)
             case(op)
               0: result=a+b;
               1: result=a|b;
               2: result=a-b;
               3: result= a^b ;
               default: result= 'bx;
             endcase
endmodule


module q3_ref #(parameter N=4)
     (
      input [N-1:0] a,b,
      input [1:0] op,
      output reg [N-1:0] result
      );
  
           always @(*)
             if(op==0)
               result=a+b;
             else if(op==1)
               result=a|b;
             else if(op==2)
               result=a-b;
             else if(op==3)
               result=a^b;
             else
               result='bx;       
endmodule



module q3_tb #(parameter N=4) ();

       reg [N-1:0] a, b ;
       reg [1:0] op ;
       wire [N-1:0] result_dut, result_ref ;

       q3_dut #(.N(N)) dut (a, b, op, result_dut) ;
       q3_ref #(.N(N)) ref (a, b, op, result_ref) ;

       initial begin
         repeat(1000) begin
           a=$random ;
           b=$random ;
           op=$random ;
           #10;
           if(result_dut != result_ref) begin
             $display("Fail") ;
             $stop ;
           end
         end
         $display("Pass") ;
         $stop;
       end

       initial 
         $monitor("a=%b, b=%b, op=%b, result_dut=%b, result_ref=%b", a, b, op, result_dut, result_ref) ;

endmodule

