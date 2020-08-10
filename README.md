# mips-vhdl

A monocycle mips hardware description in VHDL. We use 32 registers (5 bits index) And a memory with 256 spaces (8 spaces index).
  
## Instructions

Our mips read a .vhd circuit as an instructions (See [Ins1](/mips/inst1.vhd), [Ins2](/mips/inst2.vhd), See [Ins3](/mips/inst3.vhd) and See [Ins4](/mips/inst4.vhd)).

Note that our start instruction is 0x00400000, so this may be handled in your Instruction. Soon we hope to separate the instructions from the processor, and let an easy way to make the MIPS read the instructions.
  
## Deployment Observations

This Mips is not completely implemented. *save word* (sw) and *load word* (lw) are working, but lui and ori aren't implemented yet, so you need an predefined index to use sw and lw.

### Currently implemented instructions:

- **R Instructions**

  - *add*
  - *sub*
  - *and*
  - *or*
  - *slt (set on less than)*
  - *jr (jump register)*
  
- **I Instructions**
  
  - *addi (sdd imemdiate)*
  - *sw (store word)*
  - *lw (load word)*
  - *beq (branch on equal)*
  
- **J Instructions**
  - *j (jump)*
  - *jal (jump and link)*
  
## Authors

* Gabriel Assunção de Souza: [@Souza-gabriel](https://github.com/Souza-gabriel)
* Hilson A. W. Jr.: [@Hilson-Alex](https://github.com/Hilson-Alex)
* Matheus Heck: [@MatheusHeck2001](https://github.com/MatheusHeck2001)

---
## License
This project is licensed under the MIT License - see the [LICENSE.md](/LICENSE) file for details
