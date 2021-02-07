module testramwrite(
input clk,
output [31:0] data_b,
output [11:0] addr_b,
output we_b,
input [31:0] q_b
);
/*
assign we_b = 1;
assign data_b =  {8'd68, 6'b111010, 8'd77, 10'b1010010000};

always @ (posedge clk)
begin

addr_b = addr_b + 1;

end
*/

reg [7:0] dataC;
reg [11:0] addrC;
wire [7:0] datacp1;

assign datacp1 = dataC[7:0] + 1;

assign addr_b = addrC[11:0];
assign data_b = {dataC[7:0], 6'b111010, datacp1[7:0], 10'b1110100000};
assign we_b = 1;

always @ (posedge clk)
begin

	addrC <= addrC + 1;
	dataC <= dataC + 1;

end

endmodule