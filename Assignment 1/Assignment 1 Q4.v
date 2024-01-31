module q4
       (
       	input [7:0] A,
       	output [8:0] out_with_parity
       	);

          wire parit_bit ;
          assign parit_bit = ^A;
          assign out_with_parity = {A,parit_bit};

endmodule          
