`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:17:04 06/11/2016
// Design Name:   select_car_controller
// Module Name:   C:/Users/minchul/Documents/autoparkinglot/sel_car_cont_test.v
// Project Name:  autoparkinglot
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: select_car_controller
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module sel_car_cont_test;

	// Inputs
	reg clk;
	reg rst;
	reg [23:0] car_storage;
	reg button_prev;
	reg button_next;

	// Outputs
	wire [4:0] current_addr;

	// Instantiate the Unit Under Test (UUT)
	select_car_controller uut (
		.clk(clk), 
		.rst(rst), 
		.car_storage(car_storage), 
		.button_prev(button_prev), 
		.button_next(button_next), 
		.current_addr(current_addr)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		car_storage = 0;
		button_prev = 0;
		button_next = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

