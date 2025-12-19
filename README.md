# Soda_Dispenser_FSM
# 🥤 Soda Dispenser FSM - Verilog Implementation

> **Bridging Theory & Practice:** A Digital Logic Design project translating handwritten Semester 5 EXTC notes into a functional Verilog simulation.

![Verilog](https://img.shields.io/badge/Language-Verilog_HDL-blue)
![Tool](https://img.shields.io/badge/Tool-Xilinx_Vivado-red)
![Status](https://img.shields.io/badge/Status-Verified-success)

## 📖 Overview
This project implements a **Finite State Machine with Datapath (FSMD)** for a digital soda dispenser. Unlike simple counters, this design separates the **Control Logic** (State Machine) from the **Datapath** (Arithmetic & Storage), mimicking real-world processor architecture.

The system accepts coin inputs, accumulates the total value, and triggers a dispense signal once the accumulated amount equals or exceeds the soda cost.

## ⚙️ Architecture

The design consists of two main units:

1.  **The Controller (FSM):**
    * Manages state transitions: `INIT`, `WAIT`, `ADD`, `DISP`.
    * Monitors external inputs (`coin_detected`) and internal status flags (`total >= cost`).
2.  **The Datapath:**
    * Contains an **8-bit Accumulator Register** (`tot`).
    * Performs arithmetic addition (`tot = tot + coin_value`).
    * Compares the total against the set soda cost.

### 🧩 Schematic
![image alt](https://github.com/Kaarannnnnnnn/Soda_Dispenser_FSM/blob/695593396e132eb5813ad203450dca5fd51e77b4/schematic.png)

## 🛠️ Finite State Machine (FSM) Logic

The system operates on a 4-state logic:

| State | Encoding | Description |
| :--- | :--- | :--- |
| **INIT** | `00` | System reset. Clears total register to 0. |
| **WAIT** | `01` | Idle state. Waits for coin insertion (`c=1`) or dispense condition (`tot >= s`). |
| **ADD** | `10` | Adds the deposited coin value to the accumulator. Returns to WAIT. |
| **DISP** | `11` | Assert `dispense` signal (Output = 1). Resets system after dispensing. |

## 📊 Simulation Results

The design was verified using **Xilinx Vivado Behavioral Simulation**.

**Test Case:**
* **Soda Cost:** 30 units
* **Action 1:** Deposit 10 units (System waits, Total = 10)
* **Action 2:** Deposit 20 units (Total = 30)
* **Result:** `dispense` signal goes HIGH.

![image alt](

## 🚀 How to Run

1.  **Clone the Repository:**
    ```bash
    git clone [https://github.com/your-username/soda-dispenser-verilog.git](https://github.com/your-username/soda-dispenser-verilog.git)
    ```
2.  **Open in Vivado/ModelSim:**
    * Add `soda_dispenser.v` as the Design Source.
    * Add `soda_dispenser_tb.v` as the Simulation Source.
3.  **Run Simulation:**
    * Execute Behavioral Simulation for 100ns.

## 📂 File Structure

```text
├── soda_dispenser.v       # Main RTL Design Module
├── soda_dispenser_tb.v    # Testbench for verification
├── assets/                # Images (Schematics, Waveforms)
└── README.md              # Project Documentation
