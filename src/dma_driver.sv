class dma_driver extends uvm_driver #(dma_seq_item);
  `uvm_component_utils(dma_driver)

  virtual dma_reg_if.drv vif;
  dma_seq_item req;

  function new(string name = "dma_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual dma_reg_if)::get(this, "", "vif", vif))
      `uvm_fatal(get_type_name(), "vif not set");
  endfunction

task run_phase(uvm_phase phase);

  super.run_phase(phase);
  repeat(3) @(vif.drv_cb);

  forever begin
    seq_item_port.get_next_item(req);
    drive(req);
    seq_item_port.item_done();
  end
endtask


  task drive(dma_seq_item tx);


  vif.drv_cb.wr_en <= tx.wr_en;
  vif.drv_cb.rd_en <= tx.rd_en;
  vif.drv_cb.addr  <= tx.addr;
  vif.drv_cb.wdata <= tx.wdata;

  // `uvm_info(get_type_name(),
  //           $sformatf("DRIVING WRITE: wr=%0b rd=%0b addr=0x%08h wdata=0x%08h",
  //             tx.wr_en, tx.rd_en, tx.addr, tx.wdata),
  //   UVM_LOW)

  @(vif.drv_cb);

  if (tx.rd_en) begin
    repeat(2)@(posedge vif.clk)
    tx.rdata = vif.drv_cb.rdata;

    // `uvm_info(get_type_name(),
    //           $sformatf("DRIVER READ : wr=%0d,rd=%0d,addr=0x%08h rdata=0x%08h",tx.wr_en,tx.rd_en,
    //             tx.addr, tx.rdata),
    //   UVM_LOW)
  end
endtask


endclass
