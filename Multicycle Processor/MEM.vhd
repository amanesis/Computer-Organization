library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;


entity MEM is
Port ( PC_Immed : in std_logic_vector(31 downto 0);
		PC_sel, PC_LdEn : in std_logic;
		clk, Mem_WrEn , reset: in std_logic;
		ALU_MEM_Addr, MEM_DataIn : in std_logic_vector(31 downto 0);
		MEM_DataOut , Instr: out std_logic_vector(31 downto 0)
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
	
	
	COMPONENT IFSTAGE
	PORT(
		PC_Immed : IN std_logic_vector(31 downto 0);
		PC_sel : IN std_logic;
		PC_LdEn : IN std_logic;
		reset : IN std_logic;
		clk : IN std_logic;          
		PC : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

signal s2, temp : std_logic_vector(31 downto 0);

begin

temp <= ALU_MEM_Addr + "00000000000000000000010000000000"; -- +0x400
																--	"00000000000000000000010000000000"
		Inst_IFSTAGE: IFSTAGE PORT MAP(
		PC_Immed => PC_Immed,
		PC_sel => PC_sel,
		PC_LdEn => PC_LdEn,
		reset => reset,
		clk => clk,
		PC => s2
	);

	
	Inst_RAM: RAM PORT MAP(
		clk => clk,
		inst_addr => s2(12 downto 2), --"0"
		inst_dout => Instr, -- "0"
		data_we => Mem_WrEn,
		data_addr => temp(10 downto 0),
		data_din =>MEM_DataIn,
		data_dout => MEM_DataOut
	);

end Behavioral;

