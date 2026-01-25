`include "defines.sv"
class dma_reset_seq extends uvm_sequence;
  `uvm_object_utils(dma_reset_seq)

  dma_reg_block regbk;

  function new(string name="dma_reset_seq");
    super.new(name);
  endfunction

  task body();
    uvm_status_e status;

    `uvm_info(get_type_name(),
      "<------------ RESET SEQUENCE STARTED ----------->",
      UVM_MEDIUM)

    // Apply RAL mirror reset
    regbk.reset();

    //----------------------------------
    // INTR
    //----------------------------------
    regbk.intr.mirror(status, UVM_CHECK);
    `uvm_info(get_type_name(),
      $sformatf("INTR reset value = 0x%08h",
        regbk.intr.get_mirrored_value()),
      UVM_MEDIUM)

    //----------------------------------
    // CTRL
    //----------------------------------
    regbk.ctrl.mirror(status, UVM_CHECK);
    `uvm_info(get_type_name(),
      $sformatf("CTRL reset value = 0x%08h",
        regbk.ctrl.get_mirrored_value()),
      UVM_MEDIUM)

    //----------------------------------
    // IO_ADDR
    //----------------------------------
    regbk.io_addr.mirror(status, UVM_CHECK);
    `uvm_info(get_type_name(),
      $sformatf("IO_ADDR reset value = 0x%08h",
        regbk.io_addr.get_mirrored_value()),
      UVM_MEDIUM)

    //----------------------------------
    // MEM_ADDR
    //----------------------------------
    regbk.mem_addr.mirror(status, UVM_CHECK);
    `uvm_info(get_type_name(),
      $sformatf("MEM_ADDR reset value = 0x%08h",
        regbk.mem_addr.get_mirrored_value()),
      UVM_MEDIUM)

    //----------------------------------
    // EXTRA_INFO
    //----------------------------------
    regbk.extra_info.mirror(status, UVM_CHECK);
    `uvm_info(get_type_name(),
      $sformatf("EXTRA_INFO reset value = 0x%08h",
        regbk.extra_info.get_mirrored_value()),
      UVM_MEDIUM)

    //----------------------------------
    // STATUS
    //----------------------------------
    regbk.status.mirror(status, UVM_CHECK);
    `uvm_info(get_type_name(),
      $sformatf("STATUS reset value = 0x%08h",
        regbk.status.get_mirrored_value()),
      UVM_MEDIUM)

    //----------------------------------
    // TRANSFER_COUNT
    //----------------------------------
    regbk.transfer_count.mirror(status, UVM_CHECK);
    `uvm_info(get_type_name(),
      $sformatf("TRANSFER_COUNT reset value = 0x%08h",
        regbk.transfer_count.get_mirrored_value()),
      UVM_MEDIUM)

    //----------------------------------
    // DESCRIPTOR_ADDR
    //----------------------------------
    regbk.descriptor_addr.mirror(status, UVM_CHECK);
    `uvm_info(get_type_name(),
      $sformatf("DESCRIPTOR_ADDR reset value = 0x%08h",
        regbk.descriptor_addr.get_mirrored_value()),
      UVM_MEDIUM)

    //----------------------------------
    // CONFIG
    //----------------------------------
    regbk.conf.mirror(status, UVM_CHECK);
    `uvm_info(get_type_name(),
      $sformatf("CONFIG reset value = 0x%08h",
        regbk.conf.get_mirrored_value()),
      UVM_MEDIUM)

    //----------------------------------
    // ERROR_STATUS
    //----------------------------------
    regbk.error_status.mirror(status, UVM_CHECK);
    `uvm_info(get_type_name(),
      $sformatf("ERROR_STATUS reset value = 0x%08h",
        regbk.error_status.get_mirrored_value()),
      UVM_MEDIUM)

    `uvm_info(get_type_name(),
      "<------------ RESET SEQUENCE ENDED ----------->",
      UVM_MEDIUM)

  endtask
endclass



