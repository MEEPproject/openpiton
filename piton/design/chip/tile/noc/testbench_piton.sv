// synthesis translate_off
`timescale   1ns/1ns


module testbench_piton;
	
	import pronoc_pkg::*; 
	`define INCLUDE_SIM_PARAM
	`include "sim_param.sv" //will be generated by ProNoC GUI
	// simulation parameter setting
	// injected packet class percentage
	localparam 
		C0_p=100,
		C1_p=0,
		C2_p=0,
		C3_p=0;
				
	
	localparam RATIOw=$clog2(100);
   

	reg     reset ,clk;
	reg     start,stop;
	wire    sent_done;
	reg    done;
	reg [RATIOw-1:0] ratio;

	


	initial begin 
		clk = 1'b0;
		forever clk = #10 ~clk;
	end 

	

	initial begin 
		reset = 1'b1;
		start = 1'b0;
		stop  = 1'b0;
		ratio =INJRATIO;
		#80
		@(posedge clk) reset = 1'b0;
		#200
		@(posedge clk) start = 1'b1;
		@(posedge clk) start = 1'b0;
		@(posedge sent_done) 
		stop=1;//stop all packet injectprs
		@(posedge done) //wait for all sent flits to be received at their destination
		#450
		@(posedge clk)
		$stop;
	end
	
	  
	localparam     
	/* verilator lint_off WIDTH */
            
		
		DISTw = (TOPOLOGY=="FATTREE" || TOPOLOGY == "TREE") ? $clog2(2*L+1): $clog2(NR+1),
		/* verilator lint_on WIDTH */
                    
		Cw      =   (C>1)? $clog2(C): 1,
		// NEw     =   log2(NE),
                    
		NEV     =   NE  * V,
		NEFw    =   NE  * Fw,
		PCK_CNTw=   $clog2(MAX_PCK_NUM+1),
		CLK_CNTw=   $clog2(MAX_SIM_CLKs+1),
		PCK_SIZw=   $clog2(MAX_PCK_SIZ+1),
		AVG_PCK_SIZ = (MAX_PACKET_SIZE + MIN_PACKET_SIZE)/2 ;
                   
                    
  
   
    
    
	smartflit_chanel_t chan_in_all  [NE-1 : 0];
	smartflit_chanel_t chan_out_all [NE-1 : 0];
    
    
    
    
   
	wire [NE-1      :   0]  hdr_flit_sent;
	wire [EAw-1     :   0]  dest_e_addr             [NE-1           :0];  
	wire [EAw-1     :   0]  src_e_addr				[NE-1           :0]; 
	wire [Cw-1      :   0]  pck_class_in            [NE-1           :0]; 
	wire [NEw-1     :   0]  src_id					[NE-1           :0]; 
    
	wire [PCK_SIZw-1:   0] pck_size_in [NE-1        :0]; 
	wire [PCK_SIZw-1:   0] pck_size_o  [NE-1        :0];   
    
    
	//   wire    [NE-1           :0] report;
	reg     [CLK_CNTw-1             :0] clk_counter;
    
    
 
	wire    [PCK_CNTw-1     :0] pck_counter     [NE-1        :0];
	wire    [NE-1           :0] noc_report;
	wire    [NE-1           :0] update;
	wire    [CLK_CNTw-1     :0] time_stamp_h2t  [NE-1           :0];
	wire    [CLK_CNTw-1     :0] time_stamp_h2h  [NE-1           :0];
	wire    [DISTw-1         :0] distance        [NE-1           :0];    
	wire    [Cw-1           :0] msg_class       [NE-1           :0];    
    
	reg                         count_en;
  	//reg [NE-1 : 0] start_o;
  	logic [DELAYw-1 : 0] start_delay [NE-1 : 0];
  	
  
  	
  	
  	integer  rsv_size_array [MAX_PACKET_SIZE - MIN_PACKET_SIZE : 0];
  		
  	
    
	always @(posedge    clk or posedge reset) begin 
		if (reset) begin 
			count_en <=1'b0;
		end else begin 
			if(start) count_en <=1'b1;
			else if(noc_report) count_en <=1'b0;
		end 
	end//always
    
       
	piton_mesh_pronoc_wrap
		the_noc
		(
			.reset(reset),
			.clk(clk),    
			.chan_in_all(chan_in_all),
			.chan_out_all(chan_out_all)  
		);
          
      
    
	always @ (posedge clk or posedge reset)begin 
		if          (reset  ) begin clk_counter  <= 0;  end
		else  begin 
			if  (count_en) clk_counter  <= clk_counter+1'b1;    
	        
		end
	end
    
    
    
	function integer addrencode;
		input integer pos,k,n,kw;
		integer pow,i,tmp;begin
			addrencode=0;
			pow=1;
			for (i = 0; i <n; i=i+1 ) begin 
				tmp=(pos/pow);
				tmp=tmp%k;
				tmp=tmp<<i*kw;
				addrencode=addrencode | tmp;
				pow=pow * k;
			end
		end   
	endfunction 
    
    
	genvar i;
    wire [NE-1 : 0] valid_dst;
    
	generate 
	for(i=0; i< NE; i=i+1) begin : endpoints
			
       		wire [EAw-1 : 0] current_e_addr [NE-1 : 0];
			
			endp_addr_encoder #(
				.TOPOLOGY(TOPOLOGY),
				.T1(T1),
				.T2(T2),
				.T3(T3),
				.EAw(EAw),
				.NE(NE)
			)
			encoder
			(
				.id(i[NEw-1 : 0]),
				.code(current_e_addr[i])
			);    
			
            
			        
			    
			piton_traffic_gen_top #(
				.MAX_RATIO(100)          
			)
			the_traffic_gen
			(
       			.ratio (ratio),					
				.pck_size_in(pck_size_in[i]),
				.current_r_addr(chan_out_all[i].ctrl_chanel.neighbors_r_addr),
				.current_e_addr(current_e_addr[i]),
				.dest_e_addr(dest_e_addr[i]),
				.pck_class_in(pck_class_in[i]),  
				.init_weight({{(WEIGHTw-1){1'b0}},1'b1}),
				.hdr_flit_sent(hdr_flit_sent[i]),
				.pck_number(pck_counter[i]),
				.reset(reset),
				.clk(clk),
				.start(start),
				.stop(stop | ~valid_dst[i]),
				.sent_done(),
				.update(update[i]),
				.time_stamp_h2h(time_stamp_h2h[i]),
				.time_stamp_h2t(time_stamp_h2t[i]),
				.distance(distance[i]),
				.src_e_addr(src_e_addr[i] ),
				.pck_class_out(msg_class[i]),
				.report (1'b0),
				.pck_size_o(pck_size_o[i]),
				.chan_in(chan_out_all[i]),
				.chan_out(chan_in_all[i]),
				.start_delay(start_delay[i]),
				.flit_out_wr(),
				.flit_in_wr()
          
			);
			
			endp_addr_decoder #(
				.TOPOLOGY(TOPOLOGY),
				.T1(T1),
				.T2(T2),
				.T3(T3),
				.EAw(EAw),
				.NE(NE)
			)
			decoder
			(
				.id(src_id[i]),
				.code(src_e_addr[i])
			);    
     

			pck_class_in_gen #(
				.C(C),
				.C0_p(C0_p),
				.C1_p(C1_p),
				.C2_p(C2_p),
				.C3_p(C3_p)            
			)
			the_pck_class_in_gen
			(
				.en(hdr_flit_sent[i]),
				.pck_class_o(pck_class_in[i]),
				.reset(reset),
				.clk(clk)
			);
   
   
   
  
			pck_dst_gen #(
				.NE(NE),
				.MAX_PCK_NUM(MAX_PCK_NUM),
				.TRAFFIC(TRAFFIC),
				.HOTSPOT_NODE_NUM(HOTSPOT_NODE_NUM)
			)
			the_pck_dst_gen
			(
				.reset(reset),
				.clk(clk),
				.en(hdr_flit_sent[i]),
				.core_num(i[NEw-1  :   0]),
				.pck_number(pck_counter[i]),
				.current_e_addr(current_e_addr[i]),
				.dest_e_addr(dest_e_addr[i]),
				.valid_dst(valid_dst[i]),
				.hotspot_info(hotspot_info),
				.custom_traffic_t(custom_traffic_t[i]),  // defined in sim_param.sv
				.custom_traffic_en(custom_traffic_en[i])  // defined in sim_param.sv
			);
       
			pck_size_gen #(
				.PCK_SIZw(PCK_SIZw),
				.MIN(MIN_PACKET_SIZE),
				.MAX(MAX_PACKET_SIZE),
				.PCK_SIZ_SEL(PCK_SIZ_SEL),
				.DISCRETE_PCK_SIZ_NUM(DISCRETE_PCK_SIZ_NUM)
			)
			the_pck_siz_gen
			(
				.reset(reset),
				.clk(clk),
				.en(hdr_flit_sent[i]),
				.pck_size( pck_size_in[i]) ,
				.rnd_discrete(rnd_discrete)
			);
  
	end
	endgenerate

       
	




	
	real				sum_clk_h2h,sum_clk_h2t;
	real 				sum_clk_pow2;
	real 				sum_clk_pow2_per_class [C-1 : 0];
	real				sum_clk_per_hop;
	integer             total_rsv_pck_num_per_class         [C-1    :   0];
	real				sum_clk_h2h_per_class			[C-1    :   0];
	real				sum_clk_h2t_per_class  			[C-1    :   0];
	real				sum_clk_per_hop_per_class		[C-1	:	0];
	integer				rsvd_core_total_rsv_pck_num			[NE-1   :   0];
	integer				rsvd_core_worst_delay			[NE-1   :   0];
	integer             sent_core_worst_delay           [NE-1   :   0];
	integer				total_active_endp;
	integer             total_rsv_pck_num,total_rsv_flit_number;
	integer				total_sent_pck_num,total_sent_flit_number;
	
	integer core_num,k;
	always @(posedge clk or posedge reset)begin
		if (reset) begin 
			total_rsv_pck_num=0;
			total_sent_pck_num=0;
			sum_clk_h2h=0;
			sum_clk_h2t=0;
			sum_clk_pow2=0;
			sum_clk_per_hop=0;
			total_sent_flit_number=0;
			total_rsv_flit_number=0;
			for (k=0;k<C;k=k+1) begin 
					sum_clk_pow2_per_class[k]=0;
					total_rsv_pck_num_per_class[k]=0;
					sum_clk_h2h_per_class [k]=0;
					sum_clk_h2t_per_class [k]=0;
					sum_clk_per_hop_per_class[k]=0;
			end
			for (k=0;k<NE;k=k+1) begin 
				rsvd_core_total_rsv_pck_num[k]=0;
				rsvd_core_worst_delay[k]=0;
				sent_core_worst_delay[k]=0;
			end
			for (k=0; k<= MAX_PACKET_SIZE - MIN_PACKET_SIZE; k++) 	rsv_size_array[k]=0;
			
		end
		
		
		for (core_num=0; core_num<NE; core_num=core_num+1)begin 
			if(chan_in_all[core_num].flit_chanel.flit_wr)begin 
				total_sent_flit_number+=1;
				if(chan_in_all[core_num].flit_chanel.flit[Fw-1]) total_sent_pck_num+=1;
			end
			if(chan_out_all[core_num].flit_chanel.flit_wr)begin 
				total_rsv_flit_number+=1;				
			end 
			
			
			if( update [core_num] ) begin 
				total_rsv_pck_num = total_rsv_pck_num+1;
				if((total_rsv_pck_num & 'hffff )==0 ) $display(" packet received total=%d",total_rsv_pck_num);
				sum_clk_h2h +=  time_stamp_h2h[core_num];
				sum_clk_h2t +=  time_stamp_h2t[core_num];
				`ifdef STND_DEV_EN
					sum_clk_pow2+=time_stamp_h2h[core_num] * time_stamp_h2h[core_num];
					sum_clk_pow2_per_class[msg_class[core_num]]+=time_stamp_h2h[core_num] * time_stamp_h2h[core_num];
				`endif
				sum_clk_per_hop+= $itor(time_stamp_h2h[core_num])/$itor(distance[core_num]);
				total_rsv_pck_num_per_class[msg_class[core_num]]+=1;
				sum_clk_h2h_per_class[msg_class[core_num]]+=time_stamp_h2h[core_num] ;
				sum_clk_h2t_per_class[msg_class[core_num]]+=time_stamp_h2t[core_num] ;
				sum_clk_per_hop_per_class[msg_class[core_num]]+= $itor(time_stamp_h2h[core_num])/$itor(distance[core_num]);
				rsvd_core_total_rsv_pck_num[core_num]+=1;
				if (rsvd_core_worst_delay[core_num] < time_stamp_h2t[core_num]) rsvd_core_worst_delay[core_num] = ( AVG_LATENCY_METRIC == "HEAD_2_TAIL")? time_stamp_h2t[core_num] : time_stamp_h2h[core_num];
				if (sent_core_worst_delay[src_id[core_num]] < time_stamp_h2t[core_num]) sent_core_worst_delay[src_id[core_num]] = (AVG_LATENCY_METRIC == "HEAD_2_TAIL")?  time_stamp_h2t[core_num] : time_stamp_h2h[core_num];
				if (pck_size_o[core_num] >= MIN_PACKET_SIZE && pck_size_o[core_num] <=MAX_PACKET_SIZE) rsv_size_array[pck_size_o[core_num]-MIN_PACKET_SIZE] = rsv_size_array[pck_size_o[core_num]-MIN_PACKET_SIZE]+1;
					
			end			
		end		
	end//always

	
    
	
	

    integer rsv_ideal_cnt,total_rsv_flit_number_old;
	reg all_done_reg;
	wire all_done_in;
	assign all_done_in = (clk_counter > STOP_SIM_CLK) || ( total_sent_pck_num >  STOP_PCK_NUM );
	assign sent_done = all_done_in & ~ all_done_reg;
	always @(posedge clk or posedge reset)begin 
		if(reset) begin 
			all_done_reg <= 1'b0;
			rsv_ideal_cnt<=0;
			done<=1'b0;
			total_rsv_flit_number_old<=0;
		end  else  begin 
			all_done_reg <= all_done_in;
			total_rsv_flit_number_old<=total_rsv_flit_number;
			if(all_done_in) begin //All injectors stopped injecting packets 
				if(total_rsv_flit_number_old==total_rsv_flit_number) rsv_ideal_cnt<=rsv_ideal_cnt+1;//count the number of cycle when no flit is received by any injector  
				else rsv_ideal_cnt=0;
				if(total_sent_flit_number == total_rsv_flit_number) begin // All injected packets are consumed
					done<=1'b1;
				end
				if(rsv_ideal_cnt >= 100) begin //  Injectors stopped sending packets, number of received and sent flits are not equal yet and for 100 cycles no flit is consumed. 
					$display ("ERROR: The number of sent (%d) & received flits (%d) were not equal at the end of simulation",total_sent_flit_number ,total_rsv_flit_number);
					
					$stop;
				end
			end
		end
	end    
 
	initial total_active_endp=0;
 
	
	real avg_throughput,avg_latency_flit,avg_latency_pck,std_dev,avg_latency_per_hop,min_avg_latency_per_class;
	integer m;
	
	initial begin 
		for(m=0;m<NE;m++) start_delay[m] =$urandom_range((2**DELAYw)-2,0);  
	end
	
	
	//report 
	always @( posedge done) begin
	
		for (core_num=0; core_num<NE; core_num=core_num+1) begin  
			if(pck_counter[core_num]>0) total_active_endp   	= 	total_active_endp +1;
		end
		
		avg_throughput= ((total_sent_flit_number*100)/total_active_endp )/clk_counter;
		avg_latency_flit =sum_clk_h2h/$itor(total_rsv_pck_num);
		avg_latency_pck	 =sum_clk_h2t/$itor(total_rsv_pck_num);
		avg_latency_per_hop    = sum_clk_per_hop/$itor(total_rsv_pck_num);
		
		$display(" Flit injection ratio per router is =%f \n",ratio);
		$display(" simulation clock cycles:%d",clk_counter);
		$display(" total sent/received packets:%d/%d",total_sent_pck_num,total_rsv_pck_num);
		$display(" total sent/received flits:%d/%d",total_sent_flit_number,total_rsv_flit_number);
		$display(" Total active Endpoint: %d \n",total_active_endp);
		$display(" Avg throughput is: %f (flits/clk/Total active Endpoint %%)",   avg_throughput);
			
		
		
		$display("\nall : ");		
		$display(" Total number of packet = %d \n average latency per hop = %f ",total_rsv_pck_num,avg_latency_per_hop);
		$display(" average packet latency = %f \n average flit latency = %f ",avg_latency_pck, avg_latency_flit);
		
		$display(" Total injected packet in different size:");
		for (m=0;m<=(MAX_PACKET_SIZE - MIN_PACKET_SIZE);m++) begin
			if(rsv_size_array[m]>0) $display("\t %d flit_sized pck = %d",m+ MIN_PACKET_SIZE, rsv_size_array[m]);
		end
		
		
		//		if(ratio==RATIO_INIT) first_avg_latency_flit=avg_latency_flit;
		//`ifdef STND_DEV_EN
				//std_dev= standard_dev( sum_clk_pow2,total_rsv_pck_num, avg_latency_flit);
				//$display(" standard_dev = %f",std_dev);
		//`endif
				
		
		min_avg_latency_per_class=1000000;
		for(m=0;m<C;m++) begin
			avg_throughput		 = (total_rsv_pck_num_per_class[m]>0)? ((total_rsv_pck_num_per_class[m]*AVG_PCK_SIZ*100)/total_active_endp )/clk_counter:0;
			avg_latency_flit 	 = (total_rsv_pck_num_per_class[m]>0)? sum_clk_h2h_per_class[m]/total_rsv_pck_num_per_class[m]:0;
			avg_latency_pck	   	 = (total_rsv_pck_num_per_class[m]>0)? sum_clk_h2t_per_class[m]/total_rsv_pck_num_per_class[m]:0;
			avg_latency_per_hop  = (total_rsv_pck_num_per_class[m]>0)? sum_clk_per_hop_per_class[m]/total_rsv_pck_num_per_class[m]:0;
			if(AVG_LATENCY_METRIC == "HEAD_2_TAIL") begin
						$display ("\nclass : %d  ",m);
						$display (" Total number of packet  = %d \n avg_throughput = %f \n average latency per hop = %f \n average latency = %f",total_rsv_pck_num_per_class[m],avg_throughput,avg_latency_per_hop,avg_latency_pck);
						
			end else begin 

						$display ("\nclass : %d  ",m);
						$display (" Total number of packet  = %d \n avg_throughput = %f \n average latency per hop = %f \n average latency = %f",total_rsv_pck_num_per_class[m],avg_throughput,avg_latency_per_hop,avg_latency_flit);
			end
			if(min_avg_latency_per_class > avg_latency_flit) min_avg_latency_per_class=avg_latency_flit;

					//#if (STND_DEV_EN)
					//std_dev= (total_rsv_pck_num_per_class[i]>0)?  standard_dev( sum_clk_pow2_per_class[i],total_rsv_pck_num_per_class[i], avg_latency_flit):0;
					// sprintf(file_name,"%s_std%u.txt",out_file_name,i);
					// update_file( file_name,avg_throughput,std_dev);

					//#endif
		end//for
		
				

		for (m=0;m<NE;m++) begin
			$display	 ("\n\nEndpoint %d",m);
			$display	 ("\n\ttotal number of received packets: %d",rsvd_core_total_rsv_pck_num[m]);
			$display	 ("\n\tworst-case-delay of received packets (clks): %d",rsvd_core_worst_delay[m] );
			$display	 ("\n\ttotal number of sent packets: %d",pck_counter[m]);
			$display	 ("\n\tworst-case-delay of sent packets (clks): %d",sent_core_worst_delay[m] );
		end
	end

		
	

   
	initial begin

		//print_parameter 
		$display ("Router parameters:");
		$display ("\tTopology: %s",TOPOLOGY);
		$display ("\tRouting algorithm: %s",ROUTE_NAME);
		$display ("\tVC_per port: %d", V);
		$display ("\tNon-local port buffer_width per VC: %d", B);
		$display ("\tLocal port buffer_width per VC: %d", LB);
		if(TOPOLOGY=="MESH" || TOPOLOGY=="TORUS")begin
			$display ("\tRouter num in row: %d",T1);
			$display ("\tRouter num in column: %d",T2);
			$display ("\tEndpoint num per router: %d",T3);
		end else if (TOPOLOGY=="RING" || TOPOLOGY == "LINE") begin
			$display ("\t Total Router num: %d",T1);
			$display ("\tEndpoint num per router: %d",T3);
		end else if (TOPOLOGY == "TREE" ||  TOPOLOGY == "FATTREE")begin
			$display ("\tK: %d",T1);
			$display ("\tL: %d",T2);
		end else begin //CUSTOM
			$display ("\tTotal Endpoints number: %d",T1);
			$display ("\tTotal Routers number: %d",T2);
		end
		$display ("\tNumber of Class: %d", C);
		$display ("\tFlit data width: %d", Fpay);
		$display ("\tVC reallocation mechanism: %s",  VC_REALLOCATION_TYPE);
		$display ("\tVC/sw combination mechanism: %s", COMBINATION_TYPE);
		$display ("\tAVC_ATOMIC_EN:%d", AVC_ATOMIC_EN);
		$display ("\tCongestion Index:%d",CONGESTION_INDEX);
		$display ("\tADD_PIPREG_AFTER_CROSSBAR:%d",ADD_PIPREG_AFTER_CROSSBAR);
		$display ("\tSSA_EN enabled:%s",SSA_EN);
		$display ("\tMax Streight Bypass:%d",SMART_MAX);
		$display ("\tSwitch allocator arbitration type:%s",SWA_ARBITER_TYPE);
		$display ("\tMinimum supported packet size:%d flit(s)",MIN_PCK_SIZE);
		$display ("\tLoop back is enabled::%s",SELF_LOOP_EN);
		
		$display ("\nSimulation parameters");
		if(DEBUG_EN)
			$display ("\tDebuging is enabled");
		else
			$display ("\tDebuging is disabled");

		//if( AVG_LATENCY_METRIC == "HEAD_2_TAIL")  $display ("\tOutput is the average latency on sending the packet header until receiving tail");
		//else $display ("\tOutput is the average latency on sending the packet header until receiving header flit at destination node");
		$display ("\tTraffic pattern:%s",TRAFFIC);
		if(C>0) $display ("\ttraffic percentage of class 0 is : %d", C0_p);
		if(C>1) $display ("\ttraffic percentage of class 1 is : %d", C1_p);
		if(C>2) $display ("\ttraffic percentage of class 2 is : %d", C2_p);
		if(C>3) $display ("\ttraffic percentage of class 3 is : %d", C3_p);
		if(TRAFFIC == "HOTSPOT")begin
			//$display ("\tHot spot percentage: %u\n", HOTSPOT_PERCENTAGE);
			$display ("\tNumber of hot spot cores: %d", HOTSPOT_NODE_NUM);
		end
		//$display ("\tTotal packets sent by one router: %u\n", TOTAL_PKT_PER_ROUTER);
		$display ("\tSimulation timeout =%d", STOP_SIM_CLK);
		$display ("\tSimulation ends on total packet num of =%d", STOP_PCK_NUM);
		$display ("\tPacket size (min,max,average) in flits: (%d,%d,%d)",MIN_PACKET_SIZE,MAX_PACKET_SIZE,AVG_PCK_SIZ);
		$display ("\tPacket injector FIFO width in flit:%d\n\n",TIMSTMP_FIFO_NUM);

	end//initial
	
	/*
	start_delay_gen #(
			.NC(NE)
		)
		delay_gen
		(
			.clk(clk),
			.reset(reset),
			.start_i(start),
			.start_o(start_o)
		);
	 */

endmodule
// synthesis translate_on
