    module addr(
          addr,
          fetch,
          pc_addr,
          ir_addr
            );

     input [12:0] pc_addr,ir_addr;
     input fetch;
     output [12:0]addr;

     assign addr=fetch?pc_addr:ir_addr;

      endmodule