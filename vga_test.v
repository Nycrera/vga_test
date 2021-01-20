module vga_test(
    input clk, // 50 Mhz clock
	 output [2:0] rgbOut,
    output h_sync,
	 output v_sync,
	 input rst
	 );

vga_controller(clk,h_sync,v_sync,rgbOut,rst);



endmodule