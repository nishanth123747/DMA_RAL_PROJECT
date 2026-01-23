class dma_reg_seq extends uvm_sequence;
  `uvm_object_utils(dma_reg_seq)

  dma_reg_block regmodel;

  function new(string name = "dma_reg_seq");
    super.new(name);
  endfunction

  task body();
    uvm_status_e   status;
    uvm_reg_data_t des;
    uvm_reg_data_t mir;
    uvm_reg_data_t read_d;

//     if (starting_phase != null)
//       starting_phase.raise_objection(this);
//     des = regmodel.mem_addr.get();
//     mir = regmodel.mem_addr.get_mirrored_value();

//     `uvm_info(get_type_name(),
//               $sformatf("BEFORE MEM_ADDR WRITE: DES=0x%08h MIR=0x%08h",
//                 des, mir),
//       UVM_NONE)

//     // ---------------------
//     // WRITE
//     // ---------------------
//     regmodel.mem_addr.write(status, 32'h1234_5678);
//     des = regmodel.mem_addr.get();
//      `uvm_info(get_type_name(),
//                $sformatf("AFTER MEM_ADDR WRITE(get): DES=0x%08h MIR=0x%08h",
//                 des, mir),
//       UVM_NONE)
//     mir = regmodel.mem_addr.get_mirrored_value();

//     `uvm_info(get_type_name(),
//               $sformatf("AFTER MEM_ADDR WRITE(get_mirror_value): DES=0x%08h MIR=0x%08h",
//                 des, mir),
//       UVM_NONE)

//    //regmodel.mem_addr.mirror(status, UVM_CHECK);

//     // ---------------------
//     // READ
//     // ---------------------
//     regmodel.mem_addr.read(status, read_d);

//     des = regmodel.mem_addr.get();
//     mir = regmodel.mem_addr.get_mirrored_value();

//     `uvm_info(get_type_name(),
//       $sformatf("MEM_ADDR READ : DES=0x%08h MIR=0x%08h RDATA=0x%08h",
//                 des, mir, read_d),
//       UVM_NONE) 
//     regmodel.mem_addr.mirror(status, UVM_CHECK);
    
    
//     if(read_d == 32'h1234_5678)
//       $display("pass");
//     else
//       $display("fail");
    
   

//     // ---------------------
//     // WRITE
//     // ---------------------
//     regmodel.ctrl.write(status, 32'h0000_000B);
//     des = regmodel.ctrl.get();
//      `uvm_info(get_type_name(),
//                $sformatf("AFTER CTRL WRITE(get): DES=0x%08h MIR=0x%08h",
//                 des, mir),
//       UVM_NONE)
//     mir = regmodel.ctrl.get_mirrored_value();

//     `uvm_info(get_type_name(),
//               $sformatf("AFTER CTRL WRITE(get_mirror_value): DES=0x%08h MIR=0x%08h",
//                 des, mir),
//       UVM_NONE)

//     regmodel.ctrl.mirror(status, UVM_CHECK);

//     // ---------------------
//     // READ
//     // ---------------------
//     regmodel.ctrl.read(status, read_d);

//     des = regmodel.ctrl.get();
//     mir = regmodel.ctrl.get_mirrored_value();

//     `uvm_info(get_type_name(),
//       $sformatf("MEM_ADDR READ : DES=0x%08h MIR=0x%08h RDATA=0x%08h",
//                 des, mir, read_d),
//       UVM_NONE)

//     // Final mirror check
//     regmodel.ctrl.mirror(status, UVM_CHECK);
    
// ---------------------
// BACKDOOR WRITE
// ---------------------
  //  regmodel.mem_addr.read(status,read_d,UVM_BACKDOOR);
   #8;
    regmodel.mem_addr.poke(status,32'hAABB_CCDD);
  //  regmodel.mem_addr.write(status,32'hAAAA_AAAA,UVM_BACKDOOR);

des = regmodel.mem_addr.get();
mir = regmodel.mem_addr.get_mirrored_value();

`uvm_info(get_type_name(),
  $sformatf("AFTER BACKDOOR WRITE: DES=0x%08h MIR=0x%08h", des, mir),
  UVM_NONE)
    

// ---------------------
// FRONTDOOR READ
// ---------------------
    regmodel.mem_addr.read(status, read_d,UVM_FRONTDOOR);

des = regmodel.mem_addr.get();
mir = regmodel.mem_addr.get_mirrored_value();

`uvm_info(get_type_name(),
  $sformatf("AFTER FRONTDOOR READ: DES=0x%08h MIR=0x%08h RDATA=0x%08h",
            des, mir, read_d),
  UVM_NONE)
 

//      // ---------------------
    //     // WRITE(IO_ADDR)
    // // ---------------------
//     regmodel.io_addr.write(status, 32'hAABB_CCDD);
//     des = regmodel.io_addr.get();
//      `uvm_info(get_type_name(),
//                $sformatf("AFTER IO_ADDR WRITE(get): DES=0x%08h MIR=0x%08h",
//                 des, mir),
//       UVM_NONE)
//     mir = regmodel.io_addr.get_mirrored_value();

//     `uvm_info(get_type_name(),
//               $sformatf("AFTER IO_ADDR WRITE(get_mirror_value): DES=0x%08h MIR=0x%08h",
//                 des, mir),
//       UVM_NONE)

//     regmodel.io_addr.mirror(status, UVM_CHECK);

//     // ---------------------
//     // READ
//     // ---------------------
//     regmodel.io_addr.read(status, read_d);

//     des = regmodel.io_addr.get();
//     mir = regmodel.io_addr.get_mirrored_value();

//     `uvm_info(get_type_name(),
//               $sformatf("IO_ADDR READ : DES=0x%08h MIR=0x%08h RDATA=0x%08h",
//                 des, mir, read_d),
//       UVM_NONE)

//     // Final mirror check
//     regmodel.io_addr.mirror(status, UVM_CHECK);   
    
    
//      // ---------------------
//     // WRITE(EXTRA_INFO)
//     // ---------------------
//     regmodel.extra_info.write(status, 32'hAABB_CCDD);
//     des = regmodel.extra_info.get();
//      `uvm_info(get_type_name(),
//                $sformatf("AFTER EXTRA_INFO WRITE(get): DES=0x%08h MIR=0x%08h",
//                 des, mir),
//       UVM_NONE)
//     mir = regmodel.extra_info.get_mirrored_value();

//     `uvm_info(get_type_name(),
//               $sformatf("AFTER EXTRA_INFO WRITE(get_mirror_value): DES=0x%08h MIR=0x%08h",
//                 des, mir),
//       UVM_NONE)

//     regmodel.extra_info.mirror(status, UVM_CHECK);

//     // ---------------------
//     // READ
//     // ---------------------
//     regmodel.extra_info.read(status, read_d);

//     des = regmodel.extra_info.get();
//     mir = regmodel.extra_info.get_mirrored_value();

//     `uvm_info(get_type_name(),
//               $sformatf("INTR_ADDR READ : DES=0x%08h MIR=0x%08h RDATA=0x%08h",
//                 des, mir, read_d),
//       UVM_NONE)

//     // Final mirror check
//     regmodel.extra_info.mirror(status, UVM_CHECK);
    
    

//      // ---------------------
//     // WRITE(STATUS)
//     // ---------------------
//     regmodel.status.write(status, 32'hAABB_CCDD);
//     des = regmodel.status.get();
//      `uvm_info(get_type_name(),
//                $sformatf("AFTER STATUS WRITE(get): DES=0x%08h MIR=0x%08h",
//                 des, mir),
//       UVM_NONE)
//     mir = regmodel.status.get_mirrored_value();

//     `uvm_info(get_type_name(),
//               $sformatf("AFTER STATUS WRITE(get_mirror_value): DES=0x%08h MIR=0 x%08h",
//                 des, mir),
//       UVM_NONE)

//     regmodel.status.mirror(status, UVM_CHECK);

//     // ---------------------
//     // READ
//     // ---------------------
//     regmodel.status.read(status, read_d);

//     des = regmodel.status.get();
//     mir = regmodel.status.get_mirrored_value();

//     `uvm_info(get_type_name(),
//               $sformatf("STATUS READ : DES=0x%08h MIR=0x%08h RDATA=0x%08h",
//                 des, mir, read_d),
//       UVM_NONE)

//     // Final mirror check
//     regmodel.status.mirror(status, UVM_CHECK);   
    
  endtask

endclass

