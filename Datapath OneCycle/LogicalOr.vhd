-- 
-- OpCode = 0011
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LogicalOr is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end LogicalOr;

architecture Behavioral of LogicalOr is

begin

 output<= A or B;

end Behavioral;