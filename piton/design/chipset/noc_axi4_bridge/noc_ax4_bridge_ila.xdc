# ------------------------------------------------------------------------
# The current probe widths are for the case of 2x2 core tiles and RDWR_INORDER = 0
#
# Debug property should be added accordingly to Verilog sources for each of probed below signals:
# (* keep="TRUE" *) (* mark_debug="TRUE" *) input  deser_val,
#

create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 2048 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list chipset/clk_mmcm/inst/chipset_clk]]

set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 1                [get_debug_ports u_ila_0/probe0]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 1                [get_debug_ports u_ila_0/probe1]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 1                [get_debug_ports u_ila_0/probe2]

create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 1                [get_debug_ports u_ila_0/probe3]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 1                [get_debug_ports u_ila_0/probe4]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 1                [get_debug_ports u_ila_0/probe5]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 1                [get_debug_ports u_ila_0/probe6]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 1                [get_debug_ports u_ila_0/probe7]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 1                [get_debug_ports u_ila_0/probe8]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 1                [get_debug_ports u_ila_0/probe9]

create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
set_property port_width 1                [get_debug_ports u_ila_0/probe10]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
set_property port_width 1                [get_debug_ports u_ila_0/probe11]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe12]
set_property port_width 6                [get_debug_ports u_ila_0/probe12]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe13]
set_property port_width 1                [get_debug_ports u_ila_0/probe13]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe14]
set_property port_width 1                [get_debug_ports u_ila_0/probe14]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe15]
set_property port_width 6                [get_debug_ports u_ila_0/probe15]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe16]
set_property port_width 1                [get_debug_ports u_ila_0/probe16]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe17]
set_property port_width 1                [get_debug_ports u_ila_0/probe17]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe18]
set_property port_width 6                [get_debug_ports u_ila_0/probe18]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe19]
set_property port_width 1                [get_debug_ports u_ila_0/probe19]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe20]
set_property port_width 1                [get_debug_ports u_ila_0/probe20]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe21]
set_property port_width 6                [get_debug_ports u_ila_0/probe21]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe22]
set_property port_width 1                [get_debug_ports u_ila_0/probe22]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe23]
set_property port_width 1                [get_debug_ports u_ila_0/probe23]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe24]
set_property port_width 1                [get_debug_ports u_ila_0/probe24]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe25]
set_property port_width 1                [get_debug_ports u_ila_0/probe25]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe26]
set_property port_width 1                [get_debug_ports u_ila_0/probe26]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe27]
set_property port_width 1                [get_debug_ports u_ila_0/probe27]

create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe28]
set_property port_width 1                [get_debug_ports u_ila_0/probe28]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe29]
set_property port_width 1                [get_debug_ports u_ila_0/probe29]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe30]
set_property port_width 1                [get_debug_ports u_ila_0/probe30]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe31]
set_property port_width 1                [get_debug_ports u_ila_0/probe31]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe32]
set_property port_width 1                [get_debug_ports u_ila_0/probe32]

create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe33]
set_property port_width 8                [get_debug_ports u_ila_0/probe33]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe34]
set_property port_width 8                [get_debug_ports u_ila_0/probe34]

create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe35]
set_property port_width 3                [get_debug_ports u_ila_0/probe35]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe36]
set_property port_width 3                [get_debug_ports u_ila_0/probe36]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe37]
set_property port_width 3                [get_debug_ports u_ila_0/probe37]

create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe38]
set_property port_width 4                [get_debug_ports u_ila_0/probe38]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe39]
set_property port_width 4                [get_debug_ports u_ila_0/probe39]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe40]
set_property port_width 4                [get_debug_ports u_ila_0/probe40]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe41]
set_property port_width 4                [get_debug_ports u_ila_0/probe41]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe42]
set_property port_width 4                [get_debug_ports u_ila_0/probe42]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe43]
set_property port_width 4                [get_debug_ports u_ila_0/probe43]

create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe44]
set_property port_width 197              [get_debug_ports u_ila_0/probe44]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe45]
set_property port_width 197              [get_debug_ports u_ila_0/probe45]

create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe46]
set_property port_width 1                [get_debug_ports u_ila_0/probe46]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe47]
set_property port_width 1                [get_debug_ports u_ila_0/probe47]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe48]
set_property port_width 1                [get_debug_ports u_ila_0/probe48]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe49]
set_property port_width 1                [get_debug_ports u_ila_0/probe49]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe50]
set_property port_width 1                [get_debug_ports u_ila_0/probe50]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe51]
set_property port_width 1                [get_debug_ports u_ila_0/probe51]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe52]
set_property port_width 1                [get_debug_ports u_ila_0/probe52]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe53]
set_property port_width 1                [get_debug_ports u_ila_0/probe53]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe54]
set_property port_width 1                [get_debug_ports u_ila_0/probe54]

create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe55]
set_property port_width 6                [get_debug_ports u_ila_0/probe55]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe56]
set_property port_width 7                [get_debug_ports u_ila_0/probe56]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe57]
set_property port_width 6                [get_debug_ports u_ila_0/probe57]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe58]
set_property port_width 7                [get_debug_ports u_ila_0/probe58]

create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe59]
set_property port_width 8                [get_debug_ports u_ila_0/probe59]

