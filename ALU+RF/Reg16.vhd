library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Reg16 is
    Port ( 		data 	: in  	STD_LOGIC_VECTOR (15 downto 0);
					dout 	: out  STD_LOGIC_VECTOR (15 downto 0);
					we 	: in  	STD_LOGIC;
					reset : in  	STD_LOGIC;
					clk 	: in  	STD_LOGIC);
end Reg16;
architecture Structural of Reg16 is
	component Reg8 is
		Port ( data : in  	STD_LOGIC_VECTOR (7 downto 0);
					dout 	: out  STD_LOGIC_VECTOR (7 downto 0);
					we 	: in  	STD_LOGIC;
					reset	: in 	STD_LOGIC;
					clk 	: in  	STD_LOGIC);
	end component;
begin
	reg8_0: Reg8 port map(data=>data(7 downto 0),dout=>dout(7 downto 0), we=>we, reset=>reset, clk=>clk);
	reg8_1: Reg8 port map(data=>data(15 downto 8), 	dout=>dout(15 downto 8),	we=>we, reset=>reset, clk=>clk);	
end Structural;