
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg5bit is
Port( CLK, RST, WE : in std_logic;
		Data : in std_logic_vector(4 downto 0);
		Dout : out std_logic_vector(4 downto 0)
		);
end reg5bit;

architecture Behavioral of reg5bit is
signal temp : std_logic_vector(4 downto 0);

begin
process(CLK)
begin
IF RST='1' then
 temp<="00000";
 else
	If rising_edge(CLK) then
		If WE = '1' then
			temp <= Data;
		else
			temp <= temp;
		end if;
	end if;
end if;

end process;

Dout <= temp;
		
	
end Behavioral;