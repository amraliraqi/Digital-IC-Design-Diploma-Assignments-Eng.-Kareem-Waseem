module ALSU #(parameter INPUT_PRIORITY="A", FULL_ADDER="ON")
(
	input clk, rst,
	input [2:0] A, B,
	input [2:0] opcode,
	input cin, serial_in,
	input direction,
	input red_op_A, red_op_B,
	input bypass_A, bypass_B,
	output reg [5:0] out,
	output reg [15:0] leds
	);

    reg [2:0] A_reg, B_reg;
	reg [2:0] opcode_reg;
	reg cin_reg, serial_in_reg;
	reg direction_reg;
	reg red_op_A_reg, red_op_B_reg;
	reg bypass_A_reg, bypass_B_reg;
	reg [5:0] out_next;
	reg [15:0] leds_next;

	always@(posedge clk or posedge rst) 
	  if(rst) begin
	  	A_reg <= 0;
	  	B_reg <= 0;
	  	opcode_reg <= 0;
	  	cin_reg <= 0;
	  	serial_in_reg <= 0;
	  	direction_reg <= 0;
	  	red_op_A_reg <= 0;
	  	red_op_B_reg <= 0;
	  	bypass_A_reg <= 0;
	  	bypass_B_reg <= 0;
	  	out <= 0;
	  	leds <= 0;
	  end
	  else begin
	  	A_reg <= A;
	  	B_reg <= B;
	  	opcode_reg <= opcode;
	  	cin_reg <= cin;
	  	serial_in_reg <= serial_in;
	  	direction_reg <= direction;
	  	red_op_A_reg <= red_op_A;
	  	red_op_B_reg <= red_op_B;
	  	bypass_A_reg <= bypass_A;
	  	bypass_B_reg <= bypass_B;
	  	out <= out_next;
	  	leds <= leds_next;
	  end

	  always @(*) begin
	  leds_next=0;
	   if(bypass_A_reg==1 && bypass_B_reg==1)
	      if(INPUT_PRIORITY=="A")
	        out_next=A_reg;
	      else if(INPUT_PRIORITY=="B")
	        out_next=B_reg;
	      else 
	        out_next=out; 
	   else if(bypass_A_reg==1)
	      out_next=A_reg;
	   else if(bypass_B_reg==1)
	      out_next=B_reg;
	    else    	    
	  	    case(opcode_reg)
	  	       0: if(red_op_A_reg==1 && red_op_B_reg==1)
	                 if(INPUT_PRIORITY=="A")
	                     out_next=&A_reg;
	                 else if(INPUT_PRIORITY=="B")
	                     out_next=&B_reg;
	                 else 
	                     out_next=out; 
	             else if(red_op_A_reg==1)
	                 out_next=&A_reg;
	             else if(bypass_B_reg==1)
	                 out_next=&B_reg;
	             else 
	                 out_next=A_reg&B_reg; 

	           1: if(red_op_A_reg==1 && red_op_B_reg==1)
	                 if(INPUT_PRIORITY=="A")
	                     out_next=^A_reg;
	                 else if(INPUT_PRIORITY=="B")
	                     out_next=^B_reg;
	                 else 
	                     out_next=out; 
	             else if(red_op_A_reg==1)
	                 out_next=^A_reg;
	             else if(bypass_B_reg==1)
	                 out_next=^B_reg;
	             else 
	                 out_next=A_reg^B_reg;

	           2: if(red_op_A_reg==1 || red_op_B_reg==1) begin
	                out_next=0;
	                leds_next=~leds; 
	              end 
	              else if(FULL_ADDER=="ON")
	                out_next=A_reg+B_reg+cin_reg;
	              else if(FULL_ADDER=="OFF")      
	                out_next=A_reg+B_reg;
	              else 
	                out_next=out;

	           3: if(red_op_A_reg==1 || red_op_B_reg==1) begin
	                out_next=0;
	                leds_next=~leds; 
	              end 
	              else 
	                out_next=A_reg*B_reg;

	           4: if(red_op_A_reg==1 || red_op_B_reg==1) begin
	                out_next=0;
	                leds_next=~leds; 
	              end 
	              else if(direction_reg)
	                out_next={out[4:0],serial_in_reg};
	              else 
	                out_next={serial_in_reg,out[5:1]};

	            5: if(red_op_A_reg==1 || red_op_B_reg==1) begin
	                out_next=0;
	                leds_next=~leds; 
	              end 
	              else if(direction_reg)
	                out_next={out[4:0],out[5]};
	              else 
	                out_next={out[0],out[5:1]};

	            6,7: begin
	            	out_next=0;
	                leds_next=~leds; 
	            end  
	  	endcase
	  end
endmodule
