module controller(
            clk,
            rst,
            ena,
            zero,
            opcode,
            load_acc,
            load_pc,
            rd,
            wr,
            load_ir,
            HALT,
            datactr_ena,
            inc_pc
        );

input clk,rst,ena,zero;
input [2:0]opcode;
output inc_pc,load_acc,load_pc,rd,wr,load_ir,HALT,datactr_ena;

reg inc_pc,load_acc,load_pc,rd,wr,load_ir,HALT,datactr_ena;
reg [2:0]state;

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
   begin
   state<=3'b000;
     {inc_pc,load_acc,load_pc,rd,wr,load_ir,HALT,datactr_ena} <=8'b00000000;         
 end
else 
 if(ena)
  controller_cycle;
end

task controller_cycle;
 begin
   case(state)
   3'b000:begin
      {inc_pc,load_acc,load_pc,rd,wr,load_ir,HALT,datactr_ena}<=8'b10010100;
      state<=3'b001;
     end
  3'b001:begin
      {inc_pc,load_acc,load_pc,rd,wr,load_ir,HALT,datactr_ena}<=8'b10010100;
      state<=3'b010;
     end
   3'b010:begin
      {inc_pc,load_acc,load_pc,rd,wr,load_ir,HALT,datactr_ena}<=8'b00000000;
      state<=3'b011;
     end
     3'b011:begin
      if(opcode==HLT)
        {inc_pc,load_acc,load_pc,rd,wr,load_ir,HALT,datactr_ena}<=8'b00000010;  
      else
        {inc_pc,load_acc,load_pc,rd,wr,load_ir,HALT,datactr_ena}<=8'b00000000;
    state<=3'b100;
      end
      3'b100:begin
       if(opcode==JMP)
         {inc_pc,load_acc,load_pc,rd,wr,load_ir,HALT,datactr_ena}<=8'b00100000;
     else 
       if((opcode==ADD)||(opcode==AND)||(opcode==XOR)||(opcode==LDA))
          {inc_pc,load_acc,load_pc,rd,wr,load_ir,HALT,datactr_ena}<=8'b00010000;
        else
          if(opcode==STO)
              {inc_pc,load_acc,load_pc,rd,wr,load_ir,HALT,datactr_ena}<=8'b0000001;
        else
           {inc_pc,load_acc,load_pc,rd,wr,load_ir,HALT,datactr_ena}<=8'b00000000;
      state<=3'b101; 
      end
3'b101:begin
         if((opcode==ADD)||(opcode==AND)||(opcode==XOR)||(opcode==LDA))
           {inc_pc,load_acc,load_pc,rd,wr,load_ir,HALT,datactr_ena}<=8'b01010000;
         else
           if((opcode==SKZ)&&(zero==1))
             {inc_pc,load_acc,load_pc,rd,wr,load_ir,HALT,datactr_ena}<=8'b10000000;
          else
            if(opcode==JMP)
             {inc_pc,load_acc,load_pc,rd,wr,load_ir,HALT,datactr_ena}<=8'b00100000;
           else
             if(opcode==STO)
              {inc_pc,load_acc,load_pc,rd,wr,load_ir,HALT,datactr_ena}<=8'b00001001;
            else
              {inc_pc,load_acc,load_pc,rd,wr,load_ir,HALT,datactr_ena}<=8'b00000000;
        state<=3'b110;
        end
  3'b110:begin
           if(opcode==STO)
              {inc_pc,load_acc,load_pc,rd,wr,load_ir,HALT,datactr_ena}<=8'b0000001;
            else
              if((opcode==ADD)||(opcode==AND)||(opcode==XOR)||(opcode==LDA))
                 {inc_pc,load_acc,load_pc,rd,wr,load_ir,HALT,datactr_ena}<=8'b00010000;
               else
                 {inc_pc,load_acc,load_pc,rd,wr,load_ir,HALT,datactr_ena}<=8'b00000000;
            state<=3'b111;
            end
    3'b111:begin
            if((opcode==SKZ)&&(zero==1))
               {inc_pc,load_acc,load_pc,rd,wr,load_ir,HALT,datactr_ena}<=8'b10000000;
             else
               {inc_pc,load_acc,load_pc,rd,wr,load_ir,HALT,datactr_ena}<=8'b00000000;
             state<=3'b000;
            end
    default:begin
             {inc_pc,load_acc,load_pc,rd,wr,load_ir,HALT,datactr_ena}<=8'b00000000;
              state<=3'b000;
              end
        endcase                 
end
endtask

 endmodule