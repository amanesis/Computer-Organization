library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;


entity MEM is
Port (clk, Mem_WrEn , reset: in std_logic;
		ALU_MEM_Addr, MEM_DataIn : in std_logic_vector(31 downto 0);
		MEM_DataOut : out std_logic_vector(31 downto 0)
		);
end MEM;

architecture Behavioral of MEM is

	COMPONENT RAM
	PORT(
		clk : IN std_logic;
		inst_addr : IN std_logic_vector(10 downto 0);
		data_we : IN std_logic;
		data_addr : IN std_logic_vector(10 downto 0);
		data_din : IN std_logic_vector(31 downto 0);          
		inst_dout : OUT std_logic_vector(31 downto 0);
		data_dout : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

signal  temp : std_logic_vector(31 downto 0);

begin

temp <= ALU_MEM_Addr + "00000000000000000000100000000000"; -- +0x400
	
	Inst_RAM: RAM PORT MAP(
		clk => clk,
		inst_addr => "0",
		inst_dout => "0",
		data_we => Mem_WrEn,
		data_addr => temp(12 downto 2),
		data_din =>MEM_DataIn,
		data_dout => MEM_DataOut
	);

end Behavioral;

