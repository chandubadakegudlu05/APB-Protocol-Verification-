//************************************************//
//Author:CHANDU B V
//e-mail:chandubadakegudlu@gmail.com 
//Description:This is APB_SCORE_BOARD
//Date:04/03/2026 to 20/04/2026
//APB Protocol 3
//***********************************************//


`ifndef _APB_SCORE_BOARD_
`define _APB_SCORE_BOARD_


class apb_score_board;
   mailbox mon_sb;
   apb_transaction tra_h;
   
   int mem[bit[256:0]];

   int pass_count;
   int fail_count;
   int total_count;

   function new(mailbox mon_sb);
      this.mon_sb=mon_sb;
      pass_count =0;
      fail_count =0;
      total_count=0;
   endfunction:new

   task run();
      forever begin
         tra_h=new();
         mon_sb.get(tra_h);
         mem[tra_h.paddr]=tra_h.paddr;
         total_count++;
         check();
        end
   endtask:run

   task check();
      if(tra_h.pslverr)
         $display("[%0t] SCBD error detected so can't read or write data",$time);
      else begin
      if(tra_h.pwrite)begin
         mem[tra_h.paddr]=tra_h.pwdata;
         $display("SCBD [WRITE] paddr=%0d, pwdata=%0d stored",tra_h.paddr,tra_h.pwdata);
         pass_count++;
      end
      else begin
         if(mem[tra_h.paddr]==tra_h.prdata)begin
            $display("SCBD [READ] PASS exp=%0d, act=%0d ",mem[tra_h.paddr],tra_h.prdata);
            pass_count++;
         end
         else begin
            $display("SCBD [READ] FAIL exp=%0d, act=%0d",mem[tra_h.paddr],tra_h.prdata);
            fail_count++;
         end
      end
   end
   endtask:check

   task sb_report();
      $display("=== Scoreboard Report ===");
      $display("Total=%0d, Pass=%0d, Fail=%0d",total_count,pass_count,fail_count);
      if(fail_count==0 && pass_count==1)
         $display("RESULT: PASSED");
      else if(fail_count==0 && pass_count==0)
         $display("RESULT: PASSED FOR ERROR TEST");
      else
         $display("RESULT: FAILED with %0d mismatches",fail_count);
   endtask:sb_report
         
endclass:apb_score_board
`endif
