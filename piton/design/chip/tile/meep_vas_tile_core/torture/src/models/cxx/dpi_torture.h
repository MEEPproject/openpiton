// See LICENSE for license details.

#ifndef DPI_TORTURE_H
#define DPI_TORTURE_H

#include <svdpi.h>
#include <iostream>
#include <fstream>
#include <stdlib.h>
#include <string>

#define CAUSE_MISALIGNED_FETCH 0x0
#define CAUSE_FAULT_FETCH 0x1
#define CAUSE_ILLEGAL_INSTRUCTION 0x2
#define CAUSE_BREAKPOINT 0x3
#define CAUSE_MISALIGNED_LOAD 0x4
#define CAUSE_FAULT_LOAD 0x5
#define CAUSE_MISALIGNED_STORE 0x6
#define CAUSE_FAULT_STORE 0x7
#define CAUSE_USER_ECALL 0x8
#define CAUSE_SUPERVISOR_ECALL 0x9
#define CAUSE_MACHINE_ECALL 0xB
#define CAUSE_INSTR_PAGE_FAULT 0xC
#define CAUSE_LD_PAGE_FAULT 0xD
#define CAUSE_ST_AMO_PAGE_FAULT 0xF

#ifdef __cplusplus
extern "C" {
#endif

  extern void torture_dump (unsigned long long PC, unsigned long long inst, unsigned long long dst, unsigned long long reg_wr_valid, unsigned long long data, unsigned long long xcpt, unsigned long long xcpt_cause, unsigned long long csr_priv_lvl, unsigned long long csr_rw_data, unsigned long long csr_xcpt, unsigned long long csr_xcpt_cause, unsigned long long csr_tval);
  extern void torture_signature_init();
#ifdef __cplusplus
}
#endif

// Class to hold the torture signature
class tortureSignature {
uint64_t * signature; // vector to hold the register file status
std::ofstream signatureFile; // file where the info is dumped
std::string signatureFileName = "signature.txt";
bool dump_valid = true;

public:
tortureSignature()
{
 signature = (uint64_t*) calloc(32,sizeof(uint64_t));
}

virtual ~tortureSignature() { free(signature); }

void disable();

void set_dump_file_name(std::string name);

bool dump_check();

void clear_output();

void update_signature(uint64_t dst, uint64_t data);

void dump_file(uint64_t PC, uint64_t inst, uint64_t dst, uint64_t reg_wr_valid, uint64_t xcpt, uint64_t xcpt_cause, uint64_t data, uint64_t csr_priv_lvl, uint64_t csr_rw_data, uint64_t csr_tval);

void dump_xcpt(uint64_t xcpt_cause, uint64_t epc, uint64_t tval);
};

// Global torture_signature
extern tortureSignature *torture_signature;

#endif
