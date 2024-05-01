// Modified by Barcelona Supercomputing Center on March 3rd, 2022
// ========== Copyright Header Begin ============================================
// Copyright (c) 2017 Princeton University
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of Princeton University nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY PRINCETON UNIVERSITY "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL PRINCETON UNIVERSITY BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
// ========== Copyright Header End ============================================

//--------------------------------------------------
// Description:     Top level for FPGA MAC
// Author:          Alexey Lavrov
// Company:         Princeton University
// Created:         1/25/2017
//--------------------------------------------------

`ifdef  PITON_FPGA_ETH
`ifndef PITON_FPGA_ETHERNETLITE
`include "noc_axi4_bridge_define.vh"
`endif
`endif

module eth_top #(
  parameter SWAP_ENDIANESS = 0,
  parameter NUM_INTR       = 1
) (
    input                                   chipset_clk,

    input                                   rst_n,

    output      [NUM_INTR-1:0]              net_interrupt,

    input                                   noc_in_val,
    input       [`NOC_DATA_WIDTH-1:0]       noc_in_data,
    output                                  noc_in_rdy,

    output                                  noc_out_val,
    output      [`NOC_DATA_WIDTH-1:0]       noc_out_data,
    input                                   noc_out_rdy

`ifdef PITON_FPGA_ETHERNETLITE
                                            ,
    input                                   net_axi_clk,
    output                                  net_phy_rst_n,

    input                                   net_phy_tx_clk,
    output                                  net_phy_tx_en,
    output  [3 : 0]                         net_phy_tx_data,

    input                                   net_phy_rx_clk,
    input                                   net_phy_dv,
    input  [3 : 0]                          net_phy_rx_data,
    input                                   net_phy_rx_er,

    inout                                   net_phy_mdio_io,
    output                                  net_phy_mdc
`elsif PITON_FPGA_ETH_CMAC // PITON_FPGA_ETHERNETLITE
                   ,
    `ifndef PITONSYS_MEEP
    input          eth_init_clk,
    input          qsfp_ref_clk_n,
    input          qsfp_ref_clk_p,
    input   [3:0]  qsfp_4x_grx_n,
    input   [3:0]  qsfp_4x_grx_p,
    output  [3:0]  qsfp_4x_gtx_n,
    output  [3:0]  qsfp_4x_gtx_p
    `else         
	 // in PITONSYS_MEEP the CLK, RST, and interrupts are inputs to this core
     input                                net_axi_clk,
     input                                net_axi_arstn,	 	 	 
     input  [NUM_INTR-1:0]                unsync_net_int,
	 
	 `ifndef ETHERNET_DMA 
	 
     output [`AXI4_ID_WIDTH     -1:0]     core_axi_awid,
     output [`AXI4_ADDR_WIDTH   -1:0]     core_axi_awaddr,
     output [`AXI4_LEN_WIDTH    -1:0]     core_axi_awlen,
     output [`AXI4_SIZE_WIDTH   -1:0]     core_axi_awsize,
     output [`AXI4_BURST_WIDTH  -1:0]     core_axi_awburst,
     output                               core_axi_awlock,
     output [`AXI4_CACHE_WIDTH  -1:0]     core_axi_awcache,
     output [`AXI4_PROT_WIDTH   -1:0]     core_axi_awprot,
     output [`AXI4_QOS_WIDTH    -1:0]     core_axi_awqos,
     output  [`AXI4_REGION_WIDTH -1:0]    core_axi_awregion,
     output [`AXI4_USER_WIDTH   -1:0]     core_axi_awuser,
     output                               core_axi_awvalid,
     input                                core_axi_awready,

     output  [`AXI4_ID_WIDTH     -1:0]    core_axi_wid,
     output  [`AXI4_DATA_WIDTH   -1:0]    core_axi_wdata,
     output  [`AXI4_STRB_WIDTH   -1:0]    core_axi_wstrb,
     output                               core_axi_wlast,
     output  [`AXI4_USER_WIDTH   -1:0]    core_axi_wuser,
     output                               core_axi_wvalid,
     input                                core_axi_wready,
     
     output  [`AXI4_ID_WIDTH     -1:0]    core_axi_arid,
     output  [`AXI4_ADDR_WIDTH   -1:0]    core_axi_araddr,
     output  [`AXI4_LEN_WIDTH    -1:0]    core_axi_arlen,
     output  [`AXI4_SIZE_WIDTH   -1:0]    core_axi_arsize,
     output  [`AXI4_BURST_WIDTH  -1:0]    core_axi_arburst,
     output                               core_axi_arlock,
     output  [`AXI4_CACHE_WIDTH  -1:0]    core_axi_arcache,
     output  [`AXI4_PROT_WIDTH   -1:0]    core_axi_arprot,
     output  [`AXI4_QOS_WIDTH    -1:0]    core_axi_arqos,
     output  [`AXI4_REGION_WIDTH -1:0]    core_axi_arregion,
     output  [`AXI4_USER_WIDTH   -1:0]    core_axi_aruser,
     output                               core_axi_arvalid,
     input                                core_axi_arready,
     
     input   [`AXI4_ID_WIDTH     -1:0]    core_axi_rid,
     input   [`AXI4_DATA_WIDTH   -1:0]    core_axi_rdata,
     input   [`AXI4_RESP_WIDTH   -1:0]    core_axi_rresp,
     input                                core_axi_rlast,
     input   [`AXI4_USER_WIDTH   -1:0]    core_axi_ruser,
     input                                core_axi_rvalid,
     output                               core_axi_rready,
     
     input  [`AXI4_ID_WIDTH     -1:0]    core_axi_bid,
     input  [`AXI4_RESP_WIDTH   -1:0]    core_axi_bresp,
     input  [`AXI4_USER_WIDTH   -1:0]    core_axi_buser,
     input                               core_axi_bvalid,
     output                              core_axi_bready
     `else
     
     output [`C_M_AXI_LITE_ADDR_WIDTH-1:0]   dma_s_axi_awaddr,
     output                                  dma_s_axi_awvalid,
     input                                   dma_s_axi_awready,
                                      
     output [`C_M_AXI_LITE_DATA_WIDTH-1:0]   dma_s_axi_wdata,
     output [`C_M_AXI_LITE_DATA_WIDTH/8-1:0] dma_s_axi_wstrb,
     output                                  dma_s_axi_wvalid,
     input                                   dma_s_axi_wready,
                                      
     input  [`C_M_AXI_LITE_RESP_WIDTH-1:0]   dma_s_axi_bresp,
     input                                   dma_s_axi_bvalid,
     output                                  dma_s_axi_bready,
                                      
     output [`C_M_AXI_LITE_ADDR_WIDTH-1:0]   dma_s_axi_araddr,
     output                                  dma_s_axi_arvalid,
     input                                   dma_s_axi_arready,
                                      
     input  [`C_M_AXI_LITE_DATA_WIDTH-1:0]   dma_s_axi_rdata,
     input  [`C_M_AXI_LITE_RESP_WIDTH-1:0]   dma_s_axi_rresp,
     input                                   dma_s_axi_rvalid,
     output                                  dma_s_axi_rready
     
     `endif // ETHERNET DMA             
    `endif // PITONSYS_MEEP
`endif // PITON_FPGA_ETH_CMAC
);

`ifdef PITON_FPGA_ETH

// afifo <-> netbridge
wire                            afifo_netbridge_val;
wire    [`NOC_DATA_WIDTH-1:0]   afifo_netbridge_data;
wire                            netbridge_afifo_rdy;

wire                            netbridge_afifo_val;
wire    [`NOC_DATA_WIDTH-1:0]   netbridge_afifo_data;
wire                            fifo_netbridge_rdy;

// netbridge <-> mac axi
`ifdef PITON_FPGA_ETHERNETLITE
wire [`C_M_AXI_LITE_ADDR_WIDTH-1:0]   net_s_axi_awaddr;
wire                            net_s_axi_awvalid;
wire                            net_s_axi_awready;

wire [`C_M_AXI_LITE_DATA_WIDTH-1:0]   net_s_axi_wdata;
wire [`C_M_AXI_LITE_DATA_WIDTH/8-1:0] net_s_axi_wstrb;
wire                            net_s_axi_wvalid;
wire                            net_s_axi_wready;

wire [`C_M_AXI_LITE_RESP_WIDTH-1:0]   net_s_axi_bresp;
wire                            net_s_axi_bvalid;
wire                            net_s_axi_bready;

wire [`C_M_AXI_LITE_ADDR_WIDTH-1:0]   net_s_axi_araddr;
wire                            net_s_axi_arvalid;
wire                            net_s_axi_arready;

wire [`C_M_AXI_LITE_DATA_WIDTH-1:0]   net_s_axi_rdata;
wire [`C_M_AXI_LITE_RESP_WIDTH-1:0]   net_s_axi_rresp;
wire                            net_s_axi_rvalid;
wire                            net_s_axi_rready;

// MDIO
wire                            net_phy_mdio_i;
wire                            net_phy_mdio_o;
wire                            net_phy_mdio_t;

wire net_phy_crs = 1'b0;
wire net_phy_col = 1'b0;

wire net_axi_arstn = rst_n;
(* dont_touch = "true" *) wire unsync_net_int;

`else // PITON_FPGA_ETHERNETLITE, full AXI4 for rest Eth cores
 `ifndef PITONSYS_MEEP
wire [`AXI4_ID_WIDTH     -1:0]     core_axi_awid;
wire [`AXI4_ADDR_WIDTH   -1:0]     core_axi_awaddr;
wire [`AXI4_LEN_WIDTH    -1:0]     core_axi_awlen;
wire [`AXI4_SIZE_WIDTH   -1:0]     core_axi_awsize;
wire [`AXI4_BURST_WIDTH  -1:0]     core_axi_awburst;
wire                               core_axi_awlock;
wire [`AXI4_CACHE_WIDTH  -1:0]     core_axi_awcache;
wire [`AXI4_PROT_WIDTH   -1:0]     core_axi_awprot;
wire [`AXI4_QOS_WIDTH    -1:0]     core_axi_awqos;
wire [`AXI4_REGION_WIDTH -1:0]     core_axi_awregion;
wire [`AXI4_USER_WIDTH   -1:0]     core_axi_awuser;
wire                               core_axi_awvalid;
wire                               core_axi_awready;

wire  [`AXI4_ID_WIDTH     -1:0]    core_axi_wid;
wire  [`AXI4_DATA_WIDTH   -1:0]    core_axi_wdata;
wire  [`AXI4_STRB_WIDTH   -1:0]    core_axi_wstrb;
wire                               core_axi_wlast;
wire  [`AXI4_USER_WIDTH   -1:0]    core_axi_wuser;
wire                               core_axi_wvalid;
wire                               core_axi_wready;

wire  [`AXI4_ID_WIDTH     -1:0]    core_axi_arid;
wire  [`AXI4_ADDR_WIDTH   -1:0]    core_axi_araddr;
wire  [`AXI4_LEN_WIDTH    -1:0]    core_axi_arlen;
wire  [`AXI4_SIZE_WIDTH   -1:0]    core_axi_arsize;
wire  [`AXI4_BURST_WIDTH  -1:0]    core_axi_arburst;
wire                               core_axi_arlock;
wire  [`AXI4_CACHE_WIDTH  -1:0]    core_axi_arcache;
wire  [`AXI4_PROT_WIDTH   -1:0]    core_axi_arprot;
wire  [`AXI4_QOS_WIDTH    -1:0]    core_axi_arqos;
wire  [`AXI4_REGION_WIDTH -1:0]    core_axi_arregion;
wire  [`AXI4_USER_WIDTH   -1:0]    core_axi_aruser;
wire                               core_axi_arvalid;
wire                               core_axi_arready;

wire  [`AXI4_ID_WIDTH     -1:0]    core_axi_rid;
wire  [`AXI4_DATA_WIDTH   -1:0]    core_axi_rdata;
wire  [`AXI4_RESP_WIDTH   -1:0]    core_axi_rresp;
wire                               core_axi_rlast;
wire  [`AXI4_USER_WIDTH   -1:0]    core_axi_ruser;
wire                               core_axi_rvalid;
wire                               core_axi_rready;

wire  [`AXI4_ID_WIDTH     -1:0]    core_axi_bid;
wire  [`AXI4_RESP_WIDTH   -1:0]    core_axi_bresp;
wire  [`AXI4_USER_WIDTH   -1:0]    core_axi_buser;
wire                               core_axi_bvalid;
wire                               core_axi_bready;

wire                               net_axi_clk   = chipset_clk;
wire                               net_axi_arstn = rst_n;
wire  [NUM_INTR-1:0]               unsync_net_int;
 `endif
`endif


`ifndef PITON_FPGA_ETH_CMAC
`ifndef PITON_FPGA_ETHERNETLITE
  `define NO_ETH_CORE
`endif
`endif

`ifndef NO_ETH_CORE
noc_bidir_afifo  net_afifo  (
    .clk_1           (chipset_clk           ),
    .rst_1           (~rst_n                ),

    .clk_2           (net_axi_clk           ),
    .rst_2           (~net_axi_arstn        ),

    // CPU --> EMACLITE
    .flit_in_val_1   (noc_in_val      ),
    .flit_in_data_1  (noc_in_data     ),
    .flit_in_rdy_1   (noc_in_rdy      ),

    .flit_out_val_2  (afifo_netbridge_val   ),
    .flit_out_data_2 (afifo_netbridge_data  ),
    .flit_out_rdy_2  (netbridge_afifo_rdy   ),

    // EMACLITE --> CPU
    .flit_in_val_2   (netbridge_afifo_val   ),
    .flit_in_data_2  (netbridge_afifo_data  ),
    .flit_in_rdy_2   (afifo_netbridge_rdy   ),

    .flit_out_val_1  (noc_out_val      ),
    .flit_out_data_1 (noc_out_data     ),
    .flit_out_rdy_1  (noc_out_rdy      )
);
`else // NO_ETH_CORE
	// NO ETHERNET CORE
  assign afifo_netbridge_val  = noc_in_val;
  assign afifo_netbridge_data = noc_in_data;
  assign noc_in_rdy = netbridge_afifo_rdy;

  assign noc_out_val  = netbridge_afifo_val;
  assign noc_out_data = netbridge_afifo_data;
  assign afifo_netbridge_rdy = noc_out_rdy;
`endif

`ifdef PITON_FPGA_ETHERNETLITE
noc_axilite_bridge #(
    .SLAVE_RESP_BYTEWIDTH   (4),
    .SWAP_ENDIANESS         (SWAP_ENDIANESS)
) noc_ethernet_bridge (
    .clk                    (net_axi_clk        ),
    .rst                    (~rst_n             ),      // TODO: rewrite to positive ?

    .splitter_bridge_val    (afifo_netbridge_val   ),
    .splitter_bridge_data   (afifo_netbridge_data  ),
    .bridge_splitter_rdy    (netbridge_afifo_rdy   ),   // CRAZY NAMING !

    .bridge_splitter_val    (netbridge_afifo_val   ),
    .bridge_splitter_data   (netbridge_afifo_data  ),
    .splitter_bridge_rdy    (afifo_netbridge_rdy   ),   // CRAZY NAMING !

    //axi lite signals
    //write address channel
    .m_axi_awaddr        (net_s_axi_awaddr),
    .m_axi_awvalid       (net_s_axi_awvalid),
    .m_axi_awready       (net_s_axi_awready),

    //write data channel
    .m_axi_wdata         (net_s_axi_wdata),
    .m_axi_wstrb         (net_s_axi_wstrb),
    .m_axi_wvalid        (net_s_axi_wvalid),
    .m_axi_wready        (net_s_axi_wready),

    //read address channel
    .m_axi_araddr        (net_s_axi_araddr),
    .m_axi_arvalid       (net_s_axi_arvalid),
    .m_axi_arready       (net_s_axi_arready),

    //read data channel
    .m_axi_rdata         (net_s_axi_rdata),
    .m_axi_rresp         (net_s_axi_rresp),
    .m_axi_rvalid        (net_s_axi_rvalid),
    .m_axi_rready        (net_s_axi_rready),

    //write response channel
    .m_axi_bresp         (net_s_axi_bresp),
    .m_axi_bvalid        (net_s_axi_bvalid),
    .m_axi_bready        (net_s_axi_bready)
);

`elsif ETHERNET_DMA

noc_axilite_bridge #(
    .SLAVE_RESP_BYTEWIDTH   (0),
    .SWAP_ENDIANESS         (SWAP_ENDIANESS)
) noc_ethernet_bridge (
    .clk                    (net_axi_clk           ),
    .rst                    (~net_axi_arstn        ),      // TODO: rewrite to positive ?

    .splitter_bridge_val    (afifo_netbridge_val   ),
    .splitter_bridge_data   (afifo_netbridge_data  ),
    .bridge_splitter_rdy    (netbridge_afifo_rdy   ),   // CRAZY NAMING !

    .bridge_splitter_val    (netbridge_afifo_val   ),
    .bridge_splitter_data   (netbridge_afifo_data  ),
    .splitter_bridge_rdy    (afifo_netbridge_rdy   ),   // CRAZY NAMING !

    //axi lite signals
    //write address channel
    .m_axi_awaddr        (dma_s_axi_awaddr),
    .m_axi_awvalid       (dma_s_axi_awvalid),
    .m_axi_awready       (dma_s_axi_awready),
                          
    //write data channel 
    .m_axi_wdata         (dma_s_axi_wdata),
    .m_axi_wstrb         (dma_s_axi_wstrb),
    .m_axi_wvalid        (dma_s_axi_wvalid),
    .m_axi_wready        (dma_s_axi_wready),

    //read address channel
    .m_axi_araddr        (dma_s_axi_araddr),
    .m_axi_arvalid       (dma_s_axi_arvalid),
    .m_axi_arready       (dma_s_axi_arready),
                          
    //read data channel  
    .m_axi_rdata         (dma_s_axi_rdata),
    .m_axi_rresp         (dma_s_axi_rresp),
    .m_axi_rvalid        (dma_s_axi_rvalid),
    .m_axi_rready        (dma_s_axi_rready),

    //write response channel
    .m_axi_bresp         (dma_s_axi_bresp),
    .m_axi_bvalid        (dma_s_axi_bvalid),
    .m_axi_bready        (dma_s_axi_bready)
);

`else // PITON_FPGA_ETHERNETLITE, full AXI4 for rest Eth cores
noc_axi4_bridge #(
    .SWAP_ENDIANESS (SWAP_ENDIANESS)
) noc_ethernet_bridge (
    .clk                (net_axi_clk     ),  
    .rst_n              (net_axi_arstn   ), 
    .uart_boot_en       (1'b0       ),
    .phy_init_done      (1'b1       ),

    .src_bridge_vr_noc2_val(afifo_netbridge_val ),
    .src_bridge_vr_noc2_dat(afifo_netbridge_data),
    .src_bridge_vr_noc2_rdy(netbridge_afifo_rdy ),

    .bridge_dst_vr_noc3_val(netbridge_afifo_val ),
    .bridge_dst_vr_noc3_dat(netbridge_afifo_data),
    .bridge_dst_vr_noc3_rdy(afifo_netbridge_rdy ),

    .m_axi_awid(core_axi_awid),
    .m_axi_awaddr(core_axi_awaddr),
    .m_axi_awlen(core_axi_awlen),
    .m_axi_awsize(core_axi_awsize),
    .m_axi_awburst(core_axi_awburst),
    .m_axi_awlock(core_axi_awlock),
    .m_axi_awcache(core_axi_awcache),
    .m_axi_awprot(core_axi_awprot),
    .m_axi_awqos(core_axi_awqos),
    .m_axi_awregion(core_axi_awregion),
    .m_axi_awuser(core_axi_awuser),
    .m_axi_awvalid(core_axi_awvalid),
    .m_axi_awready(core_axi_awready),

    .m_axi_wid(core_axi_wid),
    .m_axi_wdata(core_axi_wdata),
    .m_axi_wstrb(core_axi_wstrb),
    .m_axi_wlast(core_axi_wlast),
    .m_axi_wuser(core_axi_wuser),
    .m_axi_wvalid(core_axi_wvalid),
    .m_axi_wready(core_axi_wready),

    .m_axi_bid(core_axi_bid),
    .m_axi_bresp(core_axi_bresp),
    .m_axi_buser(core_axi_buser),
    .m_axi_bvalid(core_axi_bvalid),
    .m_axi_bready(core_axi_bready),

    .m_axi_arid(core_axi_arid),
    .m_axi_araddr(core_axi_araddr),
    .m_axi_arlen(core_axi_arlen),
    .m_axi_arsize(core_axi_arsize),
    .m_axi_arburst(core_axi_arburst),
    .m_axi_arlock(core_axi_arlock),
    .m_axi_arcache(core_axi_arcache),
    .m_axi_arprot(core_axi_arprot),
    .m_axi_arqos(core_axi_arqos),
    .m_axi_arregion(core_axi_arregion),
    .m_axi_aruser(core_axi_aruser),
    .m_axi_arvalid(core_axi_arvalid),
    .m_axi_arready(core_axi_arready),

    .m_axi_rid(core_axi_rid),
    .m_axi_rdata(core_axi_rdata),
    .m_axi_rresp(core_axi_rresp),
    .m_axi_rlast(core_axi_rlast),
    .m_axi_ruser(core_axi_ruser),
    .m_axi_rvalid(core_axi_rvalid),
    .m_axi_rready(core_axi_rready)
);
`endif

generate
genvar idx;
for(idx=0; idx<NUM_INTR; idx=idx+1) begin: irq_sync
net_int_sync net_int_sync(
  .clk_emac(net_axi_clk),
  .clk_ciop(chipset_clk),
  .rst_n(rst_n),
  .net_int(unsync_net_int[idx]),
  .sync_int(net_interrupt[idx])
);
end
endgenerate

`ifdef PITON_FPGA_ETHERNETLITE

mac_eth_axi_lite mac_eth_axi_lite (
  .s_axi_aclk       (net_axi_clk),       // input wire s_axi_aclk
  .s_axi_aresetn    (rst_n),    // input wire s_axi_aresetn
  .ip2intc_irpt     (unsync_net_int),     // output wire ip2intc_irpt
  .s_axi_awaddr     (net_s_axi_awaddr),     // input wire [12 : 0] s_axi_awaddr
  .s_axi_awvalid    (net_s_axi_awvalid),    // input wire s_axi_awvalid
  .s_axi_awready    (net_s_axi_awready),    // output wire s_axi_awready
  .s_axi_wdata      (net_s_axi_wdata),      // input wire [31 : 0] s_axi_wdata
  .s_axi_wstrb      (net_s_axi_wstrb),      // input wire [3 : 0] s_axi_wstrb
  .s_axi_wvalid     (net_s_axi_wvalid),     // input wire s_axi_wvalid
  .s_axi_wready     (net_s_axi_wready),     // output wire s_axi_wready
  .s_axi_bresp      (net_s_axi_bresp),      // output wire [1 : 0] s_axi_bresp
  .s_axi_bvalid     (net_s_axi_bvalid),     // output wire s_axi_bvalid
  .s_axi_bready     (net_s_axi_bready),     // input wire s_axi_bready
  .s_axi_araddr     (net_s_axi_araddr),     // input wire [12 : 0] s_axi_araddr
  .s_axi_arvalid    (net_s_axi_arvalid),    // input wire s_axi_arvalid
  .s_axi_arready    (net_s_axi_arready),    // output wire s_axi_arready
  .s_axi_rdata      (net_s_axi_rdata),      // output wire [31 : 0] s_axi_rdata
  .s_axi_rresp      (net_s_axi_rresp),      // output wire [1 : 0] s_axi_rresp
  .s_axi_rvalid     (net_s_axi_rvalid),     // output wire s_axi_rvalid
  .s_axi_rready     (net_s_axi_rready),     // input wire s_axi_rready

  .phy_rst_n        (net_phy_rst_n),        // output wire phy_rst_n

  .phy_tx_clk       (net_phy_tx_clk),       // input wire phy_tx_clk
  .phy_tx_en        (net_phy_tx_en),        // output wire phy_tx_en
  .phy_tx_data      (net_phy_tx_data),      // output wire [3 : 0] phy_tx_data

  .phy_rx_clk       (net_phy_rx_clk),       // input wire phy_rx_clk
  .phy_dv           (net_phy_dv),           // input wire phy_dv
  .phy_rx_data      (net_phy_rx_data),      // input wire [3 : 0] phy_rx_data
  .phy_rx_er        (net_phy_rx_er),        // input wire phy_rx_er

  .phy_crs          (net_phy_crs),          // input wire phy_crs
  .phy_col          (net_phy_col),          // input wire phy_col

  .phy_mdio_i       (net_phy_mdio_i),       // input wire phy_mdio_i
  .phy_mdio_o       (net_phy_mdio_o),       // output wire phy_mdio_o
  .phy_mdio_t       (net_phy_mdio_t),       // output wire phy_mdio_t
  .phy_mdc          (net_phy_mdc)           // output wire phy_mdc
);

// Tri-state buffer
IOBUF u_iobuf_dq (
    .I  (net_phy_mdio_o),
    .O  (net_phy_mdio_i),
    .T  (net_phy_mdio_t),
    .IO (net_phy_mdio_io)
);

`elsif PITON_FPGA_ETH_CMAC // PITON_FPGA_ETHERNETLITE
`ifndef PITONSYS_MEEP
Eth_CMAC_syst eth_cmac_syst (
  .s_axi_clk        (net_axi_clk),          // input wire s_axi_aclk
  .s_axi_resetn     (net_axi_arstn),        // input wire s_axi_aresetn

  .s_axi_awaddr     (core_axi_awaddr),      // input wire s_axi_awaddr
  .s_axi_awvalid    (core_axi_awvalid),     // input wire s_axi_awvalid
  .s_axi_awready    (core_axi_awready),     // output wire s_axi_awready
  .s_axi_wdata      (core_axi_wdata),       // input wire s_axi_wdata
  .s_axi_wstrb      (core_axi_wstrb),       // input wire s_axi_wstrb
  .s_axi_wvalid     (core_axi_wvalid),      // input wire s_axi_wvalid
  .s_axi_wready     (core_axi_wready),      // output wire s_axi_wready
  .s_axi_bresp      (core_axi_bresp),       // output wire s_axi_bresp
  .s_axi_bvalid     (core_axi_bvalid),      // output wire s_axi_bvalid
  .s_axi_bready     (core_axi_bready),      // input wire s_axi_bready
  .s_axi_araddr     (core_axi_araddr),      // input wire s_axi_araddr
  .s_axi_arvalid    (core_axi_arvalid),     // input wire s_axi_arvalid
  .s_axi_arready    (core_axi_arready),     // output wire s_axi_arready
  .s_axi_rdata      (core_axi_rdata),       // output wire s_axi_rdata
  .s_axi_rresp      (core_axi_rresp),       // output wire s_axi_rresp
  .s_axi_rvalid     (core_axi_rvalid),      // output wire s_axi_rvalid
  .s_axi_rready     (core_axi_rready),      // input wire s_axi_rready
  .s_axi_arprot     (core_axi_arprot),      // input read  access permissions
  .s_axi_awprot     (core_axi_awprot),      // input write access permissions

  .s_axi_arburst    (core_axi_arburst),
  .s_axi_arcache    (core_axi_arcache),
  .s_axi_arlen      (core_axi_arlen),
  .s_axi_arlock     (core_axi_arlock),
  .s_axi_arqos      (core_axi_arqos),
  .s_axi_arsize     (core_axi_arsize),
  .s_axi_awburst    (core_axi_awburst),
  .s_axi_awcache    (core_axi_awcache),
  .s_axi_awlen      (core_axi_awlen),
  .s_axi_awlock     (core_axi_awlock),
  .s_axi_awqos      (core_axi_awqos),
  .s_axi_awsize     (core_axi_awsize),
  .s_axi_rlast      (core_axi_rlast),
  .s_axi_wlast      (core_axi_wlast),

  .s_axi_arid       (core_axi_arid),
  .s_axi_awid       (core_axi_awid),
  .s_axi_rid        (core_axi_rid),
  .s_axi_bid        (core_axi_bid),
  // .s_axi_wid        (core_axi_wid),
  // .s_axi_awuser     (core_axi_awuser),
  // .s_axi_aruser     (core_axi_aruser),
  // .s_axi_buser      (core_axi_buser),
  // .s_axi_ruser      (core_axi_ruser),
  // .s_axi_wuser      (core_axi_wuser),
  // .s_axi_awregion   (core_axi_awregion),
  // .s_axi_arregion   (core_axi_arregion),

  .intc               (unsync_net_int), // output interrupts (0-tx, 1-rx)

  .init_clk           (eth_init_clk),   // free-running clock required for Xilinx CMAC initialization in range 50...250 MHz
  .qsfp_refck_clk_n   (qsfp_ref_clk_n),
  .qsfp_refck_clk_p   (qsfp_ref_clk_p),
  .qsfp_4x_grx_n      (qsfp_4x_grx_n),
  .qsfp_4x_grx_p      (qsfp_4x_grx_p),
  .qsfp_4x_gtx_n      (qsfp_4x_gtx_n),
  .qsfp_4x_gtx_p      (qsfp_4x_gtx_p)
);

assign core_axi_ruser  = `AXI4_USER_WIDTH'h0;
assign core_axi_buser  = `AXI4_USER_WIDTH'h0;

`endif

`else // PITON_FPGA_ETH_CMAC
  // Ethernet core stub for simulation
  assign core_axi_awready = 1'b1;
  assign core_axi_wready  = 1'b1;
  assign core_axi_arready = 1'b1;

  reg core_axi_rvalid_reg;
  reg [`AXI4_ID_WIDTH-1:0] core_axi_rid_reg;
  always @(posedge net_axi_clk) begin
    if (~net_axi_arstn) begin
      core_axi_rvalid_reg <= 1'b0;
      core_axi_rid_reg <= `AXI4_ID_WIDTH'h0;
    end
    else if (core_axi_arvalid) begin 
      core_axi_rvalid_reg <= 1'b1;
      core_axi_rid_reg <= core_axi_arid;
    end
    else if (core_axi_rready) core_axi_rvalid_reg <= 1'b0;
  end
  assign core_axi_rvalid = core_axi_rvalid_reg;
  assign core_axi_rid    = core_axi_rid_reg;
  assign core_axi_rdata  = {(`AXI4_DATA_WIDTH/64/2+1){64'hDEADBEEFFEEDC0DE}};
  assign core_axi_rresp  = 2'h0;
  assign core_axi_rlast  = core_axi_rvalid;
  assign core_axi_ruser  = `AXI4_USER_WIDTH'h0;

  reg core_axi_bvalid_reg;
  reg [`AXI4_ID_WIDTH-1:0] core_axi_bid_reg;
  always @(posedge net_axi_clk) begin
    if (~net_axi_arstn) begin 
      core_axi_bvalid_reg <= 1'b0;
      core_axi_bid_reg <= `AXI4_ID_WIDTH'h0;
    end
    else if (core_axi_wvalid & core_axi_wlast) begin
      core_axi_bvalid_reg <= 1'b1;
      core_axi_bid_reg <= core_axi_wid;
    end
    else if (core_axi_bready) core_axi_bvalid_reg <= 1'b0;
  end
  assign core_axi_bvalid  = core_axi_bvalid_reg;
  assign core_axi_bid     = core_axi_bid_reg;
  assign core_axi_bresp   = 2'h0;
  assign core_axi_buser   = `AXI4_USER_WIDTH'h0;

  assign unsync_net_int = {NUM_INTR{1'h0}};
`endif

`else  // PITON_FPGA_ETH

    assign noc_in_rdy    = 1'b0;
    assign noc_out_val    = 1'b0;
    assign noc_out_data   = {`NOC_DATA_WIDTH{1'b0}};

    assign net_phy_tx_en        = 1'b0;
    assign net_phy_mdc          = 1'b0;

    assign net_interrupt = {NUM_INTR{1'h0}};

`endif  // PITON_FPGA_ETH

endmodule
