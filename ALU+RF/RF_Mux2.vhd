library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.BUS_PKG.ALL;

entity RF_Mux2 is
    Port ( 	input 	: in  	BUS_2;
				output	: out  STD_LOGIC_VECTOR (31 downto 0);
				control	: in  	STD_LOGIC);
end RF_Mux2;

architecture beh of RF_Mux2 is

begin

output<= input(0) when control = '0' else	
			input(1);

end beh;

