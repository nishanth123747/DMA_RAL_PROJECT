//`include "dma_env.sv"

class dma_model_base_test extends uvm_test;
  `uvm_component_utils(dma_model_base_test)

  dma_env env;

  function new(string name = "dma_model_base_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = dma_env::type_id::create("env", this);
  endfunction

  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    print();
  endfunction

//   function void report_phase(uvm_phase phase);
//     uvm_report_server svr;
//     super.report_phase(phase);

//     svr = uvm_report_server::get_server();
//     if (svr.get_severity_count(UVM_FATAL) +
//         svr.get_severity_count(UVM_ERROR) > 0) begin
//       `uvm_info("RESULT", "******** TEST FAIL ********", UVM_NONE)
//     end
//     else begin
//       `uvm_info("RESULT", "******** TEST PASS ********", UVM_NONE)
//     end
//   endfunction

endclass
class dma_reg_test extends dma_model_base_test;
  `uvm_component_utils(dma_reg_test)

  dma_reg_seq reg_seq;

  function new(string name = "dma_reg_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    reg_seq = dma_reg_seq::type_id::create("reg_seq");
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    `uvm_info("DMA_TEST", "Starting DMA register test", UVM_LOW)

    // pass RAL model to sequence
    reg_seq.regmodel   = env.regmodel;
    reg_seq.starting_phase = phase;

    reg_seq.start(env.dma_agnt.sqr);

    `uvm_info("DMA_TEST", "DMA register test completed", UVM_LOW)

    phase.drop_objection(this);
 //   phase.phase_done.set_drain_time(this, 50);
  endtask

endclass
