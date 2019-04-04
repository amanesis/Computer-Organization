## Computer-Organization
## Design of a multicycle MIPS processor.
1. ALU + RF
2. ALUSTAGE, DECSTAGE, IFSTAGE, MEMSTAGE

3. Datapath

![Screenshot](https://github.com/amanesis/Computer-Organization/blob/master/54433558_2067871909969037_678806868029603840_n.jpg)

4. Multicycle Processor and Exceptions (IBUS, ADDRL)

Processor Simulation
![Screenshot](https://github.com/amanesis/Computer-Organization/blob/master/Simulations/Lab2/Multicycle_processor_sim.jpg)

PROGRAM:
<pre>
addi r5,r0,8       // $R5=00000008 <br />
ori r3,r0,ABCD     // $R3=0000abcd <br />
sw r3,4(r0)        // RAM[1028] = 0000abcd <br />
lw r10,-4(r5)      // $R10 = 0000abcd <br />
lb r16,4(r0)       // $R16 = 000000cd <br />
nand r4,r10,r16    // $R4 = ffffff32 <br />
not r1, r5         // $R1 = fffffff7 <br />
ror r2,r4          // $R2 = 7ffff99 <br />
bne r5,r5,8        // false, pc=pc+4 <br />
b -2               // infinite loop, back to bne <br />
add r1,r2,r3       // not executed <br />




Control FSM: <br />

![Screenshot](https://github.com/amanesis/Computer-Organization/blob/master/block-diagrams/CPU_control_fsm.jpg)

 
