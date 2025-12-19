`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.12.2025 14:14:31
// Design Name: 
// Module Name: Soda_dispenser_logic
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


module Soda_dispenser_logic(
    input clk, reset,
    input c,
    input [7:0] a,
    input [7:0] s,
    output reg d  
);
   
   parameter INIT    = 2'b00;
   parameter WAIT    = 2'b01;
   parameter ADD     = 2'b10;
   parameter DISP    = 2'b11; 
   
   reg [1:0] current_state, next_state;
   reg [7:0] tot;

    // State Register Logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= INIT;
        else
            current_state <= next_state;
    end

    // Next State Logic
    always @(*) begin
        next_state = current_state;
        d = 1'b0;

        case (current_state)
            INIT: begin
                next_state = WAIT;
            end

            WAIT: begin
                if (c) 
                    next_state = ADD;
                else if (tot >= s) 
                    next_state = DISP; 
                else
                    next_state = WAIT;
            end

            ADD: begin
                next_state = WAIT;
            end

            DISP: begin 
                d = 1'b1;
                next_state = INIT;
            end
            
            default: next_state = INIT;
        endcase
    end
    
    // Datapath Logic: Total Register ('tot')
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            tot <= 8'b0;
        end else begin
            case (current_state)
                INIT:    tot <= 8'b0;
                ADD:     tot <= tot + a;
                DISP:    tot <= 8'b0;
                default: tot <= tot;
            endcase
        end
    end
endmodule
