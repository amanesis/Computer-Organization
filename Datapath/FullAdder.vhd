library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FullAdder is
    Port ( CarryOut : out  STD_LOGIC;
           Sum : out  STD_LOGIC;
           A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           CarryIn : in  STD_LOGIC);
end FullAdder;

architecture structural of FullAdder is
component HalfAdder
port(
           inputA : in  STD_LOGIC;
           inputB : in  STD_LOGIC;
			  out1 : out  STD_LOGIC;
           out2 : out  STD_LOGIC
    );
end component;
signal signalAnd,signalXor,signalAnd2:std_logic;
begin
    HalfAdder1:HalfAdder port map(inputA=>A,inputB=>B,out1=>signalAnd,out2=>signalXor);
	 HalfAdder2:HalfAdder port map(inputA=>signalXor,inputB=>CarryIn,out1=>signalAnd2,out2=>Sum);
	 CarryOut <= signalAnd2 or signalAnd;
end structural;