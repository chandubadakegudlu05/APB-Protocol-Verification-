//************************************************//
//Author:CHANDU B V
//e-mail:chandubadakegudlu@gmail.com 
//Description:This is APB_AGENT
//Date:04/03/2026 to 20/04/2026
//APB Protocol 3
//***********************************************//

`ifndef _APB_AGENT_
`define _APB_AGENT_

class apb_agent;

   apb_generator gen;
   mailbox gen_drv;
   apb_driver drv;
   mailbox mon_sb;
   apb_monitor mon;
   virtual apb_interface vif;

   function new(virtual apb_interface vif, mailbox mon_sb);
      this.vif=vif;
      this.mon_sb=mon_sb;
      gen_drv=new();
      gen=new(gen_drv);
      drv=new(gen_drv,vif);
      mon=new(mon_sb,vif);
   endfunction

   task run();
      fork
         gen.run();
         drv.run();
         mon.run();
      join_any
      #580;
      disable fork;
   endtask
endclass:apb_agent
`endif
