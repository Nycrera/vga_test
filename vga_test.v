module vga_test(
    input clk, // 50 Mhz clock
	 output [2:0] rgbOut,
    output h_sync,
	 output v_sync,
	 input rst,
	 input [31:0] data_b,
	 input [11:0] addr_b,
	 input we_b,
	 output q_b
	 );

vga_controller(clk,h_sync,v_sync,rgbOut,rst,ROMAddr,ROMOut,RAMAddr,RAmOut);

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
wire [11:0] RAMAddr;
wire [31:0] RAMOut;

RAM(data_b,RAMAddr,addr_b,we_b,clk,RAMOut,q_b);

endmodule