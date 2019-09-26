module RISC_CPU(clk,
          rst,
          data,
          rd,
          wr,
          addr,
          HALT,
          fetch   
              );

  input clk,rst;
  output rd,wr,HALT,fetch;
  output[12:0]addr;
  inout[7:0]data;

   wire con_alu,clk1;
  //wire[15:0] instr;
  wire[2:0] opcode;
  wire[12:0] ir_addr;
  wire[7:0] accum,alu_out;
  wire zero;
  wire ena_controller;
  wire[12:0] pc_addr;
  wire load_acc,load_pc,load_ir,datactr_ena,inc_pc;

clk_gen clk_gen_m (.clk(clk),
               .rst(rst),
               .clk1(clk1),
               .fetch(fetch),
               .con_alu(con_alu)); 
        
IR IR_m (.clk(clk),
     .rst(rst),
     .ena(load_ir),
     .data(data),
     .instr({opcode,ir_addr}));
        
accumulator accumulator_m (.clk(clk),
                       .rst(rst),
                       .ena(load_acc),
                       .data(alu_out),
                       .accum(accum));
                       
 alu_cpu alu_cpu_m (.clk(clk),
               .rst(rst),
               .con_alu(con_alu),
               .data(data),
               .accum(accum),
               .opcode(opcode),
               .zero(zero),
               .alu_out(alu_out));
               
data_ctl data_ctl_m (.in(alu_out),
                 .data_ena(datactr_ena),
                 .data(data)); 
                 
pc_counter pc_counter_m (.clk(clk),
                     .rst(rst),
                     .inc_pc(inc_pc),
                     .load(load_pc),
                     .ir_addr(ir_addr),
                     .pc_addr(pc_addr));
                     
  addr addr_m ( .addr(addr),
          .fetch(fetch),
          .pc_addr(pc_addr),
          .ir_addr(ir_addr));
          
 controller_ena controller_ena_m (.clk(clk),
                             .rst(rst),
                             .fetch(fetch),
                             .ena_controller(ena_controller));   
                             
  controller controller_m (.clk(clk1),
                     .rst(rst),
                     .ena(ena_controller),
                     .zero(zero),
                     .opcode(opcode),
                     .load_acc(load_acc),
                     .load_pc(load_pc),
                     .rd(rd),
                     .wr(wr),
                     .load_ir(load_ir),
                     .HALT(HALT),
                     .datactr_ena(datactr_ena),
                     .inc_pc(inc_pc));                                                                                                                                       
            
 endmodule