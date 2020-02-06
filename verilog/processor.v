`include "memory.v"
module processsor (HOLD,HLDA ,clock,enable,input_software,control_line,data_line);//,test1,test2);
    //input [7:0]data_line_in;
	//output  [7:0]data_line_out;
	input clock,enable,HOLD;
	inout   [7:0]data_line;
	//output  [7:0]test1,test2;
	 reg [7:0] address_line;
	output reg HLDA,control_line; 
	reg [7:0]value[0:1];
	reg [7:0]tmp;
	wire [7:0]tmp1;
	input [24:0] input_software ;
	integer i ;
	parameter add  = 0;
    parameter move = 1;	
	memory mem(address_line,data_line,control_line,clock);
		                            // the architecture of the processor
	assign data_line=(HOLD==0&&control_line==0)?tmp:8'bz;
	//assign test1=value[0];
	//assign test2=value[1];
	///assign tmp1=(control_line==0)?data_line:8'bz;
	
	
	
	//initial input_software = 25'b0_00000001_00000010_00000100;
		always @(posedge clock or posedge enable)
			begin
			if (enable )     begin
							    tmp=8'b0000_0000;
								address_line=8'b0000_0000;
								control_line=1'b0;
								HLDA=1'b0;
							 end 
			else 
            begin 			
				if(input_software[24]==add  &&  HOLD==add) begin 
											control_line<=1'b1;
											address_line<=input_software[7:0];
											repeat(1)@(posedge clock);
											//control_line<=1'b0;
											tmp<=data_line;
										    repeat(1)@(posedge clock);
											value[0]<=tmp;
											repeat(1)@(posedge clock);
											control_line<=1'b1;
											address_line<=input_software[15:8];
											repeat(1)@(posedge clock);
											//control_line<=1'b0;
											tmp<=data_line;
											repeat(1)@(posedge clock);
											value[1]<=tmp;
											repeat(1)@(posedge clock);
											control_line<=1'b0;
											address_line<=input_software[23:16];
											tmp<=value[0]+value[1];
											
											end
				
			    else if (input_software[24]==move  &&  HOLD==move)begin 
											tmp<=8'bzzzz_zzzz; 
											address_line<=8'bzzzz_zzzz;
											control_line<=1'bz; 
											HLDA<=1'b1; 
											end
			end
			    end
endmodule 	 
