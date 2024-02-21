module SLE (
	input D,CLK,EN,
	input ALn, ADn,
	input SLn, SD,
  input LAT,
	output Q
	);
 
          reg Q_reg_ff,Q_reg_latch; 
          reg Q_next ;

          always @(posedge CLK or negedge ALn)
            if(~ALn)
              Q_reg_ff <= ~ADn;
            else 
              Q_reg_ff <= Q_next;

          always @(*)
            if(~ALn)
              Q_reg_latch<=~ADn;
            else if(CLK)
              Q_reg_latch<=Q_next;

          always @(*)
            if(EN)
              if(~SLn)
                Q_next=SD;
             else 
                Q_next=D;
            else    
             Q_next= (LAT) ? Q_reg_latch:Q_reg_ff;

          assign Q= (LAT) ? Q_reg_latch:Q_reg_ff;     

endmodule      

`timescale 1ns/1ps
module SLE_tb();

  reg D,CLK,EN;
  reg ALn, ADn;
  reg SLn, SD;
  reg LAT;
  wire Q;
  SLE dut (D, CLK, EN, ALn, ADn, SLn, SD, LAT, Q) ;
  
  initial begin
    CLK=0;
    forever
    #10 CLK=~CLK;
  end

  initial begin
    D=0;
    ALn=0;
    ADn=0;
    EN=0;
    SLn=0;
    SD=1;
    LAT=0;
    repeat(2) @(negedge CLK);
    ALn=1;
    @(negedge CLK);
    EN=1;
    @(negedge CLK);
    SLn=1;
    repeat(2) @(negedge CLK);
    LAT=1;
    @(negedge CLK);
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

