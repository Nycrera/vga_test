module vga_test(
    input clk, // 50 Mhz clock
	 output [2:0] rgbOut,
    output h_sync,
	 output v_sync,
	 input rst
	 );

vga_controller(clk,vga_clk,h_sync,v_sync,rgbOut,rst,addr,data);

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

// 25Mhz Clock generator
reg vga_clk;
always @(posedge clk)
begin
if (~rst)
	vga_clk <= 1'b0;
else
	vga_clk <= ~vga_clk;	
end

endmodule