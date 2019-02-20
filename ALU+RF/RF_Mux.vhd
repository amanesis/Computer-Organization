library ieee;
use ieee.std_logic_1164.all;
use work.BUS_PKG.ALL;


entity RF_Mux is
 port(input : in BUS_32;
		control : in std_logic_vector(4 downto 0);
		output  : out std_logic_vector(31 downto 0));
end  RF_Mux;

architecture beh of RF_Mux is

signal temp_output:std_logic_vector ( 31 downto 0);

begin

temp_output<= "00000000000000000000000000000000" when control="00000" else

			input(1) when control="00001" else
			input(2) when control="00010" else
			input(3) when control="00011" else
			input(4) when control="00100" else
			input(5) when control="00101" else
			input(6) when control="00110" else
			input(7) when control="00111" else
			input(8) when control="01000" else
			input(9) when control="01001" else
			input(10) when control="01010" else
			input(11) when control="01011" else
			input(12) when control="01100" else
			input(13) when control="01101" else
			input(14) when control="01110" else
			input(15) when control="01111" else
			input(16) when control="10000" else
			input(17) when control="10001" else
			input(18) when control="10010" else
			input(19) when control="10011" else
			input(20) when control="10100" else
			input(21) when control="10101" else
			input(22) when control="10110" else
			input(23) when control="10111" else
			input(24) when control="11000" else
			input(25) when control="11001" else
			input(26) when control="11010" else
			input(27) when control="11011" else
			input(28) when control="11100" else
			input(29) when control="11101" else
			input(30) when control="11110" else
			input(31) when control="11111";
			
			output<=temp_output after 5 ns;
		
end beh;