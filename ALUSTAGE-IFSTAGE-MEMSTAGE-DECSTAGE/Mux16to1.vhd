library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--				0000 -> ADD
--				0001 -> SUB
--				0010 -> LOGICAL AND
--				0011 -> LOGICAL OR
--				0100 -> INVERSION
--				1000 -> ARITHMETIC SHIFT
--				1001 -> LOGICAL RIGHT SHIFT
--				1010 -> LOGICAL LEFT SHIFT
--				1100 -> LEFT CYCLE
--				1101 -> RIGHT CYCLE

entity Mux16to1 is
    Port ( input : in  STD_LOGIC_VECTOR (15 downto 0);
           sel : in  STD_LOGIC_VECTOR (3 downto 0);
           output : out  STD_LOGIC);
end Mux16to1;

architecture Behavioral of Mux16to1 is

begin
   WITH Sel SELECT
   output <= input(0) WHEN "0000",
	input(1) WHEN "0001",
	input(2) WHEN "0010",
	input(3) WHEN "0011",
	input(4) WHEN "0100",
	input(8) WHEN "1000",
	input(9) WHEN "1001",
	input(10) WHEN "1010",
	input(12) WHEN "1100",
	input(13) WHEN "1101",
            '0' WHEN OTHERS;   
end Behavioral;
