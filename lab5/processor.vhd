library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity processor is
    Port ( Clock : in  STD_LOGIC;
           Reset : in  STD_LOGIC);
end processor;

architecture Behavioral of processor is

	COMPONENT DATAPATH
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		PC_Sel : IN std_logic;
		PC_LdEn : IN std_logic;
		MEM_WrEn : IN std_logic;
		memData_sel : IN std_logic;
		data_din_Sel : IN std_logic;
		ALU_Bin_sel : IN std_logic;
		ALU_alu_sel : IN std_logic;
		ALU_func : IN std_logic_vector(3 downto 0);
		RF_WrData_sel : IN std_logic;
		RF_B_sel : IN std_logic;
		RF_WrEn : IN std_logic; 
		RF_AB_we: IN std_logic;
		Instr : OUT std_logic_vector(31 downto 0);
		zero : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT CONTROL
	PORT(
		Clock : IN std_logic;
		RST : IN std_logic;
		Instr : IN std_logic_vector(31 downto 0);
		zero : IN std_logic;          
		PC_Sel : OUT std_logic;
		PC_LdEn : OUT std_logic;
		MEM_WrEn : OUT std_logic;
		memData_sel : OUT std_logic;
		data_din_Sel : OUT std_logic;
		RF_WrData_sel : OUT std_logic;
		RF_B_sel : OUT std_logic;
		RF_Wren : OUT std_logic;
		RF_AB_we: out std_logic;
		ALU_Bin_sel : OUT std_logic;
		ALU_alu_sel : OUT std_logic;
		ALU_func : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;
	
--Signals

signal instr_sig :std_logic_vector(31 downto 0);
signal zero_sig, PC_Sel_sig , PC_LdEn_sig, MEM_WrEn_sig , sig_memData_sel, sig_data_din_Sel:  std_logic;
signal sig_RF_WrData_sel, sig_RF_Wren, sig_RF_B_sel, sig_ALU_Bin_sel ,sig_ALU_alu_sel, sig_IR_en:  std_logic;
signal sig_ALU_func :  std_logic_vector(3 downto 0);
signal  sig_RF_AB_we: std_logic;


begin

	Inst_CONTROL: CONTROL PORT MAP(
		Clock =>Clock ,
		RST => Reset,
		Instr =>instr_sig ,
		zero => zero_sig,
		PC_Sel => PC_Sel_sig,
		PC_LdEn => PC_LdEn_sig,
		MEM_WrEn => MEM_WrEn_sig,
		memData_sel => sig_memData_sel,
		data_din_Sel =>sig_data_din_Sel ,
		RF_WrData_sel => sig_RF_WrData_sel,
		RF_B_sel =>sig_RF_B_sel ,
		RF_Wren => sig_RF_Wren,
		RF_AB_we => sig_RF_AB_we,
		ALU_Bin_sel => sig_ALU_Bin_sel,
		ALU_alu_sel => sig_ALU_alu_sel,
		ALU_func => sig_ALU_func
	);


	Inst_DATAPATH: DATAPATH PORT MAP(
		clk => Clock,
		reset =>Reset ,
		PC_Sel => PC_Sel_sig,
		PC_LdEn => PC_LdEn_sig,
		MEM_WrEn => MEM_WrEn_sig,
		memData_sel =>sig_memData_sel ,
		data_din_Sel => sig_data_din_Sel,
		ALU_Bin_sel => sig_ALU_Bin_sel,
		ALU_alu_sel => sig_ALU_alu_sel,
		RF_AB_we => sig_RF_AB_we,
		ALU_func => sig_ALU_func,
		RF_WrData_sel =>sig_RF_WrData_sel ,
		RF_B_sel => sig_RF_B_sel,
		RF_WrEn => sig_RF_Wren,
		Instr => instr_sig,
		zero => zero_sig
	);

end Behavioral;

