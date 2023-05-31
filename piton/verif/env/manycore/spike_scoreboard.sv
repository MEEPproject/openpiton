/* -----------------------------------------------------------
* Project Name   : MEEP
* Organization   : Barcelona Supercomputing Center
* Test           : spike_scoreboard.sv
* Author(s)      : Saad Khalid
* Email(s)       : saad.khalid@bsc.es
* ------------------------------------------------------------
* Description:
* ------------------------------------------------------------
*/

//TODO: add store data checker

`ifdef MEEP_COSIM

import vpu_scoreboard_pkg::*;

module spike_scoreboard(
  input                           clk,
  input                           rst,
  input                           commit,
  input [63:0]                    pc,
  input drac_pkg::exe_wb_instr_t  wb_stage,
  input  [4:0]                    xreg_dest,
  input drac_pkg::cu_rr_t         cu_rr_int,
  input [63:0]                    commit_data,
  input                           excep,
  input drac_pkg::reg64_t         xreg_1,
  input drac_pkg::reg64_t         xreg_2,
  input drac_pkg::reg64_t         xreg_3,
  input drac_pkg::reg64_t         xreg_4,
  input drac_pkg::reg64_t         xreg_5,
  input drac_pkg::reg64_t         xreg_6,
  input drac_pkg::reg64_t         xreg_7,
  input drac_pkg::reg64_t         xreg_8,
  input drac_pkg::reg64_t         xreg_9,
  input drac_pkg::reg64_t         xreg_10,
  input drac_pkg::reg64_t         xreg_11,
  input drac_pkg::reg64_t         xreg_12,
  input drac_pkg::reg64_t         xreg_13,
  input drac_pkg::reg64_t         xreg_14,
  input drac_pkg::reg64_t         xreg_15,
  input drac_pkg::reg64_t         xreg_16,
  input drac_pkg::reg64_t         xreg_17,
  input drac_pkg::reg64_t         xreg_18,
  input drac_pkg::reg64_t         xreg_19,
  input drac_pkg::reg64_t         xreg_20,
  input drac_pkg::reg64_t         xreg_21,
  input drac_pkg::reg64_t         xreg_22,
  input drac_pkg::reg64_t         xreg_23,
  input drac_pkg::reg64_t         xreg_24,
  input drac_pkg::reg64_t         xreg_25,
  input drac_pkg::reg64_t         xreg_26,
  input drac_pkg::reg64_t         xreg_27,
  input drac_pkg::reg64_t         xreg_28,
  input drac_pkg::reg64_t         xreg_29,
  input drac_pkg::reg64_t         xreg_30,
  input drac_pkg::reg64_t         xreg_31,
  input ariane_pkg::exception_t   csr_excep,
  input [63:0]                    csr_cause,
  input drac_pkg::pipeline_ctrl_t control_intf,
  input drac_pkg::vpu_completed_t vpu_resp,
  input [63:0]                    hart_id,
  input [63:0]                    ref_hart_id,
  input [63:0]                    csr_mip,
  input [2:0]                     csr_vsew,
  input [14:0]                    csr_vl
);

// OpenPiton-Lagarto implementation specific addresses
localparam logic [63:0] CLINT_BASE    = 64'h000000fff1020000;
localparam logic [63:0] BOOTROM_START = 64'hfff1010000;
localparam logic [63:0] BOOTROM_END   = 64'hfff1020000;
localparam logic [63:0] UART_START    = 64'hfff0c2c000;
localparam logic [63:0] UART_END      = 64'hfff0d00000;
localparam logic [63:0] MMR_MTIME     = CLINT_BASE + 64'h000000000000bff8;

// Default prints for Spike and RTL commit info
    `define PRINT_RTL $display("[MEEP-COSIM][RTL]   Core [%0d]: PC[%16h] Instr[%8h] r[%2d]:[%16h][%1d] frg[%2d][%16h][%1d] DASM(0x%4h)", hart_id, pc_extended, instr, xreg_dest, commit_data, xreg_wr_valid, wb_stage.frd, commit_data, cu_rr_int.fwrite_enable, instr);

    `define PRINT_SPIKE $display("[MEEP-COSIM][Spike] Core [%0d]: PC[%16h] Instr[%8h] r[%2d]:[%16h]    frg[%2d][%16h][%1d] DASM(0x%4h)", hart_id, spike_log.pc, spike_log.ins, spike_commit_log.dst, spike_commit_log.data, spike_commit_log.dst, spike_commit_log.data, is_float, spike_log.ins);

// hartid must be correct otherwise it could access non-existent hart of spike
HART_ID_CHECK:  assert property (@(posedge clk) ref_hart_id == hart_id)
                else $fatal(1, "Incorrect hart ID from Design - Ref[%0d] Act[%0d]", ref_hart_id, hart_id);

import spike_dpi_pkg::*;
import riscv_pkg::*;
import drac_pkg::*;

logic [31:0]        instr;
longint unsigned    start_compare_pc = 64'h80000000;                               // after this PC, instruction by instruction match would start
int unsigned        spike_instr = 0;                                               // for tracking instruction number on spike
int unsigned        spike_instr_timeout = 100;
core_info_t         spike_log;
core_commit_info_t  spike_commit_log;
bit                 do_comparison = 0;
longint unsigned    pc_extended;
logic               xreg_wr_valid;
logic               is_exception;
logic [63:0]        exception_cause;
logic               vpu_completed;
logic               scalar_instr_commit;
logic               vector_inst_completed;
logic               commit_or_excep;
logic               is_compressed;
logic               is_vector;
logic               is_mip_read;
logic [11:0]        instr_csr_addr;
logic               system_instr;
vec_els_t           vpu_res;
logic [63:0]        rs1_data;
logic [31:0]        vec_inst;
logic [63:0]        vec_pc;
vector_operands_t   vector_operands;

logic [vpu_scoreboard_pkg::MAX_VLEN-1:0] vec_reg_q[$];
string exception_codes [logic[31:0]];

assign instr = wb_stage.inst_orig;
assign is_exception = excep || csr_excep.valid;
assign exception_cause = csr_excep.valid ? csr_cause : wb_stage.ex.cause;
assign pc_extended = $signed(pc);
assign xreg_wr_valid = cu_rr_int.write_enable && xreg_dest != 0;
assign scalar_instr_commit = commit && !control_intf.stall_exe && !is_vector;
assign vector_inst_completed = vpu_completed;
assign commit_or_excep = scalar_instr_commit || vector_inst_completed || is_exception;
assign is_compressed = ~&instr[1:0];
assign is_float = instr[6:0] inside {riscv_pkg::OP_FP,
                                     riscv_pkg::OP_LOAD_FP,
                                     riscv_pkg::OP_STORE_FP,
                                     riscv_pkg::OP_FMADD,
                                     riscv_pkg::OP_FMSUB,
                                     riscv_pkg::OP_FNMSUB,
                                     riscv_pkg::OP_FNMADD};
assign instr_csr_addr = instr[31:20];
assign system_instr = instr[6:0] == riscv_pkg::OP_SYSTEM;
assign is_counter_read = xreg_wr_valid && system_instr && ((instr_csr_addr >= riscv::CSR_MCYCLE && instr_csr_addr <= riscv::CSR_MHPM_COUNTER_31) ||
                                                           (instr_csr_addr >= riscv::CSR_CYCLE && instr_csr_addr <= riscv::CSR_HPM_COUNTER_31));
assign is_mtime_mmr_read = xreg_wr_valid && rs1_data == MMR_MTIME && instr[6:0] == riscv_pkg::OP_LOAD;
assign is_mmio_read = xreg_wr_valid && ((rs1_data >= BOOTROM_START && rs1_data <= BOOTROM_END) || (rs1_data >= UART_START && rs1_data <= UART_END)) && instr[6:0] == riscv_pkg::OP_LOAD;
assign is_mip_read = xreg_wr_valid && system_instr && instr_csr_addr == riscv::CSR_MIP;
assign is_store_amo = is_compressed ? (instr[1:0] == 2'b00 || instr[1:0] == 2'b10) && instr[15:13] inside {3'b101, 3'b110, 3'b111} : instr[6:0] inside {7'b0100011, 7'b0100111, 7'b0100111};
assign is_load = is_compressed ? (instr[1:0] == 2'b00 || instr[1:0] == 2'b10) && instr[15:13] inside {3'b001, 3'b010, 3'b011} : instr[6:0] inside {7'b0000011, 7'b0000111};
assign is_mem_instr = is_store_amo | is_load;
assign is_vector = wb_stage.is_vector;
assign vpu_completed = vpu_resp.valid;

initial begin
exception_codes = '{{1'b0,31'd0} : "INSTRUCTION MISLAIGNED ",
                {1'b0, 31'd1}  : "INSTRUCTION ACCESS FAULT",
                {1'b0, 31'd2}  : "ILLEGAL INSTRUCTION",
                {1'b0, 31'd3}  : "BREAKPOINT",
                {1'b0, 31'd4}  : "LOAD ADDRESS MISLAIGNED",
                {1'b0, 31'd5}  : "LOAD ACCESS FAULT",
                {1'b0, 31'd6}  : "STORE/AMO ADDRESS MISLAIGNED",
                {1'b0, 31'd7}  : "STORE/AMO ACCESS FAULT",
                {1'b0, 31'd8}  : "ECALL U-MODE",
                {1'b0, 31'd9}  : "ECALL S-MODE",
                {1'b0, 31'd10} : "RESERVED",
                {1'b0, 31'd11} : "ECALLL M-MODE",
                {1'b0, 31'd12} : "INSTRUCTION PAGE FAULT",
                {1'b0, 31'd13} : "LOAD PAGE FAULT",
                {1'b0, 31'd14} : "RESERVED",
                {1'b0, 31'd15} : "STORE/AMO PAGE FAULT",
                {1'b1, 31'd0}  : "RESERVED",
                {1'b1, 31'd1}  : "SUPERVISOR SOFTWARE INT",
                {1'b1, 31'd2}  : "RESERVED",
                {1'b1, 31'd3}  : "MACHINE SOFTWARE INT",
                {1'b1, 31'd4}  : "RESERVED",
                {1'b1, 31'd5}  : "SUPERVISOR TIMER INT",
                {1'b1, 31'd6}  : "RESERVED",
                {1'b1, 31'd7}  : "MACHINE TIMER INT",
                {1'b1, 31'd8}  : "RESERVED",
                {1'b1, 31'd9}  : "SUPERVISOR EXTERNAL INT",
                {1'b1, 31'd10} : "RESERVED",
                {1'b1, 31'd11} : "MACHINE EXTERNAL INT"
                };
end

`ifdef VPU_ENABLE
vpu_sim_vreg_if vreg_if();

