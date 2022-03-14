// On-chip Static memory test
// Author: Alexander Kropotov, Barcelona Supercomputing Center

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

// #include <fcntl.h>
// #include <sys/mman.h>

#include "util.h" // for multi-core support

int main(int argc, char ** argv) {

  // synchronization variable
  volatile static uint32_t amo_cnt = 0;
  // synchronize with other cores and wait until it is this core's turn
  while(argv[0][0] != amo_cnt);

  enum {
    RTL_SIMUL = 0,
    SRAM_BASEADDR = 0xfff0400000,
    SRAM_ADRRANGE = RTL_SIMUL ? 512 : 0x00080000
  };

  uint8_t volatile* memPtr8 = (uint8_t*)SRAM_BASEADDR;
  // int fid = open("/dev/mem", O_RDWR);
  // if( fid < 0 ) {
  //   printf("Could not open /dev/mem \n");
  //   exit(1);
  // }
  // memPtr8 = (uint8_t*)mmap(0, SRAM_ADRRANGE, PROT_READ|PROT_WRITE, MAP_SHARED, fid, SRAM_BASEADDR);
  // if (memPtr8 == MAP_FAILED) {
  //   printf("Memory mapping of On-chip Static memory failed.\n");
  //   exit(1);
  // }
  uint16_t volatile* memPtr16 = (uint16_t*)memPtr8;
  uint32_t volatile* memPtr32 = (uint32_t*)memPtr8;
  uint64_t volatile* memPtr64 = (uint64_t*)memPtr8;

  size_t const memBytes = SRAM_ADRRANGE / sizeof(uint8_t);
  size_t const axiWidth = 512 / 8;

  if (!RTL_SIMUL) {
  printf("-- SRAM test --\n");
  printf("-- Hart %d of %d: Test of SRAM at addr 0x%lx(virt: 0x%lx) with size %d -- \n",
         argv[0][0], argv[0][1], SRAM_BASEADDR, (size_t)memPtr8, SRAM_ADRRANGE);
  // printf(" Checking memory with random values from %x to %x \n", 0, RAND_MAX);
  // first clearing previously stored values
  for (size_t addr = 0; addr < memBytes; ++addr) memPtr8 [addr] = 0;
  }

  // filling the memory with some adddress function
  uint64_t val = 0;
  for (uint64_t addr = 0; addr < memBytes; addr += (RTL_SIMUL ? axiWidth:1)) {
    val = (val >> 8) | ((addr ^ (~addr >> 8)) << 56);
    size_t axiWordIdx = addr/axiWidth;
    // changing written data type every wide AXI word
    if (axiWordIdx%4 == 0) memPtr8 [addr  ] = val >> 56;
    if (axiWordIdx%4 == 1) memPtr16[addr/2] = val >> 48;
    if (axiWordIdx%4 == 2) memPtr32[addr/4] = val >> 32;
    if (axiWordIdx%4 == 3) memPtr64[addr/8] = val;
  }

  // checking written values
  val = 0;
  size_t simulInc = 0;
  for (uint64_t addr = 0; addr < memBytes; addr += (RTL_SIMUL ? simulInc:1) ) {
    simulInc = axiWidth+1 + ((addr&4) ? 0 : (addr&3));
    val = (val >> 8) | ((addr ^ (~addr >> 8)) << 56);
    // checking readback using different data types
    if ((addr%8) == 7 && memPtr64[addr/8] !=  val)        {
      printf("ERR:HRT=%d ADR=%lx W64=%lx ", argv[0][0], addr, memPtr64[addr/8]);
      if (RTL_SIMUL) continue;
      printf(" expected = %lx \n", val);
      exit(1);
    }
    if ((addr%4) == 3 && memPtr32[addr/4] != (val >> 32)) {
      printf("ERR:HRT=%d ADR=%lx W32=%x ", argv[0][0], addr, memPtr32[addr/4]);
      if (RTL_SIMUL) continue;
      printf(" expected = %lx \n", val >> 32);
      exit(1);
    }
    if ((addr%2) == 1 && memPtr16[addr/2] != (val >> 48)) {
      printf("ERR:HRT=%d ADR=%lx W16=%x ", argv[0][0], addr, memPtr16[addr/2]);
      if (RTL_SIMUL) continue;
      printf(" expected = %lx \n", val >> 48);
      exit(1);
    }
    if (                 memPtr8 [addr  ] != (val >> 56)) {
      printf("ERR:HRT=%d ADR=%lx BYTE=%x ", argv[0][0], addr, memPtr8[addr]);
      if (RTL_SIMUL) continue;
      printf(" expected = %lx \n", val >> 56);
      exit(1);
    }
  }

  if (!RTL_SIMUL)
  printf("-- SRAM test on hart %d of %d harts Passed --\n", argv[0][0], argv[0][1]);

  // increment atomic counter
  ATOMIC_OP(amo_cnt, 1, add, w);

  return 0;
}
