![](../../workflows/gds/badge.svg) ![](../../workflows/docs/badge.svg) ![](../../workflows/test/badge.svg)

# 4bit Arithmetic Logic Unit based on Texas Instruments 74LS181
Purpose of this project is to examine the working principle of a commonly used 4bit ALU, in order to redesign its IC integration using Tiny Tapeout tools that are available online. The project was issued in early 2024, so we use TT07 chip's architecture. It was a semester project on the VLSI course in my Integrated Master's Studies.

## Project Summary
In the first part of the project, we studied the schematic of the IC provided by Texas Instruments 74LS181 [(datasheet)](https://www.ti.com/lit/ds/symlink/sn54ls181.pdf).
Using the schematic and also the function table provided, we were able to recompile the whole IC on Verilog code. To test the functionality of this code, we used an FPGA, specifically the Spartan II family XC2S100-PQ208, programmable using Xilinx ISE v10.1 (legacy product).
After testing of our code, we uploaded it in this repository, which is a copy of Tiny Tapeout's [/tt07-verilog-template](https://github.com/TinyTapeout/tt07-verilog-template/tree/main). Using the Actions written in Python, we ended up having a 3D multilayer visual representation of the designed IC in VLSI (Very Large Scale Integration). This design would be used in TT07.
<p align = "center">
  <img width="1646" height="765" alt="image" src="https://github.com/user-attachments/assets/e9860be0-dba4-4fba-aaa9-048785866c5b" />
</p>

## Project Index

### 1. [FPGA_testing](/FPGA_testing)
Folder contains the code written in Verilog for functionality testing with the FPGA. Also, contains a Pin Assignment file used for the process, along with the addon used. 

### 2. [Schematic](/Schematic)
Folder contains the internal schematic of the IC 741LS181

### 3. [src](/src)
Folder contains the Verilog file used for Tiny Tapeout's Integration

### 4. [info.yaml](info.yaml)
File contains information about the project

### 5. [info.md](/docs/info.md)
File contains information about the project in Markdown format

### 6. [test](/test)
Folder containing testbench files used by Tiny Tapeout

## What is an Arithmetic Logic Unit?
An Arithmetic Logic Unit (ALU) is the calculator that performs all the arithmetic and logic functions inside a computer. The basic artithmetic functions it can perform are the following:
- Addition / Subtraction (with or without carry)
- Increment by 1
- Decrement by 1
- Two's Complement (subraction of every bit value from 0)

The basic logic functions that can be performed are the following:
- AND
- OR
- XOR
- One's Complement (reversing every bit value)
- NOT

We can understand its working principle better by looking the circuit symbol used to define an ALU. That symbol is the one on the picture below.
<p align = "center">
  <img width="348" height="239" alt="image" src="https://github.com/user-attachments/assets/85dcd28d-74f8-42b3-b50e-09aa7e356a87" />
</p> 

The ALU has 2 inputs _A_ and _B_, which are the numbers that need to be processed. The output of the operation performed is given in _Y_. The _Opcode_ input defines the function that is to be performed by the ALU. The _Status_ input and output can be used to flag if there is a carry in the result or the input. 

## The 74LS181 Integrated Circuit
In March 1970, Texas Instruments made an effort to generate the first 4-bit ALU, an integrated circuit named SN74181, which is the same one as the 74LS181 by Motorola. The IC is capable of performing 32 different operations. As can be seen in the [internal schematic](/Schematic/sn74ls181.jpg) of the IC, it is consisted of 75 simple logic gates (the gates of more than 2 inputs are analyzed in 2 input gates), therefore the IC belongs to **Medium Scale Integration** (MSI) category (ICs with less than 100 gates). The silicon wafer of the IC can be seen in the picture below.
<p align = "center">
  <img width="613" height="646" alt="image" src="https://github.com/user-attachments/assets/1aa440fe-eb24-4cca-ac3a-5f82deca309b" />  
</p>

#### Function Table
In the picture below we can see the table of functions that can be performed by the 74181 IC. This table concerns Active - HIGH Data. Selection is performed with the use of a **4bit input S**(S3 ~ S0) and with the **1bit M input** we can select a different set of operations, when M is HIGH we select Logic Functions and when M is LOW we select Arithmetic Functions. There is also an option of a set of functions to be performed with carry or with no carry by altering the value of the **1bit input Cn**.

<p align = "center">
  <img width="746" height="431" alt="image" src="https://github.com/user-attachments/assets/3173d0bc-d2a9-42dc-b536-97959105fdb2" />
</p>

### Why Verilog and not VHDL?
The reason for using Verilog instead of VHDL for this particular project is double. First, I wanted to experiment with the syntax differences between VHDL and Verilog and most significantly because Tiny Tapeout tools that will be used for visualization of the designed IC requires Verilog logic coding input. Syntax-wise, Verilog is a language that mostly resembles the C programming language, opposing VHDL that its syntax resembles older programming languages like Pascal.

As we can see in the image below, Verilog is becoming more and more popular in countries where advances in digital technology come rapidly, like India and United States, opposing to European countries that VHDL is still dominant in the market.

<p align = "center">
  <img width="748" height="535" alt="image" src="https://github.com/user-attachments/assets/b75891e8-c6c3-41c0-a250-044e31e6ac7f" />
</p>

## What is Tiny Tapeout?

Tiny Tapeout is an educational project that aims to make it easier and cheaper than ever to get your digital designs manufactured on a real chip.

To learn more and get started, visit the [website](https://tinytapeout.com).

## Set up your Verilog project

1. Add your Verilog files to the `src` folder.
2. Edit the [info.yaml](info.yaml) and update information about your project, paying special attention to the `source_files` and `top_module` properties. If you are upgrading an existing Tiny Tapeout project, check out our [online info.yaml migration tool](https://tinytapeout.github.io/tt-yaml-upgrade-tool/).
3. Edit [docs/info.md](docs/info.md) and add a description of your project.
4. Adapt the testbench to your design. See [test/README.md](test/README.md) for more information.

The GitHub action will automatically build the ASIC files using [OpenLane](https://www.zerotoasiccourse.com/terminology/openlane/).

## Enable GitHub actions to build the results page

- [Enabling GitHub Pages](https://tinytapeout.com/faq/#my-github-action-is-failing-on-the-pages-part)
