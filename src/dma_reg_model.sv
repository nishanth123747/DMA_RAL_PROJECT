
class intr_reg extends uvm_reg;
  `uvm_object_utils(intr_reg)

  uvm_reg_field intr_status;  
  uvm_reg_field intr_mask;

covergroup intr_cov;
  option.per_instance = 1;

  coverpoint intr_status.value[0] {
    bins not_done = {0};
    bins done     = {1};
  }

  coverpoint intr_mask.value {
    bins disabled = {16'h0000};
    bins enabled  = {[16'h0001 : 16'hFFFF]};
  }

endgroup


  function new(string name="intr_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);

    if (has_coverage(UVM_CVR_FIELD_VALS))
      intr_cov = new();
  endfunction

  function void build();
    intr_status = uvm_reg_field::type_id::create("intr_status");
    intr_status.configure(this, 16, 0, "RO", 0, 0, 1, 0, 0);

    intr_mask = uvm_reg_field::type_id::create("intr_mask");
    intr_mask.configure(this, 16, 16, "RW", 0, 0, 1, 1, 0);
  endfunction

  virtual function void sample(uvm_reg_data_t data,
                               uvm_reg_data_t byte_en,
                               bit is_read,
                               uvm_reg_map map);
      intr_cov.sample();
  endfunction

  virtual function void sample_values();
    super.sample_values();
      intr_cov.sample();
  endfunction

endclass

//=============================================================

class ctrl_reg extends uvm_reg;
  `uvm_object_utils(ctrl_reg)

  uvm_reg_field start_dma;   // [0]
  uvm_reg_field w_count;     // [15:1]
  uvm_reg_field io_mem;     
  uvm_reg_field reserved;    

  function new(string name="ctrl_reg");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction

  function void build();
    start_dma = uvm_reg_field::type_id::create("start_dma");
    start_dma.configure(this, 1, 0, "RW", 0, 0, 1, 1, 0);

    w_count = uvm_reg_field::type_id::create("w_count");
    w_count.configure(this, 15, 1, "RW", 0, 0, 1, 1, 0);

    io_mem = uvm_reg_field::type_id::create("io_mem");
    io_mem.configure(this, 1, 16, "RW", 0, 0, 1, 1, 0);

    reserved = uvm_reg_field::type_id::create("reserved");
    reserved.configure(this, 15, 17, "RO", 0, 0, 1, 0, 0);
  endfunction
endclass


class io_addr_reg extends uvm_reg;
  `uvm_object_utils(io_addr_reg)

  uvm_reg_field io_addr;

  function new(string name="io_addr_reg");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction

  function void build();
    io_addr = uvm_reg_field::type_id::create("io_addr");
    io_addr.configure(this, 32, 0, "RW", 0, 0, 1, 1, 0);
  endfunction
endclass

class mem_addr_reg extends uvm_reg;
  `uvm_object_utils(mem_addr_reg)

  uvm_reg_field mem_addr;

  function new(string name="mem_addr_reg");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction

  function void build();
    mem_addr = uvm_reg_field::type_id::create("mem_addr");
    mem_addr.configure(this, 32, 0, "RW", 0, 0, 1, 1, 0);
  endfunction
endclass


class extra_info_reg extends uvm_reg;
  `uvm_object_utils(extra_info_reg)

  uvm_reg_field extra_info;

  function new(string name="extra_info_reg");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction

  function void build();
    extra_info = uvm_reg_field::type_id::create("extra_info");
    extra_info.configure(this, 32, 0, "RW", 0, 0, 1, 1, 0);
  endfunction
endclass


class status_reg extends uvm_reg;
  `uvm_object_utils(status_reg)

  uvm_reg_field busy;
  uvm_reg_field done;
  uvm_reg_field error;
  uvm_reg_field paused;
  uvm_reg_field current_state;
  uvm_reg_field fifo_level;
  uvm_reg_field reserved;

  function new(string name="status_reg");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction

  function void build();
    busy = uvm_reg_field::type_id::create("busy");
    busy.configure(this, 1, 0, "RO", 0, 0, 1, 0, 0);

    done = uvm_reg_field::type_id::create("done");
    done.configure(this, 1, 1, "RO", 0, 0, 1, 0, 0);

    error = uvm_reg_field::type_id::create("error");
    error.configure(this, 1, 2, "RO", 0, 0, 1, 0, 0);

    paused = uvm_reg_field::type_id::create("paused");
    paused.configure(this, 1, 3, "RO", 0, 0, 1, 0, 0);

    current_state = uvm_reg_field::type_id::create("current_state");
    current_state.configure(this, 4, 4, "RO", 0, 0, 1, 0, 0);

    fifo_level = uvm_reg_field::type_id::create("fifo_level");
    fifo_level.configure(this, 8, 8, "RO", 0, 0, 1, 0, 0);

    reserved = uvm_reg_field::type_id::create("reserved");
    reserved.configure(this, 16, 16, "RO", 0, 0, 1, 0, 0);
  endfunction
