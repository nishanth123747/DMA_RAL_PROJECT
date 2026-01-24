//----------------------------------------------------------------------
// Base Test
//----------------------------------------------------------------------
class dma_test extends uvm_test;
  `uvm_component_utils(dma_test)

  dma_env env;

  function new(string name="dma_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = dma_env::type_id::create("env", this);
  endfunction

  function void end_of_elaboration();
    uvm_top.print_topology();
  endfunction
endclass


//----------------------------------------------------------------------
// MEM_ADDR Test
//----------------------------------------------------------------------
class dma_mem_addr_test extends dma_test;
  mem_addr_seq mem_seq;
  `uvm_component_utils(dma_mem_addr_test)

  function new(string name="dma_mem_addr_test", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    mem_seq = mem_addr_seq::type_id::create("mem_seq");
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    mem_seq.regmodel = env.regmodel;
    mem_seq.start(env.dma_agnt.sqr);
    phase.drop_objection(this);
  endtask
endclass


//----------------------------------------------------------------------
// CTRL Test
//----------------------------------------------------------------------
class dma_ctrl_test extends dma_test;
  ctrl_reg_seq ct_seq;
  `uvm_component_utils(dma_ctrl_test)

  function new(string name="dma_ctrl_test", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ct_seq = ctrl_reg_seq::type_id::create("ct_seq");
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    ct_seq.regmodel = env.regmodel;
    ct_seq.start(env.dma_agnt.sqr);
    phase.drop_objection(this);
  endtask
endclass


//----------------------------------------------------------------------
// INTR Test
//----------------------------------------------------------------------
class dma_intr_test extends dma_test;
  intr_reg_seq int_seq;
  `uvm_component_utils(dma_intr_test)

  function new(string name="dma_intr_test", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    int_seq = intr_reg_seq::type_id::create("int_seq");
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    int_seq.regmodel = env.regmodel;
    int_seq.start(env.dma_agnt.sqr);
    phase.drop_objection(this);
  endtask
endclass


//----------------------------------------------------------------------
// IO_ADDR Test
//----------------------------------------------------------------------
class dma_io_addr_test extends dma_test;
  io_addr_seq io_seq;
  `uvm_component_utils(dma_io_addr_test)

  function new(string name="dma_io_addr_test", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    io_seq = io_addr_seq::type_id::create("io_seq");
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    io_seq.regmodel = env.regmodel;
    io_seq.start(env.dma_agnt.sqr);
    phase.drop_objection(this);
  endtask
endclass


//----------------------------------------------------------------------
// EXTRA_INFO Test
//----------------------------------------------------------------------
class dma_extra_info_test extends dma_test;
  extra_info_seq info_seq;
  `uvm_component_utils(dma_extra_info_test)

  function new(string name="dma_extra_info_test", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    info_seq = extra_info_seq::type_id::create("info_seq");
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    info_seq.regmodel = env.regmodel;
    info_seq.start(env.dma_agnt.sqr);
    phase.drop_objection(this);
  endtask
endclass


//----------------------------------------------------------------------
// STATUS Test
//----------------------------------------------------------------------
class dma_status_test extends dma_test;
  status_reg_seq stat_seq;
  `uvm_component_utils(dma_status_test)

  function new(string name="dma_status_test", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    stat_seq = status_reg_seq::type_id::create("stat_seq");
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    stat_seq.regmodel = env.regmodel;
    stat_seq.start(env.dma_agnt.sqr);
    phase.drop_objection(this);
  endtask
endclass


//----------------------------------------------------------------------
// TRANSFER_COUNT Test
//----------------------------------------------------------------------
class dma_transfer_count_test extends dma_test;
  transfer_count_reg_seq trans_seq;
  `uvm_component_utils(dma_transfer_count_test)

  function new(string name="dma_transfer_count_test", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    trans_seq = transfer_count_reg_seq::type_id::create("trans_seq");
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    trans_seq.regmodel = env.regmodel;
    trans_seq.start(env.dma_agnt.sqr);
    phase.drop_objection(this);
  endtask
endclass


//----------------------------------------------------------------------
// DESCRIPTOR_ADDR Test
//----------------------------------------------------------------------
class dma_descriptor_addr_test extends dma_test;
  descriptor_reg_seq des_seq;
  `uvm_component_utils(dma_descriptor_addr_test)

  function new(string name="dma_descriptor_addr_test", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    des_seq = descriptor_reg_seq::type_id::create("des_seq");
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    des_seq.regmodel = env.regmodel;
    des_seq.start(env.dma_agnt.sqr);
    phase.drop_objection(this);
  endtask
endclass


//----------------------------------------------------------------------
// CONFIG Test
//----------------------------------------------------------------------
class dma_configure_test extends dma_test;
  config_reg_seq con_seq;
  `uvm_component_utils(dma_configure_test)

  function new(string name="dma_configure_test", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    con_seq = config_reg_seq::type_id::create("con_seq");
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    con_seq.regmodel = env.regmodel;
    con_seq.start(env.dma_agnt.sqr);
    phase.drop_objection(this);
  endtask
endclass


//----------------------------------------------------------------------
// ERROR_STATUS Test
//----------------------------------------------------------------------
class dma_error_status_test extends dma_test;
  error_status_reg_seq err_seq;
  `uvm_component_utils(dma_error_status_test)

  function new(string name="dma_error_status_test", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    err_seq = error_status_reg_seq::type_id::create("err_seq");
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    err_seq.regmodel = env.regmodel;
    err_seq.start(env.dma_agnt.sqr);
    phase.drop_objection(this);
  endtask
endclass


//----------------------------------------------------------------------
// REGRESSION Test
//----------------------------------------------------------------------
class dma_regression_test extends dma_test;
  dma_regression_seq reg_seq;
  `uvm_component_utils(dma_regression_test)

  function new(string name="dma_regression_test", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    reg_seq = dma_regression_seq::type_id::create("reg_seq");
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    reg_seq.regbk = env.regmodel;

    reg_seq.start(env.dma_agnt.sqr);
    phase.drop_objection(this);
  endtask
endclass
