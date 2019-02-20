library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux8to1 is
    Port ( input : in  STD_LOGIC_VECTOR (7 downto 0);
           sel : in  STD_LOGIC_VECTOR (2 downto 0);
           output : out  STD_LOGIC);
end Mux8to1;

architecture structural of Mux8to1 is
component Mux4to1
    Port ( input : in  STD_LOGIC_VECTOR (3 downto 0);
           sel : in  STD_LOGIC_VECTOR (1 downto 0);
           output : out  STD_LOGIC);
end component;
signal inner_output_A,inner_output_B,inner_signal_A,inner_signal_B:std_logic;
begin
  Mux4to1_1:Mux4to1 port map(input(0)=>input(0),
                             input(1)=>input(1),
									  input(2)=>input(2),
									  input(3)=>input(3),
									  sel(0)=>sel(0),
									  sel(1)=>sel(1),
									  output=>inner_output_A);
  Mux4to1_2:Mux4to1 port map(input(0)=>input(4),
                             input(1)=>input(5),
									  input(2)=>input(6),
									  input(3)=>input(7),
									  sel(0)=>sel(0),
									  sel(1)=>sel(1),
									  output=>inner_output_B);
  inner_signal_A<=inner_output_A and (not sel(2));
  inner_signal_B<=inner_output_B and  sel(2);
  output<=  inner_signal_A or inner_signal_B ;
end structural;

