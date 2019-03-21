LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

--USE ieee.numeric_std.ALL;
 
ENTITY TB_DATAPATH IS
END TB_DATAPATH;
 
ARCHITECTURE behavior OF TB_DATAPATH IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DATAPATH
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         PC_Sel : IN  std_logic;
         PC_LdEn : IN  std_logic;
         MEM_WrEn : IN  std_logic;
         memData_sel : IN  std_logic;
         data_din_Sel : IN  std_logic;
         ALU_Bin_sel : IN  std_logic;
         ALU_alu_sel : IN  std_logic;
         IR_en : IN  std_logic;
         ALU_func : IN  std_logic_vector(3 downto 0);
         RF_WrData_sel : IN  std_logic;
         RF_B_sel : IN  std_logic;
         RF_WrEn : IN  std_logic;
         Instr : OUT  std_logic_vector(31 downto 0);
			zero: OUT std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal PC_Sel : std_logic := '0';
   signal PC_LdEn : std_logic := '0';
   signal MEM_WrEn : std_logic := '0';
   signal memData_sel : std_logic := '0';
   signal data_din_Sel : std_logic := '0';
   signal ALU_Bin_sel : std_logic := '0';
   signal ALU_alu_sel : std_logic := '0';
   signal IR_en : std_logic := '0';
   signal ALU_func : std_logic_vector(3 downto 0) := (others => '0');
   signal RF_WrData_sel : std_logic := '0';
   signal RF_B_sel : std_logic := '0';
   signal RF_WrEn : std_logic := '0';

 	--Outputs
   signal Instr : std_logic_vector(31 downto 0);
	signal zero:  std_logic;

   -- Clock period definitions
   constant clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DATAPATH PORT MAP (
          clk => clk,
          reset => reset,
          PC_Sel => PC_Sel,
          PC_LdEn => PC_LdEn,
          MEM_WrEn => MEM_WrEn,
          memData_sel => memData_sel,
          data_din_Sel => data_din_Sel,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_alu_sel => ALU_alu_sel,
          IR_en => IR_en,
          ALU_func => ALU_func,
          RF_WrData_sel => RF_WrData_sel,
          RF_B_sel => RF_B_sel,
          RF_WrEn => RF_WrEn,
          Instr => Instr,
			 zero => zero
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		
		--reset--
	reset<='1';
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
	wait for 200 ns;
		reset<='0';
		
----		Instruction Fetch
--	PC_Sel<='0';
--	PC_LdEn<='0';
--	MEM_WrEn<='0';
--	memData_sel<='0';
--	data_din_Sel<='0';
--	RF_WrData_sel<='0';
--	RF_B_sel<='0';
--	RF_Wren<='0';
--	ALU_Bin_sel<='0';
--	ALU_alu_sel<='0';
--	--IR_en<='1';
--	ALU_func<="0000";

		wait for clk_period;
--		
--		Instruction Delay
--		RF_WrEn<='0';
--		PC_Sel<='0';
--		PC_LdEn<='0';
--		MEM_WrEn<='0';
--		memData_sel<='0';
--		data_din_Sel<='0';
--		RF_WrData_sel<='0';
--		RF_Wren<='0';
--		IR_en<='1';
--		wait for clk_period;
--		
		--Decode
			RF_WrEn<='0';  
				--	1100 00|00 000|0 0101|0000000000001000 : addi r5,r0,8
			PC_Sel<='0';
			PC_LdEn<='0';
			MEM_WrEn<='0';
			memData_sel<='0';
			data_din_Sel<='0';
			RF_WrData_sel<='0';    --ALU => RF
			RF_B_sel<='1';
			RF_Wren<='1';       
			ALU_Bin_sel<='1';          --Immed
			ALU_alu_sel<='0';
			IR_en<='0';
			ALU_func<="0000";
			
		--	wait for clk_period;
		-- pc = pc + 4
					PC_Sel<='0';
					PC_LdEn<='1';
					wait for clk_period;
					
----		-- Instruction Fetch
--		PC_Sel<='0';
--		PC_LdEn<='0';
--		MEM_WrEn<='0';
--		memData_sel<='0';
--		data_din_Sel<='0';
--		RF_WrData_sel<='0';
--		RF_B_sel<='0';
--		RF_Wren<='0';
--		ALU_Bin_sel<='0';
--		ALU_alu_sel<='0';
--		IR_en<='1';
--		ALU_func<="0000";
	
	--	wait for clk_period;
--	
--		--Instruction Delay
--		RF_WrEn<='0';
--		PC_Sel<='0';
--		PC_LdEn<='0';
--		MEM_WrEn<='0';
--		memData_sel<='0';
--		data_din_Sel<='0';
--		RF_WrData_sel<='0';
--		RF_Wren<='0';
--		IR_en<='1';
--		wait for clk_period;

	
		--Decode
			RF_WrEn<='0';  
			--1100 11|00 000|0 0011|1010101111001101: ori r3,r0, ABCD
		--	PC_Sel<='0';
		--	PC_LdEn<='0';
			MEM_WrEn<='0';
			memData_sel<='0';
			data_din_Sel<='0';
			RF_WrData_sel<='0';    --ALU=>RF
			RF_B_sel<='1';
			RF_Wren<='1';       
			ALU_Bin_sel<='1';          --Immed
			ALU_alu_sel<='0';
			IR_en<='0';
			ALU_func<="0011";
			
				-- pc = pc + 4
					PC_Sel<='0';
					PC_LdEn<='1';
					wait for clk_period;
					
----		-- Instruction Fetch
--PC_Sel<='0';
--PC_LdEn<='0';
--MEM_WrEn<='0';
--memData_sel<='0';
--data_din_Sel<='0';
--RF_WrData_sel<='0';
--RF_B_sel<='0';
--RF_Wren<='0';
--ALU_Bin_sel<='0';
--ALU_alu_sel<='0';
--IR_en<='1';
--ALU_func<="0000";
	
		--wait for clk_period;
--	
--		--Instruction Delay
--		RF_WrEn<='0';
--		PC_Sel<='0';
--		PC_LdEn<='0';
--		MEM_WrEn<='0';
--		memData_sel<='0';
--		data_din_Sel<='0';
--		RF_WrData_sel<='0';
--		RF_Wren<='0';
--		IR_en<='1';
--		wait for clk_period;

	
--Decode
RF_WrEn<='0';  			--0111 11|00 000|0 0011|0000000000000100:  sw r3, 4(r0)
PC_Sel<='0';
PC_LdEn<='0';
MEM_WrEn<='1';
memData_sel<='0';
data_din_Sel<='0';
RF_WrData_sel<='0';
RF_B_sel<='1';
ALU_Bin_sel<='1';
ALU_alu_sel<='0';
IR_en<='0';
ALU_func<="0000";
			
		--	wait for clk_period;
			
--			PC_Sel<='0';
--			PC_LdEn<='0';
--			MEM_WrEn<='1';
--			memData_sel<='0';
--			data_din_Sel<='0';
--			RF_WrData_sel<='0';    
--			RF_B_sel<='1';
--			RF_Wren<='0';       
--			ALU_Bin_sel<='1';          
--			ALU_alu_sel<='0';
--			IR_en<='0';
--			ALU_func<="0000";
--			
--			wait for clk_period;
--				PC_Sel<='0';
--				PC_LdEn<='0';
--				memData_sel<='0';
--				data_din_Sel<='0';
--				RF_WrData_sel<='0';
--				IR_en<='1';
--				


		
					--pc = pc + 4 
					PC_Sel<='0';
					PC_LdEn<='1';
					wait for clk_period;
			
---- Instruction Fetch
--		PC_Sel<='0';
--		PC_LdEn<='0';
--		MEM_WrEn<='0';
--		memData_sel<='0';
--		data_din_Sel<='0';
--		RF_WrData_sel<='0';
--		RF_B_sel<='0';
--		RF_Wren<='0';
--		ALU_Bin_sel<='0';
--		ALU_alu_sel<='0';
--		IR_en<='1';
--		ALU_func<="0000";
	
	--	wait for clk_period;
	
--		Instruction Delay
--		RF_WrEn<='0';
--		PC_Sel<='0';
--		PC_LdEn<='0';
--		MEM_WrEn<='0';
--		memData_sel<='0';
--		data_din_Sel<='0';
--		RF_WrData_sel<='0';
--		RF_Wren<='0';
--		IR_en<='1';
--		wait for clk_period;

		--Decode
														--001111 00101 01010 1111111111111100:  lw  r10,  -4(r5)
			-- PC_Sel<='0';
			--PC_LdEn<='0';
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
			
		--	wait for clk_period;
			
--			PC_Sel<='0';
--			PC_LdEn<='0';
--			MEM_WrEn<='0';
--			memData_sel<='0';
--			data_din_Sel<='0';
--			RF_WrData_sel<='0';    
--			RF_B_sel<='1';
--			RF_Wren<='0';       
--			ALU_Bin_sel<='1';          
--			ALU_alu_sel<='0';
--			IR_en<='0';
--			ALU_func<="0000";
--			
--			wait for clk_period;
--			
--			PC_Sel<='0';
--			PC_LdEn<='0';
--			MEM_WrEn<='0';
--			memData_sel<='0';
--			data_din_Sel<='0';
--			RF_WrData_sel<='1';    
--			RF_B_sel<='1';
--			RF_Wren<='1';       
--			ALU_Bin_sel<='1';          
--			ALU_alu_sel<='0';
--			IR_en<='0';
--			ALU_func<="0000";
--			
--			wait for clk_period;
			
	--pc = pc + 4 
					PC_Sel<='0';
					PC_LdEn<='1';
					wait for clk_period;
			
---- Instruction Fetch
--		PC_Sel<='0';
--		PC_LdEn<='0';
--		MEM_WrEn<='0';
--		memData_sel<='0';
--		data_din_Sel<='0';
--		RF_WrData_sel<='0';
--		RF_B_sel<='0';
--		RF_Wren<='0';
--		ALU_Bin_sel<='0';
--		ALU_alu_sel<='0';
--		IR_en<='1';
--		ALU_func<="0000";
--	
--		wait for clk_period;
	
--		--Instruction Delay
--		RF_WrEn<='0';
--		PC_Sel<='0';
--		PC_LdEn<='0';
--		MEM_WrEn<='0';
--		memData_sel<='0';
--		data_din_Sel<='0';
--		RF_WrData_sel<='0';
--		RF_Wren<='0';
--		IR_en<='1';
--		wait for clk_period;

	--	Decode
	--		001111 00101 01010 1111111111111100:  lb r16, 4(r0)
	--PC_Sel<='0';
	--PC_LdEn<='0';
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
	
--	wait for clk_period;
--	
--	PC_Sel<='0';
--	PC_LdEn<='0';
--	MEM_WrEn<='0';
--	memData_sel<='1';
--	data_din_Sel<='0';
--	RF_WrData_sel<='0';    
--	RF_B_sel<='1';
--	RF_Wren<='0';       
--	ALU_Bin_sel<='1';          
--	ALU_alu_sel<='0';
--	IR_en<='0';
--	ALU_func<="0000";
	
--	wait for clk_period;
--	PC_Sel<='0';
--	PC_LdEn<='0';
--	MEM_WrEn<='0';
--	memData_sel<='1';
--	data_din_Sel<='0';
--	RF_WrData_sel<='1';    
--	RF_B_sel<='1';
--	RF_Wren<='1';       
--	ALU_Bin_sel<='1';          
--	ALU_alu_sel<='0';
--	IR_en<='0';
--	ALU_func<="0000";
	
	--wait for clk_period;
	
	--pc = pc + 4 
					PC_Sel<='0';
					PC_LdEn<='1';
					wait for clk_period;
			
---- Instruction Fetch
--		PC_Sel<='0';
--		PC_LdEn<='0';
--		MEM_WrEn<='0';
--		memData_sel<='0';
--		data_din_Sel<='0';
--		RF_WrData_sel<='0';
--		RF_B_sel<='0';
--		RF_Wren<='0';
--		ALU_Bin_sel<='0';
--		ALU_alu_sel<='0';
--		IR_en<='1';
--		ALU_func<="0110";
--	
--		wait for clk_period;
		
--				--Instruction Delay
--		RF_WrEn<='0';
--		PC_Sel<='0';
--		PC_LdEn<='0';
--		MEM_WrEn<='0';
--		memData_sel<='0';
--		data_din_Sel<='0';
--		RF_WrData_sel<='0';
--		RF_Wren<='0';
--		IR_en<='1';
--		wait for clk_period;
		
		
		-- DECODE => 8144 8032 nand r4,r10,r16
		--	PC_Sel<='0';
			--PC_LdEn<='0';
			MEM_WrEn<='0';
			memData_sel<='0';
			data_din_Sel<='0';
			RF_WrData_sel<='0';    --ALU => RF
			RF_B_sel<='0';
			RF_Wren<='1';       
			ALU_Bin_sel<='0';          --Immed
			ALU_alu_sel<='0';
			IR_en<='0';
			ALU_func<="0110";
			
					--wait for clk_period;
					
								-- pc = pc + 4
					PC_Sel<='0';
					PC_LdEn<='1';
					wait for clk_period;	
					
					-------------------------------------------------------------------------------------					
--    -- Instruction Fetch
--		PC_Sel<='0';
--		PC_LdEn<='0';
--		MEM_WrEn<='0';
--		memData_sel<='0';
--		data_din_Sel<='0';
--		RF_WrData_sel<='0';
--		RF_B_sel<='0';
--		RF_Wren<='0';
--		ALU_Bin_sel<='0';
--		ALU_alu_sel<='0';
--		IR_en<='1';
--		ALU_func<="0100";
--	
--		wait for clk_period;
	
--		--Instruction Delay
--		RF_WrEn<='0';
--		PC_Sel<='0';
--		PC_LdEn<='0';
--		MEM_WrEn<='0';
--		memData_sel<='0';
--		data_din_Sel<='0';
--		RF_WrData_sel<='0';
--		RF_Wren<='0';
--		IR_en<='1';
--		wait for clk_period;
		
		
-- DECODE =>  not r1,r5
--100000 00101 00001 00000 00000 110100
		
			RF_WrEn<='1';  
			--PC_Sel<='0';
			--PC_LdEn<='0';
			MEM_WrEn<='0';
			memData_sel<='0';
			data_din_Sel<='0';
			RF_WrData_sel<='0';    --ALU => RF
			RF_B_sel<='0';
			RF_Wren<='1';       
			ALU_Bin_sel<='0';          --Immed
			ALU_alu_sel<='0';
			IR_en<='0';
			ALU_func<="0100";
			
					--wait for clk_period;		
						
					
			-- pc = pc + 4
					PC_Sel<='0';
					PC_LdEn<='1';
					wait for clk_period;		
					
					
					
---- Instruction Fetch
--		PC_Sel<='0';
--		PC_LdEn<='0';
--		MEM_WrEn<='0';
--		memData_sel<='0';
--		data_din_Sel<='0';
--		RF_WrData_sel<='0';
--		RF_B_sel<='0';
--		RF_Wren<='0';
--		ALU_Bin_sel<='0';
--		ALU_alu_sel<='0';
--		IR_en<='1';
--		ALU_func<="1101";
--	
--		wait for clk_period;
	
--		--Instruction Delay
--		RF_WrEn<='0';
--		PC_Sel<='0';
--		PC_LdEn<='0';
--		MEM_WrEn<='0';
--		memData_sel<='0';
--		data_din_Sel<='0';
--		RF_WrData_sel<='0';
--		RF_Wren<='0';
--		IR_en<='1';
--		wait for clk_period;
		
		
-- DECODE =>  ror r2,r4
--100000 00100 00010 00000 00000 111101
		
			RF_WrEn<='1';  
			--PC_Sel<='0';
			--PC_LdEn<='0';
			MEM_WrEn<='0';
			memData_sel<='0';
			data_din_Sel<='0';
			RF_WrData_sel<='0';    --ALU => RF
			RF_B_sel<='0';
			RF_Wren<='1';       
			ALU_Bin_sel<='0';          --Immed
			ALU_alu_sel<='0';
			IR_en<='0';
			ALU_func<="1101";
			
					--wait for clk_period;		
						
					
			-- pc = pc + 4
					PC_Sel<='0';
					PC_LdEn<='1';
					wait for clk_period;	
--			RF_WrEn<='0';
--			PC_Sel<='0';
--			PC_LdEn<='0';
--			MEM_WrEn<='0';
--			memData_sel<='0';
--			data_din_Sel<='0';
--			RF_WrData_sel<='0';    --ALU => RF
--			RF_B_sel<='0';
--			RF_Wren<='1';       
--			ALU_Bin_sel<='0';          --Immed
--			ALU_alu_sel<='0';
--			IR_en<='0';
--			ALU_func<="0110";
--wait for clk_period;
					

					
--				-- Instruction Fetch
--		PC_Sel<='0';
--		PC_LdEn<='0';
--		MEM_WrEn<='0';
--		memData_sel<='0';
--		data_din_Sel<='0';
--		RF_WrData_sel<='0';
--		RF_B_sel<='0';
--		RF_Wren<='0';
--		ALU_Bin_sel<='0';
--		ALU_alu_sel<='0';
--		IR_en<='1';
--		ALU_func<="0000";
--		wait for clk_period;
		
		--Decode: 04A50008: bne r5, r5, 8
		
		PC_Sel<='0';
		--PC_LdEn<='0';
		MEM_WrEn<='0';
		memData_sel<='0';
		data_din_Sel<='0';
		RF_WrData_sel<='0';   
		RF_B_sel<='1';
		RF_Wren<='0';       
		ALU_Bin_sel<='0';    
		ALU_alu_sel<='0';    
		IR_en<='0';
		ALU_func<="0001";
		
		--wait for clk_period;
		PC_LdEn<='1'; 
		wait for clk_period;
		
--				-- Instruction Fetch
--		PC_Sel<='0';
--		PC_LdEn<='0';
--		MEM_WrEn<='0';
--		memData_sel<='0';
--		data_din_Sel<='0';
--		RF_WrData_sel<='0';
--		RF_B_sel<='0';
--		RF_Wren<='0';
--		ALU_Bin_sel<='0';
--		ALU_alu_sel<='0';
--		IR_en<='1';
--		ALU_func<="0000";
--		wait for clk_period;
		
		--Decode: 04A50008: b -2
		
		PC_Sel<='0';
		PC_LdEn<='0';
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
		
		
		wait for clk_period;
		
		PC_Sel<='1';
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
		
		
--		wait for clk_period;
--		Pc_LdEN<='1';
--		PC_LdEn<='1'; 
--		wait for clk_period;

		
							wait for clk_period;
				PC_Sel<='0';
		PC_LdEn<='0';
		-- Instruction Fetch
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
		ALU_func<="1101";
	

			
	

      -- insert stimulus here 

      wait;
   end process;

END;
