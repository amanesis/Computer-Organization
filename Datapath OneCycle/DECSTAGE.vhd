
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity DECSTAGE is
    Port ( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrEn,reset : in  STD_LOGIC;
           ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Immed : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0));
end DECSTAGE;

architecture Behavioral of DECSTAGE is

component RF is
    Port (		Ard1 	: in  	STD_LOGIC_VECTOR (4 downto 0);
					Ard2 	: in  	STD_LOGIC_VECTOR (4 downto 0);
					Awr 	: in  	STD_LOGIC_VECTOR (4 downto 0);
					Din 	: in  	STD_LOGIC_VECTOR (31 downto 0);
					WrEn	: in 	STD_LOGIC;
					Dout1 : out  STD_LOGIC_VECTOR (31 downto 0);
					Dout2 : out  STD_LOGIC_VECTOR (31 downto 0);
					reset : in  	STD_LOGIC;
					clk 	: in  	STD_LOGIC);
end component;

component  mux2x1 is
    Port ( In0 : in  STD_LOGIC_VECTOR (31 downto 0);
           In1 : in  STD_LOGIC_VECTOR (31 downto 0);
           sel : in  STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component mux5bit_2x1 is
    Port ( In0 : in  STD_LOGIC_VECTOR (4 downto 0);
           In1 : in  STD_LOGIC_VECTOR (4 downto 0);
           sel : in  STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (4 downto 0));
end component;


component Cloud is
    Port ( Imm : in  STD_LOGIC_VECTOR (15 downto 0);
           code : in  STD_LOGIC_VECTOR (5 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

signal rr2: std_logic_vector(4 downto 0);
signal wr_data : std_logic_vector (31 downto 0);
begin

MUX_B : mux5bit_2x1 port map(
								In0 => Instr(15 downto 11),
								In1 => Instr(20 downto 16),
								sel => RF_B_sel,
								output =>rr2 );
								
MUX_RF : mux2x1 port map(
							In0 => ALU_out,
							In1 => MEM_out,
							sel => RF_WrData_sel,
							output => wr_data);								
cloud_final: Cloud port map(
								Imm => Instr (15 downto 0),
								code => Instr (31 downto 26),
								output => Immed);								
RF_final : RF port map(
						Ard1 => Instr(25 downto 21),
					   Ard2 => rr2,					
						Awr => Instr(20 downto 16),
					   Din => wr_data,
					   WrEn => RF_WrEn,
					   Dout1 => RF_A,
					   Dout2 => RF_B,
					   reset => reset,
					   clk => 	clk);
end Behavioral;


