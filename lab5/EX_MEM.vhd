library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EX_MEM is
port (
	clock,Reset : in std_logic;
	ALU , RF_B  : in std_logic_vector(31 downto 0);
	wraddr : in std_logic_vector (4 downto 0 );
	ex_control : in std_logic_vector(4 downto 0);
	ALU_out ,  RF_B_out : out std_logic_vector(31 downto 0 );
	wraddr_out , mem_control : out std_logic_vector(4 downto 0)
);
end EX_MEM;

architecture Behavioral of EX_MEM is

COMPONENT Reg32
	PORT(
		data : IN std_logic_vector(31 downto 0);
		we : IN std_logic;
		reset : IN std_logic;
		clk : IN std_logic;          
		dout : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
COMPONENT reg5bit
	PORT(
		CLK : IN std_logic;
		RST : IN std_logic;
		WE : IN std_logic;
		Data : IN std_logic_vector(4 downto 0);          
		Dout : OUT std_logic_vector(4 downto 0)
		);
	END COMPONENT;

begin

Reg1: 		Reg32 PORT MAP(data =>ALU ,dout =>ALU_out ,we => '1',reset =>Reset ,clk => clock);
Reg2: 		Reg32 PORT MAP(data => RF_B,dout => RF_B_out,we => '1',reset => Reset,clk => clock);
Reg3: 		reg5bit PORT MAP(CLK => clock,RST => Reset,WE =>'1' ,Data =>wraddr ,Dout => wraddr_out);	
Reg4:			reg5bit PORT MAP(CLK => clock,RST => Reset,WE => '1',Data =>ex_control ,Dout => mem_control);

end Behavioral;

