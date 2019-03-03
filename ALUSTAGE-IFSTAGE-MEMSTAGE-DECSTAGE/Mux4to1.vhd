library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux4to1 is
    Port ( input : in  STD_LOGIC_VECTOR (3 downto 0);
           sel : in  STD_LOGIC_VECTOR (1 downto 0);
           output : out  STD_LOGIC);
end Mux4to1;

architecture structural of Mux4to1 is
component Mux2to1
    Port ( in0 : in  STD_LOGIC;
           in1 : in  STD_LOGIC;
           sel : in  STD_LOGIC;
           output : out  STD_LOGIC);
end component;
signal inner_signal_A,inner_signal_B:std_logic;
begin
   Mux2to1_1: Mux2to1 port map(in0=>input(0),
	                            in1=>input(1),
										 sel=>sel(0),
										 output=>inner_signal_A);
   Mux2to1_2: Mux2to1 port map(in0=>input(2),
	                            in1=>input(3),
										 sel=>sel(0),
										 output=>inner_signal_B);
	Mux2to1_3: Mux2to1 port map(in0=>inner_signal_A,
	                            in1=>inner_signal_B,
										 sel=>sel(1),
										 output=>output);
end structural;

