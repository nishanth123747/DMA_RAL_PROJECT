interface dma_reg_if (
  input logic clk,
  input logic rst_n
);

  bit        wr_en;
  bit        rd_en;
  bit [31:0] addr;
  bit [31:0] wdata;
  logic [31:0] rdata;

 clocking drv_cb @(posedge clk);
  default input #0 output #0;
  output wr_en, rd_en, addr, wdata;
  input  rdata;
endclocking

clocking mon_cb @(posedge clk);
  default input #0 output #0;
  input wr_en, rd_en, addr, wdata, rdata;
endclocking

modport drv (clocking drv_cb, input clk, rst_n);
modport mon (clocking mon_cb, input clk, rst_n);


endinterface
