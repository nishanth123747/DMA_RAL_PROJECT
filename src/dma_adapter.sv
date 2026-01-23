class dma_adapter extends uvm_reg_adapter;
  `uvm_object_utils(dma_adapter)

  function new(string name="dma_adapter");
    super.new(name);
  endfunction

  function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
    dma_seq_item tx = dma_seq_item::type_id::create("tx");
    tx.addr  = rw.addr;
    tx.wdata = rw.data;
    tx.wr_en = (rw.kind == UVM_WRITE);
    tx.rd_en = (rw.kind == UVM_READ);
    return tx;
  endfunction

  function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
    dma_seq_item tx;
    assert($cast(tx, bus_item))
    else $error("[adp] Casting error");
    if(tx.wr_en)begin
      rw.kind = UVM_WRITE;
    rw.data = tx.wdata;
    end
    else
     begin 
    rw.data   = tx.rdata;
    rw.kind   = UVM_READ;
     end
    rw.addr = tx.addr;
    rw.status = UVM_IS_OK;
  endfunction
endclass

