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
  RF_AB_we: out std_logic;
  ALU_func : out std_logic_vector(3 downto 0)
  );
end CONTROL;

architecture Behavioral of CONTROL is

type state is (idle, Fetch, InstrDelay, Decode, add, sub, andS, notS, orS, nandS, sraS, sllS, srlS, rolS, rorS, li, lui, addi, nandi, ori, b, beq, beqDelay, bne, bneDelay, sw, swDelay, sb, sbDelay, lw, lwDelay, lb, lbDelay);

signal currentS, nextS : state;

begin


fsm_synch: process (Clock, RST)
	begin
		if (RST='1')  	   				then 	currentS <= idle;  
		elsif (rising_edge(Clock))  	then	currentS <= nextS; 
		end if;
end process fsm_synch;


--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--
--	                Define states of each instruction						--
--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--
fsm_comb: process(currents, Instr, zero)
begin

case currentS is
		when  idle=> nextS<=Decode;
		when Fetch=> nextS<= InstrDelay;
		when InstrDelay=> nexts<=Decode;
		when Decode => if Instr = "00000000000000000000000000000000" then nextS<=Fetch;
												  elsif Instr (31 downto 26) = "100000" then
												  
																				-- RType Instructions
																				if Instr(5 downto 0) = "110000" then nextS<=add;
																				elsif Instr(5 downto 0) = "110001" then nextS<=sub;
																				--	elsif Instr(5 downto 0) = "110010" then nextS<=andS;
																				-- 	exoun vgalei thn AND ap'to ISA, gia kapoio logo (????), organwsi2k19lul
																				elsif Instr(5 downto 0) = "110100" then nextS<=notS;
																				elsif Instr(5 downto 0) = "110010" then nextS<=nandS;
																				elsif Instr(5 downto 0) = "110111" then nextS<=orS;
																				elsif Instr(5 downto 0) = "110111" then nextS<=orS;
																				elsif Instr(5 downto 0) = "111000" then nextS<=sraS;
																				elsif Instr(5 downto 0) = "111001" then nextS<=sllS;
																				elsif Instr(5 downto 0) = "111010" then nextS<=srlS;
																				elsif Instr(5 downto 0) = "111100" then nextS<=rolS;
																				elsif Instr(5 downto 0) = "111101" then nextS<=rorS;
																				
													end if;
													elsif Instr (31 downto 26) = "111000" then nextS<=li;
													elsif Instr (31 downto 26) = "111001" then nextS<=lui;
													elsif Instr (31 downto 26) = "110000" then nextS<=addi;
													elsif Instr (31 downto 26) = "110010" then nextS<=nandi;
													elsif Instr (31 downto 26) = "110011" then nextS<=ori;
													elsif Instr (31 downto 26) = "111111" then nextS<=b;
													elsif Instr (31 downto 26) = "000000" then nextS<=beq;
													elsif Instr (31 downto 26) = "000001" then nextS<=bne;
													elsif Instr (31 downto 26) = "000011" then nextS<=lb;
													elsif Instr (31 downto 26) = "000111" then nextS<=sb;
													elsif Instr (31 downto 26) = "001111" then nextS<=lw;
													elsif Instr (31 downto 26) = "011111" then nextS<=sw;
													else nextS<=idle;
													end if;
	
			when b=> nextS<=InstrDelay;
			when beq => nextS<=beqDelay;
			when beqDelay=> 	if zero='1' then nextS<=b;
															else nextS<=Fetch;
															end if;
			when bne => nextS<=bneDelay;
			when bneDelay=> 	if zero='0' then nextS<=b;
															else nextS<=Fetch;
															end if;
			when sw=> nextS<=swDelay;
			when sb=> nextS<=sbDelay;
			when lw=> nextS<=lwDelay;
			when lb=> nextS<=lbDelay;
			when others => nextS<=Fetch;
		end case;
end process fsm_comb;	

--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--
--	  Set value to control signals accordingly their state 		--
--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--
	with currentS select
		PC_sel <= 	'1' when b,
									'0' when others;
	with currentS select
		PC_LdEn <= 	'1' when Fetch,
										'1' when b,
										'0' when others;
	with currentS select
		RF_WrEn <= 	'0' when Idle,
										'0' when Fetch,
										'0' when InstrDelay,
										'0' when Decode,
										'0' when b,
										'0' when beq,
										'0' when beqDelay,
										'0' when bne,
										'0' when bneDelay,
										'0' when sw,
										'0' when swDelay,
										'0' when sb,
										'0' when sbDelay,
										'0' when lw,
										'1' when lwDelay,
										'0' when lb,
										'1' when lbDelay,
										'1' when others;
	with currentS select
	
		RF_WrData_sel <= 	'0' when Fetch,
														'0' when li,
														'0' when lui,
														'1' when sw,
														'1' when swDelay,
														'1' when lw,
														'1' when lwDelay,
														'1' when lb,
														'1' when lbDelay,
														'0' when others;
	with currentS select
		RF_B_sel <= 	'1' when beq,
										'1' when bne,
										'1' when sw,
										'1' when swDelay,
										'1' when sb,
										'1' when sbDelay,
										'1' when lw,
										'1' when lwDelay,
										'1' when lb,
										'1' when lbDelay,
										'1' when li,
										'1' when lui,
										'0' when others;
	with currentS select
	
		RF_AB_we<= '1' when Decode,
										'1' when beq,
										'1' when bne,
										'1' when sw,
										'1' when sb,
										'1' when lw,
										'1' when lb,
										'0' when others;
										
	with currentS select
		ALU_Bin_sel <=	'0' when Fetch,
												'1' when addi,
												'1' when nandi,
												'1' when ori,
												'1' when sw,
												'1' when swDelay,
												'1' when sb,
												'1' when sbDelay,
												'1' when lw,
												'1' when lwDelay,
												'1' when lb,
												'1' when lbDelay,
												'0' when others;
												
	with currentS select
		ALU_func <=	Instr (3 downto 0) when add,
										Instr (3 downto 0) when sub,
										--Instr (3 downto 0) when andS, 
										-- 	exoun vgalei thn AND ap'to ISA, gia kapoio logo (????), organwsi2k19lul
										Instr (3 downto 0) when nandS,
										Instr (3 downto 0) when notS,
										Instr (3 downto 0) when orS,
										Instr (3 downto 0) when sraS,
										Instr (3 downto 0) when sllS,
										Instr (3 downto 0) when srlS,
										Instr (3 downto 0) when rolS,
										Instr (3 downto 0) when rorS,
										"0000" when addi,
										"0110" when nandi,
										"0011" when ori,
										"0001" when beqDelay,
										"0001" when bneDelay,
										"0000" when sw,
										"0000" when sb,
										"0000" when lw,
										"0000" when lb,
										"0000" when others;
										
	with currentS select
		MEM_WrEn <= 	'1' when swDelay,
												'1' when sbDelay,
												'0' when others;
												
	with currentS select 
		memData_sel <= 	'1' when sb,
													'1' when sbDelay,
													'1' when lb,
													'1' when lbDelay,
													'0' when others;			
		
	with currentS select 
		data_din_sel <= 		'1' when sb,
													'1' when sbDelay,
													'1' when lb,
													'1' when lbDelay,
													'0' when others;				
	
	with currentS select 
		ALU_alu_sel <=	'1' when li,
												'1' when lui,
												'0' when others;
end Behavioral;