
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity DEC_EX is
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
end DEC_EX;

architecture Behavioral of DEC_EX is

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
	
	signal temp: std_logic_vector(31 downto 0);
	

begin

Reg1: 	Reg32 PORT MAP(data => RF_A,dout => RF_A_out,we => '1',reset => Reset,clk =>clock );	
Reg2: 	Reg32 PORT MAP(data =>RF_B ,dout =>RF_B_out ,we => '1',reset => Reset,clk => clock);	
Reg3: 	Reg32 PORT MAP(data => imm,dout =>imm_out ,we => '1',reset => Reset,clk => clock);	
Reg4: 	reg5bit PORT MAP(CLK => clock,RST => Reset,WE =>'1' ,Data => wraddr,Dout => wraddr_out);
temp <= "00000000000000000000000"&MEM_WrEn  & RF_WrData_sel & RF_WrEn & ALU_Bin_sel & ALU_alu_sel& ALU_func(3 downto 0);	
Reg5: 	Reg32 PORT MAP(data => temp,dout => temp_out,we =>'1' ,reset => Reset,clk => clock);
Reg6:  	reg5bit PORT MAP(CLK => clock,RST => Reset,WE => '1',Data =>reada ,Dout => reada_out);
Reg7:  	reg5bit PORT MAP(CLK => clock,RST =>Reset ,WE => '1',	Data =>readb ,Dout =>readb_out );

end Behavioral;

