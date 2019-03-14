library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux2 is
    Port (	input : in  STD_LOGIC_VECTOR (1 downto 0);
				output : out  STD_LOGIC;
				control : in  	STD_LOGIC);
end Mux2;

architecture Structural of Mux2 is

begin

	output<= (input(0) and (not control)) or (input(1) and control);
end Structural;