`ifdef BSC_RTL_SRAMS
  generate
    for(genvar i = 0; i < vpu_scoreboard_pkg::N_LANES; i++) begin
      for(genvar bnk = 0; bnk < vpu_scoreboard_pkg::N_BANKS; bnk++) begin
        for(genvar j = 0; j < vpu_scoreboard_pkg::VRF_WPACK; j++) begin
          assign vreg_if.lane[i].bank[bnk].subbank[j] = `VPU_0.vector_lane_gen[i].vector_lane_inst.vrf_slice_wrapper_inst.vrf_slice_inst.vrf_bank_gen[bnk].vrf_bank_inst.ram_dp_gen[j].ram_dp_inst.mem;
        end
      end
    end
  endgenerate
`endif
`endif // `endif VPU_ENABLE

// Spike setup for cosimulation
initial begin
  @(posedge clk);

  // waiting till Spike reaches that particular PC after which instruction match will start,
  while(spike_log.pc != start_compare_pc) begin
    step(spike_log, hart_id);
    get_spike_commit_info(spike_commit_log, hart_id);

    `PRINT_RTL;
    `PRINT_SPIKE;

    spike_instr++;

    // there are only a few starting PCs, which are being ignored now so timing out after a certain threshold
    if (spike_instr >= spike_instr_timeout) begin
      $fatal(1, "[MEEP-COSIM] Core [%0d]: Spike instruction count exceeded %d, but still did not reach start_compare_pc", hart_id, spike_instr_timeout);
    end
  end

  $display("[MEEP-COSIM] Core [%0d]: Spike at PC[%16h]. Now waiting for the step after RTL instruction will be committed.", hart_id, start_compare_pc);
