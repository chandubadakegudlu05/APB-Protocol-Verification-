//************************************************//
//Author:CHANDU B V
//e-mail:chandubadakegudlu@gmail.com 
//Description:This is interface here we are creating a group of APB protocol singals
//Date:04/03/2026 to 20/04/2026
//APB Protocol 3
//***********************************************//

`ifndef _APB_INTERFACE_
`define _APB_INTERFACE_

interface apb_interface(input logic pclk,presetn);

   //control signals
   logic        psel;
   logic        penable;
   logic        pready;

   //side band signals
   logic [31:0] paddr;
   logic        pwrite;
   logic [31:0] pwdata;
   logic [31:0] prdata;
   logic        pslverr;
   //below 6 signals are for future use
  // logic        pport;
  // logic        pstrb;
  // logic        pauser;
  // logic        pwuser;
  // logic        pbuser;
  // logic        pruser;

   //clocking block for driver
   clocking master_cb@(posedge pclk);
      //default input #2 output #3;
      input pready,prdata,pslverr;
      output psel,penable,paddr,pwrite,pwdata;
   endclocking

   //modport block
   modport slave_mp(output pready,prdata,pslverr,
      input psel,penable,paddr,pwrite,pwdata);

   //clocking block for monitor
   clocking monitor_cb@(negedge pclk);
      //default input #4;
      input pready,prdata,pslverr;
      input psel,penable,paddr,pwrite,pwdata;
   endclocking


//   assertion block
   assert1:assert property (p1);
   assert2:assert property (p2);
   assert3:assert property (p3);
   assert4:assert property (p4);
   assert5:assert property (p5);
   assert6:assert property (p6);
   assert7:assert property (p7);
   assert8:assert property (p8);
//   assert9:assert property (p9);

   property p1;//penable should be high after 1cp of psel high
      @(posedge pclk) disable iff(!presetn || $isunknown(presetn)) $rose(psel)|-> ##1 $rose(penable);
   endproperty

   property p2;//when psel and penable are high within 0 to 5 pready should assert
      @(posedge pclk) disable iff(!presetn || $isunknown(presetn)) $rose(psel && penable)|-> ##[0:5] pready;
   endproperty

   property p3;//paddr and pwrite should be stable throughout setup to access
      @(posedge pclk) disable iff(!presetn || $isunknown(presetn)) 
      (psel && !penable)|=> 
      $stable(paddr) throughout (psel && penable);
   endproperty

   property p4;//when presetn deassert all blow signal should be deassert
      @(posedge pclk) $fell(presetn || $isunknown(presetn)) |-> ((!psel && !penable && !pwdata && !pwrite) || $isunknown({psel, penable, pwdata, pwrite, prdata}));
   endproperty

   property p5;//when transaction completes after 1cp state shoulb be idle 
      @(posedge pclk) disable iff(!presetn || $isunknown(presetn)) (psel && penable && pready)|-> ##[1:2] (!psel && !penable) ;
   endproperty

   property p6;//SETUP must be always followed by ACCESS 
      @(posedge pclk) disable iff(!presetn || $isunknown(presetn)) (psel && !penable) |=> (psel && penable);
   endproperty

   property p7;//pwrite should be stable throughout setup to access
      @(posedge pclk) disable iff(!presetn  || $isunknown(presetn)) 
      (psel && !penable)|=> 
      $stable(pwrite) until_with (psel && penable && pready);
   endproperty

   property p8;//penable should become low when ever psel is low
      @(posedge pclk) disable iff(!presetn || $isunknown(presetn)) !psel|->  !penable;
   endproperty

endinterface:apb_interface
`endif
