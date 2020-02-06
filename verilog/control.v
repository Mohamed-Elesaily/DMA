
`include"dma.v"
// module control; 
// reg HOLD_for_processor,enable_for_processor;
// reg HOLD_for_DMA,enable_for_DMA;
// reg clock;
// wire  HLDA_processor;
// reg HLDA_DMA;
// wire [7:0]addressbus;
// integer i =0;
// //output [7:0]test;


// wire  control_line_processor,control_line_DMA;
// wire [7:0] data_line_processor,data_line_DMA;
// reg [7:0]length,address_dist,address_source;
// assign test1=data_line_processor;
// reg pc;
// reg [24:0]input_software=25'b0_0000_0001_0000_0010_00000100;
// reg [24:0]instr[0:31];
// // //  reg [24:0]input_software;
// // // initial begin
// // //     $readmemb("machine.txt",instr);
// // // 	for(i =0 ;i<2;i = i+1)
// // // 	begin
// // // 		input_software = instr[i];
// // // 		#100 i = i +0;
// // // 	end

// //     end
// initial begin 
//     $dumpfile("dump.vcd");
//     $dumpvars(0,control);
//     pc=0;
//     clock =1'b0;
//     #3000$finish();
//     end
// always 
//      begin 
// 	 #5
// 	 clock =~clock ;
// 	 end 
// processsor w1(HOLD_for_processor,HLDA_processor ,clock,enable_for_processor,input_software,control_line_processor,data_line_processor);
// new_dma dma1(control_line_DMA,HLDA_processor,data_line_DMA,addressbus,length,address_dist,address_source,HLDA_DMA,clock,enable_for_DMA);
// always@(posedge clock)
// 					begin
					
				
// 					if (input_software[24]==0)
// 					                     begin
// 					              enable_for_processor<=1'b1;
											
// 											  enable_for_DMA<=1'b0;
// 										    HOLD_for_processor<=1'b0;
											
// 										 end
// 					else  
// 										begin 
// 											HLDA_DMA<=1'b1;
// 											enable_for_processor<=1'b0;HLDA_DMA<=1'b1;
// 											enable_for_processor<=1'b0;
// 											enable_for_DMA<=1'b0;
// 											length<= input_software[7:0];
// 											address_dist<=input_software[15:8];
// 											address_source<=input_software[23:16];
// 										end 
					
					
					
				
//                     end


// endmodule


module control;
//   output [7:0]test1; 
  integer i;
reg HOLD_for_processor,enable_for_processor;
reg HOLD_for_DMA,enable_for_DMA;
reg clock;
wire  HLDA_processor;
reg HLDA_DMA;
wire [7:0]addressbus;
//output [7:0]test;
//reg clock ;
// output [24:0]test3;
wire  control_line_processor,control_line_DMA;
wire [7:0] data_line_processor,data_line_DMA;
reg [7:0]length,address_dist,address_source;
assign test1=data_line_processor;
reg [24:0] instructions [0:1];
// reg [24:0]input_software=25'b0_00000001_00000010_00000100;//1_00000000_0000_1010_00000_100//0_00000001_00000010_00000100
reg [24:0]input_software;
reg [24:0]inputfile[0:2];
assign test3 = input_software;
initial begin clock =1'b0;end
always 
     begin 
	 #5
	 clock =~clock ;
	 end 
initial begin
    $readmemb("machine.txt",inputfile);
	input_software = inputfile[0];
	end
initial begin 
    $dumpfile("dump.vcd");
    $dumpvars(0,control);
    // pc=0;
    clock =1'b0;
    #3000$finish();
    end	 
processsor w1(HOLD_for_processor,HLDA_processor ,clock,enable_for_processor,input_software,control_line_processor,data_line_processor);

new_dma dma1(control_line_DMA,HLDA_processor,data_line_DMA,addressbus,length,address_dist,address_source,HLDA_DMA,clock,enable_for_DMA);

always@(posedge clock)
					begin 
					if (input_software[24]==0)
					                     begin
					              enable_for_processor<=1'b0;
											
											  enable_for_DMA<=1'b0;
										    HOLD_for_processor<=1'b0;
											
										 end
					else  
										begin 
										  HLDA_DMA<=1'b1;
										  enable_for_processor<=1'b0;
											enable_for_DMA<=1'b0;
											length<= input_software[7:0];
											address_dist<=input_software[15:8];
											address_source<=input_software[23:16];
										end 
									/*for(i =0;i<2;i=i+1)
									   begin
									    input_software <= instructions[i];
										repeat(75) @(posedge clock);
									   end*/
					
					end
			/*initial 
			    begin
				instructions[0] <= 25'b0_00000001_00000010_00000100;
				instructions[1] <= 25'b1_00000000_00001010_00000100;
									for(i =0;i<2;i=i+1)
									   begin
									     input_software <= instructions[i];
										 repeat(75) @(posedge clock);
									   end
				end*/
					
endmodule
