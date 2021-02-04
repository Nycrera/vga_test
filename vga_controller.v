module vga_controller(
    input clk, // 50 Mhz clock,
	 input vga_clk,
    output vga_hsync,
    output vga_vsync,
	 output [2:0] rgbOut,
	 input rst, // Clock Reset
	 output reg [13:0] addr,
	 input wire data
);
	 wire vga_hsync_original;
	 wire vga_vsync_original;
    wire inDisplayArea;
    wire [9:0] PosX;
	 wire [9:0] PosY;
	 

	 
	 hvsync(vga_clk,vga_hsync_original,vga_vsync_original,inDisplayArea_original,PosX,PosY);
	 
	 // Drawing Logic goes here
	 wire glyph_x,glyph_y;
	 assign glyph_x = PosX[2:0];
	 assign glyph_y = PosY[3:0];
	 
	 always @(posedge vga_clk)
	 begin
	 addr <= (8'b01000100 << 7) + glyph_x + (glyph_y << 3);
	 end
	 
	 initial begin
	 addr <= 14'b00000000000000;
	 end
	 
	 assign rgbOut[0] = data & inDisplayArea;
	 /*
	 assign rgbOut[2] = ((PosX > 0) & (PosX < 300) & (PosY > 0) & (PosY < 300))?1:0;
	 assign rgbOut[1] = ((PosX > 200) & (PosX < 400) & (PosY > 150) & (PosY < 350)?1:0);
	 assign rgbOut[0] = ((PosX > 300) & (PosX < 600) & (PosY > 180) & (PosY < 480))?1:0;
	 */
	 
	 reg hsync_delayed1;
	 reg hsync_delayed2;
	 reg hsync_delayed3;
	 reg vsync_delayed1;
	 reg vsync_delayed2;
	 reg vsync_delayed3;
	 reg inDisplayArea_delayed1;
	 reg inDisplayArea_delayed2;
	 reg inDisplayArea_delayed3;
	 
	 always @(posedge vga_clk)
	 begin
	 hsync_delayed1 <= vga_hsync_original;
	 hsync_delayed2 <= hsync_delayed1;
	 hsync_delayed3 <= hsync_delayed2;
	
	 vsync_delayed1 <= vga_vsync_original;
	 vsync_delayed2 <= vsync_delayed1;
	 vsync_delayed3 <= vsync_delayed2;
	 
	 inDisplayArea_delayed1 <= inDisplayArea_original;
	 inDisplayArea_delayed2 <= inDisplayArea_delayed1;
	 inDisplayArea_delayed3 <= inDisplayArea_delayed2;
	 end
	 
	 assign vga_vsync = vsync_delayed3;
	 assign vga_hsync = hsync_delayed3;
	 assign inDisplayArea = inDisplayArea_delayed3;
	 endmodule