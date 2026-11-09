//************************************************//
//Author:CHANDU B V
//e-mail:chandubadakegudlu@gmail.com 
//Description:This is top module
//Date:04/03/2026 to 20/04/2026
//APB Protocol 3
//***********************************************//

import apb_test_package::*;

module apb_top();
reg pclk,presetn;
apb_interface intf_h(pclk,presetn);
apb_test t_h;
apb_write_test w_t_h;
apb_read_test r_t_h;
apb_write_read_test w_r_t_h;
apb_error_test e_t_h;
apb_slave dut(intf_h);

always #5 pclk=~pclk;

initial begin
   pclk=0;presetn=0;
   #5 presetn=1;
   #30 presetn=0;
   #10 presetn=1;
   #30 presetn=1'bx;
   #10 presetn=1;
   #2300 $finish;
end
//error_test
//initial begin
//   e_t_h=new(intf_h);
//   t_h=e_t_h;
//   $cast(t_h,e_t_h);
//   e_t_h.run();
//end

//read_test
initial begin
   t_h=new(intf_h);

   $display("\n entered to write/read test case \n");
   w_r_t_h=new(intf_h);
   t_h=w_r_t_h;
   //$cast(t_h,r_t_h);
   t_h.run();

   $display("\n entered to write test case \n");
   w_t_h=new(intf_h);
   t_h=w_t_h;
   //$cast(t_h,r_t_h);
   t_h.run();

   $display("\n entered to read test case \n");
    r_t_h=new(intf_h);
   t_h=r_t_h;
   //$cast(t_h,r_t_h);
   t_h.run();

   $display("\n entered to error test case \n");
    e_t_h=new(intf_h);
   t_h=e_t_h;
   //$cast(t_h,r_t_h);
   t_h.run();
   
end

//write_test
//initial begin
//   w_t_h=new(intf_h);
//   t_h=w_t_h;
//   $cast(t_h,w_t_h);
//   w_t_h.run();
//end
endmodule
