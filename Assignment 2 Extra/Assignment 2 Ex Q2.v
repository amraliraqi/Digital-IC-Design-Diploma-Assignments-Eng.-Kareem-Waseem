module demux_1x4_dut (
	input D,
	input [1:0] S,
	output reg [3:0] Y);

     always @(*) 
     begin
       Y=4'b0000;
       case(S)
        0: Y[0]=D;
        1: Y[1]=D;
        2: Y[2]=D;
        3: Y[3]=D;
       endcase
     end  

endmodule       


module demux_1x4_ref (
	input D,
	input [1:0] S,
	output reg [3:0] Y);

     always @(*) 
       if(S==0)
         Y={3'b0,D} ;  
       else if(S==1)
         Y={2'b0,D,1'b0} ;
       else if(S==2)
         Y={1'b0,D,2'b0} ;
       else 
         Y={D,3'b0} ;      

endmodule       


module demux_1x4_tb ();

      reg  D;
      reg [1:0] S ;
      wire [3:0] Y_dut, Y_ref ;

      demux_1x4_dut dut (D, S, Y_dut) ;
      demux_1x4_ref ref (D, S, Y_ref) ;

      initial begin
         repeat(100) begin
            D = $random ;
            S = $random ;
            #10;
            if(Y_dut != Y_ref) begin
               $display ("Fail") ;
               $stop ;
            end
         end
         $display("Pass") ;
         $stop ;
      end

      initial begin
         $monitor("D=%b, S=%b, Y_dut=%b, Y_ref=%b",D,S,Y_dut,Y_ref) ;
      end

endmodule