end

`ifdef VPU_ENABLE
// Vector OVI Interface monitor
always @(posedge clk) begin
  automatic logic [vpu_scoreboard_pkg::MAX_VLEN-1:0] vec_reg_t;

  if (`VPU_0.completed_valid_o) begin
    vpu_res = retrieve_vpu_result(`VPU_0.reorder_buffer_inst.vreg_o, (2**csr_vsew)*8);
    foreach (vpu_res[elem]) begin
      vec_reg_t = {vec_reg_t, vpu_res[elem]};
    end
    vec_reg_t = {<<64{vec_reg_t}};
    vec_reg_q.push_back(vec_reg_t);

  end

  if (`VPU_0.issue_valid_i) begin
    vec_inst  = `VPU_0.issue_instr_i;
    vec_pc    = wb_stage.pc;
  end
end
`endif // `endif VPU_ENABLE

// Cosimulation - Scoreboard
always @(posedge clk) begin
  automatic logic [vpu_scoreboard_pkg::MAX_VLEN-1:0] vec_reg_spike;
  automatic logic [vpu_scoreboard_pkg::MAX_VLEN-1:0] vec_reg_rtl;

  if(commit_or_excep || (commit && is_exception)) begin
    // Instruction comparison
    if (pc_extended == start_compare_pc || do_comparison) begin
      // as soon as RTL PC reaches start_compare_pc, it should start comparison
      do_comparison <= 1;

      // Overriding stuff from RTL
      // 1. HPM counter CSRs
      // 2. mip CSR

      // when there is interrupt on RTL, override mip CSR since it depends upon MMRs in hardware
      // and Spike may have values reflected immediately in mip, so overriding mip CSR in Spike
      if (spike_get_csr(riscv::CSR_MIP) != csr_mip && is_exception && exception_cause[63]) begin
        $display("[MEEP-COSIM] Overridden Spike mip - Hart[%0d] spike old mip[%0h] spike new mip[%16h]" , hart_id, spike_get_csr(riscv::CSR_MIP), csr_mip);
        override_csr_backdoor(hart_id, riscv::CSR_MIP, csr_mip);
      end

      // do not increment for 1st instruction, since its already at the correct PC
      if (do_comparison) begin
        step(spike_log, hart_id);
        spike_instr++;
      end

      // // Counters (instret, cycle and other PMU counters) are not implemented in Spike
      // // since those counters are already being checked via PMU scoreboard so just
      // // overriding Spike whenever there is a read from any counter. Also reg data comparison
      // // for such instruction is not necessary
      // // mtime MMR and mip CSR read could also contain different values for Spike and RTL so
      // // overriding those too
      if (is_counter_read || is_mtime_mmr_read || is_mmio_read || is_mip_read) begin
        override_spike_gpr(hart_id, xreg_dest, commit_data);
        $display("[MEEP-COSIM] Overridden Spike - Core[%0d] GPR[%0d][%16h]" , hart_id, xreg_dest, spike_get_gpr(xreg_dest));
      end

      get_spike_commit_info(spike_commit_log, hart_id);