create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe60]
set_property port_width 1                [get_debug_ports u_ila_0/probe60]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe61]
set_property port_width 1                [get_debug_ports u_ila_0/probe61]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe62]
set_property port_width 1                [get_debug_ports u_ila_0/probe62]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe63]
set_property port_width 1                [get_debug_ports u_ila_0/probe63]

connect_debug_port u_ila_0/probe0  chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_read/m_axi_arvalid
connect_debug_port u_ila_0/probe1  chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_read/m_axi_arready
connect_debug_port u_ila_0/probe2  chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_read/m_axi_rvalid
connect_debug_port u_ila_0/probe3  chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_read/m_axi_rready

connect_debug_port u_ila_0/probe4  chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_write/m_axi_awvalid
connect_debug_port u_ila_0/probe5  chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_write/m_axi_awready
connect_debug_port u_ila_0/probe6  chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_write/m_axi_wvalid
connect_debug_port u_ila_0/probe7  chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_write/m_axi_wready
connect_debug_port u_ila_0/probe8  chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_write/m_axi_bvalid
connect_debug_port u_ila_0/probe9  chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_write/m_axi_bready

connect_debug_port u_ila_0/probe10  chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/deser_val
connect_debug_port u_ila_0/probe11  chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/deser_rdy
connect_debug_port u_ila_0/probe12  chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/read_req_id
connect_debug_port u_ila_0/probe13  chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/read_req_val
connect_debug_port u_ila_0/probe14  chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/read_req_rdy
connect_debug_port u_ila_0/probe15  chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/read_resp_id
connect_debug_port u_ila_0/probe16  chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/read_resp_val
connect_debug_port u_ila_0/probe17  chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/read_resp_rdy
connect_debug_port u_ila_0/probe18  chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/write_req_id
connect_debug_port u_ila_0/probe19  chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/write_req_val
connect_debug_port u_ila_0/probe20  chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/write_req_rdy
connect_debug_port u_ila_0/probe21  chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/write_resp_id
connect_debug_port u_ila_0/probe22  chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/write_resp_val
connect_debug_port u_ila_0/probe23  chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/write_resp_rdy
connect_debug_port u_ila_0/probe24 chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/ser_val
connect_debug_port u_ila_0/probe25 chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/ser_rdy
connect_debug_port u_ila_0/probe26 chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/fifo_in
connect_debug_port u_ila_0/probe27 chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/fifo_out

connect_debug_port u_ila_0/probe28 chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/deser_go
connect_debug_port u_ila_0/probe29 chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/read_req_go
connect_debug_port u_ila_0/probe30 chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/write_req_go
connect_debug_port u_ila_0/probe31 chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/req_go
connect_debug_port u_ila_0/probe32 chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/ser_go

connect_debug_port u_ila_0/probe33 chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/outstnd_vrt_empts
connect_debug_port u_ila_0/probe34 chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/outstnd_abs_rdptrs_val
connect_debug_port u_ila_0/probe35 chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/full_resp_id
connect_debug_port u_ila_0/probe36 chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/full_req_id
connect_debug_port u_ila_0/probe37 chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/full_stor_id
connect_debug_port u_ila_0/probe38 chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/outstnd_abs_rdptr
connect_debug_port u_ila_0/probe39 chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/outstnd_abs_wrptr
connect_debug_port u_ila_0/probe40 chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/outstnd_abs_wrptr_mem
connect_debug_port u_ila_0/probe41 chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/outstnd_vrt_rdptr
connect_debug_port u_ila_0/probe42 chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/outstnd_abs_rdptr_mem
connect_debug_port u_ila_0/probe43 chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/outstnd_vrt_wrptr
connect_debug_port u_ila_0/probe44 chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/clean_header
connect_debug_port u_ila_0/probe45 chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/stor_header
connect_debug_port u_ila_0/probe46 chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/init_outstnd_mem
connect_debug_port u_ila_0/probe47 chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/outstnd_abs_rdptr_val
connect_debug_port u_ila_0/probe48 chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/outstnd_vrt_empt
connect_debug_port u_ila_0/probe49 chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/outstnd_vrt_rdptr_val
connect_debug_port u_ila_0/probe50 chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/req_occup
connect_debug_port u_ila_0/probe51 chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/resp_val
connect_debug_port u_ila_0/probe52 chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/outstnd_abs_rdptr_val_act
connect_debug_port u_ila_0/probe53 chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/stor_hdr_val
connect_debug_port u_ila_0/probe54 chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/stor_hdr_en
connect_debug_port u_ila_0/probe55 chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/rd_offset
connect_debug_port u_ila_0/probe56 chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/rd_size
connect_debug_port u_ila_0/probe57 chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/wr_offset
connect_debug_port u_ila_0/probe58 chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/wr_size

connect_debug_port u_ila_0/probe59 chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/outstnd_command
connect_debug_port u_ila_0/probe60 chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/read_resp_val_act
connect_debug_port u_ila_0/probe61 chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/write_resp_val_act
connect_debug_port u_ila_0/probe62 chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/req_val
connect_debug_port u_ila_0/probe63 chipset/chipset_impl/mc_top/noc_axi4_bridge/noc_axi4_bridge_buffer/axi_id_deadlock

set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets clk]