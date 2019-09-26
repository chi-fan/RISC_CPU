  module alu_cpu(
              clk,
              rst,
          con_alu,
             data,
             accum,
             opcode,
             zero,
             alu_out
          );

    input clk,rst,con_alu;
    input [7:0] data,accum;
    input [2:0] opcode;
    output [7:0] alu_out;
    output zero;

    reg [7:0] alu_out;

    parameter  HLT=3'b000,
     SKZ=3'b001,
     ADD=3'b010,
     AND=3'b011,
     XOR=3'b100,
     LDA=3'b101,
     STO=3'b110,
     JMP=3'b111;                      

      always@(posedge clk or negedge rst)
        begin
         if(!rst)
         alu_out<=8'b00000000;
       else 
      begin
        if(con_alu)
     begin
      casex(opcode)
        HLT:alu_out<=accum;
        SKZ:alu_out<=accum;
        ADD:alu_out<=accum+data;
        AND:alu_out<=data&accum;
        XOR:alu_out<=data^accum;
        LDA:alu_out<=data;
       STO:alu_out<=accum;
       JMP:alu_out<=accum;
       default:alu_out<=8'bxxxxxxxx;
     endcase
     end
     end
     end

      assign zero=!accum; 

    endmodule 