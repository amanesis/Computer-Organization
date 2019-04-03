library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity cloudnew is
    Port (Imm : in  	STD_LOGIC_VECTOR (15 downto 0);
				Outp : out  	STD_LOGIC_VECTOR (31 downto 0);
code : in STD_LOGIC_VECTOR (5 downto 0));
end cloudnew;

architecture Behavioral of cloudnew is

begin
	ConvertImmediate:  process(code, Imm)
	begin
		case code is
			when "000011" | "000111" | "001111" | "011111" | "110000" | "111000" => --SignExt
				for i in 0 to 15 loop
					Outp(16+i)<=Imm(15);
				end loop;
				Outp(15 downto 0)<=Imm;
			when "111111" | "000000" | "000001" => --SignExt(Imm)<<2
				for i in 0 to 13 loop
					Outp(18+i)<=Imm(15);
				end loop;
				Outp(17 downto 2)<=Imm;
				Outp(1 downto 0)<="00";
			when "111001"=> --Imm<<16zerofill
				Outp(31 downto 16)<=Imm;
				Outp(15 downto 0)<=std_logic_vector(to_unsigned(0,16));
			when "110010" | "110011"=> --ZeroFill
				Outp(31 downto 16)<=std_logic_vector(to_unsigned(0,16));
				Outp(15 downto 0)<=Imm;
			when others => Outp<=std_logic_vector(to_unsigned(0,32));
		end case;
end process ConvertImmediate;


end Behavioral;

