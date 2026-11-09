//************************************************//
//Author:CHANDU B V
//e-mail:chandubadakegudlu@gmail.com 
//Description:This is APB_READ_TEST
//Date:04/03/2026 to 20/04/2026
//APB Protocol 3
//***********************************************//

`ifndef _APB_READ_TEST_
`define _APB_READ_TEST_

class apb_read_test extends apb_test; 

   apb_env env;
   virtual apb_interface vif;
//   apb_generator gen;
    
   function new(virtual apb_interface vif);
       super.new(vif);
       this.vif=vif;
       env=new(vif);
   endfunction

   task run();
      env.agent_h.gen.count=10;
      env.agent_h.gen.write_p=0;
      env.run();
   endtask

endclass:apb_read_test

`endif
