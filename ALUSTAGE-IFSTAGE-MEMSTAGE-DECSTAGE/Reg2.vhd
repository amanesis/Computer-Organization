library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Reg2 is
    Port ( 		data 	: in  	STD_LOGIC_VECTOR (1 downto 0);
					dout 	: out  STD_LOGIC_VECTOR (1 downto 0);
					we 	: in  	STD_LOGIC;
					reset : in  	STD_LOGIC;
					clk 	: in  	STD_LOGIC);
end Reg2;

architecture Structural of Reg2 is
	component Reg1 is
		Port ( data : in  	STD_LOGIC;
					dout 	: out  STD_LOGIC;
					we 	: in  	STD_LOGIC;
					reset	: in 	STD_LOGIC;
					clk 	: in  	STD_LOGIC);
	end component;
	
begin
	reg1_0: Reg1 port map(data=>data(0), dout=>dout(0), we=>we, reset=>reset, clk=>clk);
	reg1_1: Reg1 port map(data=>data(1), dout=>dout(1), we=>we, reset=>reset, clk=>clk);	
end Structural;