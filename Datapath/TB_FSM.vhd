--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:05:19 03/20/2019
-- Design Name:   
-- Module Name:   /home/amanesis/HRY312_LAB1/TB_FSM.vhd
-- Project Name:  HRY312_LAB1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CONTROL
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TB_FSM IS
END TB_FSM;
 
ARCHITECTURE behavior OF TB_FSM IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CONTROL
    PORT(
         Clock : IN  std_logic;
         RST : IN  std_logic;
         Instr : IN  std_logic_vector(31 downto 0);
         zero : IN  std_logic;
         PC_Sel : OUT  std_logic;
         PC_LdEn : OUT  std_logic;
         MEM_WrEn : OUT  std_logic;
         memData_sel : OUT  std_logic;
         data_din_Sel : OUT  std_logic;
         RF_WrData_sel : OUT  std_logic;
         RF_B_sel : OUT  std_logic;
         RF_Wren : OUT  std_logic;
         ALU_Bin_sel : OUT  std_logic;
         ALU_alu_sel : OUT  std_logic;
         IR_en : OUT  std_logic;
         ALU_func : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clock : std_logic := '0';
   signal RST : std_logic := '0';
   signal Instr : std_logic_vector(31 downto 0) := (others => '0');
   signal zero : std_logic := '0';

 	--Outputs
   signal PC_Sel : std_logic;
   signal PC_LdEn : std_logic;
   signal MEM_WrEn : std_logic;
   signal memData_sel : std_logic;
   signal data_din_Sel : std_logic;
   signal RF_WrData_sel : std_logic;
   signal RF_B_sel : std_logic;
   signal RF_Wren : std_logic;
   signal ALU_Bin_sel : std_logic;
   signal ALU_alu_sel : std_logic;
   signal IR_en : std_logic;
   signal ALU_func : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant Clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CONTROL PORT MAP (
          Clock => Clock,
          RST => RST,
          Instr => Instr,
          zero => zero,
          PC_Sel => PC_Sel,
          PC_LdEn => PC_LdEn,
          MEM_WrEn => MEM_WrEn,
          memData_sel => memData_sel,
          data_din_Sel => data_din_Sel,
          RF_WrData_sel => RF_WrData_sel,
          RF_B_sel => RF_B_sel,
          RF_Wren => RF_Wren,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_alu_sel => ALU_alu_sel,
          IR_en => IR_en,
          ALU_func => ALU_func
        );

   -- Clock process definitions
   Clock_process :process
   begin
		Clock <= '0';
		wait for Clock_period/2;
		Clock <= '1';
		wait for Clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
RST<='1';
      wait for Clock_period*10;
RST<='0';
		wait for clock_period;
		Instr<="11000000000001010000000000001000";
		wait for clock_period;
		
      -- insert stimulus here 

      wait;
   end process;

END;
