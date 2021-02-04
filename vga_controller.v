module vga_controller(
    input clk, // 50 Mhz clock,
    output vga_hsync,
    output vga_vsync,
	 output [2:0] rgbOut,
	 input rst, // Clock Reset
	 output [13:0] addr,
	 input data
);
	
    wire inDisplayArea;
    wire [9:0] PosX;
	 wire [9:0] PosY;
	 
	 // 25Mhz Clock generator
	 reg vga_clk;
	 always @(posedge clk)
	 begin
	 if (~rst)
		vga_clk <= 1'b0;
	 else
		vga_clk <= ~vga_clk;	
	 end
	 
	 hvsync(vga_clk,vga_hsync,vga_vsync,inDisplayArea,PosX,PosY);
	 
	 // Drawing Logic goes here
	 assign addr = 14'b10001000000000 + PosX[2:0] + {PosY[3:0], 3'b000};
	 
	 assign rgbOut[0] = data & inDisplayArea;
	 assign rgbOut[1] = rgbOut[0];
	 assign rgbOut[2] = rgbOut[0];

	 endmodule