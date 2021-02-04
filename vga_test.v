module vga_test(
    input clk, // 50 Mhz clock
	 output [2:0] rgbOut,
    output h_sync,
	 output v_sync,
	 input rst
	 );

vga_controller(clk,h_sync,v_sync,rgbOut,rst,addr,data);

// ASCII Character ROM

wire [13:0] addr;
reg mem [16383:0];
reg data;

initial begin
	$readmemb("glyph.b", mem);
end

always @(posedge clk)
begin
		data <= mem[addr];
end

// TEXT Character RAM


endmodule