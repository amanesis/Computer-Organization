library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MEM_WRITE_BACK is
port(clock , Reset : in std_logic;
	  mem_wback_input , reg_waddr : in std_logic_vector(4 downto 0 );
	  aluin : in std_logic_vector(31 downto 0);
	  mem_wback_out , reg_waddr_out: out std_logic_vector(4 downto 0 );
	  aluout : out std_logic_vector(31 downto 0)
);
end MEM_WRITE_BACK;

architecture Behavioral of MEM_WRITE_BACK is

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
Reg1: reg5bit PORT MAP(CLK => clock,RST =>Reset ,WE =>'1' ,Data =>mem_wback_input ,Dout => mem_wback_out);
Reg2: reg5bit PORT MAP(CLK =>clock ,RST => Reset,WE =>'1' ,Data =>reg_waddr ,Dout => reg_waddr_out);
Reg3: Reg32 PORT MAP(data =>aluin ,dout => aluout,we =>'1' ,reset =>Reset ,clk =>clock );


end Behavioral;

