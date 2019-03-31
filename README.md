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

addi r5,r0,8 

ori r3,r0,ABCD

sw r3,4(r0)

lw r10,-4(r5)

lb r16,4(r0)

nand r4,r10,r16

not r1, r5

ror r2,r4

bne r5,r5,8

b -2  (infinite loop)

add r1.r2,r3 (not executed)




Control FSM:

![Screenshot](https://github.com/amanesis/Computer-Organization/blob/master/block-diagrams/CPU_control_fsm.jpg)

 
