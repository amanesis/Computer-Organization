
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity LogicalNor is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end LogicalNor;

architecture Behavioral of LogicalNor is

begin

output <= A nor B;

end Behavioral;

