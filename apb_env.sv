//************************************************//
//Author:CHANDU B V
//e-mail:chandubadakegudlu@gmail.com 
//Description:This is APB_ENV
//Date:04/03/2026 to 20/04/2026
//APB Protocol 3
//***********************************************//


`ifndef _APB_ENV_
`define _APB_ENV_


class apb_env;
   apb_agent agent_h;
   apb_score_board sb_h;
   mailbox mon_sb;
   virtual apb_interface vif;

   function new(virtual apb_interface vif);
      this.vif=vif;
      mon_sb=new();
      sb_h  =new(mon_sb);
      agent_h=new(vif,mon_sb);
   endfunction

   task run();
      fork
         agent_h.run();
         sb_h.run();
      join_any
     #0;
    disable fork;
         sb_h.sb_report();
   endtask

endclass:apb_env
`endif
