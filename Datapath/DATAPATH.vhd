library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity DATAPATH is
end DATAPATH;

architecture Behavioral of DATAPATH is

	COMPONENT MEM
	PORT(
		PC_Immed : IN std_logic_vector(31 downto 0);
		PC_sel : IN std_logic;
		PC_LdEn : IN std_logic;
		clk : IN std_logic;
		Mem_WrEn : IN std_logic;
		reset : IN std_logic;
		ALU_MEM_Addr : IN std_logic_vector(31 downto 0);
		MEM_DataIn : IN std_logic_vector(31 downto 0);          
		MEM_DataOut : OUT std_logic_vector(31 downto 0);
		Instr : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT DECSTAGE
	PORT(
		Instr : IN std_logic_vector(31 downto 0);
		RF_WrEn : IN std_logic;
		reset : IN std_logic;
		ALU_out : IN std_logic_vector(31 downto 0);
		MEM_out : IN std_logic_vector(31 downto 0);
		RF_WrData_sel : IN std_logic;
		RF_B_sel : IN std_logic;
		Clk : IN std_logic;          
		Immed : OUT std_logic_vector(31 downto 0);
		RF_A : OUT std_logic_vector(31 downto 0);
		RF_B : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT ALUSTAGE
	PORT(
		RF_A : IN std_logic_vector(31 downto 0);
		RF_B : IN std_logic_vector(31 downto 0);
		Immed : IN std_logic_vector(31 downto 0);
		ALU_Bin_sel : IN std_logic;
		ALU_func : IN std_logic_vector(3 downto 0);          
		ALU_out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;


begin

	Inst_MEM: MEM PORT MAP(
		PC_Immed => ,
		PC_sel => ,
		PC_LdEn => ,
		clk => ,
		Mem_WrEn => ,
		reset => ,
		ALU_MEM_Addr => ,
		MEM_DataIn => ,
		MEM_DataOut => ,
		Instr => 
	);
	
		Inst_DECSTAGE: DECSTAGE PORT MAP(
		Instr => ,
		RF_WrEn => ,
		reset => ,
		ALU_out => ,
		MEM_out => ,
		RF_WrData_sel => ,
		RF_B_sel => ,
		Clk => ,
		Immed => ,
		RF_A => ,
		RF_B => 
	);
	
		Inst_ALUSTAGE: ALUSTAGE PORT MAP(
		RF_A => ,
		RF_B => ,
		Immed => ,
		ALU_Bin_sel => ,
		ALU_func => ,
		ALU_out => 
	);

end Behavioral;

