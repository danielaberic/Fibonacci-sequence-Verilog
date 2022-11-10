`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:16:10 07/09/2022 
// Design Name: 
// Module Name:    dekadski 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module dekadski(
		input wire [7:0] key_code_1,
		input wire [7:0] key_code_2,
		output [7:0] dekadski_broj
    );
	 reg [3:0] prvi_broj;
	 reg [3:0] drugi_broj;
	 
	 always @(*) 
		begin
		case (key_code_1) 

			
			8'h45: prvi_broj = 8'd0;
			8'h1e: prvi_broj=  8'd2;

			8'h26: prvi_broj = 8'd3;

			8'h25: prvi_broj = 8'd4;

			8'h2e: prvi_broj = 8'd5;

			8'h36: prvi_broj= 8'd6;

			8'h3d: prvi_broj = 8'd7;

			8'h3e: prvi_broj = 8'd8;

			8'h46: prvi_broj = 8'd9;

			//8'b01000101: ascii_code = 1'd0;

			//8'h5a: ascii_code = 8'h0d; // (enter, cr) 

		default: prvi_broj = 8'd1;
		

		endcase 
		end
		always @(*) 
		begin
		case (key_code_2) 

			8'h16: drugi_broj = 8'd1;

			8'h1e: drugi_broj=  8'd2;

			8'h26: drugi_broj = 8'd3;

			8'h25: drugi_broj = 8'd4;

			8'h2e: drugi_broj = 8'd5;

			8'h36: drugi_broj= 8'd6;

			8'h3d: drugi_broj = 8'd7;

			8'h3e: drugi_broj = 8'd8;

			8'h46: drugi_broj = 8'd9;

			//8'b01000101: ascii_code = 1'd0;

			//8'h5a: ascii_code = 8'h0d; // (enter, cr) 

		default: drugi_broj = 8'd0;  

		endcase
		end		
	 
	assign dekadski_broj=prvi_broj*10+drugi_broj;

endmodule

