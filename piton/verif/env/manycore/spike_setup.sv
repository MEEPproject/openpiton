/* -----------------------------------------------------------
* Project Name   : MEEP
* Organization   : Barcelona Supercomputing Center
* Test           : spike_setup.sv
* Author(s)      : Saad Khalid
* Email(s)       : saad.khalid@bsc.es
* ------------------------------------------------------------
* Description:
* ------------------------------------------------------------
*/

`ifdef MEEP_COSIM

module spike_setup #(parameter NUM_CORES = 1) ();
  import spike_dpi_pkg::*;

  // Spike setup for cosimulation
  initial begin
    automatic int nargs = 0;
    automatic string exec_bin;
    automatic string argv;                                                          // Comma-separated arguments...

    if ($value$plusargs("SPIKE_BIN=%s", argv)) begin
        nargs = 1;
        $display("[MEEP-COSIM] SPIKE's arguments are' %s", argv);
    end else begin
        $fatal("[MEEP-COSIM] To use spike_seq.sv you need to pass +SPIKE_BIN plusarg, by giving -cosim in sims command");
    end
    // nargs++; // to pass ISA string
    // setup(nargs, {"--isa=RV64IMAFDCV ", argv}, NUM_CORES);
    nargs++; // pass ISA string
    argv = {"--isa=RV64IMAFDCV ", argv};
    nargs++; // pass varch
    argv = {$sformatf("--varch=vlen:%0d,elen:64,slen:%0d ", EPI_pkg::MAX_VLEN, EPI_pkg::MAX_VLEN), argv};
    nargs++; // pass number of processes(cores)
    argv = {$sformatf("-p=%0d ", NUM_CORES), argv};
    $display("[MEEP-COSIM] SPIKE's arguments are' %s", argv);
    setup(nargs, argv);
    $display("[MEEP-COSIM] Setup done for Spike!");

    start_execution();
    $display("[MEEP-COSIM] Execution started on Spike!");
  end
endmodule
`endif
