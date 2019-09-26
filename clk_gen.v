     module clk_gen(
          clk,
          rst,
          clk1,
          fetch,
          con_alu
          );

     input clk,rst;
     output fetch,con_alu,clk1;
     reg fetch,con_alu;
     wire clk1;
     reg [2:0]count;

     assign clk1=~clk;

    always@(posedge clk or negedge rst)
     begin
      if(!rst)
       count<=0;
    else if(count==7)
    count<=0;
   else
     count<=count+1;
  end

   always@(posedge clk or negedge rst)
       begin
      if (!rst)
       begin
      fetch<=0;
     con_alu<=0;
     end  
    else
    case(count)
     0:begin
     fetch<=1;
     con_alu<=0;
     end
    1:begin
    fetch<=1;
    con_alu<=0;
    end
    2:begin
     fetch<=1;
    con_alu<=0;
   end
     3:begin
    fetch<=1;
    con_alu<=0;
   end
     4:begin
     fetch<=0;
     con_alu<=0;
     end
     5:begin
     fetch<=0;
     con_alu<=1;
     end
     6:begin
     fetch<=0;
     con_alu<=0;
     end
     7:begin
     fetch<=0;
     con_alu<=0;
      end 
     default:begin
        fetch<=0;
        con_alu<=0;
       end
      endcase
      end

    endmodule