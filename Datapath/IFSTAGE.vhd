library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity IFSTAGE is
Port (PC_Immed : in std_logic_vector(31 downto 0);
			PC_sel, PC_LdEn : in std_logic;
			reset, clk : in std_logic;
			PC : out std_logic_vector(31 downto 0)
		);
end IFSTAGE;

architecture Behavioral of IFSTAGE is

component MUX_IF is
Port ( A,B : in std_logic_vector(31 downto 0);
				sel : in std_logic;
				C : out std_logic_vector(31 downto 0)
		);
end component;

COMPONENT Reg32
PORT(
		data : IN std_logic_vector(31 downto 0);
		we : IN std_logic;
		reset : IN std_logic;
		clk : IN std_logic;          
		dout : OUT std_logic_vector(31 downto 0)
		);
END COMPONENT;

signal s1,s2,m1,m2 ,pcc: std_logic_vector (31 downto 0);
signal outputF: std_logic_vector (33 downto 0);
--m1,m2 mux inputs
--s1,s2 inner signals for reg32 i/o

begin

m1 <= s2 + 4;--"00000000000000000000000000000100";
m2 <= m1 + PC_Immed+4;



Inst_MUX_IF: MUX_IF PORT MAP(
		A =>m1 ,
		B => m2,
		sel => PC_Sel,
		C => s1
	);

PC_Reg32: Reg32 PORT MAP(
		data =>s1,
		dout => s2,
		we =>PC_LdEn ,
		reset => reset,
		clk => clk
	);
	
PC<=s2 after 5 ns;

end Behavioral;

