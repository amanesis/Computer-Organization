library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Reg1 is
    Port ( 	data 	: in  	STD_LOGIC;
					dout 	: out  STD_LOGIC;
					we 	: in  	STD_LOGIC;
					reset	: in 	STD_LOGIC;
					clk 	: in  	STD_LOGIC);
end Reg1;
architecture Structural of Reg1 is
	
component Mux2
Port (input 	: in  	STD_LOGIC_VECTOR (1 downto 0);
		output : out  STD_LOGIC;
		control : in  	STD_LOGIC);
end component;	
	
component DFlipFlop
    Port (	D 		: in  	STD_LOGIC;
				reset	: in  	STD_LOGIC;
				clk 	: in  	STD_LOGIC;
				Q 		: out  STD_LOGIC);
end component;

	signal mux2_output, DFF_output: STD_LOGIC;
	
begin
	mux_2: Mux2 port map(input(0)=>DFF_output, input(1)=>data, output=>mux2_output, control=>we);
	Dff: DFlipFlop port map(D=>mux2_output, reset=>reset, clk=>clk, Q=>DFF_output);
	dout<=DFF_output;
end Structural;