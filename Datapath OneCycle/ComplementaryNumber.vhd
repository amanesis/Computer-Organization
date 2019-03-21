library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ComplementaryNumber is
    Port ( input : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end ComplementaryNumber;

architecture Behavioral of ComplementaryNumber is

begin

 output<=not(input);

end Behavioral;