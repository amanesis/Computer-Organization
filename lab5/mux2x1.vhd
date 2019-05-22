library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2x1 is
    Port ( In0 : in  STD_LOGIC_VECTOR (31 downto 0);
           In1 : in  STD_LOGIC_VECTOR (31 downto 0);
           sel : in  STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end mux2x1;

architecture Behavioral of mux2x1 is

signal tmp_delay :  STD_LOGIC_VECTOR (31 downto 0);

begin
tmp_delay<= In0 when sel = '0' else
	In1;

output<=tmp_delay after 5 ns;	
	
end Behavioral;