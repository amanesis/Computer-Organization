library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity CONTROL is
port (
  Clock , RST : in std_logic;
  Instr : in std_logic_vector(31 downto 0);
  zero : in std_logic;
  PC_Sel , PC_LdEn : out std_logic; 
  MEM_WrEn , memData_sel, data_din_Sel: out std_logic;
  RF_WrData_sel, RF_B_sel, RF_Wren : out std_logic;
  ALU_Bin_sel, ALU_alu_sel : out std_logic;
  IR_en: out std_logic;
  ALU_func : out std_logic_vector(3 downto 0)
  );
end CONTROL;

architecture Behavioral of CONTROL is

type state is (reset_state, Fetch , RType ,li_type, alui_type, branch_type  , sb_type
,lb_type , final_rtype ,beq_type , bne_type , lw_type , sw_type , sel_0 , sel_1 , lb_final , lw_type_final , wait_state,delay);
signal currentS, nextS : state;

begin
fsm_comb:process(currentS, Instr, zero)
begin
 case currentS is
  when reset_state=>
	PC_Sel<='0';
	PC_LdEn<='0';
	MEM_WrEn<='0';
	memData_sel<='0';
	data_din_Sel<='0';
	RF_WrData_sel<='0';
	RF_B_sel<='0';
	RF_Wren<='0';
	ALU_Bin_sel<='0';
	ALU_alu_sel<='0';
	IR_en<='0';
	ALU_func <="0000";
	nextS<=delay;
  when delay=>
	PC_Sel<='0';
	PC_LdEn<='0';
	MEM_WrEn<='0';
	memData_sel<='0';
	data_din_Sel<='0';
	RF_WrData_sel<='0';
	RF_Wren<='0';
	IR_en<='1';
	nextS<=Fetch;

  when Fetch=>
	PC_Sel<='0';
	PC_LdEn<='0';
	MEM_WrEn<='0';
	memData_sel<='0';
	data_din_Sel<='0';
	RF_WrData_sel<='0';
	RF_B_sel<='0';
	RF_Wren<='0';
	ALU_Bin_sel<='0';
	ALU_alu_sel<='0';
	IR_en<='1';
	ALU_func<="0000";
   if Instr(31 downto 26)="100000" then
		nextS<=RType;
	elsif Instr(31 downto 26)="111111" then
		nextS<=branch_type;
   else 
		nextS<=wait_state;
	end if;
  when RType=>
	PC_Sel<='0';
	PC_LdEn<='1';
	MEM_WrEn<='0';
	memData_sel<='0';
	data_din_Sel<='0';
	RF_WrData_sel<='0';  --grafetai to apotelesma ths ALU sto RF
	RF_B_sel<='0';
	RF_Wren<='0';       --grafoume sthn RF
	ALU_Bin_sel<='0';
	ALU_alu_sel<='0';
	IR_en<='0';
   if Instr(5 downto 0)="110000" then
		ALU_func<="0000";  --pros8esh
	elsif Instr(5 downto 0)="110001" then
		ALU_func<="0001";  --afairesh
	elsif Instr(5 downto 0)="110010" then
		ALU_func<="0010";  --NAND
	elsif Instr(5 downto 0)="110100" then
		ALU_func<="0100";  --NOT
	elsif Instr(5 downto 0)="110011" then
		ALU_func<="0011";  --OR
	elsif Instr(5 downto 0)="111000" then
		ALU_func<="1000";  --sra
	elsif Instr(5 downto 0)="111001" then
		ALU_func<="1010";  --sll
	elsif Instr(5 downto 0)="111010" then
		ALU_func<="1001";  --srl
	elsif Instr(5 downto 0)="111100" then
		ALU_func<="1100";  --rol
	elsif Instr(5 downto 0)="111101" then
		ALU_func<="1101";  --ror
	end if;
   nextS<= Final_Rtype;
  when wait_state=>          
   PC_Sel<='0';
	PC_LdEn<='1';
	MEM_WrEn<='0';
	memData_sel<='0';
	data_din_Sel<='0';
	RF_WrData_sel<='0';   
	RF_B_sel<='0';
	RF_Wren<='0';       
	ALU_Bin_sel<='0';    
	ALU_alu_sel<='0';    
	IR_en<='0';
	ALU_func<="0000";    
	if Instr(31 downto 26)="111000" OR Instr(31 downto 26)="111001" then
		nextS<=li_type;
	elsif Instr(31 downto 26)="110000" OR Instr(31 downto 26)="110010" OR Instr(31 downto 26)="110011" then
		nextS<=alui_type;
	elsif Instr(31 downto 26)="111111" then
		nextS<=branch_type;
	elsif Instr(31 downto 26)="000000" then 
		nextS<=beq_type;
	elsif Instr(31 downto 26)="000001" then
		nextS<=bne_type;
	elsif Instr(31 downto 26)="000111" then
		nextS<=sb_type;
	elsif Instr(31 downto 26)="000011" then
		nextS<=lb_type;
	elsif Instr(31 downto 26)="011111" then
		nextS<=sw_type;
	elsif Instr(31 downto 26)="001111" then
		nextS<=lw_type;
	end if;
	
	

	
  when li_type=>           --li, lui
   PC_Sel<='0';
	PC_LdEn<='0';
	MEM_WrEn<='0';
	memData_sel<='0';
	data_din_Sel<='0';
	RF_WrData_sel<='0';   --grafoume to apotelesma ths ALU sto rf 
	RF_B_sel<='1';
	RF_Wren<='1';       
	ALU_Bin_sel<='1';    --pername to immed san deutero telestaio
	ALU_alu_sel<='1';    --pername mhdenika san prwto telestaio
	IR_en<='0';
	ALU_func<="0000";    --kanoume pros8esh
	nextS<=delay;
  
  when alui_type=>     --addi, nandi, ori
  	PC_Sel<='0';
	PC_LdEn<='0';
	MEM_WrEn<='0';
	memData_sel<='0';
	data_din_Sel<='0';
	RF_WrData_sel<='0';    --grafoume to apotelesma ths ALU sto rf
	RF_B_sel<='1';
	RF_Wren<='1';       
	ALU_Bin_sel<='1';          --pername to immed
	ALU_alu_sel<='0';
	IR_en<='0';
	if Instr(31 downto 26)="110000" then
		ALU_func<="0000";    --add
	elsif Instr(31 downto 26)="110010" then
		ALU_func<="0010";   --nand
	elsif Instr(31 downto 26)="110011" then
		ALU_func<="0011";   --or
	else
		ALU_func<="0000";
	end if;
	nextS<=delay;
  when Final_Rtype=>
	PC_Sel<='0';
	PC_LdEn<='0';
	MEM_WrEn<='0';
	memData_sel<='0';
	data_din_Sel<='0';
	RF_WrData_sel<='0';  
	RF_B_sel<='0';
	RF_Wren<='1';       
	ALU_Bin_sel<='0';
	ALU_alu_sel<='0';
	IR_en<='0';
	nextS<=delay;
  when branch_type=>           --b
   PC_Sel<='1';
	PC_LdEn<='1';
	MEM_WrEn<='0';
	memData_sel<='0';
	data_din_Sel<='0';
	RF_WrData_sel<='0';   
	RF_B_sel<='0';
	RF_Wren<='0';       
	ALU_Bin_sel<='0';    
	ALU_alu_sel<='0';    
	IR_en<='0';
	ALU_func<="0000";    
	nextS<=delay;
  
  when beq_type=>           --beq
   PC_Sel<='0';
	PC_LdEn<='0';
	MEM_WrEn<='0';
	memData_sel<='0';
	data_din_Sel<='0';
	RF_WrData_sel<='0';   
	RF_B_sel<='0';
	RF_Wren<='0';       
	ALU_Bin_sel<='0';    
	ALU_alu_sel<='0';    
	IR_en<='0';
	ALU_func<="0001";
	if zero='0' then
		nextS<=sel_0;
	else
		nextS<=sel_1;
	end if;
	when bne_type=>           --bne
   PC_Sel<='0';
	PC_LdEn<='0';
	MEM_WrEn<='0';
	memData_sel<='0';
	data_din_Sel<='0';
	RF_WrData_sel<='0';   
	RF_B_sel<='0';
	RF_Wren<='0';       
	ALU_Bin_sel<='0';    
	ALU_alu_sel<='0';    
	IR_en<='0';
	ALU_func<="0001";
	if zero='1' then
		nextS<=sel_0;
	else
		nextS<=sel_1;
	end if;
  when sel_0 => --, Pc=Pc +4
	PC_Sel<='0';
	PC_LdEn<='1';
	MEM_WrEn<='0';
	memData_sel<='0';
	data_din_Sel<='0';
	RF_WrData_sel<='0';   
	RF_B_sel<='1';
	RF_Wren<='0';       
	ALU_Bin_sel<='0';    
	ALU_alu_sel<='0';    
	IR_en<='0';
	ALU_func<="0000";
	nextS<=delay;
	when sel_1 =>  -- , Pc=Pc +4 +imm
	PC_Sel<='1';
	PC_LdEn<='1';
	MEM_WrEn<='0';
	memData_sel<='0';
	data_din_Sel<='0';
	RF_WrData_sel<='0';   
	RF_B_sel<='0';
	RF_Wren<='0';       
	ALU_Bin_sel<='0';    
	ALU_alu_sel<='0';    
	IR_en<='0';
	ALU_func<="0000";
	nextS<=delay;  
  when sb_type=>
   PC_Sel<='0';
	PC_LdEn<='0';
	MEM_WrEn<='1';
	memData_sel<='0';
	data_din_Sel<='1';
	RF_WrData_sel<='0';    
	RF_B_sel<='1';
	RF_Wren<='0';       
	ALU_Bin_sel<='1';          
	ALU_alu_sel<='0';
	IR_en<='0';
	ALU_func<="0000";
	nextS<=delay;
  when lb_type =>     --lb
	PC_Sel<='0';
	PC_LdEn<='0';
	MEM_WrEn<='0';
	memData_sel<='0';
	data_din_Sel<='0';
	RF_WrData_sel<='0';    
	RF_B_sel<='1';
	RF_Wren<='0';       
	ALU_Bin_sel<='1';          
	ALU_alu_sel<='0';
	IR_en<='0';
	ALU_func<="0000";
	nextS<=lb_final;
  when lb_final=>
	PC_Sel<='0';
	PC_LdEn<='0';
	MEM_WrEn<='0';
	memData_sel<='1';
	data_din_Sel<='0';
	RF_WrData_sel<='1';    
	RF_B_sel<='1';
	RF_Wren<='1';       
	ALU_Bin_sel<='1';          
	ALU_alu_sel<='0';
	IR_en<='0';
	ALU_func<="0000";
	nextS<=delay;
  when sw_type=>
   PC_Sel<='0';
	PC_LdEn<='0';
	MEM_WrEn<='1';
	memData_sel<='0';
	data_din_Sel<='0';
	RF_WrData_sel<='0';    
	RF_B_sel<='1';
	RF_Wren<='0';       
	ALU_Bin_sel<='1';          
	ALU_alu_sel<='0';
	IR_en<='0';
	ALU_func<="0000";
	nextS<=delay;		
  when lw_type=>
   PC_Sel<='0';
	PC_LdEn<='0';
	MEM_WrEn<='0';
	memData_sel<='0';
	data_din_Sel<='0';
	RF_WrData_sel<='0';    
	RF_B_sel<='1';
	RF_Wren<='0';       
	ALU_Bin_sel<='1';          
	ALU_alu_sel<='0';
	IR_en<='0';
	ALU_func<="0000";
	nextS<=lw_type_final;
  when lw_type_final=>
   PC_Sel<='0';
	PC_LdEn<='0';
	MEM_WrEn<='0';
	memData_sel<='0';
	data_din_Sel<='0';
	RF_WrData_sel<='1';    
	RF_B_sel<='1';
	RF_Wren<='1';       
	ALU_Bin_sel<='1';          
	ALU_alu_sel<='0';
	IR_en<='0';
	ALU_func<="0000";
	nextS<=delay;
 end case;

end process; 
  
fsm_synch:process(Clock,RST)
begin
	if(RST='1') then currentS<=reset_state;
	elsif (rising_edge(Clock)) then currents<=nextS;
	end if;
end process;
end Behavioral;