endclass


class transfer_count_reg extends uvm_reg;
  `uvm_object_utils(transfer_count_reg)

  uvm_reg_field transfer_count;

  function new(string name="transfer_count_reg");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction

  function void build();
    transfer_count = uvm_reg_field::type_id::create("transfer_count");
    transfer_count.configure(this, 32, 0, "RO", 0, 0, 1, 0, 0);
  endfunction
endclass


class descriptor_addr_reg extends uvm_reg;
  `uvm_object_utils(descriptor_addr_reg)

  uvm_reg_field descriptor_addr;

  function new(string name="descriptor_addr_reg");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction

  function void build();
    descriptor_addr = uvm_reg_field::type_id::create("descriptor_addr");
    descriptor_addr.configure(this, 32, 0, "RW", 0, 0, 1, 1, 0);
  endfunction
endclass



class error_status_reg extends uvm_reg;
  `uvm_object_utils(error_status_reg)

  uvm_reg_field bus_error;
  uvm_reg_field timeout_error;
  uvm_reg_field alignment_error;
  uvm_reg_field overflow_error;
  uvm_reg_field underflow_error;
  uvm_reg_field reserved;
  uvm_reg_field error_code;
  uvm_reg_field error_addr_offset;

  function new(string name="error_status_reg");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction

  function void build();
    bus_error = uvm_reg_field::type_id::create("bus_error");
    bus_error.configure(this, 1, 0, "W1C", 1, 0, 1, 1, 0);//volatile

    timeout_error = uvm_reg_field::type_id::create("timeout_error");
    timeout_error.configure(this, 1, 1, "W1C", 0, 0, 1, 1, 0);

    alignment_error = uvm_reg_field::type_id::create("alignment_error");
    alignment_error.configure(this, 1, 2, "W1C", 0, 0, 1, 1, 0);

    overflow_error = uvm_reg_field::type_id::create("overflow_error");
    overflow_error.configure(this, 1, 3, "W1C", 0, 0, 1, 1, 0);

    underflow_error = uvm_reg_field::type_id::create("underflow_error");
    underflow_error.configure(this, 1, 4, "W1C", 0, 0, 1, 1, 0);

    reserved = uvm_reg_field::type_id::create("reserved");
    reserved.configure(this, 3, 5, "RO", 0, 0, 1, 0, 0);

    error_code = uvm_reg_field::type_id::create("error_code");
    error_code.configure(this, 8, 8, "RO", 0, 0, 1, 0, 0);

    error_addr_offset = uvm_reg_field::type_id::create("error_addr_offset");
    error_addr_offset.configure(this, 16, 16, "RO", 0, 0, 1, 0, 0);
  endfunction
endclass



class config_reg extends uvm_reg;
  `uvm_object_utils(config_reg)

  uvm_reg_field priority_f;         
  uvm_reg_field auto_restart;
  uvm_reg_field interrupt_enable;
  uvm_reg_field burst_size;
  uvm_reg_field data_width;
  uvm_reg_field descriptor_mode;
  uvm_reg_field reserved;

  function new(string name="config_reg");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction

  function void build();
    priority_f = uvm_reg_field::type_id::create("priority");
    priority_f.configure(this, 2, 0, "RW", 0, 0, 1, 1, 0);

    auto_restart = uvm_reg_field::type_id::create("auto_restart");
    auto_restart.configure(this, 1, 2, "RW", 0, 0, 1, 1, 0);

    interrupt_enable = uvm_reg_field::type_id::create("interrupt_enable");
    interrupt_enable.configure(this, 1, 3, "RW", 0, 0, 1, 1, 0);

    burst_size = uvm_reg_field::type_id::create("burst_size");
    burst_size.configure(this, 2, 4, "RW", 0, 0, 1, 1, 0);

    data_width = uvm_reg_field::type_id::create("data_width");
    data_width.configure(this, 2, 6, "RW", 0, 0, 1, 1, 0);

    descriptor_mode = uvm_reg_field::type_id::create("descriptor_mode");
    descriptor_mode.configure(this, 1, 8, "RW", 0, 0, 1, 1, 0);

    reserved = uvm_reg_field::type_id::create("reserved");
    reserved.configure(this, 23, 9, "RO", 0, 0, 1, 0, 0);
  endfunction
endclass

