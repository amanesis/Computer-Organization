library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity mux2x1_2bit is
Port ( A, B : in std_logic_vector(1 downto 0);
		sel : in std_logic;
		C : out std_logic_vector(1 downto 0)
		);
end mux2x1_2bit;

architecture Behavioral of mux2x1_2bit is

begin
C<= A when sel = '0' else
	B;

end Behavioral;