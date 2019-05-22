
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity PipelinedProcessor is
port ( clk , Reset : in std_logic
		);
end PipelinedProcessor;

architecture Behavioral of PipelinedProcessor is
	
	COMPONENT pipelined_control
	PORT(
		reset : IN std_logic;
		opcode : IN std_logic_vector(5 downto 0);          
		MEM_WrEn : OUT std_logic;
		ALU_Bin_sel : OUT std_logic;
		ALU_alu_sel : OUT std_logic;
		ALU_func : OUT std_logic_vector(3 downto 0);
		RF_WrData_sel : OUT std_logic;
		RF_WrEn : OUT std_logic;
		RF_B_sel : OUT std_logic
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
		wr_addr_input: in std_logic_vector(4 downto 0);		
		Immed : OUT std_logic_vector(31 downto 0);
		RF_A : OUT std_logic_vector(31 downto 0);
		RF_B : OUT std_logic_vector(31 downto 0);
		reada : OUT std_logic_vector(4 downto 0);
		readb : OUT std_logic_vector(4 downto 0);
		wraddr : OUT std_logic_vector(4 downto 0);
		new_write_data : OUT std_logic_vector(31 downto 0)
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
	
		COMPONENT ALUSTAGE
	PORT(
		RF_A : IN std_logic_vector(31 downto 0);
		RF_B : IN std_logic_vector(31 downto 0);
		--Immed : IN std_logic_vector(31 downto 0);
		--ALU_Bin_sel : IN std_logic;
		ALU_func : IN std_logic_vector(3 downto 0);          
		zero : OUT std_logic;
		ALU_out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT mux2x1
	PORT(
		In0 : IN std_logic_vector(31 downto 0);
		In1 : IN std_logic_vector(31 downto 0);
		sel : IN std_logic;          
		output : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

component  mux4x1 is
port( A , B , C , D : in std_logic_vector(31 downto 0 );
		sel : in std_logic_vector(1 downto 0 );
		output : out std_logic_vector(31 downto 0 )
);
end component;
component mod_rfB is
Port( rfB : in std_logic_vector(31 downto 0);
		rfB_out : out std_logic_vector(31 downto 0)
		);
end component;

component DEC_EX is
Port(clock,Reset : in std_logic;
	RF_A, RF_B : in std_logic_vector(31 downto 0);
	reada, readb, wraddr : in std_logic_vector(4 downto 0);
	imm : in std_logic_vector(31 downto 0);
	MEM_WrEn , 	ALU_Bin_sel , 	ALU_alu_sel , RF_WrData_sel , RF_WrEn  , RF_B_sel : in  std_logic;
	ALU_func :  in std_logic_vector(3 downto 0);
	RF_A_out, RF_B_out : out std_logic_vector(31 downto 0);
	reada_out, readb_out, wraddr_out : out std_logic_vector(4 downto 0);
	imm_out , temp_out: out std_logic_vector(31 downto 0)
	);
end component;

component EX_MEM is
port (
	clock,Reset : in std_logic;
	ALU , RF_B  : in std_logic_vector(31 downto 0);
	wraddr : in std_logic_vector (4 downto 0 );
	ex_control : in std_logic_vector(4 downto 0);
	ALU_out ,  RF_B_out : out std_logic_vector(31 downto 0 );
	wraddr_out , mem_control : out std_logic_vector(4 downto 0)
);
end component;

component MEM_WRITE_BACK is
port(clock , Reset : in std_logic;
	  mem_wback_input , reg_waddr : in std_logic_vector(4 downto 0 );
	  aluin : in std_logic_vector(31 downto 0);
	  mem_wback_out , reg_waddr_out: out std_logic_vector(4 downto 0 );
	  aluout : out std_logic_vector(31 downto 0)
);
end component;

component mux3x1 is
port( A , B , C : in std_logic_vector(31 downto 0 );
		sel : in std_logic_vector(1 downto 0 );
		output : out std_logic_vector(31 downto 0 )
);
end component;

component forwarding_unit is
port( decex_Rs , decex_Rt , exmem_Rd , wb_Rd  : in std_logic_vector(4 downto 0);
	exmem_Rw, wb_Rw : in std_logic;
	forwardA , forwardB : out std_logic_vector (1 downto 0)
);
end component;

component stall is
Port (reset ,mem_readen : in std_logic;
		ex_rt, dec_rs, dec_rt :in std_logic_vector(4 downto 0);
		en1 , pc_lden: out std_logic
		);
end component;

component mux2x1_2bit is
Port ( A, B : in std_logic_vector(1 downto 0);
		sel : in std_logic;
		C : out std_logic_vector(1 downto 0)
		);
end component;

component stall_delay is
Port (clock, A: in std_logic;
		C : out std_logic
		);
end component;

-- Signals

signal s_alu_out , s_mem_din , s_mem_dout , s_instr , s_immed, s_regB  , s_mem_addr , ex_control, wback_alu_out , alu_mux2_out, IR_out, final_instr: std_logic_vector (31 downto 0);
signal temp_regA , temp_regB, s_RF_A_out, s_RF_B_out, s_imm_out, mux_out , ex_alu_out , ex_rfb_out , wb_mux_data , ALU_A , ALU_B: std_logic_vector(31 downto 0);
signal s_wraddr, s_wraddr_out , ex_wraddr_out , s_mem_control , s_mem_wback, reg_addr_final, s_reada, s_readb, s_reada_out, s_readb_out: std_logic_vector(4 downto 0);

signal sigZero, PC_LdEn  , MEM_WrEn , 	ALU_Bin_sel , 	ALU_alu_sel , RF_WrData_sel , RF_WrEn  , RF_B_sel , en_stall , en_stall_delayed:   std_logic;		
signal	ALU_func :  std_logic_vector(3 downto 0); 
signal fwA, fwB, s_en, sigConc : std_logic_vector(1 downto 0);

begin

-- ##############################
-- CONTROL 
-- ##############################

CONTROL_mod: pipelined_control port map(Reset , final_instr(31 downto 26)   , MEM_WrEn , 	ALU_Bin_sel , 	ALU_alu_sel, ALU_func ,   RF_WrData_sel , RF_WrEn  , RF_B_sel);


-- ##############################
-- PIPELINED DATAPATH
-- ##############################


-- MEMSTAGE
MEMSTAGE_mod: MEM PORT MAP(s_immed, '0' , PC_LdEn , clk , s_mem_control(2) , Reset , ex_alu_out ,ex_rfb_out , s_mem_dout , s_instr);

-- DECSTAGE (with some new outputs to simplify port map)
DECSTAGE_mod: DECSTAGE PORT MAP(
		Instr => final_instr,
		RF_WrEn => s_mem_wback(0),
		reset => Reset,
		ALU_out => wback_alu_out,
		MEM_out =>s_mem_dout ,
		RF_WrData_sel => s_mem_wback(1),
		RF_B_sel => RF_B_sel ,
		Clk => clk,
		wr_addr_input=>reg_addr_final,
		Immed => s_immed,
		RF_A => temp_regA,
		RF_B => temp_regB,
		reada =>s_reada ,
		readb => s_readb,
		wraddr => s_wraddr ,
		new_write_data => wb_mux_data
	);
	
-- DEC_EX - PIPELINE REGISTER
	Inst_DEC_EX: DEC_EX PORT MAP(
		clock => clk,
		Reset => reset,
		RF_A => temp_regA,
		RF_B => temp_regB,
		reada => s_reada,
		readb => s_readb ,
		wraddr => s_wraddr,
		imm => s_immed,
		MEM_WrEn => s_en(1),
		ALU_Bin_sel => ALU_Bin_sel,
		ALU_alu_sel => ALU_alu_sel,
		RF_WrData_sel => RF_WrData_sel,
		RF_WrEn => s_en(0),
		RF_B_sel => RF_B_sel ,
		ALU_func => ALU_func ,
		RF_A_out => s_RF_A_out,
		RF_B_out => s_RF_B_out,
		reada_out => s_reada_out,
		readb_out => s_readb_out,
		wraddr_out => s_wraddr_out,
		imm_out => s_imm_out,
		temp_out => ex_control
	);

-- ALUSTAGE	
Inst_ALUSTAGE: ALUSTAGE PORT MAP(
		RF_A => ALU_A,
		RF_B => ALU_B,
		ALU_func => ex_control(3 downto 0),
		zero => sigZero,
		ALU_out => s_alu_out
	);
	
		Inst_mux2x1: mux2x1 PORT MAP(
		In0 =>s_RF_A_out ,
		In1 => "00000000000000000000000000000000",
		sel => ex_control(4),
		output => mux_out
	);
	
-- Muxes
	ALU_MUX: mux2x1 PORT MAP(
		In0 =>s_RF_B_out ,
		In1 => s_imm_out,
		sel => ex_control(5),
		output => alu_mux2_out
	);
	
	FWA_MUX: mux3x1 PORT MAP(
		A => mux_out,
		B => ex_alu_out,
		C => wb_mux_data,
		sel => fwA,
		output => ALU_A
	);
	
	FWB_MUX: mux3x1 PORT MAP(
		A => alu_mux2_out,
		B => ex_alu_out,
		C => wb_mux_data,
		sel => fwB,
		output => ALU_B
	);
	
-- EX/MEM Pipeline Register

	Inst_EX_MEM: EX_MEM PORT MAP(
		clock =>clk ,
		Reset => Reset,
		ALU =>  s_alu_out,
		RF_B => s_RF_B_out,
		wraddr => s_wraddr_out ,
		ex_control => ex_control(10 downto 6),
		ALU_out => ex_alu_out,
		RF_B_out => ex_rfb_out,
		wraddr_out => ex_wraddr_out,
		mem_control => s_mem_control
	);	

--  MEM/WB Pipeline Register

	Inst_MEM_WRITE_BACK: MEM_WRITE_BACK PORT MAP(
		clock => clk,
		Reset => Reset,
		mem_wback_input => s_mem_control ,
		reg_waddr =>ex_wraddr_out ,
		aluin => ex_alu_out,
		mem_wback_out => s_mem_wback,
		reg_waddr_out => reg_addr_final,
		aluout => wback_alu_out
	);
	
-- Forwarding Unit

	Inst_forwarding_unit: forwarding_unit PORT MAP(
		decex_Rs => s_reada_out,
		decex_Rt => s_readb_out,
		exmem_Rd => ex_wraddr_out ,
		wb_Rd => reg_addr_final,
		exmem_Rw => s_mem_control(0),
		wb_Rw => s_mem_wback(0),
		forwardA => fwA,
		forwardB => fwB
	);	

-- Stall 

	Inst_stall: stall PORT MAP(
		reset => Reset,
		mem_readen => ex_control(7),
		ex_rt => s_wraddr_out,
		dec_rs => s_reada,
		dec_rt => s_readb,
		en1 => en_stall,
		pc_lden => PC_LdEn
	);
	
	Stall_delay_mod: stall_delay PORT MAP(
		clock => clk,
		A => en_stall,
		C => en_stall_delayed
	);
	
-- Register
	Instr_Reg: Reg32 PORT MAP(
		data => s_instr,
		dout => IR_out,
		we => en_stall,
		reset => Reset,
		clk => clk
	);

-- Muxes

	mux_1: mux2x1 PORT MAP(
		In0 =>IR_out ,
		In1 => s_instr,
		sel => en_stall_delayed,
		output => final_instr
	);
	
	sigConc<=MEM_Wren & RF_WrEn;
	
	Inst_mux2x1_2bit: mux2x1_2bit PORT MAP(
		A => sigConc,
		B =>"00" ,
		sel => en_stall,
		C => s_en
	);
	

end Behavioral;

