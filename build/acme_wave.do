onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group scalar_core /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/datapath_inst/clk_i
add wave -noupdate -expand -group scalar_core /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/datapath_inst/rstn_i
add wave -noupdate -expand -group scalar_core /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/datapath_inst/reset_addr_i
add wave -noupdate -expand -group scalar_core -expand /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/datapath_inst/resp_vpu_cpu_i
add wave -noupdate -expand -group scalar_core /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/datapath_inst/ovi_memop_sync_start_i
add wave -noupdate -expand -group scalar_core /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/datapath_inst/ovi_memop_sync_end_o
add wave -noupdate -expand -group scalar_core -expand /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/datapath_inst/req_cpu_vpu_o
add wave -noupdate -expand -group scalar_core /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/datapath_inst/ovi_load_o
add wave -noupdate -expand -group scalar_core /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/datapath_inst/velem_cnt_o
add wave -noupdate -expand -group scalar_core /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/datapath_inst/instVPU
add wave -noupdate -expand -group scalar_core /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/datapath_inst/accs_execution_mode_i
add wave -noupdate -expand -group scalar_core /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/datapath_inst/wfi_detect_op_o
add wave -noupdate -expand -group scalar_core /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/datapath_inst/which_acc
add wave -noupdate -expand -group scalar_core /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/datapath_inst/exe_to_wb_exe.valid
add wave -noupdate -expand -group scalar_core /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/datapath_inst/exe_to_wb_exe.pc
add wave -noupdate -expand -group scalar_core /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/datapath_inst/exe_to_wb_exe.inst.bits
add wave -noupdate -expand -group scalar_core /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/datapath_inst/control_int
add wave -noupdate -expand -group Accelerator_VPU /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/vpu_inst/clk_i
add wave -noupdate -expand -group Accelerator_VPU /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/vpu_inst/mode_sel_i
add wave -noupdate -expand -group Accelerator_VPU /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/vpu_inst/issue_valid_i
add wave -noupdate -expand -group Accelerator_VPU /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/vpu_inst/issue_instr_i
add wave -noupdate -expand -group Accelerator_VPU /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/vpu_inst/issue_data_i
add wave -noupdate -expand -group Accelerator_VPU /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/vpu_inst/issue_sb_id_i
add wave -noupdate -expand -group Accelerator_VPU /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/vpu_inst/issue_csr_i
add wave -noupdate -expand -group Accelerator_VPU /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/vpu_inst/issue_credit_o
add wave -noupdate -expand -group Accelerator_VPU /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/vpu_inst/dispatch_sb_id_i
add wave -noupdate -expand -group Accelerator_VPU /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/vpu_inst/dispatch_nxt_sen_i
add wave -noupdate -expand -group Accelerator_VPU /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/vpu_inst/completed_sb_id_o
add wave -noupdate -expand -group Accelerator_VPU /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/vpu_inst/completed_valid_o
add wave -noupdate -expand -group Accelerator_VPU /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/vpu_inst/memop_sb_id_i
add wave -noupdate -expand -group Accelerator_VPU /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/vpu_inst/virt_addr_i
add wave -noupdate -expand -group Accelerator_VPU -expand -group noc2 /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/vpu_inst/vpu_req_buff_data_o
add wave -noupdate -expand -group Accelerator_VPU -expand -group noc2 /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/vpu_inst/vpu_req_buff_data_valid_o
add wave -noupdate -expand -group Accelerator_VPU -expand -group noc2 /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/vpu_inst/noc2_enc_rdy_i
add wave -noupdate -expand -group Accelerator_VPU -expand -group noc3 /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/vpu_inst/noc3_dec_data_i
add wave -noupdate -expand -group Accelerator_VPU -expand -group noc3 /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/vpu_inst/noc3_dec_data_valid_i
add wave -noupdate -expand -group Accelerator_VPU -expand -group noc3 /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/vpu_inst/vpu_resp_buff_rdy_o
add wave -noupdate -group NoC_1_router /cmp_top/system/chip/tile0/user_dynamic_network0/dynamic_node_top/clk
add wave -noupdate -group NoC_1_router /cmp_top/system/chip/tile0/user_dynamic_network0/dynamic_node_top/reset_in
add wave -noupdate -group NoC_1_router /cmp_top/system/chip/tile0/user_dynamic_network0/dynamic_node_top/dataIn_N
add wave -noupdate -group NoC_1_router /cmp_top/system/chip/tile0/user_dynamic_network0/dynamic_node_top/dataIn_E
add wave -noupdate -group NoC_1_router /cmp_top/system/chip/tile0/user_dynamic_network0/dynamic_node_top/dataIn_S
add wave -noupdate -group NoC_1_router /cmp_top/system/chip/tile0/user_dynamic_network0/dynamic_node_top/dataIn_W
add wave -noupdate -group NoC_1_router /cmp_top/system/chip/tile0/user_dynamic_network0/dynamic_node_top/dataIn_P
add wave -noupdate -group NoC_1_router /cmp_top/system/chip/tile0/user_dynamic_network0/dynamic_node_top/validIn_N
add wave -noupdate -group NoC_1_router /cmp_top/system/chip/tile0/user_dynamic_network0/dynamic_node_top/validIn_E
add wave -noupdate -group NoC_1_router /cmp_top/system/chip/tile0/user_dynamic_network0/dynamic_node_top/validIn_S
add wave -noupdate -group NoC_1_router /cmp_top/system/chip/tile0/user_dynamic_network0/dynamic_node_top/validIn_W
add wave -noupdate -group NoC_1_router /cmp_top/system/chip/tile0/user_dynamic_network0/dynamic_node_top/validIn_P
add wave -noupdate -group NoC_1_router /cmp_top/system/chip/tile0/user_dynamic_network0/dynamic_node_top/yummyIn_N
add wave -noupdate -group NoC_1_router /cmp_top/system/chip/tile0/user_dynamic_network0/dynamic_node_top/yummyIn_E
add wave -noupdate -group NoC_1_router /cmp_top/system/chip/tile0/user_dynamic_network0/dynamic_node_top/yummyIn_S
add wave -noupdate -group NoC_1_router /cmp_top/system/chip/tile0/user_dynamic_network0/dynamic_node_top/yummyIn_W
add wave -noupdate -group NoC_1_router /cmp_top/system/chip/tile0/user_dynamic_network0/dynamic_node_top/yummyIn_P
add wave -noupdate -group NoC_1_router /cmp_top/system/chip/tile0/user_dynamic_network0/dynamic_node_top/myLocX
add wave -noupdate -group NoC_1_router /cmp_top/system/chip/tile0/user_dynamic_network0/dynamic_node_top/myLocY
add wave -noupdate -group NoC_1_router /cmp_top/system/chip/tile0/user_dynamic_network0/dynamic_node_top/myChipID
add wave -noupdate -group NoC_1_router /cmp_top/system/chip/tile0/user_dynamic_network0/dynamic_node_top/store_meter_partner_address_X
add wave -noupdate -group NoC_1_router /cmp_top/system/chip/tile0/user_dynamic_network0/dynamic_node_top/store_meter_partner_address_Y
add wave -noupdate -group NoC_1_router /cmp_top/system/chip/tile0/user_dynamic_network0/dynamic_node_top/ec_cfg
add wave -noupdate -group NoC_1_router /cmp_top/system/chip/tile0/user_dynamic_network0/dynamic_node_top/dataOut_N
add wave -noupdate -group NoC_1_router /cmp_top/system/chip/tile0/user_dynamic_network0/dynamic_node_top/dataOut_E
add wave -noupdate -group NoC_1_router /cmp_top/system/chip/tile0/user_dynamic_network0/dynamic_node_top/dataOut_S
add wave -noupdate -group NoC_1_router /cmp_top/system/chip/tile0/user_dynamic_network0/dynamic_node_top/dataOut_W
add wave -noupdate -group NoC_1_router /cmp_top/system/chip/tile0/user_dynamic_network0/dynamic_node_top/dataOut_P
add wave -noupdate -group NoC_1_router /cmp_top/system/chip/tile0/user_dynamic_network0/dynamic_node_top/validOut_N
add wave -noupdate -group NoC_1_router /cmp_top/system/chip/tile0/user_dynamic_network0/dynamic_node_top/validOut_E
add wave -noupdate -group NoC_1_router /cmp_top/system/chip/tile0/user_dynamic_network0/dynamic_node_top/validOut_S
add wave -noupdate -group NoC_1_router /cmp_top/system/chip/tile0/user_dynamic_network0/dynamic_node_top/validOut_W
add wave -noupdate -group NoC_1_router /cmp_top/system/chip/tile0/user_dynamic_network0/dynamic_node_top/validOut_P
add wave -noupdate -group NoC_1_router /cmp_top/system/chip/tile0/user_dynamic_network0/dynamic_node_top/yummyOut_N
add wave -noupdate -group NoC_1_router /cmp_top/system/chip/tile0/user_dynamic_network0/dynamic_node_top/yummyOut_E
add wave -noupdate -group NoC_1_router /cmp_top/system/chip/tile0/user_dynamic_network0/dynamic_node_top/yummyOut_S
add wave -noupdate -group NoC_1_router /cmp_top/system/chip/tile0/user_dynamic_network0/dynamic_node_top/yummyOut_W
add wave -noupdate -group NoC_1_router /cmp_top/system/chip/tile0/user_dynamic_network0/dynamic_node_top/yummyOut_P
add wave -noupdate -group NoC_1_router /cmp_top/system/chip/tile0/user_dynamic_network0/dynamic_node_top/thanksIn_P
add wave -noupdate -group NoC_1_router /cmp_top/system/chip/tile0/user_dynamic_network0/dynamic_node_top/external_interrupt
add wave -noupdate -group NoC_1_router /cmp_top/system/chip/tile0/user_dynamic_network0/dynamic_node_top/store_meter_ack_partner
add wave -noupdate -group NoC_1_router /cmp_top/system/chip/tile0/user_dynamic_network0/dynamic_node_top/store_meter_ack_non_partner
add wave -noupdate -group NoC_1_router /cmp_top/system/chip/tile0/user_dynamic_network0/dynamic_node_top/ec_out
add wave -noupdate -group NoC_2_router /cmp_top/system/chip/tile0/user_dynamic_network1/dynamic_node_top/clk
add wave -noupdate -group NoC_2_router /cmp_top/system/chip/tile0/user_dynamic_network1/dynamic_node_top/reset_in
add wave -noupdate -group NoC_2_router /cmp_top/system/chip/tile0/user_dynamic_network1/dynamic_node_top/dataIn_N
add wave -noupdate -group NoC_2_router /cmp_top/system/chip/tile0/user_dynamic_network1/dynamic_node_top/dataIn_E
add wave -noupdate -group NoC_2_router /cmp_top/system/chip/tile0/user_dynamic_network1/dynamic_node_top/dataIn_S
add wave -noupdate -group NoC_2_router /cmp_top/system/chip/tile0/user_dynamic_network1/dynamic_node_top/dataIn_W
add wave -noupdate -group NoC_2_router /cmp_top/system/chip/tile0/user_dynamic_network1/dynamic_node_top/dataIn_P
add wave -noupdate -group NoC_2_router /cmp_top/system/chip/tile0/user_dynamic_network1/dynamic_node_top/validIn_N
add wave -noupdate -group NoC_2_router /cmp_top/system/chip/tile0/user_dynamic_network1/dynamic_node_top/validIn_E
add wave -noupdate -group NoC_2_router /cmp_top/system/chip/tile0/user_dynamic_network1/dynamic_node_top/validIn_S
add wave -noupdate -group NoC_2_router /cmp_top/system/chip/tile0/user_dynamic_network1/dynamic_node_top/validIn_W
add wave -noupdate -group NoC_2_router /cmp_top/system/chip/tile0/user_dynamic_network1/dynamic_node_top/validIn_P
add wave -noupdate -group NoC_2_router /cmp_top/system/chip/tile0/user_dynamic_network1/dynamic_node_top/yummyIn_N
add wave -noupdate -group NoC_2_router /cmp_top/system/chip/tile0/user_dynamic_network1/dynamic_node_top/yummyIn_E
add wave -noupdate -group NoC_2_router /cmp_top/system/chip/tile0/user_dynamic_network1/dynamic_node_top/yummyIn_S
add wave -noupdate -group NoC_2_router /cmp_top/system/chip/tile0/user_dynamic_network1/dynamic_node_top/yummyIn_W
add wave -noupdate -group NoC_2_router /cmp_top/system/chip/tile0/user_dynamic_network1/dynamic_node_top/yummyIn_P
add wave -noupdate -group NoC_2_router /cmp_top/system/chip/tile0/user_dynamic_network1/dynamic_node_top/myLocX
add wave -noupdate -group NoC_2_router /cmp_top/system/chip/tile0/user_dynamic_network1/dynamic_node_top/myLocY
add wave -noupdate -group NoC_2_router /cmp_top/system/chip/tile0/user_dynamic_network1/dynamic_node_top/myChipID
add wave -noupdate -group NoC_2_router /cmp_top/system/chip/tile0/user_dynamic_network1/dynamic_node_top/store_meter_partner_address_X
add wave -noupdate -group NoC_2_router /cmp_top/system/chip/tile0/user_dynamic_network1/dynamic_node_top/store_meter_partner_address_Y
add wave -noupdate -group NoC_2_router /cmp_top/system/chip/tile0/user_dynamic_network1/dynamic_node_top/ec_cfg
add wave -noupdate -group NoC_2_router /cmp_top/system/chip/tile0/user_dynamic_network1/dynamic_node_top/dataOut_N
add wave -noupdate -group NoC_2_router /cmp_top/system/chip/tile0/user_dynamic_network1/dynamic_node_top/dataOut_E
add wave -noupdate -group NoC_2_router /cmp_top/system/chip/tile0/user_dynamic_network1/dynamic_node_top/dataOut_S
add wave -noupdate -group NoC_2_router /cmp_top/system/chip/tile0/user_dynamic_network1/dynamic_node_top/dataOut_W
add wave -noupdate -group NoC_2_router /cmp_top/system/chip/tile0/user_dynamic_network1/dynamic_node_top/dataOut_P
add wave -noupdate -group NoC_2_router /cmp_top/system/chip/tile0/user_dynamic_network1/dynamic_node_top/validOut_N
add wave -noupdate -group NoC_2_router /cmp_top/system/chip/tile0/user_dynamic_network1/dynamic_node_top/validOut_E
add wave -noupdate -group NoC_2_router /cmp_top/system/chip/tile0/user_dynamic_network1/dynamic_node_top/validOut_S
add wave -noupdate -group NoC_2_router /cmp_top/system/chip/tile0/user_dynamic_network1/dynamic_node_top/validOut_W
add wave -noupdate -group NoC_2_router /cmp_top/system/chip/tile0/user_dynamic_network1/dynamic_node_top/validOut_P
add wave -noupdate -group NoC_2_router /cmp_top/system/chip/tile0/user_dynamic_network1/dynamic_node_top/yummyOut_N
add wave -noupdate -group NoC_2_router /cmp_top/system/chip/tile0/user_dynamic_network1/dynamic_node_top/yummyOut_E
add wave -noupdate -group NoC_2_router /cmp_top/system/chip/tile0/user_dynamic_network1/dynamic_node_top/yummyOut_S
add wave -noupdate -group NoC_2_router /cmp_top/system/chip/tile0/user_dynamic_network1/dynamic_node_top/yummyOut_W
add wave -noupdate -group NoC_2_router /cmp_top/system/chip/tile0/user_dynamic_network1/dynamic_node_top/yummyOut_P
add wave -noupdate -group NoC_2_router /cmp_top/system/chip/tile0/user_dynamic_network1/dynamic_node_top/thanksIn_P
add wave -noupdate -group NoC_2_router /cmp_top/system/chip/tile0/user_dynamic_network1/dynamic_node_top/external_interrupt
add wave -noupdate -group NoC_2_router /cmp_top/system/chip/tile0/user_dynamic_network1/dynamic_node_top/store_meter_ack_partner
add wave -noupdate -group NoC_2_router /cmp_top/system/chip/tile0/user_dynamic_network1/dynamic_node_top/store_meter_ack_non_partner
add wave -noupdate -group NoC_2_router /cmp_top/system/chip/tile0/user_dynamic_network1/dynamic_node_top/ec_out
add wave -noupdate -group NoC_3_router /cmp_top/system/chip/tile0/user_dynamic_network2/dynamic_node_top/clk
add wave -noupdate -group NoC_3_router /cmp_top/system/chip/tile0/user_dynamic_network2/dynamic_node_top/reset_in
add wave -noupdate -group NoC_3_router /cmp_top/system/chip/tile0/user_dynamic_network2/dynamic_node_top/dataIn_N
add wave -noupdate -group NoC_3_router /cmp_top/system/chip/tile0/user_dynamic_network2/dynamic_node_top/dataIn_E
add wave -noupdate -group NoC_3_router /cmp_top/system/chip/tile0/user_dynamic_network2/dynamic_node_top/dataIn_S
add wave -noupdate -group NoC_3_router /cmp_top/system/chip/tile0/user_dynamic_network2/dynamic_node_top/dataIn_W
add wave -noupdate -group NoC_3_router /cmp_top/system/chip/tile0/user_dynamic_network2/dynamic_node_top/dataIn_P
add wave -noupdate -group NoC_3_router /cmp_top/system/chip/tile0/user_dynamic_network2/dynamic_node_top/validIn_N
add wave -noupdate -group NoC_3_router /cmp_top/system/chip/tile0/user_dynamic_network2/dynamic_node_top/validIn_E
add wave -noupdate -group NoC_3_router /cmp_top/system/chip/tile0/user_dynamic_network2/dynamic_node_top/validIn_S
add wave -noupdate -group NoC_3_router /cmp_top/system/chip/tile0/user_dynamic_network2/dynamic_node_top/validIn_W
add wave -noupdate -group NoC_3_router /cmp_top/system/chip/tile0/user_dynamic_network2/dynamic_node_top/validIn_P
add wave -noupdate -group NoC_3_router /cmp_top/system/chip/tile0/user_dynamic_network2/dynamic_node_top/yummyIn_N
add wave -noupdate -group NoC_3_router /cmp_top/system/chip/tile0/user_dynamic_network2/dynamic_node_top/yummyIn_E
add wave -noupdate -group NoC_3_router /cmp_top/system/chip/tile0/user_dynamic_network2/dynamic_node_top/yummyIn_S
add wave -noupdate -group NoC_3_router /cmp_top/system/chip/tile0/user_dynamic_network2/dynamic_node_top/yummyIn_W
add wave -noupdate -group NoC_3_router /cmp_top/system/chip/tile0/user_dynamic_network2/dynamic_node_top/yummyIn_P
add wave -noupdate -group NoC_3_router /cmp_top/system/chip/tile0/user_dynamic_network2/dynamic_node_top/myLocX
add wave -noupdate -group NoC_3_router /cmp_top/system/chip/tile0/user_dynamic_network2/dynamic_node_top/myLocY
add wave -noupdate -group NoC_3_router /cmp_top/system/chip/tile0/user_dynamic_network2/dynamic_node_top/myChipID
add wave -noupdate -group NoC_3_router /cmp_top/system/chip/tile0/user_dynamic_network2/dynamic_node_top/store_meter_partner_address_X
add wave -noupdate -group NoC_3_router /cmp_top/system/chip/tile0/user_dynamic_network2/dynamic_node_top/store_meter_partner_address_Y
add wave -noupdate -group NoC_3_router /cmp_top/system/chip/tile0/user_dynamic_network2/dynamic_node_top/ec_cfg
add wave -noupdate -group NoC_3_router /cmp_top/system/chip/tile0/user_dynamic_network2/dynamic_node_top/dataOut_N
add wave -noupdate -group NoC_3_router /cmp_top/system/chip/tile0/user_dynamic_network2/dynamic_node_top/dataOut_E
add wave -noupdate -group NoC_3_router /cmp_top/system/chip/tile0/user_dynamic_network2/dynamic_node_top/dataOut_S
add wave -noupdate -group NoC_3_router /cmp_top/system/chip/tile0/user_dynamic_network2/dynamic_node_top/dataOut_W
add wave -noupdate -group NoC_3_router /cmp_top/system/chip/tile0/user_dynamic_network2/dynamic_node_top/dataOut_P
add wave -noupdate -group NoC_3_router /cmp_top/system/chip/tile0/user_dynamic_network2/dynamic_node_top/validOut_N
add wave -noupdate -group NoC_3_router /cmp_top/system/chip/tile0/user_dynamic_network2/dynamic_node_top/validOut_E
add wave -noupdate -group NoC_3_router /cmp_top/system/chip/tile0/user_dynamic_network2/dynamic_node_top/validOut_S
add wave -noupdate -group NoC_3_router /cmp_top/system/chip/tile0/user_dynamic_network2/dynamic_node_top/validOut_W
add wave -noupdate -group NoC_3_router /cmp_top/system/chip/tile0/user_dynamic_network2/dynamic_node_top/validOut_P
add wave -noupdate -group NoC_3_router /cmp_top/system/chip/tile0/user_dynamic_network2/dynamic_node_top/yummyOut_N
add wave -noupdate -group NoC_3_router /cmp_top/system/chip/tile0/user_dynamic_network2/dynamic_node_top/yummyOut_E
add wave -noupdate -group NoC_3_router /cmp_top/system/chip/tile0/user_dynamic_network2/dynamic_node_top/yummyOut_S
add wave -noupdate -group NoC_3_router /cmp_top/system/chip/tile0/user_dynamic_network2/dynamic_node_top/yummyOut_W
add wave -noupdate -group NoC_3_router /cmp_top/system/chip/tile0/user_dynamic_network2/dynamic_node_top/yummyOut_P
add wave -noupdate -group NoC_3_router /cmp_top/system/chip/tile0/user_dynamic_network2/dynamic_node_top/thanksIn_P
add wave -noupdate -group NoC_3_router /cmp_top/system/chip/tile0/user_dynamic_network2/dynamic_node_top/external_interrupt
add wave -noupdate -group NoC_3_router /cmp_top/system/chip/tile0/user_dynamic_network2/dynamic_node_top/store_meter_ack_partner
add wave -noupdate -group NoC_3_router /cmp_top/system/chip/tile0/user_dynamic_network2/dynamic_node_top/store_meter_ack_non_partner
add wave -noupdate -group NoC_3_router /cmp_top/system/chip/tile0/user_dynamic_network2/dynamic_node_top/ec_out
add wave -noupdate -group {Memory Tile} {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/clk_i}
add wave -noupdate -group {Memory Tile} {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/resetn_i}
add wave -noupdate -group {Memory Tile} -expand -group axi4_to_mainmem {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/xbar_mem_aclk_i}
add wave -noupdate -group {Memory Tile} -expand -group axi4_to_mainmem {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/xbar_mem_aresetn_i}
add wave -noupdate -group {Memory Tile} -expand -group axi4_to_mainmem {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/xbar_mem_arid_o}
add wave -noupdate -group {Memory Tile} -expand -group axi4_to_mainmem {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/xbar_mem_araddr_o}
add wave -noupdate -group {Memory Tile} -expand -group axi4_to_mainmem {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/xbar_mem_arlen_o}
add wave -noupdate -group {Memory Tile} -expand -group axi4_to_mainmem {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/xbar_mem_arsize_o}
add wave -noupdate -group {Memory Tile} -expand -group axi4_to_mainmem {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/xbar_mem_arburst_o}
add wave -noupdate -group {Memory Tile} -expand -group axi4_to_mainmem {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/xbar_mem_arlock_o}
add wave -noupdate -group {Memory Tile} -expand -group axi4_to_mainmem {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/xbar_mem_arcache_o}
add wave -noupdate -group {Memory Tile} -expand -group axi4_to_mainmem {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/xbar_mem_arprot_o}
add wave -noupdate -group {Memory Tile} -expand -group axi4_to_mainmem {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/xbar_mem_arqos_o}
add wave -noupdate -group {Memory Tile} -expand -group axi4_to_mainmem {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/xbar_mem_arregion_o}
add wave -noupdate -group {Memory Tile} -expand -group axi4_to_mainmem {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/xbar_mem_aruser_o}
add wave -noupdate -group {Memory Tile} -expand -group axi4_to_mainmem {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/xbar_mem_arvalid_o}
add wave -noupdate -group {Memory Tile} -expand -group axi4_to_mainmem {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/xbar_mem_arready_i}
add wave -noupdate -group {Memory Tile} -expand -group axi4_to_mainmem {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/xbar_mem_awid_o}
add wave -noupdate -group {Memory Tile} -expand -group axi4_to_mainmem {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/xbar_mem_awaddr_o}
add wave -noupdate -group {Memory Tile} -expand -group axi4_to_mainmem {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/xbar_mem_awlen_o}
add wave -noupdate -group {Memory Tile} -expand -group axi4_to_mainmem {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/xbar_mem_awsize_o}
add wave -noupdate -group {Memory Tile} -expand -group axi4_to_mainmem {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/xbar_mem_awburst_o}
add wave -noupdate -group {Memory Tile} -expand -group axi4_to_mainmem {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/xbar_mem_awlock_o}
add wave -noupdate -group {Memory Tile} -expand -group axi4_to_mainmem {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/xbar_mem_awcache_o}
add wave -noupdate -group {Memory Tile} -expand -group axi4_to_mainmem {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/xbar_mem_awprot_o}
add wave -noupdate -group {Memory Tile} -expand -group axi4_to_mainmem {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/xbar_mem_awqos_o}
add wave -noupdate -group {Memory Tile} -expand -group axi4_to_mainmem {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/xbar_mem_awregion_o}
add wave -noupdate -group {Memory Tile} -expand -group axi4_to_mainmem {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/xbar_mem_awuser_o}
add wave -noupdate -group {Memory Tile} -expand -group axi4_to_mainmem {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/xbar_mem_awvalid_o}
add wave -noupdate -group {Memory Tile} -expand -group axi4_to_mainmem {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/xbar_mem_awready_i}
add wave -noupdate -group {Memory Tile} -expand -group axi4_to_mainmem {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/xbar_mem_wid_o}
add wave -noupdate -group {Memory Tile} -expand -group axi4_to_mainmem {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/xbar_mem_wdata_o}
add wave -noupdate -group {Memory Tile} -expand -group axi4_to_mainmem {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/xbar_mem_wstrb_o}
add wave -noupdate -group {Memory Tile} -expand -group axi4_to_mainmem {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/xbar_mem_wlast_o}
add wave -noupdate -group {Memory Tile} -expand -group axi4_to_mainmem {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/xbar_mem_wuser_o}
add wave -noupdate -group {Memory Tile} -expand -group axi4_to_mainmem {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/xbar_mem_wvalid_o}
add wave -noupdate -group {Memory Tile} -expand -group axi4_to_mainmem {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/xbar_mem_wready_i}
add wave -noupdate -group {Memory Tile} -expand -group axi4_to_mainmem {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/xbar_mem_rid_i}
add wave -noupdate -group {Memory Tile} -expand -group axi4_to_mainmem {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/xbar_mem_rdata_i}
add wave -noupdate -group {Memory Tile} -expand -group axi4_to_mainmem {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/xbar_mem_rresp_i}
add wave -noupdate -group {Memory Tile} -expand -group axi4_to_mainmem {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/xbar_mem_rlast_i}
add wave -noupdate -group {Memory Tile} -expand -group axi4_to_mainmem {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/xbar_mem_ruser_i}
add wave -noupdate -group {Memory Tile} -expand -group axi4_to_mainmem {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/xbar_mem_rvalid_i}
add wave -noupdate -group {Memory Tile} -expand -group axi4_to_mainmem {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/xbar_mem_rready_o}
add wave -noupdate -group {Memory Tile} -expand -group axi4_to_mainmem {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/xbar_mem_bid_i}
add wave -noupdate -group {Memory Tile} -expand -group axi4_to_mainmem {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/xbar_mem_bresp_i}
add wave -noupdate -group {Memory Tile} -expand -group axi4_to_mainmem {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/xbar_mem_buser_i}
add wave -noupdate -group {Memory Tile} -expand -group axi4_to_mainmem {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/xbar_mem_bvalid_i}
add wave -noupdate -group {Memory Tile} -expand -group axi4_to_mainmem {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/xbar_mem_bready_o}
add wave -noupdate -group {Memory Tile} -expand -group cnoc {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/cnoc_req_val_i}
add wave -noupdate -group {Memory Tile} -expand -group cnoc {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/cnoc_req_dat_i}
add wave -noupdate -group {Memory Tile} -expand -group cnoc {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/cnoc_req_rdy_o}
add wave -noupdate -group {Memory Tile} -expand -group cnoc {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/cnoc_rsp_val_o}
add wave -noupdate -group {Memory Tile} -expand -group cnoc {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/cnoc_rsp_dat_o}
add wave -noupdate -group {Memory Tile} -expand -group cnoc {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/cnoc_rsp_rdy_i}
add wave -noupdate -group {Memory Tile} -expand -group vnoc {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/vnoc_req_val_o}
add wave -noupdate -group {Memory Tile} -expand -group vnoc {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/vnoc_req_dat_o}
add wave -noupdate -group {Memory Tile} -expand -group vnoc {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/vnoc_req_hdr_o}
add wave -noupdate -group {Memory Tile} -expand -group vnoc {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/vnoc_req_sgl_flt_o}
add wave -noupdate -group {Memory Tile} -expand -group vnoc {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/vnoc_req_rdy_i}
add wave -noupdate -group {Memory Tile} -expand -group vnoc {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/vnoc_rsp_val_i}
add wave -noupdate -group {Memory Tile} -expand -group vnoc {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/vnoc_rsp_dat_i}
add wave -noupdate -group {Memory Tile} -expand -group vnoc {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/vnoc_rsp_hdr_i}
add wave -noupdate -group {Memory Tile} -expand -group vnoc {/cmp_top/system/chipset/chipset_impl/MT_TOP[0]/memtile_top_inst/mt/vnoc_rsp_rdy_o}
add wave -noupdate -expand -group {LVRF read-write manager} /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/RW_LOGIC/clk_i
add wave -noupdate -expand -group {LVRF read-write manager} /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/RW_LOGIC/rst_ni
add wave -noupdate -expand -group {LVRF read-write manager} /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/RW_LOGIC/depack_val_i
add wave -noupdate -expand -group {LVRF read-write manager} /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/RW_LOGIC/depack_hdr_i
add wave -noupdate -expand -group {LVRF read-write manager} /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/RW_LOGIC/depack_vec_data_i
add wave -noupdate -expand -group {LVRF read-write manager} /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/RW_LOGIC/depack_rdy_o
add wave -noupdate -expand -group {LVRF read-write manager} /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/RW_LOGIC/pck_tail_o
add wave -noupdate -expand -group {LVRF read-write manager} /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/RW_LOGIC/pack_rdy_i
add wave -noupdate -expand -group {LVRF read-write manager} /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/RW_LOGIC/pack_val_o
add wave -noupdate -expand -group {LVRF read-write manager} /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/RW_LOGIC/pack_last_flit_o
add wave -noupdate -expand -group {LVRF read-write manager} /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/RW_LOGIC/pack_hdr_o
add wave -noupdate -expand -group {LVRF read-write manager} /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/RW_LOGIC/pack_vec_data_o
add wave -noupdate -expand -group {LVRF read-write manager} /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/RW_LOGIC/lvrf_wr_en_o
add wave -noupdate -expand -group {LVRF read-write manager} /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/RW_LOGIC/lvrf_en_o
add wave -noupdate -expand -group {LVRF read-write manager} /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/RW_LOGIC/lvrf_addr_o
add wave -noupdate -expand -group {LVRF read-write manager} -subitemconfig {{/cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/RW_LOGIC/lvrf_data_o[1]} -expand {/cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/RW_LOGIC/lvrf_data_o[0]} -expand} /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/RW_LOGIC/lvrf_data_o
add wave -noupdate -expand -group {LVRF read-write manager} -expand -subitemconfig {{/cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/RW_LOGIC/lvrf_data_i[1]} -expand {/cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/RW_LOGIC/lvrf_data_i[0]} -expand} /cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/RW_LOGIC/lvrf_data_i
add wave -noupdate -group LVRF {/cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/LVRF_TOP/dut_mock_sp/ram_tdp_bank_gen[0]/ram_tdp_dword_gen[0]/ram_tdp_wpack_gen[0]/ram_tdp_inst/mem}
add wave -noupdate -group LVRF {/cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/LVRF_TOP/dut_mock_sp/ram_tdp_bank_gen[0]/ram_tdp_dword_gen[0]/ram_tdp_wpack_gen[1]/ram_tdp_inst/mem}
add wave -noupdate -group LVRF {/cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/LVRF_TOP/dut_mock_sp/ram_tdp_bank_gen[0]/ram_tdp_dword_gen[1]/ram_tdp_wpack_gen[0]/ram_tdp_inst/mem}
add wave -noupdate -group LVRF {/cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/LVRF_TOP/dut_mock_sp/ram_tdp_bank_gen[0]/ram_tdp_dword_gen[1]/ram_tdp_wpack_gen[1]/ram_tdp_inst/mem}
add wave -noupdate -group LVRF {/cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/LVRF_TOP/dut_mock_sp/ram_tdp_bank_gen[0]/ram_tdp_dword_gen[2]/ram_tdp_wpack_gen[0]/ram_tdp_inst/mem}
add wave -noupdate -group LVRF {/cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/LVRF_TOP/dut_mock_sp/ram_tdp_bank_gen[0]/ram_tdp_dword_gen[2]/ram_tdp_wpack_gen[1]/ram_tdp_inst/mem}
add wave -noupdate -group LVRF {/cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/LVRF_TOP/dut_mock_sp/ram_tdp_bank_gen[0]/ram_tdp_dword_gen[3]/ram_tdp_wpack_gen[0]/ram_tdp_inst/mem}
add wave -noupdate -group LVRF {/cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/LVRF_TOP/dut_mock_sp/ram_tdp_bank_gen[0]/ram_tdp_dword_gen[3]/ram_tdp_wpack_gen[1]/ram_tdp_inst/mem}
add wave -noupdate -group LVRF {/cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/LVRF_TOP/dut_mock_sp/ram_tdp_bank_gen[0]/ram_tdp_dword_gen[4]/ram_tdp_wpack_gen[0]/ram_tdp_inst/mem}
add wave -noupdate -group LVRF {/cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/LVRF_TOP/dut_mock_sp/ram_tdp_bank_gen[0]/ram_tdp_dword_gen[4]/ram_tdp_wpack_gen[1]/ram_tdp_inst/mem}
add wave -noupdate -group LVRF {/cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/LVRF_TOP/dut_mock_sp/ram_tdp_bank_gen[0]/ram_tdp_dword_gen[5]/ram_tdp_wpack_gen[0]/ram_tdp_inst/mem}
add wave -noupdate -group LVRF {/cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/LVRF_TOP/dut_mock_sp/ram_tdp_bank_gen[0]/ram_tdp_dword_gen[5]/ram_tdp_wpack_gen[1]/ram_tdp_inst/mem}
add wave -noupdate -group LVRF {/cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/LVRF_TOP/dut_mock_sp/ram_tdp_bank_gen[0]/ram_tdp_dword_gen[6]/ram_tdp_wpack_gen[0]/ram_tdp_inst/mem}
add wave -noupdate -group LVRF {/cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/LVRF_TOP/dut_mock_sp/ram_tdp_bank_gen[0]/ram_tdp_dword_gen[6]/ram_tdp_wpack_gen[1]/ram_tdp_inst/mem}
add wave -noupdate -group LVRF {/cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/LVRF_TOP/dut_mock_sp/ram_tdp_bank_gen[0]/ram_tdp_dword_gen[7]/ram_tdp_wpack_gen[0]/ram_tdp_inst/mem}
add wave -noupdate -group LVRF {/cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/LVRF_TOP/dut_mock_sp/ram_tdp_bank_gen[0]/ram_tdp_dword_gen[7]/ram_tdp_wpack_gen[1]/ram_tdp_inst/mem}
add wave -noupdate -group LVRF {/cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/LVRF_TOP/dut_mock_sp/ram_tdp_bank_gen[1]/ram_tdp_dword_gen[0]/ram_tdp_wpack_gen[0]/ram_tdp_inst/mem}
add wave -noupdate -group LVRF {/cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/LVRF_TOP/dut_mock_sp/ram_tdp_bank_gen[1]/ram_tdp_dword_gen[0]/ram_tdp_wpack_gen[1]/ram_tdp_inst/mem}
add wave -noupdate -group LVRF {/cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/LVRF_TOP/dut_mock_sp/ram_tdp_bank_gen[1]/ram_tdp_dword_gen[1]/ram_tdp_wpack_gen[0]/ram_tdp_inst/mem}
add wave -noupdate -group LVRF {/cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/LVRF_TOP/dut_mock_sp/ram_tdp_bank_gen[1]/ram_tdp_dword_gen[1]/ram_tdp_wpack_gen[1]/ram_tdp_inst/mem}
add wave -noupdate -group LVRF {/cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/LVRF_TOP/dut_mock_sp/ram_tdp_bank_gen[1]/ram_tdp_dword_gen[2]/ram_tdp_wpack_gen[0]/ram_tdp_inst/mem}
add wave -noupdate -group LVRF {/cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/LVRF_TOP/dut_mock_sp/ram_tdp_bank_gen[1]/ram_tdp_dword_gen[2]/ram_tdp_wpack_gen[1]/ram_tdp_inst/mem}
add wave -noupdate -group LVRF {/cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/LVRF_TOP/dut_mock_sp/ram_tdp_bank_gen[1]/ram_tdp_dword_gen[3]/ram_tdp_wpack_gen[0]/ram_tdp_inst/mem}
add wave -noupdate -group LVRF {/cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/LVRF_TOP/dut_mock_sp/ram_tdp_bank_gen[1]/ram_tdp_dword_gen[3]/ram_tdp_wpack_gen[1]/ram_tdp_inst/mem}
add wave -noupdate -group LVRF {/cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/LVRF_TOP/dut_mock_sp/ram_tdp_bank_gen[1]/ram_tdp_dword_gen[4]/ram_tdp_wpack_gen[0]/ram_tdp_inst/mem}
add wave -noupdate -group LVRF {/cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/LVRF_TOP/dut_mock_sp/ram_tdp_bank_gen[1]/ram_tdp_dword_gen[4]/ram_tdp_wpack_gen[1]/ram_tdp_inst/mem}
add wave -noupdate -group LVRF {/cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/LVRF_TOP/dut_mock_sp/ram_tdp_bank_gen[1]/ram_tdp_dword_gen[5]/ram_tdp_wpack_gen[0]/ram_tdp_inst/mem}
add wave -noupdate -group LVRF {/cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/LVRF_TOP/dut_mock_sp/ram_tdp_bank_gen[1]/ram_tdp_dword_gen[5]/ram_tdp_wpack_gen[1]/ram_tdp_inst/mem}
add wave -noupdate -group LVRF {/cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/LVRF_TOP/dut_mock_sp/ram_tdp_bank_gen[1]/ram_tdp_dword_gen[6]/ram_tdp_wpack_gen[0]/ram_tdp_inst/mem}
add wave -noupdate -group LVRF {/cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/LVRF_TOP/dut_mock_sp/ram_tdp_bank_gen[1]/ram_tdp_dword_gen[6]/ram_tdp_wpack_gen[1]/ram_tdp_inst/mem}
add wave -noupdate -group LVRF {/cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/LVRF_TOP/dut_mock_sp/ram_tdp_bank_gen[1]/ram_tdp_dword_gen[7]/ram_tdp_wpack_gen[0]/ram_tdp_inst/mem}
add wave -noupdate -group LVRF {/cmp_top/system/chip/tile0/g_lagarto_m20_core/core/lagarto_m20/lvrf_wrapper_inst/LVRF_TOP/dut_mock_sp/ram_tdp_bank_gen[1]/ram_tdp_dword_gen[7]/ram_tdp_wpack_gen[1]/ram_tdp_inst/mem}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{End vse} {318984881 ps} 1} {{Start vse} {318901500 ps} 1}
quietly wave cursor active 2
configure wave -namecolwidth 200
configure wave -valuecolwidth 359
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {318792273 ps} {319166465 ps}
