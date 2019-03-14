library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity OrGate is
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           output : out  STD_LOGIC);
end OrGate;

architecture Behavioral of OrGate is

begin
 
 output<=A or B;

end Behavioral;