library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Reg8 is
    Port ( 		data 	: in  	STD_LOGIC_VECTOR (7 downto 0);
					dout 	: out  STD_LOGIC_VECTOR (7 downto 0);
					we 	: in  	STD_LOGIC;
					reset : in 	STD_LOGIC;
					clk 	: in  	STD_LOGIC);
end Reg8;
architecture Structural of Reg8 is
	component Reg4 is
		Port ( 	data : in  	STD_LOGIC_VECTOR (3 downto 0);
					dout 	: out  STD_LOGIC_VECTOR (3 downto 0);
					we 	: in  	STD_LOGIC;
					reset	: in 	STD_LOGIC;
					clk 	: in  	STD_LOGIC);
	end component;
begin
	reg4_0: Reg4 port map(data=>data(3 downto 0), dout=>dout(3 downto 0), we=>we, reset=>reset, clk=>clk);
	reg4_1: Reg4 port map(data=>data(7 downto 4), dout=>dout(7 downto 4), we=>we, reset=>reset, clk=>clk);	
end Structural;