
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity forwarding_unit is
port( decex_Rs , decex_Rt , exmem_Rd , wb_Rd  : in std_logic_vector(4 downto 0);
	 exmem_Rw , wb_Rw : in std_logic;
	forwardA , forwardB : out std_logic_vector (1 downto 0)
);
end forwarding_unit;

architecture Behavioral of forwarding_unit is

begin

process (decex_Rs , decex_Rt , exmem_Rw , exmem_Rd , wb_Rw , wb_Rd)
begin


forwardA<="00";
forwardB<="00"; 
if (exmem_Rw/='0') and (exmem_Rd/="00000" ) and (exmem_Rd = decex_Rs) then
	forwardA <="01";
end if;	

if (exmem_Rw/='0') and (exmem_Rd/="00000" ) and (exmem_Rd = decex_Rt) then
	forwardB <="01";
end if;	
	
if (wb_Rw/='0') and (wb_Rd/="00000") and (wb_Rd = decex_Rs) then 
	forwardA<="10";
	if wb_Rd = exmem_Rd then
		forwardA<="01";
	end if;
end if;


if (wb_Rw/='0') and (wb_Rd/="00000") and (wb_Rd = decex_Rt) then 
	forwardB<="10";
	if wb_Rd = exmem_Rd then
		forwardB<="01";
	end if;
end if;	
  
end process;


end Behavioral;