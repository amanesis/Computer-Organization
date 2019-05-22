library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity mux3x1 is
port( A , B , C : in std_logic_vector(31 downto 0 );
		sel : in std_logic_vector(1 downto 0 );
		output : out std_logic_vector(31 downto 0 )
);
end mux3x1;

architecture Behavioral of mux3x1 is

begin
output<= A when sel = "00" else
        B when sel = "01" else
		  C when sel = "10" else
		  A ;
	

end Behavioral;