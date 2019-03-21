-- 
-- OpCode = 0010
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LogicalAnd is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
	        B : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end LogicalAnd;

architecture Behavioral of LogicalAnd is

begin
 
 output<= A and B;

end Behavioral;

