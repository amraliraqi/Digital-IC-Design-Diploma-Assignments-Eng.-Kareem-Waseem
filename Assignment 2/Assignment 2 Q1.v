`timescale 1ns/1ps
module q1_dut 
         (
         	input [3:0] x,
         	output reg [1:0] y
         	);

         always @(*)
            casex(x)
              4'b1xxx: y=2'b11 ;
              4'b01xx: y=2'b10 ;
              4'b001x: y=2'b01 ;
              default: y=2'b00 ;
            endcase
            
endmodule              


module q1_ref 
         (
         	input [3:0] x,
         	output reg [1:0] y
         	);


         always @(*)
           if(x[3])
              y=2'b11 ;
           else if (x[2])
              y=2'b10 ;
           else if (x[1])
              y=2'b01 ;
           else
              y=2'b00 ;

endmodule                       


module q1_tb ();

      reg [3:0] x;
      wire [1:0] y_dut, y_ref ;

      q1_dut dut (x, y_dut) ;
      q1_ref ref (x, y_ref) ;

      initial begin
         repeat(100) begin
            x = $random ;
            #10;
            if(y_dut != y_ref) begin
               $display ("Fail") ;
               $stop ;
            end
         end
         $display("Pass") ;
         $stop ;
      end

      initial begin
         $monitor("x=%b,y_dut=%b,y_ref=%b",x,y_dut,y_ref) ;
      end

endmodule
