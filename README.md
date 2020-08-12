# mips-vhdl

A monocycle mips hardware description in VHDL. We use 32 registers (5 bits index) And a memory with 256 spaces (8 spaces index).
  
## Instructions

Our mips receive an instruction as input and sends the addr of the instruction to be readed as output. To make it execute instructions you just need to replace the instruction component in [mips_tb](/mips/mips_tb.vhd). We choose to work this way to let a simple way to switch between instructions and be certain that it will not interfere in the mips logic. 

> (See [Inst1](/mips/mips_instructions/inst1.vhd), [Inst2](/mips/mips_instructions/inst2.vhd), [Inst3](/mips/mips_instructions/inst3.vhd) and [Inst4](/mips/mips_instructions/inst4.vhd)).

> (See [mips_tb](/mips/mips_tb.vhd))

Note that our start instruction is 0x00400000, so this may be handled in your Instruction. Soon we hope to separate the instructions from the processor, and let an easy way to make the MIPS read the instructions.
  
## Deployment Observations

This Mips is not completely implemented. *save word* (sw) and *load word* (lw) are working, but lui and ori aren't implemented yet, so you need an predefined index to use sw and lw. We used the $sp register to test those instructions. 

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

## Tests

We let the testing instructions in [mips_instructions](/mips/mips_instructions) folder for anyone who feels curiosity about our tests and what this mips can do.

### [Inst1](/mips/mips_instructions/inst1.vhd)

The first file tests the processor capacity for execute sum, subtraction and conditional branch instructions (especifically beq).

-  mipsasm code:
``` assembly
.text
main:
    addi $s0, $zero, 0
    addi $s1, $zero, 1
    addi $s2, $zero, 2
    addi $s3, $zero, 3
    addi $s4, $zero, 4

    beq $s3, $s4, L1 
    add $s0, $s1, $s2
L1: sub $s0, $s0, $s3
```
- C code:
``` C
int s0 = 0, s1 = 1, s2 = 2, s3 = 3, s4 = 4;
if (s3 != s4){
  s0 = s1 + s2;
}
s0 = s0 - s3;
```
  
### [Inst2](/mips/mips_instructions/inst2.vhd)

The second file tests the unconditional branch instructions j (jump) creating an infinity loop.

-  mipsasm code:
``` assembly
.text
main:
       addi $s0, $zero, 1
loop:  addi $s0, $s0, 2
       j loop
```
- C code:
``` C
int x = 1;
while (true){
  x += 2;
}
```
  
### [Inst3](/mips/mips_instructions/inst3.vhd)

The third file tests the unconditional branch instructions jal and jr, to validate the capacity of execute functions and procedures.

-  mipsasm code:
``` assembly
.text

j main

leaf_example:
  add $t0, $a0, $a1   # $t0 = g + h
  add $t1, $a2, $a3   # $t1 = i + j
  sub $v0, $t0, $t1   # f = $t0 - $t1
  jr $ra              # retorna do procedimento

main:
 addi $a0, $zero, 4   # inicializa 1º parâmetro (g)
 addi $a1, $zero, 3   # inicializa 2º parâmetro (h)
 addi $a2, $zero, 2   # inicializa 3º parâmetro (i)
 addi $a3, $zero, 1   # inicializa 4º parâmetro (j)
 jal leaf_example     # chama o procedimento
 nop                  # não faz nada. $v0 tem o resultado do procedimento
```
- C code:
``` C
int leaf_example (int g, int h, int i, int j) {
    int f;
    f = (g + h) - (i + j);
    return f;
}


int main(){
    int g = 4, h = 3, i = 2, j = 1, f;
    f = leaf_example(g, h, i, j);
    return 0;
}
```

### [Inst4](/mips/mips_instructions/inst4.vhd)

The fourth file tests the sw (save word) and lw (load word) commands. 

-  mipsasm code:
``` assembly
.text 

	addi $s0, $zero, 5
	sw $s0, 0($sp)
	lw $s1, 0($sp)
```
- C code:
``` C
int globalStore[10] = {0};

int main(){
    int a = 5;
    int b;
    globalStore[0] = a;
    b = globalStore[0];
}
```

## Registers conventions

|   name    |   reg#   |        convention         | Preserved on call |
| --------- | -------- | ------------------------- | ----------------- |
|   $zero   |    $0    |      **constant 0**       |   not available*  |
|    $at    |    $1    |   reserved for compiler   |   not available*  |
| $v0 - $v1 |  $2 - 3  |  value return registers   |        no         |
| $a0 - $a3 |  $4 - 7  |    function arguments     |        yes        |
| $t0 - $t7 | $8 - 15  |    temporary registers    |        no         |
| $s0 - $s7 | $16 - 23 |      saved registers      |        yes        |
| $t8 - $t9 | $24 - 25 |    temporary registers    |        no         |
| $k0 - $k1 | $26 - 27 |    reserved for hernel    |   not available*  |
|    $gp    |   $28    |    global area pointer    |        yes        |
|    $sp    |   $29    |       stack pointer       |        yes        |
|    $fp    |   $30    |       frame pointer       |        yes        |
|    $ra    |   $31    | return adress (functions) |        yes        |

> \* You shold not use these registers for instructions.

> **Preserved on call** refers for which registers you shold store the value in case of use them in a function

---

## Authors

* Gabriel Assunção de Souza: [@Souza-gabriel](https://github.com/Souza-gabriel)
* Hilson A. W. Jr.: [@Hilson-Alex](https://github.com/Hilson-Alex)
* Matheus Heck: [@MatheusHeck2001](https://github.com/MatheusHeck2001)

## License
This project is licensed under the MIT License - see the [LICENSE.md](/LICENSE) file for details
