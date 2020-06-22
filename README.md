# mips-vhdl

A monocycle mips hardware description in VHDL. We use 32 registers (5 bits index) And a memory with 256 spaces (8 spaces index).
  
## Instructions

Our mips read a .vhd circuit as an instructions (See [Ins1](/mips/inst1.vhd) and [Ins2](/mips/inst2.vhd)).

Note that our start instruction is 0x00400000, so this may be handled in your Instruction.
  
## Deployment Observations

This Mips is not completely implemented. *save word* (sw) and *load word* (lw) aren't currently implemented, our memory is a placeholder, as are our outputs for reading and writing it.
  
## Authors

* Gabriel Assunção de Souza: [@Souza-gabriel](https://github.com/Souza-gabriel)
* Hilson A. W. Jr.: [@Wojcikiewicz](https://github.com/Wojcikiewicz)
* Matheus Heck: [@MatheusHeck2001](https://github.com/MatheusHeck2001)