`ifdef VPU_ENABLE
      get_dst_vreg (spike_commit_log.dst, vector_operands.vd);
`endif // `endif VPU_ENABLE

      if (spike_commit_log.xcpt != is_exception/* && instr != 32'h9f019073 /* csrw 0x9f0, gp*/) begin
        `PRINT_RTL;
        if (is_exception) begin
          $fatal(1, "[MEEP-COSIM] Core [%0d]: Exception Mismatch between RTL[%0h](%s) and Spike[%0h]!", hart_id, is_exception, exception_codes[exception_cause], spike_commit_log.xcpt[0]);
        end
        else begin
          $fatal(1, "[MEEP-COSIM] Core [%0d]: Exception Mismatch between RTL[%0h] and Spike[%0h](%s)!", hart_id, is_exception, spike_commit_log.xcpt[0], exception_codes[spike_commit_log.xcpt_cause]);
        end
      end
      else if (is_exception && spike_commit_log.xcpt_cause != exception_cause) begin
        `PRINT_RTL;
        $fatal(1, "[MEEP-COSIM] Core [%0d]: Exception Cause Mismatch between RTL[%0h] %s and Spike[%0h] %s!", hart_id, exception_cause,
        exception_codes[exception_cause], spike_commit_log.xcpt_cause, exception_codes[spike_commit_log.xcpt_cause]);
      end
      else begin

          if (is_exception) begin
              `PRINT_RTL;
              if (exception_cause[63]) begin
                $display("[MEEP-COSIM][RTL]   Core [%0d]: Interrupt - mcause[%16h] %s", hart_id, exception_cause, exception_codes[exception_cause]);
              end else begin
                $display("[MEEP-COSIM][RTL]   Core [%0d]: Exception - mcause[%16h] %s", hart_id, exception_cause, exception_codes[exception_cause]);
              end
          // Vector reg contents will be checked on completed_valid from VPU
          end
          else if (vector_inst_completed) begin
            // converting structure into a packed array
            foreach (vector_operands.vd[elem]) begin
              // $display("Spike Vector element[%d] %h", elem, vector_operands.vd[elem]);
              vec_reg_spike = {vec_reg_spike, vector_operands.vd[elem]};
            end
            vec_reg_spike = {<<64{vec_reg_spike}};
            vec_reg_rtl = vec_reg_q.pop_front();

            $display("[MEEP-COSIM][VPU]   Core [%0d]: PC[%16h] Instr[%8h] DASM(0x%4h)", hart_id, spike_log.pc, spike_log.ins, spike_log.ins);

            if (vec_inst[6:0] != riscv_pkg::OP_STORE_FP) begin

              $display("[MEEP-COSIM][VPU]   Core [%0d]: V[%0d][%h]", hart_id, spike_commit_log.dst, vec_reg_rtl);

              // Vector Destination Register Data Comparison
              if (vec_reg_rtl != vec_reg_spike) begin
                $fatal(1, "[MEEP-COSIM] Core [%0d]: Vector Reg Mismatch between RTL[%h] and Spike[%h]!", hart_id, vec_reg_rtl, vec_reg_spike);
              end
            end
            
            // Vector PC Comparison
            if (vec_pc != spike_log.pc) begin
              $fatal(1, "[MEEP-COSIM] Core [%0d]: PC Mismatch between RTL[%16h] and Spike[%16h]!", hart_id, vec_pc, spike_log.pc);
            end
            // Vector Instruction Comparison
            if (vec_inst != spike_log.ins) begin
              $fatal(1, "[MEEP-COSIM] Core [%0d]: Instruction Mismatch between RTL[%16h] and Spike[%16h]!", hart_id, vec_inst, spike_log.ins);
            end
          end

          else if (scalar_instr_commit && !is_vector) begin
            `PRINT_RTL;
            // PC Comparison
            if (pc_extended != spike_log.pc) begin
              `PRINT_SPIKE;
              $fatal(1, "[MEEP-COSIM] Core [%0d]: PC Mismatch between RTL[%16h] and Spike[%16h]!", hart_id, pc_extended, spike_log.pc);
            end

            // Instruction Comparison
            if (is_compressed) begin
              if (instr[15:0] != spike_log.ins[15:0]) begin
                $fatal(1, "[MEEP-COSIM] Core [%0d]: Instruction Mismatch between RTL[%8h] and Spike[%8h]!", hart_id, instr[15:0], spike_log.ins[15:0]);
              end
            end else begin
              if (instr != spike_log.ins) begin
                `PRINT_SPIKE;
                $fatal(1, "[MEEP-COSIM] Core [%0d]: Instruction Mismatch between RTL[%16h] and Spike[%16h]!", hart_id, instr, spike_log.ins);
              end
            end

            // Destination X-Reg Comparison
            if (xreg_wr_valid && xreg_dest != spike_commit_log.dst) begin
              `PRINT_SPIKE;
              $fatal(1, "[MEEP-COSIM] Core [%0d]: Destination Register Address Mismatch between RTL[%d] and Spike[%d]!", hart_id, xreg_dest, spike_commit_log.dst);
            end

            // Destination X-Reg Data Comparison
            if (xreg_wr_valid && commit_data != spike_commit_log.data && !is_counter_read && !is_mtime_mmr_read && !is_mmio_read && !is_mip_read) begin
              if (system_instr) begin
                `PRINT_SPIKE;
                $fatal(1, "[MEEP-COSIM] Core [%0d]: CSR - 0x%3h Read Mismatch between RTL[%16h] and Spike[%16h]!", hart_id, instr_csr_addr, commit_data, spike_commit_log.data);
              end else begin
                `PRINT_SPIKE;
                $fatal(1, "[MEEP-COSIM] Core [%0d]: Destination Register Data Mismatch between RTL[%16h] and Spike[%16h]!", hart_id, commit_data, spike_commit_log.data);
              end
            end

            // Destination F-Reg Comparison
            if (cu_rr_int.fwrite_enable && wb_stage.frd != spike_commit_log.dst) begin
              `PRINT_SPIKE;
              $fatal(1, "[MEEP-COSIM] Core [%0d]: Destination Floating Register Address Mismatch between RTL[%d] and Spike[%d]!", hart_id, xreg_dest, spike_commit_log.dst);
            end
            // Destination F-Reg Data Comparison
            if (cu_rr_int.fwrite_enable && commit_data != spike_commit_log.data) begin
              `PRINT_SPIKE;
              $fatal(1, "[MEEP-COSIM] Core [%0d]: Destination Floating Register Data Mismatch between RTL[%16h] and Spike[%16h]!", hart_id, commit_data, spike_commit_log.data);
            end
          end
      end
    end
  end
end

`ifdef VPU_ENABLE
// From Unit Level VPU verification environment
    // Function: retrieve_vpu_result
    // Takes value of the destination register of the instruction in the VPU
    function vec_els_t retrieve_vpu_result(int vdest, int sew);
        vec_els_t vec_result;
        vreg_elements_t vec_el;
        automatic int elements = 0;
        automatic int lane = 0;
        automatic int elems_per_lane = vpu_scoreboard_pkg::MAX_64BIT_BLOCKS/vpu_scoreboard_pkg::N_LANES;
        automatic int bank = (vdest*elems_per_lane)%vpu_scoreboard_pkg::N_BANKS;
        automatic int addr = (vdest*elems_per_lane)/vpu_scoreboard_pkg::N_BANKS;
        automatic int sub_banks = vpu_scoreboard_pkg::VRF_WPACK;
        automatic int i = 0;
        int ilane, ibank, ij, iaddr;
        for (; i < vpu_scoreboard_pkg::MAX_VLEN/vpu_scoreboard_pkg::MIN_SEW; i = i + sub_banks*vpu_scoreboard_pkg::VRF_WBITS/sew) begin
            case (sew)
                8: begin
                    if(vpu_scoreboard_pkg::VRF_WBITS == 4) begin
                      for(int j=0;j<sub_banks/2;j++) begin
                        vec_el[i+j] = {vreg_if.lane[lane].bank[bank].subbank[j*2+1][addr],vreg_if.lane[lane].bank[bank].subbank[j*2][addr]} ;
                      end
                    end
                    if(vpu_scoreboard_pkg::VRF_WBITS == 8) begin
                        for(int j=0;j<sub_banks;j++) begin
                          vec_el[i+j] = vreg_if.lane[lane].bank[bank].subbank[j][addr] ;
                        end
                    end
                end
                16: begin
                      if(vpu_scoreboard_pkg::VRF_WBITS == 4) begin
                        vec_el[i] = {vreg_if.lane[lane].bank[bank].subbank[3][addr],
                                     vreg_if.lane[lane].bank[bank].subbank[2][addr],
                                     vreg_if.lane[lane].bank[bank].subbank[1][addr],
                                     vreg_if.lane[lane].bank[bank].subbank[0][addr]};
                        vec_el[i+1] =  {vreg_if.lane[lane].bank[bank].subbank[7][addr],
                                        vreg_if.lane[lane].bank[bank].subbank[6][addr],
                                        vreg_if.lane[lane].bank[bank].subbank[5][addr],
                                        vreg_if.lane[lane].bank[bank].subbank[4][addr]};
                        vec_el[i+2] = {vreg_if.lane[lane].bank[bank].subbank[11][addr],
                                       vreg_if.lane[lane].bank[bank].subbank[10][addr],
                                       vreg_if.lane[lane].bank[bank].subbank[9][addr],
                                       vreg_if.lane[lane].bank[bank].subbank[8][addr]};
                        vec_el[i+3] =  {vreg_if.lane[lane].bank[bank].subbank[15][addr],
                                        vreg_if.lane[lane].bank[bank].subbank[14][addr],
                                        vreg_if.lane[lane].bank[bank].subbank[13][addr],
                                        vreg_if.lane[lane].bank[bank].subbank[12][addr]};
                      end
                      if(vpu_scoreboard_pkg::VRF_WBITS == 8) begin
                        vec_el[i] = {vreg_if.lane[lane].bank[bank].subbank[1][addr],
                                     vreg_if.lane[lane].bank[bank].subbank[0][addr]};
                        vec_el[i+1] = {vreg_if.lane[lane].bank[bank].subbank[3][addr],
                                       vreg_if.lane[lane].bank[bank].subbank[2][addr]};
                        vec_el[i+2] = {vreg_if.lane[lane].bank[bank].subbank[5][addr],
                                       vreg_if.lane[lane].bank[bank].subbank[4][addr]};
                        vec_el[i+3] = {vreg_if.lane[lane].bank[bank].subbank[7][addr],
                                       vreg_if.lane[lane].bank[bank].subbank[6][addr]};
                      end
                    end
                32: begin
                      if(vpu_scoreboard_pkg::VRF_WBITS == 8) begin
                                    vec_el[i] = {vreg_if.lane[lane].bank[bank].subbank[3][addr],
                                                 vreg_if.lane[lane].bank[bank].subbank[2][addr],
                                                 vreg_if.lane[lane].bank[bank].subbank[1][addr],
                                                 vreg_if.lane[lane].bank[bank].subbank[0][addr]};
                                    vec_el[i+1] = {vreg_if.lane[lane].bank[bank].subbank[7][addr],
                                                   vreg_if.lane[lane].bank[bank].subbank[6][addr],
                                                   vreg_if.lane[lane].bank[bank].subbank[5][addr],
                                                   vreg_if.lane[lane].bank[bank].subbank[4][addr]};
                      end
                      if(vpu_scoreboard_pkg::VRF_WBITS == 4) begin
                        vec_el[i] = {vreg_if.lane[lane].bank[bank].subbank[7][addr],
                                     vreg_if.lane[lane].bank[bank].subbank[6][addr],
                                     vreg_if.lane[lane].bank[bank].subbank[5][addr],
                                     vreg_if.lane[lane].bank[bank].subbank[4][addr],
                                     vreg_if.lane[lane].bank[bank].subbank[3][addr],
                                     vreg_if.lane[lane].bank[bank].subbank[2][addr],
                                     vreg_if.lane[lane].bank[bank].subbank[1][addr],
                                     vreg_if.lane[lane].bank[bank].subbank[0][addr]};
                        vec_el[i+1] = {vreg_if.lane[lane].bank[bank].subbank[15][addr],
                                       vreg_if.lane[lane].bank[bank].subbank[14][addr],
                                       vreg_if.lane[lane].bank[bank].subbank[13][addr],
                                       vreg_if.lane[lane].bank[bank].subbank[12][addr],
                                       vreg_if.lane[lane].bank[bank].subbank[11][addr],
                                       vreg_if.lane[lane].bank[bank].subbank[10][addr],
                                       vreg_if.lane[lane].bank[bank].subbank[9][addr],
                                       vreg_if.lane[lane].bank[bank].subbank[8][addr]};
                      end
                end
                64: begin
                      if(vpu_scoreboard_pkg::VRF_WBITS == 8) begin
                        vec_el[i] = {vreg_if.lane[lane].bank[bank].subbank[7][addr],
                                     vreg_if.lane[lane].bank[bank].subbank[6][addr],
                                     vreg_if.lane[lane].bank[bank].subbank[5][addr],
                                     vreg_if.lane[lane].bank[bank].subbank[4][addr],
                                     vreg_if.lane[lane].bank[bank].subbank[3][addr],
                                     vreg_if.lane[lane].bank[bank].subbank[2][addr],
                                     vreg_if.lane[lane].bank[bank].subbank[1][addr],
                                     vreg_if.lane[lane].bank[bank].subbank[0][addr]};
                      end
                      if(vpu_scoreboard_pkg::VRF_WBITS == 4) begin
                        vec_el[i] = {vreg_if.lane[lane].bank[bank].subbank[15][addr],
                                     vreg_if.lane[lane].bank[bank].subbank[14][addr],
                                     vreg_if.lane[lane].bank[bank].subbank[13][addr],
                                     vreg_if.lane[lane].bank[bank].subbank[12][addr],
                                     vreg_if.lane[lane].bank[bank].subbank[11][addr],
                                     vreg_if.lane[lane].bank[bank].subbank[10][addr],
                                     vreg_if.lane[lane].bank[bank].subbank[9][addr],
                                     vreg_if.lane[lane].bank[bank].subbank[8][addr],
                                     vreg_if.lane[lane].bank[bank].subbank[7][addr],
                                     vreg_if.lane[lane].bank[bank].subbank[6][addr],
                                     vreg_if.lane[lane].bank[bank].subbank[5][addr],
                                     vreg_if.lane[lane].bank[bank].subbank[4][addr],
                                     vreg_if.lane[lane].bank[bank].subbank[3][addr],
                                     vreg_if.lane[lane].bank[bank].subbank[2][addr],
                                     vreg_if.lane[lane].bank[bank].subbank[1][addr],
                                     vreg_if.lane[lane].bank[bank].subbank[0][addr]};
                      end
                end
            endcase
            if (lane == vpu_scoreboard_pkg::N_LANES-1 && bank < vpu_scoreboard_pkg::N_BANKS-1) bank++;
            else if (lane == vpu_scoreboard_pkg::N_LANES-1) begin
                bank = 0;
                addr++;
            end
            if (lane < vpu_scoreboard_pkg::N_LANES-1) lane++;
            else lane = 0;
        end
        case (sew)
            8: begin
                for (iaddr=0; iaddr<MAX_64BIT_BLOCKS; iaddr++) begin
                    vec_result[iaddr] = {vec_el[8*iaddr+7][7:0], vec_el[8*iaddr+6][7:0],
                                         vec_el[8*iaddr+5][7:0], vec_el[8*iaddr+4][7:0],
                                         vec_el[8*iaddr+3][7:0], vec_el[8*iaddr+2][7:0],
                                         vec_el[8*iaddr+1][7:0], vec_el[8*iaddr+0][7:0]};
                end
            end
            16: begin
                for (iaddr=0; iaddr<MAX_64BIT_BLOCKS; iaddr++) begin
                    vec_result[iaddr] = {vec_el[4*iaddr+3][15:0], vec_el[4*iaddr+2][15:0],
                                         vec_el[4*iaddr+1][15:0], vec_el[4*iaddr+0][15:0]};
                end
            end
            32: begin
                for (iaddr=0; iaddr<MAX_64BIT_BLOCKS; iaddr++) begin
                    vec_result[iaddr] = {vec_el[2*iaddr+1][31:0], vec_el[2*iaddr+0][31:0]};
                end
            end
            64: begin
                for (iaddr=0; iaddr<MAX_64BIT_BLOCKS; iaddr++) begin
                    vec_result[iaddr] = vec_el[iaddr];
                end
            end
        endcase
        return vec_result;
    endfunction : retrieve_vpu_result
