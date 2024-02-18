module shift_register 
   #(parameter LOAD_AVALUE=1, LOAD_SVALUE=1,
	SHIFT_DIRECTION="LEFT",SHIFT_WIDTH=8)
   (input sclr, sset, shiftin, load,
   	input aclr, aset,clk, enable,
   	input [SHIFT_WIDTH-1:0] data,
   	output [SHIFT_WIDTH-1:0] q,
   	output reg shiftout
   	);
   reg [SHIFT_WIDTH-1:0] Q_reg, Q_next ;
   reg temp;

   always @(posedge clk or posedge aclr or posedge aset)
     if(aclr)
       Q_reg<=0;
     else if (aset)
       Q_reg<=LOAD_AVALUE;
     else begin
       Q_reg<=Q_next;
       shiftout=temp;
     end  

    always @(*)
    	if(enable)
    	  if(sclr)
    	    Q_next=0;
    	  else if(sset)
    	    Q_next=LOAD_SVALUE ;
    	  else if(load)
    	    Q_next = data;
    	  else if(!load && SHIFT_DIRECTION=="LEFT")
    	    {temp,Q_next}={Q_reg,shiftin};
    	  else if(!load && SHIFT_DIRECTION=="RIGHT")
    	    {Q_next,temp}={shiftin,Q_reg};
    	  else 
    	    Q_next=Q_reg;
    	else 
    	  Q_next=Q_reg;            

    assign q = Q_reg;
endmodule    


`timescale 1ns/1ps
module shift_register_tb #(parameter LOAD_AVALUE=1, LOAD_SVALUE=1,
	SHIFT_DIRECTION="LEFT",SHIFT_WIDTH=8) ();
    reg sclr, sset, shiftin, load ;
   	reg aclr, aset,clk, enable ;
   	reg [SHIFT_WIDTH-1:0] data ;
   	wire [SHIFT_WIDTH-1:0] q ;
   	wire shiftout ;
  	shift_register #(LOAD_AVALUE,LOAD_SVALUE,SHIFT_DIRECTION,SHIFT_WIDTH) 
   	dut (sclr, sset, shiftin, load, aclr, aset,clk, enable, data, q, shiftout);
   	initial begin
   		clk=0;
   		forever
   		  #10 clk=~clk;
   	end
   	initial begin
   	    data=8'b1100_1010;
   		{sclr,sset,shiftin,load,enable}=0;	
   		aset=0;
   	    aclr=1;
  		@(negedge clk);	
   	    aset=1; 
  	    aclr=0;
   		@(negedge clk);
   		aset=1;
   		aclr=1;
   		@(negedge clk);
   		aset=0;
   		aclr=0;
   	    @(negedge clk);
   		sset=0;
   		sclr=1;
   	    @(negedge clk);
   	    enable=1;
   		sset=1;
   		sclr=0;
   		@(negedge clk);
   		sset=1;
   		sclr=1;
   	    @(negedge clk);
   		sset=0;
   		sclr=0;
   		load=1;
   		@(negedge clk);
   		load=0;
   		repeat(10) @(negedge clk);
   		$stop;
   	end
endmodule  
 	


