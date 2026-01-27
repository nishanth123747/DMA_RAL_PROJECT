
class dma_env extends uvm_env;
  `uvm_component_utils(dma_env)

  dma_agent dma_agnt;
  dma_reg_block regmodel;
  dma_adapter adapter;
  uvm_reg_predictor #(dma_seq_item) predictor;
  dma_coverage cov;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    dma_agnt = dma_agent::type_id::create("dma_agnt", this);

    regmodel = dma_reg_block::type_id::create("regmodel", this);
    regmodel.set_hdl_path_root("tb.DUT");
    regmodel.build();
    regmodel.lock_model();
    regmodel.reset();

    regmodel.default_map.set_auto_predict(0);

    adapter   = dma_adapter::type_id::create("adapter", this);
    predictor = uvm_reg_predictor #(dma_seq_item)::type_id::create("predictor", this);
    cov       = dma_coverage::type_id::create("cov", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

  
    regmodel.default_map.set_sequencer(dma_agnt.sqr, adapter);

   
    predictor.map     = regmodel.default_map;
    predictor.adapter = adapter;
    dma_agnt.mon.ap.connect(predictor.bus_in);

    // Coverage
    dma_agnt.mon.ap.connect(cov.analysis_export);
  endfunction

endclass

