`timescale 1ns / 1ps


module connect_ser_des_tb;

   integer file, i; 
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
	//  odczyt danych z pliku 
	   $readmemb("Dane_Odczyt.txt",data);
   
	initial begin
	
	// otwarcie pliku do zapisu 
		file = $fopen("Dane_Zapis2.txt","w"); 
		i = 1; 
		in_comp = 0;
		clk = 0;
		nreset = 0;
		#100
		nreset = 1; 
		
		// odczyt z pliku 
		$display("Data read: ");
		
		for (i=0;i<15;i=i+1) begin
			$display("%d : %B",i,data[i]);
			in_comp = data[i];
			#100;
			$fwrite(file, " %B \n", out_comp);
		end
		$fclose(file);		
	end 


	always #10 clk = ~clk;
endmodule