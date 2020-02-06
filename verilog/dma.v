`include "processor.v"
/*module simple_memory(addressbus,databus,control,clk);
input [7:0] addressbus;
input control;
input clk;
inout [7:0]databus;
integer i=0;
reg [7:0] mem[0:31];
wire dev_sel;
assign dev_sel = (addressbus>=0&&addressbus<32);
assign databus= ((control == 1'b0)&&dev_sel)? mem[addressbus]:8'bz;// control = read dma = mem write

initial
  begin
   for(i = 0;i<32;i=i+1)
    begin
	mem[i]<=i;
	end
  end
always @(posedge clk)
  begin
	if(addressbus>=0&&addressbus<32)
	begin
	    if(control == 1'b1)//control write = mem read
	      begin
	         mem[addressbus] <= databus;
	      end
	end
  end


endmodule*/
//////////////////processsor code ///////////////////////////////////////////////////////////////

////////////////////////////DMA/////////////////////////
module new_dma(
    control,hld,
    databus,
    addressbus,
    length, //????? ???? ???? ?????
    address_dist,   // ??????? ???? ???? ??? ??????
    address_source, // ?????? ???? ???? ???
    hlda,//hold acknowledge
    clk,reset
	//dma_req,dma_ack
);
    output reg[7:0] addressbus;
	inout [7:0] databus;
    //output reg[1:0]dma_ack;
	output reg control;
	output reg hld;
	input [7:0] length,address_dist,address_source;
	input clk,hlda,reset;
	//input [1:0] dma_req;
    reg [7:0]count,dist1,source,tmp;
	reg check;
	assign databus = (hlda&&control == 1'b0)? tmp:8'bz;
	memory mymemory(addressbus,databus,control,clk);
    always@(posedge clk or reset)// memory memory
        begin
		     if(reset)//initial state for  registers
			 begin
			 check <=1;
			 count<=0;
			 source <= 8'b0;
			 dist1 <= 8'b0;
			 tmp <=8'b0;
			// dma_ack <=2'b0;
			 hld<=1'b0;
			 end
			 //if((dma_req == 2'b01)|| dma_req == 2'b11)//first channel asks for a dma request
			 //begin
			// if(count ==0) hld<=1'b1; // if dma isn't doing a request at the moment
		     if(hlda&&check)begin    // recieved ok from processsor put inputs inside registers
               count <= length; 
               dist1 <= address_dist;
               source <= address_source;
			   check <=1'b0;
			  // dma_ack[0] <= 1;
             end 
			// end
			 /*else if((dma_req == 2'b10)&&!(dma_req ==2'b11))//same as above
			 begin
			   if(count ==0) hld<=1'b1;
		       if(hlda&&check)begin
                  count <= length; 
                   dist1 <= address_dist;
                   source <= address_source;
			       check <=1'b0;
			       dma_ack[1] <= 1;
			   
                end 
			 end*/

            if(count != 0)
            begin //memory to memory
               addressbus <= source;
               control <= 1'b1;
              repeat(1) @(posedge clk);
			  // if(count == length)begin @(posedge clk);end
               tmp <= databus;
               addressbus <= dist1;
               control <=1'b0;
               count <= count-1;
               source<=source+1;
               dist1<=dist1+1;
			   if (count == 1) begin
		        repeat(1) @(posedge clk);
		         hld<=0;
			   end
            end

       else if (count == 0) begin
	           check <=1'b1;
			   hld<=1'b1;
            end
        end
	/*	always
           begin
            #5 
            clk = ~clk;
           end*/
		initial
		  begin
            check<=1;
			#10
			check<=0;
		  end


endmodule













