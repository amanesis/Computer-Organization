library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ALUSTAGE is
    Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
          -- Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           --ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
			  zero: out STD_LOGIC;
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0));
end ALUSTAGE;

architecture Behavioral of ALUSTAGE is

component ALU is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           Op : in  STD_LOGIC_VECTOR (3 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0);
           Zero : out  STD_LOGIC;
           Cout : out  STD_LOGIC;
           Ovf : out  STD_LOGIC);
end component;

component mux2x1 is
    Port ( In0 : in  STD_LOGIC_VECTOR (31 downto 0);
           In1 : in  STD_LOGIC_VECTOR (31 downto 0);
           sel : in  STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

signal temp_MuxOut :std_logic_vector(31 downto 0);
begin

--ALU_MUX : mux2x1 port map(
--							In0 => RF_B,
--							In1 => Immed,
--							sel =>ALU_Bin_sel ,
--							output =>temp_MuxOut);
							
ALU_final : ALU port map(
							A => RF_A,
							B => RF_B,
							Op => ALU_func,
							Zero => zero,
							output => ALU_out);							
							

end Behavioral;