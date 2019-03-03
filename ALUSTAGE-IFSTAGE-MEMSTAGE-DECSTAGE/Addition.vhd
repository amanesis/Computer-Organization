-- 
-- OpCode = 0000
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Addition is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           CarryIn : in  STD_LOGIC;
           CarryOut : out  STD_LOGIC;
			  Ovf :out STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end Addition;

architecture structual of Addition is
component FullAdder
    port ( CarryOut : out  STD_LOGIC;
           Sum : out  STD_LOGIC;
           A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           CarryIn : in  STD_LOGIC);
end component;
signal inner_carry:std_logic_vector(31 downto 0);
begin

 FullAdder1:FullAdder port map(A=>A(0),B=>B(0),CarryIn=>CarryIn,CarryOut=>inner_carry(0),Sum=>output(0));
 FullAdder_instances:
 for i in 1 to 31 generate
   FAs:FullAdder port map(A=>A(i),B=>B(i),CarryIn=>inner_carry(i-1),CarryOut=>inner_carry(i),Sum=>output(i));
 end generate;
 CarryOut<=inner_carry(31);
 Ovf<=((((B(31)and A(31)) and ( not inner_carry(30) )) and inner_carry(31)) or ((( not(B(31)) and  not(A(31)) ) and inner_carry(30)) and not(inner_carry(31))));
end structual;