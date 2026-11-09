//************************************************//
//Author:CHANDU B V
//e-mail:chandubadakegudlu@gmail.com 
//Description:This is APB_TRANSACTION
//Date:04/03/2026 to 20/04/2026
//APB Protocol 3
//***********************************************//


`ifndef _APB_TRANSACTION_
`define _APB_TRANSACTION_

class apb_transaction;
                   
   //control signals
        bit psel;
        bit penable;
        bit pready;

   //side band signals
   rand bit [31:0] paddr;
   rand bit        pwrite;
   rand bit [31:0] pwdata;
        bit [31:0] prdata;
        bit        pslverr;

   //constraints   cann't write soft and dist together
   constraint c_paddr{soft paddr inside{[0:256]};
                      !(paddr inside{0,4,8,12});}
   constraint c_pwdata{pwdata dist{[8'h0:8'hff]:/30,[16'h100:16'hffff]:/30,[32'h10000:32'hffff_ffff]:/40};}
   
   function void display(string name);
      $display("[%0t],[%s] paddr=%0d,pwrite=%0b,pwdata=%0d,prdata=%0d,pslverr=%0b",$time,name,paddr,pwrite,pwdata,prdata,pslverr);
   endfunction

endclass:apb_transaction
`endif
