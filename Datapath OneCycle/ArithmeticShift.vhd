-- 
-- OpCode = 1000
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ArithmeticShift is
    Port ( input : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end ArithmeticShift;

architecture Behavioral of ArithmeticShift is

begin

 output(0)<=input(1);
 output(1)<=input(2);
 output(2)<=input(3);
 output(3)<=input(4);
 output(4)<=input(5);
 output(5)<=input(6);
 output(6)<=input(7);
 output(7)<=input(8);
 output(8)<=input(9);
 output(9)<=input(10);
 output(10)<=input(11);
 output(11)<=input(12);
 output(12)<=input(13);
 output(13)<=input(14);
 output(14)<=input(15);
 output(15)<=input(16);
 output(16)<=input(17);
 output(17)<=input(18);
 output(18)<=input(19);
 output(19)<=input(20);
 output(20)<=input(21);
 output(21)<=input(22);
 output(22)<=input(23);
 output(23)<=input(24);
 output(24)<=input(25);
 output(25)<=input(26);
 output(26)<=input(27);
 output(27)<=input(28);
 output(28)<=input(29);
 output(29)<=input(30);
 output(30)<=input(31);
 output(31)<=input(31);

end Behavioral;