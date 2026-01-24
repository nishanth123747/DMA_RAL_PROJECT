

`include "dma_interface.sv"
`include "dma_pkg.sv"
 `include "dma_design.sv"
import uvm_pkg::*;
import dma_pkg::*;
 
module tb;
 
  bit clk;
  bit rst_n;
 
  initial clk = 0;
  always #5 clk = ~clk;
 
  dma_reg_if vif(clk, rst_n);
 
  dma_design DUT(.clk(vif.clk), .rst_n(vif.rst_n), .addr(vif.addr), .wr_en(vif.wr_en), .rd_en(vif.rd_en), .wdata(vif.wdata), .rdata(vif.rdata));
 
  initial begin
    uvm_config_db#(virtual dma_reg_if)::set(null, "*", "vif", vif);
 
    rst_n = 0;
    #20;
    rst_n = 1;
  end
 
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
 
  initial begin
   run_test("dma_regression_test");
   // run_test("dma_mem_addr_test");
  //  run_test("dma_io_addr_test");
   //  run_test("dma_ctrl_test");
    // run_test("dma_intr_test");
    // run_test("dma_extra_info_test");
    //run_test("dma_status_test");
   // run_test("dma_transfer_count_test");
   // run_test("dma_descriptor_addr_test");
   // run_test("dma_configure_test");
    // run_test("dma_error_status_test");
  end
 
endmodule
