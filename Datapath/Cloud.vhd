
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Cloud is
    Port ( Imm : in  STD_LOGIC_VECTOR (15 downto 0);
           code : in  STD_LOGIC_VECTOR (5 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end Cloud;

architecture Behavioral of Cloud is

begin
	ConvertImmediate:  process(code, Imm)
	begin
		case code is
			when "000011" | "000111" | "001111" | "011111" | "110000" | "111000" => --SignExt
				for i in 0 to 15 loop
					output(16+i)<=Imm(15);
				end loop;
				output(15 downto 0)<=Imm;
			when "111111" | "000000" | "000001" => --SignExt(Imm)<<2
				for i in 0 to 13 loop
					output(18+i)<=Imm(15);
				end loop;
				output(17 downto 2)<=Imm;
				output(1 downto 0)<="00";
			when "111001"=> --Imm<<16zerofill
				output(31 downto 16)<=Imm;
				output(15 downto 0)<=std_logic_vector(to_unsigned(0,16));
			when "110010" | "110011"=> --ZeroFill
				output(31 downto 16)<=std_logic_vector(to_unsigned(0,16));
				output(15 downto 0)<=Imm;
			when others => output<=std_logic_vector(to_unsigned(0,32));
		end case;
end process ConvertImmediate;
end Behavioral;