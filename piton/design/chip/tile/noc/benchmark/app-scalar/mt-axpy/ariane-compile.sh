#/bin/bash!

# Default problem size
size=1024

common="../common_ariane"
compiler_bin="$RISCV/bin/"
bin="bin/mt-axpy${1}.riscv"

if [ "$#" -gt 2 ] || [ "$#" -lt 1 ]; then
    echo "Usage: #cores [opt]Mat_dim(power of 2)"
    exit 2
fi

if [ "$#" -eq 2 ]; then
    perl ./axpy_gendata.pl --size $2 
else
    if [ ! -f dataset.h ]
    then
        perl ./axpy_gendata.pl --size $size 
    fi
fi


mkdir -p  bin
rm $bin
#run epi_compiler directly

#compile="../../../epi_compiler/llvm-EPI-release-toolchain-cross/bin/riscv64-unknown-elf-gcc"
#compile="../../../epi_compiler/llvm-EPI-release-toolchain-cross/bin/clang --target=riscv64-unknown-elf -mepi"
 
$compiler_bin/riscv64-unknown-elf-gcc -I../ -I${common}/env -I${common} -I/usr/include/ -DPREALLOCATE=1 -mcmodel=medany -static -std=gnu99 -O2 -ffast-math -fno-common -fno-builtin-printf ${common}/syscalls.c $common/crt.S -static -nostdlib -nostartfiles -T ${common}/test.ld mt-axpy.c axpy.c -lm -lgcc -o $bin -DARIANE_TILE -DPITON_NUMTILES=$1 -DPITONSTREAM

$compiler_bin/riscv64-unknown-elf-objdump --disassemble-all --disassemble-zeroes --section=.text --section=.text.startup --section=.data $bin > $bin.dump



