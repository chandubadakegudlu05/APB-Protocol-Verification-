//************************************************//
//Author:CHANDU B V
//e-mail:chandubadakegudlu@gmail.com 
//Description:This is APB_TEST
//Date:04/03/2026 to 20/04/2026
//APB Protocol 3
//***********************************************//

`ifndef _APB_TEST_
`define _APB_TEST_

class apb_test; 

   apb_env env;
   virtual apb_interface vif;
       
  function new(virtual apb_interface vif);
      this.vif=vif;
      env=new(vif);
   endfunction

  virtual task run();
      
   endtask

endclass:apb_test

`endif
