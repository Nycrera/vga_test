module vga_controller(
    input clk, // 50 Mhz clock
    output vga_hsync,
    output vga_vsync,
	 output [2:0] rgbOut,
	 input rst // Clock Reset
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
	 
	 assign rgbOut[2] = ((PosX > 0) & (PosX < 300) & (PosY > 0) & (PosY < 300))?1:0;
	 assign rgbOut[1] = ((PosX > 200) & (PosX < 400) & (PosY > 150) & (PosY < 350)?1:0);
	 assign rgbOut[0] = ((PosX > 300) & (PosX < 600) & (PosY > 180) & (PosY < 480))?1:0;
	 
	 
	 endmodule