`ifdef MEEP_COSIM

package spike_dpi_pkg;

    import EPI_pkg::*;

localparam MAX_VLEN = EPI_pkg::MAX_VLEN;
localparam MAX_64BIT_BLOCKS = MAX_VLEN/64;

// Spike data
typedef logic [DATA_PATH_WIDTH-1:0] vec_operand_t [MAX_VLEN/MIN_SEW-1:0];
typedef longint unsigned vec_els_t [0:MAX_64BIT_BLOCKS-1];

// This struct contains 4 vector registers:
//

typedef struct
{
    vec_els_t old_vd;
    vec_els_t vd;
    vec_els_t vs1;
    vec_els_t vs2;
    vec_els_t vs3;
    vec_els_t vmask;
} vector_operands_t;

typedef struct
{
    longint old_vd;
    longint vd;
    vec_operand_t vs1;
    vec_operand_t vs2;
    vec_operand_t vs3;
    vec_operand_t vmask;
} formatted_vector_operands_t;

typedef struct {
    byte unsigned frm;
    byte unsigned fflags;
    byte unsigned trap_illegal;
} csrs_t;

typedef struct
{
    longint unsigned pc;
    int unsigned ins;
    longint unsigned destination_reg;
    longint unsigned rs1;
    longint unsigned rs2;
    longint unsigned fp_rs1;
    byte unsigned simm5;
    int unsigned vstart;
    int unsigned vl;
    int unsigned vxrm;
    int unsigned frm;
    int unsigned vlmul;
    int unsigned vsew;
    int unsigned vill;
    int unsigned vxsat;
    int unsigned vlen;
    int unsigned elen;
    csrs_t csrs;
    // vector_operands_t vector_operands;
    // formatted_vector_operands_t formatted_vector_operands;
} core_info_t;

typedef struct
{
  longint unsigned next_pc;
  longint unsigned dst;
  longint unsigned reg_wr_valid;
  longint unsigned data;
  longint unsigned xcpt;
  longint unsigned xcpt_cause;
  longint unsigned csr_priv_lvl;
  longint unsigned csr_xcpt;
  longint unsigned csr_xcpt_cause;
  longint unsigned csr_tval;
  int  rs1;
  int  rs2;
  int  rs3;
} core_commit_info_t;

// DPI function calls from spike/spike_main/spike-dpi.cc
  import "DPI-C" function void setup(input longint argc, input string argv);
  import "DPI-C" function void stop_execution();
  import "DPI-C" function void start_execution();
  import "DPI-C" function void step(output core_info_t core_info, input int hart_id);
  import "DPI-C" function void get_spike_commit_info(output core_commit_info_t core_info, input int hart_id);
  import "DPI-C" function int  run_until_vector_ins(inout core_info_t core_info);
  import "DPI-C" function void feed_reduction_result(input longint vpu_result, input int vdest);
  import "DPI-C" function int  get_memory_data(output longint mem_element, input longint mem_addr);
  import "DPI-C" function longint unsigned spike_get_csr(input int csr);
  import "DPI-C" function void spike_set_external_interrupt(input longint mip_val);
  import "DPI-C" function longint unsigned spike_get_gpr(int unsigned gpr);
  import "DPI-C" function void override_spike_gpr(longint unsigned hart_id, byte reg_dest, longint unsigned reg_data);
  import "DPI-C" function void override_spike_csr(longint unsigned hart_id, int csr_addr, longint unsigned csr_data);
  import "DPI-C" function void override_csr_backdoor(longint unsigned hart_id, int csr_addr, longint unsigned csr_data);
  import "DPI-C" function void get_src_vreg(input int reg_id, output longint unsigned vreg []);
  import "DPI-C" function void get_dst_vreg(input int reg_id, output longint unsigned vreg []);
//   import "DPI-C" function void get_mem_addr(output longint unsigned vreg []);
//   import "DPI-C" function void get_mem_elem(output longint unsigned vreg []);
endpackage

`endif
