**CSE Bubble Processor**



* **PDS1**

    We plan to use 1024 registers, each of which stores 32 bit words. The instructions and words are loaded into these registers.

* **PDS2**

    We are using 1024 of 8 byte (32 bit) memory elements in instruction memory to hold the instructions. Similarly, we use 1024 of 8 byte memory elements in data memory to store words.

* **PDS3**

    We use the instruction encoding identical to MIPS standard. That is, opcode (of 6 bits) of 0 for R type instruction, followed by four 5 bit blocks for source1, source2, dest and shift, followed by 6 bits for funct. Similarly an opcode of 2 for J type instruction followed by 26 bits for the address of the instruction. We use format of 6 bit opcode, and 16 bit address in the end for L type instructions.



---

**ALU Instruction Set**


<table>
  <tr>
   <td><strong>Instruction</strong>
   </td>
   <td><strong>Opcode</strong>
   </td>
   <td><strong>Funct</strong>
   </td>
  </tr>
  <tr>
   <td>add
   </td>
   <td>0
   </td>
   <td>32
   </td>
  </tr>
  <tr>
   <td>addi
   </td>
   <td>0
   </td>
   <td>33
   </td>
  </tr>
  <tr>
   <td>sub
   </td>
   <td>0
   </td>
   <td>34
   </td>
  </tr>
  <tr>
   <td>subi
   </td>
   <td>0
   </td>
   <td>35
   </td>
  </tr>
  <tr>
   <td>and
   </td>
   <td>0
   </td>
   <td>36
   </td>
  </tr>
  <tr>
   <td>or
   </td>
   <td>0
   </td>
   <td>37
   </td>
  </tr>
  <tr>
   <td>sll
   </td>
   <td>0
   </td>
   <td>0
   </td>
  </tr>
  <tr>
   <td>srl
   </td>
   <td>0
   </td>
   <td>2
   </td>
  </tr>
  <tr>
   <td>beq
   </td>
   <td>3
   </td>
   <td>NA
   </td>
  </tr>
  <tr>
   <td>bne
   </td>
   <td>4
   </td>
   <td>NA
   </td>
  </tr>
  <tr>
   <td>bgt
   </td>
   <td>5
   </td>
   <td>NA
   </td>
  </tr>
  <tr>
   <td>bgte
   </td>
   <td>6
   </td>
   <td>NA
   </td>
  </tr>
  <tr>
   <td>blt 
   </td>
   <td>7
   </td>
   <td>NA
   </td>
  </tr>
  <tr>
   <td>bleq
   </td>
   <td>8
   </td>
   <td>NA
   </td>
  </tr>
</table>
