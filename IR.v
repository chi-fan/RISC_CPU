 module IR(
              clk,
              rst,
              ena,
             data,
            instr
          );

    input clk,rst,ena;
    input [7:0] data;
    output [15:0] instr;

    reg [15:0] instr;
    reg state;

  always@(posedge clk or negedge rst)
    begin
   if(!rst)
    begin
     instr<=16'b0000000000000000;
   state<=1'b0;
  end
  else 
  begin
  if(ena)
    begin
     casex(state)
   1'b0:begin
        instr[15:8]<=data;
        state<=1'b1;
        end
   1'b1:begin
        instr[7:0]<=data;
        state<=1'b0;
        end
   default:begin
        instr<=16'bxxxxxxxxxxxx;
        state<=1'bx;
        end
    endcase
    end
   end
   end               

   endmodule 