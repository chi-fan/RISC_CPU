 module pc_counter(
              clk,
              rst,
              inc_pc,
             load,
             ir_addr,
             pc_addr
          );

     input clk,rst,load,inc_pc;
     input [12:0] ir_addr;
     output [12:0] pc_addr;

     reg [12:0] pc_addr;

    always@(posedge clk or negedge rst)
    begin
    if(!rst)
      pc_addr<=13'b0000000000000;
    else
     if(load)
       pc_addr<=ir_addr;
    else
      if(inc_pc)
        pc_addr<=pc_addr+1;
   end

   endmodule  