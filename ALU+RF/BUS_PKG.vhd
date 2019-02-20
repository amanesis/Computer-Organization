library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- BUSES FOR DECLARARIONS

package BUS_PKG is
	type BUS_32 is array (31 downto 0) 	of STD_LOGIC_VECTOR (31 downto 0);
	type BUS_16	is array (15 downto 0) 	of STD_LOGIC_VECTOR (31 downto 0);
	type BUS_8 	is array (7 downto 0) 	of STD_LOGIC_VECTOR (31 downto 0);
	type BUS_4 	is array (3 downto 0) 	of STD_LOGIC_VECTOR (31 downto 0);
	type BUS_2 	is array (1 downto 0) 	of STD_LOGIC_VECTOR (31 downto 0);
end package;

