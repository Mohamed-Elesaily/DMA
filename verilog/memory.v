////////////////////////////memory code /////////////////////////////////////////////
module memory(addressbus,databus,control,clk);
input [7:0] addressbus;
input control;
input clk;
inout [7:0]databus;
integer i=0;
reg [7:0] mem[0:31];
wire dev_sel;
integer file;
assign dev_sel = (addressbus>=0&&addressbus<32);
assign databus= ((control == 1'b1)&&dev_sel)? mem[addressbus]:8'bz;// control = read dma = mem write
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
	    if(control == 1'b0)//control write = mem write
	      begin
	         mem[addressbus] <= databus;
	      end
	end
  end
initial
  begin
  file=$fopen("ram.txt");
 #1000
 for(i=0;i<32;i=i+1)
 $fwrite(file ,"%d  \n",mem[i]);
  end

endmodule