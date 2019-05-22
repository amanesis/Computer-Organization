library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux2to1 is
    Port ( in0 : in  STD_LOGIC;
           in1 : in  STD_LOGIC;
           sel : in  STD_LOGIC;
           output : out  STD_LOGIC);
end Mux2to1;

architecture Behavioral of Mux2to1 is

begin
 
 output <= (in1 and sel) or (in0 and (not sel));

end Behavioral;