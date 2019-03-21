library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity HalfAdder is
    Port ( inputA : in  STD_LOGIC;
           inputB : in  STD_LOGIC;
			  out1 : out  STD_LOGIC;
           out2 : out  STD_LOGIC);
end HalfAdder;

architecture Behavioral of HalfAdder is

begin
 
 out1<= inputA and inputB;
 out2<= inputA xor inputB;
 
end Behavioral;