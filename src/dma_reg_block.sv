class dma_reg_block extends uvm_reg_block;
  `uvm_object_utils(dma_reg_block)

  intr_reg            intr;
  ctrl_reg            ctrl;
  io_addr_reg         io_addr;
  mem_addr_reg        mem_addr;
  extra_info_reg      extra_info;
  status_reg          status;
  transfer_count_reg  transfer_count;
  descriptor_addr_reg descriptor_addr;
  error_status_reg    error_status;
  config_reg          conf;

  function new(string name = "dma_reg_block");
    super.new(name, UVM_NO_COVERAGE);
  endfunction

 
  function void build();
    //coverage
    uvm_reg::include_coverage("*", UVM_CVR_ALL);
    //backdoor
    add_hdl_path("DUT","RTL");
    
    intr  = intr_reg  ::type_id::create("intr");
    ctrl = ctrl_reg ::type_id::create("ctrl");
    io_addr  = io_addr_reg::type_id::create("io_addr");
    mem_addr =  mem_addr_reg ::type_id::create("mem_addr");
    extra_info = extra_info_reg  ::type_id::create("extra_info");
    status  = status_reg  ::type_id::create("status");
    transfer_count  = transfer_count_reg ::type_id::create("transfer_count");
    descriptor_addr = descriptor_addr_reg::type_id::create("descriptor_addr");
    error_status = error_status_reg ::type_id::create("error_status");
    conf = config_reg ::type_id::create("conf");

  
    intr.build();
    ctrl.build();
    io_addr.build();
    mem_addr.build();
    extra_info.build();
    status.build();
    transfer_count.build();
    descriptor_addr.build();
    error_status.build();
    conf.build();

 
    intr.configure(this);
    ctrl.configure(this);
    io_addr.configure(this);
    mem_addr.configure(this);
    extra_info.configure(this);
    status.configure(this);
    transfer_count.configure(this);
    descriptor_addr.configure(this);
    error_status.configure(this);
    conf.configure(this);
    
  //coverage  
//  intr.set_coverage(UVM_CVR_FIELD_VALS);
//  ctrl.set_coverage(UVM_CVR_FIELD_VALS);
//  io_addr.set_coverage(UVM_CVR_FIELD_VALS); 
//  mem_addr.set_coverage(UVM_CVR_FIELD_VALS);
//  extra_info.set_coverage(UVM_CVR_FIELD_VALS);
//   status.set_coverage(UVM_CVR_FIELD_VALS);
//    transfter_count.set_coverage(UVM_CVR_FIELD_VALS);
//     descriptor_addr.set_coverage(UVM_CVR_FIELD_VALS);
//    error_status.set_coverage(UVM_CVR_FIELD_VALS);
//     conf.set_coverage(UVM_CVR_FIELD_VALS);
    
intr.add_hdl_path_slice("intr_status", 0, 16);   
intr.add_hdl_path_slice("intr_mask",  16, 16); 
    
ctrl.add_hdl_path_slice("ctrl_start_dma", 0, 1);
ctrl.add_hdl_path_slice("ctrl_w_count",   1, 15);
ctrl.add_hdl_path_slice("ctrl_io_mem",   16, 1);
   
io_addr.add_hdl_path_slice("io_addr", 0, 32);
mem_addr.add_hdl_path_slice("mem_addr", 0, 32);
extra_info.add_hdl_path_slice("extra_info", 0, 32);
status.add_hdl_path_slice("status", 0, 32);
transfer_count.add_hdl_path_slice("transfer_count", 0, 32);
descriptor_addr.add_hdl_path_slice("descriptor_addr", 0, 32);
error_status.add_hdl_path_slice("error_status", 0, 32);
conf.add_hdl_path_slice("conf", 0, 32);

    default_map = create_map(
      "default_map",
      'h400,                
      4,                   
      UVM_LITTLE_ENDIAN
    );

    default_map.add_reg(intr, 'h00, "RW");
    default_map.add_reg(ctrl, 'h04, "RW");
    default_map.add_reg(io_addr,'h08, "RW");
    default_map.add_reg(mem_addr,'h0C, "RW");
    default_map.add_reg(extra_info, 'h10, "RW");
    default_map.add_reg(status, 'h14, "RO");
    default_map.add_reg(transfer_count,'h18, "RW");
    default_map.add_reg(descriptor_addr,'h1C, "RW");
    default_map.add_reg(error_status,'h20, "W1C");
    default_map.add_reg(conf,'h24, "RW");


    lock_model();

  endfunction

endclass
