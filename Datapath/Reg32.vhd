library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Reg32 is
    Port ( 		data 	: in  	STD_LOGIC_VECTOR (31 downto 0);
					dout 	: out  STD_LOGIC_VECTOR (31 downto 0);
					we 	: in  	STD_LOGIC;
					reset : in  	STD_LOGIC;
					clk 	: in  	STD_LOGIC);
end Reg32;
architecture Structural of Reg32 is
	component Reg16 is
		Port ( data : in  	STD_LOGIC_VECTOR (15 downto 0);
					dout 	: out  STD_LOGIC_VECTOR (15 downto 0);
					we 	: in  	STD_LOGIC;
					reset	: in 	STD_LOGIC;
					clk 	: in  	STD_LOGIC);
	end component;
begin
	reg16_0: Reg16 port map(data=>data(15 downto 0), 		dout=>dout(15 downto 0), 	we=>we, reset=>reset, clk=>clk);
	reg16_1: Reg16 port map(data=>data(31 downto 16),	dout=>dout(31 downto 16), 	we=>we, reset=>reset, clk=>clk);	
end Structural;