`endif // `endif VPU_ENABLE

always_comb begin
  case (wb_stage.rs1)
    1  : rs1_data = xreg_1;
    2  : rs1_data = xreg_2;
    3  : rs1_data = xreg_3;
    4  : rs1_data = xreg_4;
    5  : rs1_data = xreg_5;
    6  : rs1_data = xreg_6;
    7  : rs1_data = xreg_7;
    8  : rs1_data = xreg_8;
    9  : rs1_data = xreg_9;
    10 : rs1_data = xreg_10;
    11 : rs1_data = xreg_11;
    12 : rs1_data = xreg_12;
    13 : rs1_data = xreg_13;
    14 : rs1_data = xreg_14;
    15 : rs1_data = xreg_15;
    16 : rs1_data = xreg_16;
    17 : rs1_data = xreg_17;
    18 : rs1_data = xreg_18;
    19 : rs1_data = xreg_19;
    20 : rs1_data = xreg_20;
    21 : rs1_data = xreg_21;
    22 : rs1_data = xreg_22;
    23 : rs1_data = xreg_23;
    24 : rs1_data = xreg_24;
    25 : rs1_data = xreg_25;
    26 : rs1_data = xreg_26;
    27 : rs1_data = xreg_27;
    28 : rs1_data = xreg_28;
    29 : rs1_data = xreg_29;
    30 : rs1_data = xreg_30;
    31 : rs1_data = xreg_31;
    default: rs1_data = 64'h0;
  endcase
end

endmodule

`ifdef VPU_ENABLE
// From Unit Level VPU verification environment
// Interface: vpu_vreg_if
// VPU VREG Interface
interface vpu_sim_vreg_if ();
    lane_vreg_t lane [vpu_scoreboard_pkg::N_LANES-1:0];
    logic [5:0] rename_vdest;
endinterface : vpu_sim_vreg_if
`endif // endif VPU_ENABLE

`endif
