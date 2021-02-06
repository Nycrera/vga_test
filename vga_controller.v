module vga_controller(
    input clk, // 50 Mhz clock,
    output vga_hsync,
    output vga_vsync,
	 output [2:0] rgbOut,
	 input rst, // Clock Reset
	 output [13:0] ROMAddr,
	 input ROMOut,
	 output [11:0] RAMAddr,
	 input [31:0] RAMOut
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
	 wire [7:0] asciiData;
	 wire [2:0] colorF;
	 wire [2:0] colorB;
	 wire [11:0] RAMAddr_NoParse;
	 
	 assign asciiData = RAMAddr_NoParse[0] ? RAMOut[31:24] : RAMOut[17:10];
	 assign colorF = RAMAddr_NoParse[0] ? RAMOut[23:21] : RAMOut[9:7];
	 assign colorB = RAMAddr_NoParse[0] ? RAMOut[20:18] : RAMOut[6:4]; // 4 bit unused for now...
	 
	 assign RAMAddr_NoParse = {5'b00000, PosX[9:3]} + ({6'b000000, PosY[9:4]} * 80);// (PosX / 8) + (PosY / 16) * 80 Text Indexing
	 assign RAMAddr = (RAMAddr_NoParse[11:0] >> 1);
	 
	 assign ROMAddr = {asciiData[6:0], 7'b0000000 } + PosX[2:0] + {PosY[3:0], 3'b000}; // Text Pixel Indexing
	 
	 assign rgbOut[0] = ROMOut ? (colorF[0] & inDisplayArea) : (colorB[0] & inDisplayArea);
	 assign rgbOut[1] = ROMOut ? (colorF[1] & inDisplayArea) : (colorB[1] & inDisplayArea);
	 assign rgbOut[2] = ROMOut ? (colorF[2] & inDisplayArea) : (colorB[2] & inDisplayArea);

	 endmodule