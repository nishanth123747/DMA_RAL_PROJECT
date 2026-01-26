
class dma_monitor extends uvm_monitor;
  `uvm_component_utils(dma_monitor )

  uvm_analysis_port#(dma_seq_item) ap;

   virtual dma_reg_if.mon vif;

   function new( string name, uvm_component parent );
      super.new( name, parent );
   endfunction: new

   function void build_phase( uvm_phase phase );
      super.build_phase( phase );
      ap = new("ap", this);
     if (!uvm_config_db#(virtual dma_reg_if)::get(this, "", "vif", vif))
      `uvm_fatal("MON", "Virtual interface vif not set")
   endfunction

   task run_phase( uvm_phase phase );
     dma_seq_item tx;
     super.run_phase(phase);
     
     repeat(4)@(vif.mon_cb);
      forever begin 
      tx = dma_seq_item::type_id::create("tx");
         tx.wr_en = vif.mon_cb.wr_en;
  		 tx.rd_en = vif.mon_cb.rd_en;  
  		 tx.addr = vif.mon_cb.addr;
  		 tx.wdata = vif.mon_cb.wdata;
 		 tx.rdata = vif.mon_cb.rdata;
       // tx.print();
        ap.write(tx);
        @(vif.mon_cb);
       /* 
        
        tx = dma_seq_item::type_id::create("tx");
        repeat(2) @(vif.mon_cb);
			tx.wr_en = vif.mon_cb.wr_en ;
			tx.rd_en = vif.mon_cb.rd_en ;
			tx.addr  = vif.mon_cb.addr  ;
			tx.wdata = vif.mon_cb.wdata ;
			tx.rdata = vif.mon_cb.rdata ;
// 			`uvm_info(get_type_name,$sformatf("\nMonitor: wr:%0b | rd:%0b || wdata:%0d | rdata:%0d | addr:%0d",tx.wr_en, tx.rd_en, tx.wdata, tx.rdata, tx.addr), UVM_MEDIUM)
        ap.write(tx);
      */
      end
   endtask
endclass
