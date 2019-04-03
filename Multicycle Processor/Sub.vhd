-- 
-- OpCode = 0001
--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Sub is
    Port ( A,B : in  STD_LOGIC_VECTOR (31 downto 0);
           CarryIn : in  STD_LOGIC;
           CarryOut : out  STD_LOGIC;
			  Ovf : out  STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end Sub;

architecture structural of Sub is
component Addition
    port ( A,B : in  STD_LOGIC_VECTOR (31 downto 0);
			  Ovf : out STD_LOGIC;
			  CarryIn : in  STD_LOGIC;
           CarryOut : out  STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
component NegativeNumber
    Port ( input : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
signal Bneg:std_logic_vector(31 downto 0);
begin
   Negative_B:NegativeNumber port map(input=>B,output=>Bneg);
   Add:Addition port map(A=>A,B=>Bneg,CarryIn=>CarryIn,CarryOut=>CarryOut,Ovf=>Ovf,output=>output);
end structural;

