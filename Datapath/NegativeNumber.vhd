library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity NegativeNumber is
    Port ( input : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end NegativeNumber;

architecture structural of NegativeNumber is
component ComplementaryNumber
    Port ( input : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
component Addition
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           CarryIn : in  STD_LOGIC;
           CarryOut : out  STD_LOGIC;
			  Ovf :out STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
signal inner_output:std_logic_vector(31 downto 0);
signal carry_out:std_logic;
signal inner_Ovf:std_logic;
begin
 Compl_Number:ComplementaryNumber port map(input=>input,output=>inner_output);
 Add:Addition port map(A=>inner_output,
                       B=>"00000000000000000000000000000001",
							  CarryIn=>'0',
							  CarryOut=>carry_out,
							  Ovf =>inner_Ovf,
							  output=>output);

end structural;