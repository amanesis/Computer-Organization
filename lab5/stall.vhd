library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity stall is
Port (reset ,mem_readen : in std_logic;
		ex_rt, dec_rs, dec_rt :in std_logic_vector(4 downto 0);
		en1, pc_lden: out std_logic
		);
end stall;

architecture Behavioral of stall is

begin
process( ex_rt, dec_rs, dec_rt, mem_readen)
begin
	if reset = '1' then
		en1 <= '0';
		pc_lden <= '1';
	else
		if mem_readen = '1' then
			if (ex_rt = dec_rs) or (ex_rt = dec_rt) then
				en1 <= '1';
				pc_lden <='0';
			else
				en1 <= '0';
				pc_lden <= '1';
			end if;
		else
			en1 <= '0';
			pc_lden <='1';
		end if;
	end if;

end process;
end Behavioral;