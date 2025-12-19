`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.12.2025 14:52:32
// Design Name: 
// Module Name: Soda_dispenser_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Soda_dispenser_tb();
    reg clk;
    reg reset;
    reg c;
    reg [7:0] a;
    reg [7:0] s;
    wire d;

    Soda_dispenser_logic uut (
        .clk(clk),
        .reset(reset),
        .c(c),
        .a(a),
        .s(s),
        .d(d)
    );

   
    always #5 clk = ~clk;  // Clock is generated out here

    initial begin
        clk = 0;
        reset = 1;
        c = 0;
        a = 0;
        s = 8'd30;      // We set the cost of Soda to 30p

        
        #15 reset = 0; // delay is set to 15 , to release reset of 0

        // Insert first coin 
        #10;            
        a = 8'd10;      //  coin value is set to 10
        c = 1;          // Coin detection
        #10 c = 0;      
        
        // The system is in wait state since 10<=30

        // Wait State
        #30;     

        // Insert the next coin
        a = 8'd20;      // Second coin is worth 20p
        c = 1;          // C sets to 1 as coin is detected
        #10 c = 0;      
        
        // Here Total = 10 + 20 = 30
        // Since 30 >= 30,  System goes to display state

        // Display goes to 1
        wait(d == 1);   // d sets to 1
        $display("Success: Soda Dispensed at time %t (Total reached 30)", $time);

        #50;
      $finish;        
    end
endmodule


endmodule
