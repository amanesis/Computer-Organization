
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity mux5bit_2x1 is
    Port ( In0 : in  STD_LOGIC_VECTOR (4 downto 0);
           In1 : in  STD_LOGIC_VECTOR (4 downto 0);
           sel : in  STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (4 downto 0));
end mux5bit_2x1;

architecture Behavioral of mux5bit_2x1 is

begin

output<= In0 when sel = '0' else
	In1;

end Behavioral;

