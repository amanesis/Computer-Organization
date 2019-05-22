
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity pipelined_control is
port( reset : in std_logic;
		opcode : in std_logic_vector(5 downto 0);
		
		MEM_WrEn : out std_logic;
		ALU_Bin_sel : out std_logic;
		ALU_alu_sel : out std_logic;
		ALU_func : out  std_logic_vector(3 downto 0); 
		RF_WrData_sel , RF_WrEn : out  std_logic;
		RF_B_sel : out std_logic
);
end pipelined_control;

architecture Behavioral of pipelined_control is

begin
process(opcode,reset)
begin
if reset = '1'   then
	RF_B_sel <='0';
	MEM_Wren <='0';
	ALU_alu_sel <='0';  
	ALU_Bin_sel <='0';
	ALU_func <="0000";
	RF_wrData_sel <='0';
	RF_WrEn <='0';
else
	
	
		if opcode ="111000" then --li
			RF_B_sel <='1';
			MEM_Wren <='0';
			ALU_alu_sel <='1';  
			ALU_Bin_sel <='1';
			ALU_func <="0000";
			RF_wrData_sel <='0';
			RF_WrEn <='1';
			
		elsif opcode = "001111" then --lw
			RF_B_sel <='1';
			MEM_Wren <='0';
			ALU_alu_sel <='0';  
			ALU_Bin_sel <='1';
			ALU_func <="0000";
			RF_wrData_sel <='1';
			RF_WrEn <='1';

		elsif opcode = "011111" then --sw
			RF_B_sel <='1';
			MEM_Wren <='1';
			ALU_alu_sel <='0';  
			ALU_Bin_sel <='1';
			ALU_func <="0000";
			RF_wrData_sel <='0';
			RF_WrEn <='0';

		elsif opcode = "100000" then --add
			RF_B_sel <='0';
			MEM_Wren <='0';
			ALU_alu_sel <='0';  
			ALU_Bin_sel <='0';
			ALU_func <="0000";
			RF_wrData_sel <='0';
			RF_WrEn <='1';

		
		else   
			RF_B_sel <='0';
			MEM_Wren <='0';
			ALU_alu_sel <='0';  
			ALU_Bin_sel <='0';
			ALU_func <="0000";
			RF_wrData_sel <='0';
			RF_WrEn <='0';
		
		
	end if;

end if;
end process;


end Behavioral;

