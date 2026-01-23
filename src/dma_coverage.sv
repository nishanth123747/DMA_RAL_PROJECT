class dma_coverage extends uvm_subscriber #(dma_seq_item);
  `uvm_component_utils(dma_coverage)

  dma_seq_item tr;

  typedef enum bit {READ = 0, WRITE = 1} acc_e;
  acc_e acc;

  real input_cov;
  real output_cov;

  // ---------------- INPUT COVERAGE ---------------- //
  covergroup dma_input_cg;

    // Address coverage
    addr_cp : coverpoint tr.addr {
      bins INTR       = {32'h400};
      bins CTRL       = {32'h404};
      bins IO_ADDR    = {32'h408};
      bins MEM_ADDR   = {32'h40C};
      bins EXTRA_INFO = {32'h410};
      bins STATUS     = {32'h414};
      bins COUNT      = {32'h418};
    }

    // Access type
    access_cp : coverpoint acc {
      bins READ  = {READ};
      bins WRITE = {WRITE};
    }

    // Write data 
    wdata_cp : coverpoint tr.wdata iff (acc == WRITE) {
      bins ZERO = {32'h0};
      bins NON_ZERO = {[1 : 32'hFFFF_FFFF]};
    }
    addr_x_access : cross addr_cp, access_cp;

  endgroup


  // ---------------- OUTPUT COVERAGE ---------------- //
  covergroup dma_output_cg;

    // Read data coverage
    rdata_cp : coverpoint tr.rdata iff (acc == READ) {
      bins ZERO = {32'h0};
      bins NON_ZERO = {[1 : 32'hFFFF_FFFF]};
    }

  endgroup


  function new(string name = "dma_coverage", uvm_component parent);
    super.new(name, parent);
    dma_input_cg  = new();
    dma_output_cg = new();
  endfunction

  function void write(dma_seq_item t);
    tr  = t;
    acc = (t.wr_en) ? WRITE : READ;

    dma_input_cg.sample();
    dma_output_cg.sample();
  endfunction


  // ---------------- EXTRACT PHASE ---------------- //
  function void extract_phase(uvm_phase phase);
    super.extract_phase(phase);
    input_cov  = dma_input_cg.get_coverage();
    output_cov = dma_output_cg.get_coverage();
  endfunction


  // ---------------- REPORT PHASE ---------------- //
  function void report_phase(uvm_phase phase);
    super.report_phase(phase);

    `uvm_info(get_type_name(),
      $sformatf("DMA INPUT  COVERAGE = %0.2f%%", input_cov),
      UVM_MEDIUM)

    `uvm_info(get_type_name(),
      $sformatf("DMA OUTPUT COVERAGE = %0.2f%%", output_cov),
      UVM_MEDIUM)
  endfunction

endclass

