module SLE #(parameter LAT=0, ADn=0, SD=1)(
	input D,CLK,EN,
	input ALn,
	input SLn,
	output Q
	);
 
      reg Q_reg, Q_next ;
      generate
        if(~LAT) begin
          always @(posedge CLK or negedge ALn)
            if(~ALn)
              Q_reg <= ~ADn;
            else 
              Q_reg <= Q_next;

          always @(*)
            if(EN)
              if(~SLn)
                Q_next=SD;
             else 
                Q_next=D;
            else 
              Q_next=Q_reg;
          assign Q=Q_reg;    
        end       
        else begin
          always @(*)
            if(~ALn)
              Q_reg<=~ADn;
            else if(CLK)
              Q_reg<=Q_next;

          always @(*)
            if(EN)
              if(~SLn)
                Q_next=SD;
             else 
                Q_next=D;
            else 
              Q_next=Q_reg;
          assign Q=Q_reg;     
        end                          
      endgenerate

endmodule      

`timescale 1ns/1ps
module SLE_tb();

  reg D,CLK,EN;
  reg ALn;
  reg SLn;
  wire Q;
  SLE  #(0,0,1)dut (D, CLK, EN, ALn, SLn,Q) ;
  
  initial begin
    CLK=0;
    forever
    #10 CLK=~CLK;
  end
  initial begin
    D=0;
    ALn=0;
    EN=0;
    SLn=0;
    @(negedge CLK);
    ALn=1;
    @(negedge CLK);
    EN=1;
    @(negedge CLK);
    SLn=1;
    repeat(2) @(negedge CLK);
    $stop;
  end
endmodule

