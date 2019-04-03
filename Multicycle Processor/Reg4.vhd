library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Reg4 is
    Port ( 	data 	: in  	STD_LOGIC_VECTOR (3 downto 0);
					dout 	: out  STD_LOGIC_VECTOR (3 downto 0);
					we 	: in  	STD_LOGIC;
					reset : in  	STD_LOGIC;
					clk 	: in  	STD_LOGIC);
end Reg4;

architecture Structural of Reg4 is
	component Reg2 is
		Port ( data : in  	STD_LOGIC_VECTOR (1 downto 0);
					dout 	: out  STD_LOGIC_VECTOR (1 downto 0);
					we 	: in  	STD_LOGIC;
					reset	: in 	STD_LOGIC;
					clk 	: in  	STD_LOGIC);
	end component;
begin
	reg2_0: Reg2 port map(data=>data(1 downto 0), dout=>dout(1 downto 0), we=>we, reset=>reset, clk=>clk);
	reg2_1: Reg2 port map(data=>data(3 downto 2), dout=>dout(3 downto 2), we=>we, reset=>reset, clk=>clk);	
end Structural;