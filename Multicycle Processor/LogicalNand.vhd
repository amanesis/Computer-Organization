library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LogicalNand is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end LogicalNand;

architecture Behavioral of LogicalNand is

begin

output <= A nand B;

end Behavioral;

