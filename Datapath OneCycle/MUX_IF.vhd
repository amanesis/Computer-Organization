library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity MUX_IF is
Port ( A,B : in std_logic_vector(31 downto 0);
		sel : in std_logic;
		C : out std_logic_vector(31 downto 0)
		);
end MUX_IF;

architecture Behavioral of MUX_IF is

signal tmp_delay :  STD_LOGIC_VECTOR (31 downto 0);

begin

tmp_delay<= A when sel = '0' else
	B when sel='1';

C<=tmp_delay after 5 ns;
end Behavioral;

