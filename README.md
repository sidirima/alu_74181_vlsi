![](../../workflows/gds/badge.svg) ![](../../workflows/docs/badge.svg) ![](../../workflows/test/badge.svg)

# 4bit Arithmetic Logic Unit based on Texas Instruments 74LS181
Purpose of this project is to examine the working principle of a commonly used 4bit ALU, in order to redesign its IC integration using Tiny Tapeout tools that are available online. The project was issued in early 2024, so we use TT07 chip's architecture. It was a semester project on the VLSI course in my Integrated Master's Studies.

## Project Summary
In the first part of the project, we studied the schematic of the IC provided by Texas Instruments 74LS181 [(datasheet)](https://www.ti.com/lit/ds/symlink/sn54ls181.pdf).
Using the schematic and also the function table provided, we were able to recompile the whole IC on Verilog code. To test the functionality of this code, we used an FPGA, specifically the Spartan II family XC2S100-PQ208, programmable using Xilinx ISE v10.1 (legacy product).
After testing of our code, we uploaded it in this repository, which is a copy of Tiny Tapeout's [/tt07-verilog-template](https://github.com/TinyTapeout/tt07-verilog-template/tree/main). Using the Actions written in Python, we ended up having a 3D multilayer visual representation of the designed IC in VLSI (Very Large Scale Integration). This design would be used in TT07.
<p align = "center">
  <img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/51b4ec09-404f-4c69-b929-0a1d510a7f96" />
</p>

## Project Index

### 1. [FPGA_testing](/FPGA_testing)
Folder contains the code written in Verilog for functionality testing with the FPGA. Also, contains a Pin Assignment file used for the process, along with the addon used. 

### 2. [src](/src)
Folder contains the Verilog file used for Tiny Tapeout's Integration

### 3. [info.yaml](info.yaml)
File contains information about the project

### 4. [info.md](info.md)
File contains information about the project in Markdown format

### 5. [test](/test)
Folder containing testbench files used by Tiny Tapeout


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
