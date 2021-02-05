module RAM
(
	input [31:0] data_b,
	input [11:0] addr_a, addr_b,
	input we_b, clk,
	output reg [31:0] q_a, q_b
);

	// Declare the RAM variable
	reg [31:0] ram[4095:0];

	// Port A for VGA Controller Only Read
	always @ (posedge clk)
	begin
		q_a <= ram[addr_a];
	end 

	// Port B for CPU Read/Write
	always @ (posedge clk)
	begin
		if (we_b) 
		begin
			ram[addr_b] <= data_b;
			q_b <= data_b;
		end
		else 
		begin
			q_b <= ram[addr_b];
		end 
	end

endmodule