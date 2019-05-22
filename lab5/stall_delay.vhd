
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity stall_delay is
Port (clock, A: in std_logic;
		C : out std_logic
		);
end stall_delay;

architecture Behavioral of stall_delay is

begin
process(clock)
begin
if rising_edge(clock) then
	C <= A;
end if;

end process;


end Behavioral;

