-- 			COMPUTER ORGANIZATION 	
-- 			LAB 1: ALU'S TOPLEVEL
--
--
--				OpCodes:
--
--				0000 -> ADD => 0
--				0001 -> SUB	=> 1
--				0010 -> LOGICAL AND => 2
--				0011 -> LOGICAL OR => 3
--				0100 -> INVERSION => 4
--				1000 -> ARITHMETIC SHIFT => 8
--				1001 -> LOGICAL RIGHT SHIFT => 9
--				1010 -> LOGICAL LEFT SHIFT => 10
--				1100 -> LEFT CYCLE => 12
--				1101 -> RIGHT CYCLE => 13
--
--
--
-- 			# output delay: 10 ns
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           Op : in  STD_LOGIC_VECTOR (3 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0);
           Zero : out  STD_LOGIC;
           Cout : out  STD_LOGIC;
           Ovf : out  STD_LOGIC);
end ALU;

architecture structural of ALU is
component Addition
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           CarryIn : in  STD_LOGIC;
           CarryOut : out  STD_LOGIC;
			  Ovf : out  STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
component Sub
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           CarryIn : in  STD_LOGIC;
           CarryOut : out  STD_LOGIC;
			  Ovf : out  STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
component Mux16to1
    Port ( input : in  STD_LOGIC_VECTOR (15 downto 0);
           sel : in  STD_LOGIC_VECTOR (3 downto 0);
           output : out  STD_LOGIC);
end component;
component LogicalAnd
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
	        B : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
component LogicalOr
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
	        B : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component LogicalNand is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component LogicalNor is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component ComplementaryNumber
    Port ( input : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
component ArithmeticShift
    Port ( input : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
component LogicalLeftShift
    Port ( input : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
component LogicalRightShift
    Port ( input : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
component LeftCycle
    Port ( input : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
component RightCycle
    Port ( input : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
component OrGate
    Port ( A : in  STD_LOGIC;
	        B : in  STD_LOGIC;
           output : out  STD_LOGIC);
end component;
signal carry_sub,carry_add:std_logic;
signal add_output,sub_output,log_and_output,log_or_output,log_nand_output,log_nor_output,compl_num_output,arithm_output,r_log_shift_output,l_log_shift_output,r_cyc_output,l_cyc_output:std_logic_vector(31 downto 0);
signal temp_output:std_logic_vector(31 downto 0);
signal temp_Zero:std_logic_vector(30 downto 0);
signal Ovf_add,Ovf_sub:std_logic;
signal temp_Ovf, temp_Cout:std_logic;
begin

  Add:Addition port map(A=>A,B=>B,CarryIn=>'0',CarryOut=>carry_add,Ovf=>Ovf_add,output=>add_output);  
  Sub1:Sub port map(A=>A,B=>B,CarryIn=>'0',CarryOut=>carry_sub,Ovf=>Ovf_sub,output=>sub_output);
  Log_And:LogicalAnd port map(A=>A,B=>B,output=>log_and_output);
  Log_Or:LogicalOr port map(A=>A,B=>B,output=>log_or_output);
  Log_Nand: LogicalNand port map (A=>A, B=> B, output => log_nand_output); --new
  Log_Nor: LogicalNor port map(A=>A,B=>B,output=>log_nor_output); --new
  ComplNum:ComplementaryNumber port map(input=>A,output=>compl_num_output);
  Arith_shift:ArithmeticShift port map(input=>A,output=>arithm_output);
  R_Logical_Shift:LogicalRightShift port map(input=>A,output=>r_log_shift_output);
  L_Logical_Shift:LogicalLeftShift port map(input=>A,output=>l_log_shift_output);
  R_Cycle:RightCycle port map(input=>A,output=>r_cyc_output);
  L_Cycle:LeftCycle port map(input=>A,output=>l_cyc_output);
  
  Mux_instances:for i in 0 to 31 generate
    mux:Mux16to1 port map(input(0)=>add_output(i),
                          input(1)=>sub_output(i),
                          input(2)=>log_and_output(i),
								  input(3)=> log_or_output(i),
								  input(4)=>compl_num_output(i),
								  input(5)=>'0',
								  input(6)=>log_nand_output(i),
								  input(7)=>log_or_output(i),
								  input(8)=>arithm_output(i),
								  input(9)=>r_log_shift_output(i),
								  input(10)=>l_log_shift_output(i),
                          input(11)=>'0',
								  input(12)=>l_cyc_output(i),
								  input(13)=>r_cyc_output(i),
								  input(14)=>'0',
								  input(15)=>'0',
                          sel=>Op,
								  output=>temp_output(i));
						
  end generate;
 
 
--Outputs
 
-- Cout Mux
 mux_Cout:Mux16to1 port map(input(0)=>carry_add,
                            input(1)=>carry_sub,
                            input(2)=>'0',
								    input(3)=>'0',
								    input(4)=>'0',
								    input(5)=>'0',
								    input(6)=>'0',
								    input(7)=>'0',
								    input(8)=>'0',
								    input(9)=>'0',
								    input(10)=>'0',
								    input(11)=>'0',
                            input(12)=>'0',
								    input(13)=>'0',
                            input(14)=>'0',
								    input(15)=>'0',
								    sel=>Op,
								    output=>temp_Cout);
Cout<=temp_Cout after 10 ns;
									 
-- OVF Mux
 mux_Ovf:Mux16to1 port map(input(0)=>Ovf_add,
                            input(1)=>Ovf_sub,
                            input(2)=>'0',
								    input(3)=>'0',
								    input(4)=>'0',
								    input(5)=>'0',
								    input(6)=>'0',
								    input(7)=>'0',
								    input(8)=>'0',
								    input(9)=>'0',
								    input(10)=>'0',
								    input(11)=>'0',
                            input(12)=>'0',
								    input(13)=>'0',
                            input(14)=>'0',
								    input(15)=>'0',
								    sel=>Op,
								    output=>temp_Ovf);
 output<=temp_output after 10 ns;
 Ovf<=temp_Ovf after 10 ns;
 
 -- Zero 
 First_or_gate:OrGate port map(A=>temp_output(0),B=>temp_output(1),output=>temp_Zero(0));
 or_gate_instances:
 for i in 1 to 30 generate
    or_gates:OrGate port map(A=>temp_output(i+1),B=>temp_Zero(i-1),output=>temp_Zero(i));
 end generate; 
 Zero<=not temp_Zero(30) after 10 ns;
end structural;