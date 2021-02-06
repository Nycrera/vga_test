module vga_test(
    input clk, // 50 Mhz clock
	 output [2:0] rgbOut,
    output h_sync,
	 output v_sync,
	 input rst
	 );
	 
wire [31:0] data_b;

testramwrite(clk,data_b,addr_b,we_b,q_b);

vga_controller(clk,h_sync,v_sync,rgbOut,rst,ROMAddr,ROMOut,addr_a,q_a);

// ASCII Character ROM

wire [13:0] ROMAddr;
reg ROM [16383:0];
reg ROMOut;

initial begin
	$readmemb("glyph.b", ROM);
end

always @(posedge clk)
begin
		ROMOut <= ROM[ROMAddr];
end

// TEXT Character RAM

wire [11:0] addr_a;
wire [11:0] addr_b;
wire we_a, we_b;
wire data_a;
reg [31:0] q_a, q_b;
assign data_a = 0;
assign we_a = 0;

// Declare the RAM variable
	reg [31:0] ram[4095:0];

	// Port A for VGA Controller Only Read
	always @ (posedge clk)
	begin
		if (we_a) 
		begin
			ram[addr_a] <= data_a;
			q_a <= data_a;
		end
		else 
		begin
			q_a <= ram[addr_a];
		end 
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