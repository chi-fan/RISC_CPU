 module accumulator(
              clk,
              rst,
              ena,
             data,
            accum
          );

     input clk,rst,ena;
     input [7:0] data;
     output [7:0] accum;

    reg [7:0] accum;

     always@(posedge clk or negedge rst)
    begin
    if(!rst)
    accum<=8'b00000000;
    else 
    if(ena)
    accum<=data;
     end

    endmodule 