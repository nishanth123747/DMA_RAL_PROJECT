
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
//         `uvm_info(get_type_name(),
//                   $sformatf("MONITOR rd_en = %0d wr_en=%0d addr=0x%08h wdata=0x%08h rdata=0x%08h",tx.rd_en,tx.wr_en,
//                     tx.addr, tx.wdata, tx.rdata),
//           UVM_LOW)
//         $display("writing into port %0t",$time);
        ap.write(tx);
        @(vif.mon_cb);
      end
   endtask
endclass
