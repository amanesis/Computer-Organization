
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity mod_rfB is
Port( rfB : in std_logic_vector(31 downto 0);
		rfB_out : out std_logic_vector(31 downto 0)
		);
end mod_rfB;

architecture Behavioral of mod_rfB is

begin

rfB_out <= "000000000000000000000000"&rfB(7 downto 0);
						--"111111111111111111111111"

end Behavioral;

