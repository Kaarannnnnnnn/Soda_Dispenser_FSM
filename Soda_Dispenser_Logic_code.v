`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name:    Soda_dispenser_logic
// Project Name:   Soda Dispenser FSM Design
// Description:    Finite State Machine with Datapath (FSMD) implementation 
//                 for a soda dispenser. 
//                 - Controller handles state transitions (Init, Wait, Add, Disp)
//                 - Datapath handles 8-bit addition and cost comparison
//
// Dependencies:   None
// Revision:       1.0
//////////////////////////////////////////////////////////////////////////////////

module Soda_dispenser_logic(
    input clk,          // System Clock
    input reset,        // Asynchronous Reset
    input c,            // Coin Detected Signal
    input [7:0] a,      // Value of deposited coin (8-bit)
    input [7:0] s,      // Cost of soda (8-bit)
    output reg d        // Dispense Signal (1 = Dispense, 0 = Wait)
);
   
    // --- State Encoding ---
    parameter INIT = 2'b00;
    parameter WAIT = 2'b01;
    parameter ADD  = 2'b10;
    parameter DISP = 2'b11; 
   
    reg [1:0] current_state, next_state;
    reg [7:0] tot;      // The 'Total' Register (Accumulator)

    // -------------------------------------------------------------------------
    // 1. State Register Logic (Sequential)
    // -------------------------------------------------------------------------
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= INIT;
        else
            current_state <= next_state;
    end

    // -------------------------------------------------------------------------
    // 2. Next State Logic (Combinational Controller)
    // -------------------------------------------------------------------------
    always @(*) begin
        // Default assignments to prevent latches
        next_state = current_state;
        d = 1'b0;

        case (current_state)
            INIT: begin
                next_state = WAIT;
            end

            WAIT: begin
                if (c) 
                    next_state = ADD;       // Coin detected -> Go add it
                else if (tot >= s) 
                    next_state = DISP;      // Cost met -> Go dispense
                else
                    next_state = WAIT;      // Else -> Keep waiting
            end

            ADD: begin
                next_state = WAIT;          // Return to wait after addition
            end

            DISP: begin 
                d = 1'b1;                   // Trigger Dispense Output
                next_state = INIT;          // Reset system for next user
            end
            
            default: next_state = INIT;
        endcase
    end
    
    // -------------------------------------------------------------------------
    // 3. Datapath Logic (Sequential "Muscle")
    // -------------------------------------------------------------------------
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            tot <= 8'b0;
        end else begin
            case (current_state)
                INIT:    tot <= 8'b0;       // Clear total
                ADD:     tot <= tot + a;    // Accumulate coin value
                DISP:    tot <= 8'b0;       // Clear after dispense
                default: tot <= tot;        // Hold value
            endcase
        end
    end

endmodule
