#Here we define the accelerator_build.sh variables to use in differents targets
include Makefile.in
FPGA_TARGET ?= alveou280
ROOT_DIR    =  $(PWD)
PITON_BUILD_DIR = $(ROOT_DIR)/build
PROJECT_SUBDIR =  $(PITON_BUILD_DIR)/$(FPGA_TARGET)/system/
PROJECT_DIR = $(PROJECT_SUBDIR)/$(FPGA_TARGET)_system/$(FPGA_TARGET)_system.xpr
DATE        =  `date +'%a %b %e %H:%M:$S %Z %Y'`
SYNTH_DCP   =  $(ROOT_DIR)/dcp/synthesis.dcp
IMPL_DCP    =  $(ROOT_DIR)/dcp/implementation.dcp
BIT_FILE    =  $(ROOT_DIR)/bitstream/system.bit
TCL_DIR     =  $(ROOT_DIR)/piton/tools/src/proto/common
VIVADO_VER    ?= 2023.2
XILINX_VIVADO ?= /opt/Xilinx/Vivado/$(VIVADO_VER)
VIVADO_PATH := $(XILINX_VIVADO)/bin/
VIVADO_XLNX := $(XILINX_VIVADO)/bin/vivado
VIVADO_OPT  := -mode batch -nolog -nojournal -notrace -source

# This needs to match the path set in <core>_setup.sh
RISCV   ?= $(ROOT_DIR)/riscv
SHELL := /bin/bash
#Env variables to define the opentpiton+framework using the acceleretor_build.sh configuration
CORE        ?= lagarto
XTILES ?= 1
YTILES ?= 1
MULTIMC =
MULTIMC_INDICES =
#EA and OPTIONS helps to definde the env. EA could be the available acme_ea combinations, OPTIONS here we can define the protosyn flags
EA=
OPTIONS=
MC_OPTION =

ifdef MULTIMC
	MC_OPTION = --multimc $(MULTIMC)
	ifdef MULTIMC_INDICES
	MC_OPTION = --multimc $(MULTIMC) --multimc_indices $(MULTIMC_INDICES)
	endif
endif



PROTO_OPTIONS ?= vnpm eth hbm pronoc
MORE_OPTIONS ?= ""

#Don't rely on this to call the subprograms
export PATH := $(VIVADO_PATH):$(PATH)

.PHONY: clean clean_synthesis clean_implementation

all: initialize synthesis implementation bitstream


initialize: $(RISCV)

synthesis: $(SYNTH_DCP)

implementation: $(IMPL_DCP)

bitstream: $(BIT_FILE)

incremental:
	@echo "Source a tcl so Vivado takes the latest dcp file to configure incremental implementaiton"


$(RISCV):
	git clone https://github.com/riscv/riscv-gnu-toolchain; \
	cd riscv-gnu-toolchain; \
	./configure --prefix=$@ && make -j8; \
	cd $(ROOT_DIR); \

# Protosyn rule is connected with the piton/design/chipset/meep_shell/accelerator_build.sh script. In order with the values we define there
#Theses variables $CORE, $XTILES, $YTILES, and $PROTO_OPTIONS have the specific values to create the infrasctructure. We removed the vpu because it is 
#already defined in the PROTO_OPTIONS variable

acc_framework: clean_project
	source piton/$(CORE)_setup.sh; \
	protosyn --board $(FPGA_TARGET) --design system --core $(CORE) --x_tiles $(XTILES) --y_tiles $(YTILES) --num_tiles $(NTILES)  --zeroer_off $(PROTO_OPTIONS) $(MC_OPTION) $(MORE_OPTIONS)

$(SYNTH_DCP): $(PROJECT_FILE)
	$(VIVADO_XLNX $(VIVADO_OPT) $(TCL_DIR)/gen_synthesis.tcl -tclargs $(PROJECT_DIR)

$(IMPL_DCP): $(SYNTH_DCP)
	$(VIVADO_XLNX) $(VIVADO_OPT) $(TCL_DIR)/gen_implementation.tcl -tclargs $(ROOT_DIR)

$(BIT_FILE): $(IMPL_DCP)
	$(VIVADO_XLNX) $(VIVADO_OPT) $(TCL_DIR)/gen_bitstream.tcl -tclargs $(ROOT_DIR)


#new way to generate the infrastructure:
# First thing is to define which accelerator we want to work, we provide the name and the flags we want to use.
# Here, we can know how to use the accelerator_build.sh script, and define the ea_acelerator to use with the Openpiton framework

# Using this target, we ca know how the acelerator_build.sh works. Detailed information.
help_ea:
	source piton/design/chipset/meep_shell/accelerator_build.sh -h

#Here we can know the syntax of accelerator_build.sh
syntax_ea:
	source piton/design/chipset/meep_shell/accelerator_build.sh -s

#This is helpful when we are working in meep_openpiton repo

acc_env:
	source piton/design/chipset/meep_shell/accelerator_build.sh $(EA) $(OPTIONS)
	source piton/configure piton/design/chipset/meep_shell/env_accelerator.sh

# We use this target into the accelerator_build. sh script, because the fpga_shell flow has been made to be used with differents ea_accelerators,
#maybe in the future we can call this rule from the FPGA_Shell MAkefile, but at the moment we are going to use it with the accelerator_build.sh script



### Create targets to be used only in the CI/CD environment. They do not have requirements

ci_implementation:
	$(VIVADO_XLNX) $(VIVADO_OPT) $(TCL_DIR)/gen_implementation.tcl -tclargs $(ROOT_DIR)

ci_bitstream:
	$(VIVADO_XLNX) $(VIVADO_OPT) $(TCL_DIR)/gen_bitstream.tcl -tclargs $(ROOT_DIR)


# Compile the riscv-test baremetal
test_riscv_fpga:
	$(MAKE) -C piton/design/chip/tile/vas_tile_core/modules/riscv-tests/benchmarks NUMTILES=$(NTILES) fpga


test_riscv_clean:
	$(MAKE) -C piton/design/chip/tile/vas_tile_core/modules/riscv-tests/benchmarks clean


### Cleaning calls ###

# Clean the both tiles of untracket files
clean_tiles:
	cd piton/design/chip/tile/vas_tile_core; git clean -fdx; cd
	cd piton/design/chip/tile/ariane; git clean -fdx; cd

clean: clean_project

clean_all: clean_project
	rm -rf $(PITON_BUILD_DIR)/alveo*

clean_synthesis:
	rm -rf dcp/*

clean_implementation:
	rm -rf dcp/implementation.dcp bitstream reports

clean_project: clean_synthesis clean_implementation
	rm -rf $(PROJECT_DIR)

