
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Cloud is
    Port ( Imm : in  STD_LOGIC_VECTOR (15 downto 0);
           code : in  STD_LOGIC_VECTOR (5 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end Cloud;

architecture Behavioral of Cloud is

signal temp_out: std_logic_vector(31 downto 0);

begin
process(Imm,code,temp_out)
begin
if code = "111001" then
		temp_out <= Imm & "0000000000000000";
elsif code = "110010" or code = "110011" then
		temp_out <= "0000000000000000"&Imm;
elsif code <= "111111" or code = "000000" or code = "000001" then 
		if Imm(15) = '0' then 
			temp_out <= "00000000000000" & Imm & "00";
		else
			temp_out <= "11111111111111" & Imm & "00";
		end if;  
elsif code = "111000" or code = "110000" or code = "000001" or code = "000111" or code = "001111" or code = "011111" then 
			if Imm(15) = '0' then
				temp_out <= "0000000000000000" & Imm;
			else
				temp_out <= "1111111111111111" & Imm;
			end if;	
end if;
end process;

output <= temp_out;
end Behavioral;