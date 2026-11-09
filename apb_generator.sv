//************************************************//
//Author:CHANDU B V
//e-mail:chandubadakegudlu@gmail.com 
//Description:This is APB_GENERATOR
//Date:04/03/2026 to 20/04/2026
//APB Protocol 3
//***********************************************//

`ifndef _APB_GENERATOR_
`define _APB_GENERATOR_

class apb_generator;

   apb_transaction packet;
   mailbox gen_drv;
   int count;
   bit [1:0] write_p;
   int write_read;
   int error;

   function new(mailbox gen_drv);
      this.gen_drv=gen_drv;
   endfunction:new

   task write();
      packet=new();
      packet.randomize() with {pwrite==1;};
      gen_drv.put(packet);
   endtask:write

   task read();
      packet=new();
      packet.randomize() with {pwrite==0;};
      gen_drv.put(packet);
   endtask:read

   task run();
    repeat(count) begin
      if (write_p==1 && !error)begin
         write();
      end
      else if(write_p==0 && !error) begin
         read();
      end
       else if(write_p==2 && !error) begin
         write();
         packet.display("Gen");
         read();
       end
      else if(error) begin
         packet=new();
         packet.randomize() with {paddr == 32'hffff_ffff;};
         gen_drv.put(packet);
      end
      else begin
         packet=new();
         packet.randomize();
         gen_drv.put(packet);
      end
      packet.display("Gen");
    end
   endtask:run
endclass:apb_generator
`endif
