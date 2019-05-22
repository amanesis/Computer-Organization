--Datapath Unit
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity DATAPATH is
port ( clk , reset : in std_logic;
			PC_Sel , PC_LdEn  : in std_logic; 
			MEM_WrEn, memData_sel, data_din_Sel : in std_logic;
			ALU_Bin_sel, ALU_alu_sel : in std_logic;
			
			ALU_func : in std_logic_vector(3 downto 0); 
			RF_WrData_sel, RF_B_sel , RF_WrEn, RF_AB_we : in std_logic;
			Instr : out std_logic_vector(31 downto 0);
			zero : out std_logic
		);
end DATAPATH;

architecture Behavioral of DATAPATH is

	COMPONENT mux2x1
	PORT(
		In0 : IN std_logic_vector(31 downto 0);
		In1 : IN std_logic_vector(31 downto 0);
		sel : IN std_logic;          
		output : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	
	COMPONENT Reg32
	PORT(
		data : IN std_logic_vector(31 downto 0);
		we : IN std_logic;
		reset : IN std_logic;
		clk : IN std_logic;          
		dout : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT mod_rfB
	PORT(
		rfB : IN std_logic_vector(31 downto 0);          
		rfB_out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

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
		zero: out STD_LOGIC;	
		ALU_out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

-- INNER SIGNALS:

--signal s_alu_out , s_mem_din , s_mem_dout , s_instr , s_immed, s_regB, s_mem_dout_mod, s_mem_dout_final , ir_out , MEMR_out: std_logic_vector (31 downto 0);
--signal temp_regA , temp_regB, mux_out : std_logic_vector(31 downto 0);

signal in_immed, in_alu_out, in_mem_din, in_mem_dout, in_instr, MEM_Reg_out, MEM_Reg_outDelay,
			IF_Reg_out,IF_Reg_outDelay, in_mem_dout_final, temp_A, temp_B, mux_out, in_mem_dout_mod, in_temp_B : std_logic_vector(31 downto 0);
signal sig_rfA, sig_rfB, sig_rfA_reg, sig_rfB_reg,sig_rfA_reg_delay,sig_rfB_reg_delay: std_logic_vector(31 downto 0);
--signal RF_AB_we: std_logic;
begin

-- IFSTAGE + MEMSTAGE
IFMEMStage: MEM PORT MAP(
		PC_Immed => in_immed,
		PC_sel => PC_sel,
		PC_LdEn => PC_LdEn,
		clk => clk,
		Mem_WrEn => Mem_WrEn,
		reset => reset,
		ALU_MEM_Addr => in_alu_out,
		MEM_DataIn => in_mem_din,
		MEM_DataOut => in_mem_dout ,
		Instr => in_instr
	);

-- Registers that drive the RF's outputs RF_A, RF_B to ALU.
-- 5 ns delay for each output

RF_A_REG: Reg32 PORT MAP(
		data => sig_rfA,
		dout =>sig_rfA_reg_delay ,
		we => RF_AB_we,
		reset => reset,
		clk => clk
	);
	
sig_rfA_reg<=sig_rfA_reg_delay after 5 ns;

RF_B_REG: Reg32 PORT MAP(
		data => sig_rfB,
		dout => sig_rfB_reg_delay,
		we => RF_AB_we ,
		reset => reset,
	clk => clk
	);
	
sig_rfB_reg<=sig_rfB_reg_delay after 5 ns;

-- DECSTAGE
DEC_STAGE: DECSTAGE PORT MAP(
		Instr => in_instr,
		RF_WrEn =>RF_WrEn ,
		reset => reset,
		ALU_out => in_alu_out,
		MEM_out => in_mem_dout_final,
		RF_WrData_sel =>RF_WrData_sel ,
		RF_B_sel => RF_B_sel,
		Clk => clk,
		Immed => in_immed,
		RF_A => sig_rfA,
		RF_B => sig_rfB
	);

-- ALUSTAGE
ALU_STAGE: ALUSTAGE PORT MAP(
		RF_A => mux_out,
		RF_B => sig_rfB_reg,
		Immed => in_immed,
		ALU_Bin_sel =>ALU_Bin_sel ,
		ALU_func => ALU_func,
		Zero => zero,
		ALU_out => in_alu_out
	);

-- Mux for choosing rfA or zeros at ALU	 (li,lui)
MUX_ALU_rfA: mux2x1 PORT MAP(
		In0 =>sig_rfA_reg ,
		In1 => "00000000000000000000000000000000",
		sel => ALU_alu_sel,
		output => mux_out
	);

-- Mux for choosing rfB or the 8-LSB of rfB for RAM's MEM_DataIn (sw, sb)
mux_ram: mux2x1 PORT MAP(
		In0 => sig_rfB_reg,
		In1 => in_temp_B,
		sel => data_din_Sel,
		output => in_mem_din
	);


-- Module for the 8-LSB of rfB (rfB:32bits)
rfB_8LSB: mod_rfB PORT MAP(
		rfB => sig_rfB_reg,
		rfB_out => in_temp_B
	);

--	Choosing MEMR_out - OR -  MEMR_out: 8-LSB
mux_mem: mux2x1 PORT MAP(
		In0 => in_mem_dout,
		In1 => in_mem_dout_mod,
		sel =>memData_sel ,
		output => in_mem_dout_final
	);

-- Module for the 8-LSB of MEMR_out(MEM Register Out) 
MEMR_8_LSB: mod_rfB PORT MAP(
		rfB => in_mem_dout,
		rfB_out => in_mem_dout_mod
	);
	
Instr<=in_instr;
	
end Behavioral;

