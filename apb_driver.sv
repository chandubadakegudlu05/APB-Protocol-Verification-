//************************************************//
//Author:CHANDU B V
//e-mail:chandubadakegudlu@gmail.com 
//Description:This is APB_DRIVER
//Date:04/03/2026 to 20/04/2026
//APB Protocol 3
//***********************************************//

`ifndef _APB_DRIVER_
`define _APB_DRIVER_

class apb_driver;

   apb_transaction tra_h;
   mailbox gen_dvr;
   mailbox recovery;
   virtual apb_interface vif;
   int wait_count;

   function new(mailbox gen_dvr,virtual apb_interface vif);
      tra_h=new();
      recovery=new();
      this.vif=vif;
      this.gen_dvr=gen_dvr;
   endfunction:new

   task run();
      forever begin
         if (!vif.presetn || $isunknown(vif.presetn))
            reset_logic();
         else begin
         if (recovery.num()==0)
            gen_dvr.get(tra_h);
         else
            recovery.get(tra_h);
            driver_logic();
         end
         @(vif.master_cb);
      end
   endtask:run

   task reset_logic();
      do begin
      $display("[%0t] enter to reset_logic",$time);
      vif.master_cb.psel<=1'b0;
      vif.master_cb.penable<=1'b0;
      vif.master_cb.paddr<=32'b0;
      vif.master_cb.pwdata<=32'b0;
      vif.master_cb.pwrite<=1'b0;
      @(vif.master_cb);
      $display("[%0t] exited from reset logic",$time);
      end
      while(!vif.presetn || $isunknown(vif.presetn));
   endtask:reset_logic
   
   task driver_logic();

      @(vif.master_cb);

      //setup state
      if(!vif.presetn || $isunknown(vif.presetn))begin
         reset_logic();
         recovery.put(tra_h);
         return;
      end
         tra_h.display("DRIVER");


         vif.master_cb.psel   <=1'b1;
         vif.master_cb.penable<=1'b0;
         vif.master_cb.paddr  <=tra_h.paddr;
         vif.master_cb.pwdata<=tra_h.pwdata;
         vif.master_cb.pwrite<=tra_h.pwrite;
         $display("[%0t] entered to setup state",$time);
         @(vif.master_cb);

      //access state
      if(!vif.presetn || $isunknown(vif.presetn))begin
         reset_logic();
         recovery.put(tra_h);
         return;
      end

      vif.master_cb.penable<=1'b1;
      $display("[%0t] entered to access state",$time);

      @(vif.master_cb);
      if(!vif.presetn || $isunknown(vif.presetn))begin
         reset_logic();
         recovery.put(tra_h);
         return;
      end

      wait_count=32'b0;
     while(!vif.pready) begin //if preay = 0 enter to while loop
         @(vif.master_cb);
        if(!vif.presetn || $isunknown(vif.presetn))begin
         reset_logic();
         recovery.put(tra_h);
         return;
        end      
        wait_count++;
        if(wait_count>5)begin
        $error("[%0t] wait count reached maximum",$time);
        break;
     end
    end
      $display("[%0t] pready occured at %0d clock pulse",$time,wait_count);
      
      @(vif.master_cb);//wait 1 clk to read/write the data

       if(!vif.presetn || $isunknown(vif.presetn))begin
         reset_logic();
         recovery.put(tra_h);
         return;
        end
        
      vif.master_cb.psel<=1'b0;
      vif.master_cb.penable<=1'b0;
      $display("[%0t] Transcation completed\n",$time);

   endtask:driver_logic
endclass:apb_driver
`endif