//-----------------------------------------
//MEM_ADDR
//--------------------------------------------------
class mem_addr_seq extends uvm_sequence;
  `uvm_object_utils(mem_addr_seq)

  dma_reg_block regmodel;

  function new(string name="mem_addr_seq");
    super.new(name);
  endfunction

  task body();
      uvm_status_e   status;
   uvm_reg_data_t des,mir, wdata, rdata;

    repeat (`SIZE) begin
      wdata = $urandom_range(0, 32'hFFFF_FFFF);

    // WRITE
      regmodel.mem_addr.write(status,wdata);
    des = regmodel.mem_addr.get();
    mir = regmodel.mem_addr.get_mirrored_value();

    `uvm_info(get_type_name(),
      $sformatf("MEM_ADDR WRITE: DES=0x%08h MIR=0x%08h", des, mir),
      UVM_NONE)

    // READ
    regmodel.mem_addr.read(status, rdata);
    des = regmodel.mem_addr.get();
    mir = regmodel.mem_addr.get_mirrored_value();

    `uvm_info(get_type_name(),
      $sformatf("MEM_ADDR READ : DES=0x%08h MIR=0x%08h RDATA=0x%08h",
                des, mir, rdata),
      UVM_NONE)

    regmodel.mem_addr.mirror(status, UVM_CHECK);
    end
  endtask
endclass


//----------------------------------------------------------
// CTRL
//-------------------------------------------------------------

class ctrl_reg_seq extends uvm_sequence;
  `uvm_object_utils(ctrl_reg_seq)

  dma_reg_block regmodel;

  function new(string name="ctrl_reg_seq");
    super.new(name);
  endfunction

  task body();
    uvm_status_e   status;
    uvm_reg_data_t des, mir;
    uvm_reg_data_t wdata, rdata;

    repeat (`SIZE) begin
      wdata = $urandom_range(0, 32'hFFFF_FFFF);

      // WRITE 
      regmodel.ctrl.write(status, wdata);

      des = regmodel.ctrl.get();
      mir = regmodel.ctrl.get_mirrored_value();

      `uvm_info(get_type_name(),
        $sformatf("CTRL WRITE: DES=0x%08h MIR=0x%08h",
                  des, mir),
        UVM_LOW)

      // READ
      regmodel.ctrl.read(status, rdata);

      des = regmodel.ctrl.get();
      mir = regmodel.ctrl.get_mirrored_value();

      `uvm_info(get_type_name(),
        $sformatf("CTRL READ : DES=0x%08h MIR=0x%08h RDATA=0x%08h",
                  des, mir, rdata),
        UVM_LOW)
      regmodel.ctrl.mirror(status, UVM_CHECK);

    end
  endtask
endclass



 //------------------------------------------------------
 // INTR 
 //-------------------------------------------------------             

class intr_reg_seq extends uvm_sequence;
  `uvm_object_utils(intr_reg_seq)

  dma_reg_block regmodel;

  function new(string name="intr_reg_seq");
    super.new(name);
  endfunction

  task body();
    uvm_status_e status;
 uvm_reg_data_t des,mir, wdata, rdata;

    repeat (`SIZE) begin
      wdata = $urandom_range(0, 32'hFFFF_FFFF);

    // WRITE
      regmodel.intr.write(status, wdata);
    des = regmodel.intr.get();
    mir = regmodel.intr.get_mirrored_value();

    `uvm_info(get_type_name(),
      $sformatf("INTR WRITE: DES=0x%08h MIR=0x%08h", des, mir),
      UVM_NONE)

    // READ
    regmodel.intr.read(status, rdata);
    des = regmodel.intr.get();
    mir = regmodel.intr.get_mirrored_value();

    `uvm_info(get_type_name(),
      $sformatf("INTR READ : DES=0x%08h MIR=0x%08h RDATA=0x%08h",
                des, mir, rdata),
      UVM_NONE)

    regmodel.intr.mirror(status, UVM_CHECK);
    end
  endtask
endclass


//-----------------------------------------------------------------
//IO ADD
//-----------------------------------------------------
 class io_addr_seq extends uvm_sequence;
  `uvm_object_utils(io_addr_seq)

  dma_reg_block regmodel;

  function new(string name="io_addr_seq");
    super.new(name);
  endfunction

  task body();
    uvm_status_e status;
    uvm_reg_data_t des,mir, wdata, rdata;

    repeat (`SIZE) begin
      wdata = $urandom_range(0, 32'hFFFF_FFFF);

      regmodel.io_addr.write(status, wdata);
    des = regmodel.io_addr.get();
    mir = regmodel.io_addr.get_mirrored_value();

    `uvm_info(get_type_name(),
      $sformatf("IO_ADDR WRITE: DES=0x%08h MIR=0x%08h", des, mir),
      UVM_NONE)

    regmodel.io_addr.read(status, rdata);
    des = regmodel.io_addr.get();
    mir = regmodel.io_addr.get_mirrored_value();

    `uvm_info(get_type_name(),
      $sformatf("IO_ADDR READ : DES=0x%08h MIR=0x%08h RDATA=0x%08h",
                des, mir, rdata),
      UVM_NONE)

    regmodel.io_addr.mirror(status, UVM_CHECK);
    end
  endtask
endclass

///--------------------------------------------------
//EXRA_INFO
//-----------------------------------------------

class extra_info_seq extends uvm_sequence;
  `uvm_object_utils(extra_info_seq)

  dma_reg_block regmodel;

  function new(string name="extra_info_seq");
    super.new(name);
  endfunction

  task body();
    uvm_status_e status;
     uvm_reg_data_t des,mir, wdata, rdata;

    repeat (`SIZE) begin
      wdata = $urandom_range(0, 32'hFFFF_FFFF);
      // regmodel.extra_info.read(status, rdata);
    // regmodel.extra_info.poke(status, 32'h0000_ABCD);
      regmodel.extra_info.write(status, wdata);
    des = regmodel.extra_info.get();
    mir = regmodel.extra_info.get_mirrored_value();

    `uvm_info(get_type_name(),
      $sformatf("EXTRA_INFO WRITE: DES=0x%08h MIR=0x%08h", des, mir),
      UVM_NONE)

    regmodel.extra_info.read(status, rdata);
    des = regmodel.extra_info.get();
    mir = regmodel.extra_info.get_mirrored_value();

    `uvm_info(get_type_name(),
      $sformatf("EXTRA_INFO READ : DES=0x%08h MIR=0x%08h RDATA=0x%08h",
                des, mir, rdata),
      UVM_NONE)

    regmodel.extra_info.mirror(status, UVM_CHECK);
    end
  endtask
endclass

//-----------------------------------------
//STATUS
//-------------------------------------------------
  class status_reg_seq extends uvm_sequence;
  `uvm_object_utils(status_reg_seq)

  dma_reg_block regmodel;

  function new(string name="status_reg_seq");
    super.new(name);
  endfunction

  task body();
    uvm_status_e status;
     uvm_reg_data_t des,mir, wdata, rdata;

    repeat (`SIZE) begin
      wdata = $urandom_range(0, 32'hFFFF_FFFF);
   // regmodel.status.read(status, rdata);
    // regmodel.status.poke(status, 32'h0000_ABCD);
      regmodel.status.write(status, wdata);
    des = regmodel.status.get();
    mir = regmodel.status.get_mirrored_value();

    `uvm_info(get_type_name(),
      $sformatf("STATUS WRITE: DES=0x%08h MIR=0x%08h", des, mir),
      UVM_NONE)
    //regmodel.status.read(status, rdata,UVM_FRONTDOOR);
    regmodel.status.read(status, rdata);
    des = regmodel.status.get();
    mir = regmodel.status.get_mirrored_value();

    `uvm_info(get_type_name(),
      $sformatf("STATUS READ : DES=0x%08h MIR=0x%08h RDATA=0x%08h",
                des, mir, rdata),
      UVM_NONE)

    regmodel.status.mirror(status, UVM_CHECK);
    end
  endtask
endclass

//---------------------------------------------------
// TRANSFER COUNT
//--------------------------------------------------------------              
    
   class transfer_count_reg_seq extends uvm_sequence;
  `uvm_object_utils(transfer_count_reg_seq)

  dma_reg_block regmodel;

  function new(string name="transfer_count_reg_seq");
    super.new(name);
  endfunction

  task body();
    uvm_status_e status;
     uvm_reg_data_t des,mir, wdata, rdata;

    repeat (`SIZE) begin
      wdata = $urandom_range(0, 32'hFFFF_FFFF);
    // regmodel.transfer_count.read(status, rdata);
    // regmodel.transfer_count.poke(status, 32'h0000_ABCD);
      regmodel.transfer_count.write(status, wdata);
    des = regmodel.transfer_count.get();
    mir = regmodel.transfer_count.get_mirrored_value();

    `uvm_info(get_type_name(),
              $sformatf("TRANSFER_COUNT WRITE: DES=0x%08h MIR=0x%08h", des, mir),
      UVM_NONE)

    regmodel.transfer_count.read(status, rdata);
    des = regmodel.transfer_count.get();
    mir = regmodel.transfer_count.get_mirrored_value();

    `uvm_info(get_type_name(),
              $sformatf("TRANSFER COUNT READ : DES=0x%08h MIR=0x%08h RDATA=0x%08h",
                des, mir, rdata),
      UVM_NONE)

    regmodel.transfer_count.mirror(status, UVM_CHECK);
    end
  endtask
endclass

//------------------------------------------------------
// descriptor reg
//---------------------------------------------------
class descriptor_reg_seq extends uvm_sequence;
  `uvm_object_utils(descriptor_reg_seq)

  dma_reg_block regmodel;

  function new(string name="descriptor_reg_seq");
    super.new(name);
  endfunction

  task body();
    uvm_status_e   status;
   uvm_reg_data_t des,mir, wdata, rdata;

    repeat (`SIZE) begin
      wdata = $urandom_range(0, 32'hFFFF_FFFF);

    // WRITE
      regmodel.descriptor_addr.write(status, wdata);
    des = regmodel.descriptor_addr.get();
    mir = regmodel.descriptor_addr.get_mirrored_value();

    `uvm_info(get_type_name(),
      $sformatf("DESCRIPTOR_ADDR WRITE: DES=0x%08h MIR=0x%08h",
                des, mir),
      UVM_LOW)

    // READ
    regmodel.descriptor_addr.read(status, rdata);
    des = regmodel.descriptor_addr.get();
    mir = regmodel.descriptor_addr.get_mirrored_value();

    `uvm_info(get_type_name(),
      $sformatf("DESCRIPTOR_ADDR READ : DES=0x%08h MIR=0x%08h RDATA=0x%08h",
                des, mir, rdata),
      UVM_LOW)

    regmodel.descriptor_addr.mirror(status, UVM_CHECK);
    end
  endtask
endclass


    // ------------------------------------------------------------
    // CONFIG (RW)
// ------------------------------------------------------------

class config_reg_seq extends uvm_sequence;
  `uvm_object_utils(config_reg_seq)

  dma_reg_block regmodel;

  function new(string name="config_reg_seq");
    super.new(name);
  endfunction

  task body();
    uvm_status_e   status;
     uvm_reg_data_t des,mir, wdata, rdata;

    repeat (`SIZE) begin
      wdata = $urandom_range(0, 32'hFFFF_FFFF);

    // WRITE
      regmodel.conf.write(status, wdata);
    des = regmodel.conf.get();
    mir = regmodel.conf.get_mirrored_value();

    `uvm_info(get_type_name(),
      $sformatf("CONFIG WRITE: DES=0x%08h MIR=0x%08h",
                des, mir),
      UVM_LOW)

    // READ
    regmodel.conf.read(status, rdata);
    des = regmodel.conf.get();
    mir = regmodel.conf.get_mirrored_value();

    `uvm_info(get_type_name(),
      $sformatf("CONFIG READ : DES=0x%08h MIR=0x%08h RDATA=0x%08h",
                des, mir, rdata),
      UVM_LOW)

    regmodel.conf.mirror(status, UVM_CHECK);
    end
  endtask
endclass

//------------------------------------------
//ERROR STATUS
//-------------------------------------------------
  wdata = $urandom_range(0, 32'hFFFF_FFFF);
    //WRITE
    #10;
       regmodel.error_status.poke(status, wdata);
  // regmodel.error_status.write(status, 32'hFFFF_FFFF);
regmodel.error_status.bus_error.write(status,1'h1);           
regmodel.error_status.timeout_error.write(status,1'h1);
regmodel.error_status.alignment_error.write(status,1'h1);        
regmodel.error_status.overflow_error.write(status,1'h1);       
regmodel.error_status.underflow_error.write(status,1'h1);
    des = regmodel.error_status.get();
    mir = regmodel.error_status.get_mirrored_value();
    `uvm_info(get_type_name(),
              $sformatf("ERROR_STATUS WRITE: DES=0x%08h MIR=0x%08h",
                des, mir),
      UVM_LOW)



    // READ
    regmodel.error_status.read(status, rdata);
    des = regmodel.error_status.get();
    mir = regmodel.error_status.get_mirrored_value();

    `uvm_info(get_type_name(),
      $sformatf("ERROR_STATUS READ : DES=0x%08h MIR=0x%08h RDATA=0x%08h",
                des, mir, rdata),
      UVM_LOW)

    regmodel.error_status.mirror(status, UVM_CHECK);
    end
  endtask
endclass

class dma_corner_case_seq extends uvm_sequence;
  `uvm_object_utils(dma_corner_case_seq)

  dma_reg_block regmodel;

  function new(string name="dma_corner_case_seq");
    super.new(name);
  endfunction

  task body();
    uvm_status_e   status;
    uvm_reg_data_t des, mir, wdata, rdata;

    repeat (`SIZE) begin


      //-----------------------------------------
      //  Restart DMA
      //-----------------------------------------
      wdata = 32'h0000_0001;
      regmodel.ctrl.write(status, wdata);

      //-----------------------------------------
      // Read STATUS
      //-----------------------------------------
      regmodel.status.read(status, rdata);

      des = regmodel.status.get();
      mir = regmodel.status.get_mirrored_value();

      `uvm_info(get_type_name(),
        $sformatf("STATUS AFTER RESTART: DES=0x%08h MIR=0x%08h RDATA=0x%08h",
                  des, mir, rdata),
        UVM_LOW)

      regmodel.status.mirror(status, UVM_CHECK);

    end
  endtask
endclass



class dma_regression_seq extends uvm_sequence;
  `uvm_object_utils(dma_regression_seq)
  dma_reset_seq              reset_seq;
  mem_addr_seq               mem_seq;
  ctrl_reg_seq               ct_seq;
  intr_reg_seq               int_seq;
  io_addr_seq                io_seq;
  extra_info_seq             info_seq;
  status_reg_seq             stat_seq;
  transfer_count_reg_seq     trans_seq;
  descriptor_reg_seq         des_seq;
  config_reg_seq             con_seq;
  error_status_reg_seq       err_seq;
  dma_corner_case_seq        corner_seq;

  dma_reg_block regbk;

  function new(string name="dma_regression_seq");
    super.new(name);
  endfunction

  virtual task body();
    reset_seq= dma_reset_seq::type_id::create("reset_seq");
    mem_seq   = mem_addr_seq::type_id::create("mem_seq");
    ct_seq    = ctrl_reg_seq::type_id::create("ct_seq");
    int_seq   = intr_reg_seq::type_id::create("int_seq");
    io_seq    = io_addr_seq::type_id::create("io_seq");
    info_seq  = extra_info_seq::type_id::create("info_seq");
    stat_seq  = status_reg_seq::type_id::create("stat_seq");
    trans_seq = transfer_count_reg_seq::type_id::create("trans_seq");
    des_seq   = descriptor_reg_seq::type_id::create("des_seq");
    con_seq   = config_reg_seq::type_id::create("con_seq");
    err_seq   = error_status_reg_seq::type_id::create("err_seq");
    corner_seq= dma_corner_case_seq::type_id::create("corner_seq");   
    reset_seq.regbk = regbk;
    mem_seq.regmodel   = regbk;
    ct_seq.regmodel    = regbk;
    int_seq.regmodel   = regbk;
    io_seq.regmodel    = regbk;
    info_seq.regmodel  = regbk;
    stat_seq.regmodel  = regbk;
    trans_seq.regmodel = regbk;
    des_seq.regmodel   = regbk;
    con_seq.regmodel   = regbk;
    err_seq.regmodel   = regbk;
    corner_seq.regmodel = regbk;
    
    reset_seq.start(m_sequencer);
    mem_seq.start(m_sequencer);
    ct_seq.start(m_sequencer);
    int_seq.start(m_sequencer);
    io_seq.start(m_sequencer);
    info_seq.start(m_sequencer);
    stat_seq.start(m_sequencer);
    trans_seq.start(m_sequencer);
    des_seq.start(m_sequencer);
    con_seq.start(m_sequencer);
    err_seq.start(m_sequencer);
    corner_seq.start(m_sequencer);
  endtask
endclass
 
