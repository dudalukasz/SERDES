`timescale 1ns / 1ps


module connect_ser_des_tb;

	// Inputs
	reg [7:0] in_comp;
	reg clk;
	reg nreset;
	// line for the text read from file
	reg [7:0] data [0:15]; 
	// Outputs
	wire [7:0] out_comp;

	// Instantiate the Unit Under Test (UUT)
	connect_ser_des uut (
		.in_comp(in_comp), 
		.out_comp(out_comp), 
		.clk(clk), 
		.nreset(nreset)
	);

	initial
	   $readmemb("data.txt",data);
   integer i,ot;
	initial begin
		in_comp = 0;
		clk = 0;
		nreset = 0;
		
		$display("Data read: ");
		for (i=0;i<15;i=i+1)
		$display("%d: %B",i,data[i]);
	end 
	always #5 clk = ~clk;
	initial begin
	//zerowanie w celu, usuniecia stanów nieustalonych na poczatku
	clk = 0;
	nreset = 0;
	ot = $fopen("output_data.txt","w");
	$fwrite(ot,"  __________________________________________________________________________________________________________________________________ \n");
	$fwrite(ot,"| wyjscie\n", ot);
	end
	
endmodule
