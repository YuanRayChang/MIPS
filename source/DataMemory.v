module DataMemory(
	input			CLK,	// Clock signal rising edge
	input	[5:0]	A,		// Address for 64 locations
	input			WE,		// Write Enable 1: Write 0: no write
	input	[31:0]	WD,		// 32-bit data in
	output	[31:0]	RD		// 32-bit read data
);

	reg [31:0] DataArr [63:0];   // This is the variable that holds the memory
	initial begin
		// Initialize the array with this content
	    $readmemh("datamem_direction_h.txt", DataArr);
	end

	assign RD = DataArr[A];		// Read Data (RD) corresponds to address (A)

	always @ ( posedge CLK )	// At rising edge of CLK
	begin
		if (WE)					// if Write Enable (WE) is set
			DataArr[A] <= WD;	// Copy Write Data (WD) to the address (A)
    end

endmodule