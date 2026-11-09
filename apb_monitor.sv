//************************************************//
//Author:CHANDU B V
//e-mail:chandubadakegudlu@gmail.com 
//Description:This is APB_MONITOR
//Date:04/03/2026 to 20/04/2026
//APB Protocol 3
//***********************************************//

`ifndef _APB_MONITOR_
`define _APB_MONITOR_

class apb_monitor;

   virtual apb_interface vif;
   mailbox mon_sb;
   apb_transaction tra_h;
   int count;

   function new(mailbox mon_sb,virtual apb_interface vif);
      tra_h=new();
      this.vif=vif;
      this.mon_sb=mon_sb;
      cg=new();
      apb_state_cg=new();
   endfunction:new

   task run();
      forever begin
        cg.sample();
         @(vif.monitor_cb);

         if(!vif.monitor_cb.psel && !vif.monitor_cb.penable)

         if(!vif.presetn || $isunknown(vif.presetn))
            continue;
//setup state         
         if(!(vif.monitor_cb.psel && !vif.monitor_cb.penable))
            continue;
         tra_h.paddr=vif.monitor_cb.paddr;
         tra_h.pwdata=vif.monitor_cb.pwdata;
         tra_h.pwrite=vif.monitor_cb.pwrite;

         $display("[%0t] [MON] setup: paddr=%0d, pwrite=%0d, pwdata=%0d",$time,vif.monitor_cb.paddr,vif.monitor_cb.pwrite,vif.monitor_cb.pwdata);

         @(vif.monitor_cb);
           
         if(!vif.presetn || $isunknown(vif.presetn))
            continue;

//access state
         if(!vif.monitor_cb.penable)begin
            $display("[%0t] [MON] penable is not asserted",$time);
            continue;
         end

         @(vif.monitor_cb);

         if(!vif.presetn || $isunknown(vif.presetn))
            continue;
//wait for pready
         count=32'b0;
      while(!vif.monitor_cb.pready)begin
         @(vif.monitor_cb);
         if(!vif.presetn || $isunknown(vif.presetn))
            continue;
         count++;
         if(count > 5)begin
            $error("[MON] pready timeout");
            break;
         end
      end
         if(!vif.presetn || $isunknown(vif.presetn))
            continue;
    
         tra_h.prdata=vif.monitor_cb.prdata;
         tra_h.pslverr=vif.monitor_cb.pslverr;

         if(vif.monitor_cb.pslverr)
            $display("[%0t] [MON] ----ERROR DETECTED----",$time);
         
         mon_sb.put(tra_h);
         tra_h.display("MON");
         end
         
   endtask:run
 
   covergroup cg;
      pwrite:coverpoint vif.monitor_cb.pwrite{bins write_high={1};
                                              bins write_low={0};}
      pslverr:coverpoint vif.monitor_cb.pslverr{bins pslverr_high={1};
                                                bins pslverr_low={0};}
      psel:coverpoint vif.monitor_cb.psel{bins psel_high={1};
                                          bins psel_low={0};}
      penable:coverpoint vif.monitor_cb.penable{bins penable_high={1};
                                                bins penable_low={0};}
      pwdata:coverpoint vif.monitor_cb.pwdata{bins pwdata_low={[8'h0:8'hff]};
                                              bins pwdata_medium={[16'h100:16'hffff]};
                                              bins pwdata_high={[32'h10000:32'hffff_ffff]};}
      paddr:coverpoint vif.monitor_cb.paddr{bins paddr_low={[0:100]};
                                              bins paddr_medium={[101:180]};
                                              bins paddr_high={[181:256]};}
      prdata:coverpoint vif.monitor_cb.prdata{bins prdata_low={[0:100]};
                                              bins prdata_medium={[101:180]};
                                              bins prdata_high={[181:256]};}
      wait_count:coverpoint count iff(vif.monitor_cb.psel && vif.monitor_cb.penable){bins odd={1,3,5};
              bins even={0,2,4};}
            //  bins two={2};
            //  bins high={5,4};}
//              bins four={4};
//              bins five={5};}
     pready:coverpoint vif.monitor_cb.pready iff(vif.monitor_cb.psel && vif.monitor_cb.penable){bins low={0};
              bins high={1};}
     //cross coverage
      pwdata_wait:cross pwdata,wait_count;
      pslverr_wait:cross pslverr,wait_count;
      
   endgroup

   covergroup apb_state_cg @(posedge vif.pclk);
      apb_state: coverpoint {vif.psel,vif.penable}{ bins idle={2'b00};
                                             bins setup={2'b10};
                                             bins access={2'b11};
                                             illegal_bins invalid={2'b01};}
      apb_state_transition: coverpoint {vif.psel,vif.penable}{ bins t1=(2'b00=>2'b10);
        bins t2=(2'b10=>2'b11);
        bins t3=(2'b11=>2'b00);}

  endgroup

endclass:apb_monitor
`endif
