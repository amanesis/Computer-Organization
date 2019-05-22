--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:20:10 03/05/2019
-- Design Name:   
-- Module Name:   /home/amanesis/HRY312_LAB1/DECSTAGE_TB_NEW.vhd
-- Project Name:  HRY312_LAB1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DECSTAGE
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
 
ENTITY DECSTAGE_TB_NEW IS
END DECSTAGE_TB_NEW;
 
ARCHITECTURE behavior OF DECSTAGE_TB_NEW IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DECSTAGE
    PORT(
         Instr : IN  std_logic_vector(31 downto 0);
         RF_WrEn : IN  std_logic;
         reset : IN  std_logic;
         ALU_out : IN  std_logic_vector(31 downto 0);
         MEM_out : IN  std_logic_vector(31 downto 0);
         RF_WrData_sel : IN  std_logic;
         RF_B_sel : IN  std_logic;
         Clk : IN  std_logic;
         Immed : OUT  std_logic_vector(31 downto 0);
         RF_A : OUT  std_logic_vector(31 downto 0);
         RF_B : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Instr : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_WrEn : std_logic := '0';
   signal reset : std_logic := '0';
   signal ALU_out : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_out : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_WrData_sel : std_logic := '0';
   signal RF_B_sel : std_logic := '0';
   signal Clk : std_logic := '0';

 	--Outputs
   signal Immed : std_logic_vector(31 downto 0);
   signal RF_A : std_logic_vector(31 downto 0);
   signal RF_B : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 50 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DECSTAGE PORT MAP (
          Instr => Instr,
          RF_WrEn => RF_WrEn,
          reset => reset,
          ALU_out => ALU_out,
          MEM_out => MEM_out,
          RF_WrData_sel => RF_WrData_sel,
          RF_B_sel => RF_B_sel,
          Clk => Clk,
          Immed => Immed,
          RF_A => RF_A,
          RF_B => RF_B
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		
		
		
		
		
       wait for Clk_period*0.5;
		reset <= '1';
		Instr <= "00000000000000000000000000000000";
		RF_WrEn <= '0';
		ALU_out <= "00000000000000000000000000000000";
		MEM_out <= "00000000000000000000000000000000";
		RF_WrData_sel <= '0';
		RF_B_sel <= '0';
		wait for Clk_period*5;
		reset <= '0';
		Instr <= "100000" & "00010" & "00001" & "00001" & "00000" & "110000"; --add
		RF_WrEn <= '1';
		ALU_out <= "00000000000000000000000000000100";
		MEM_out <= "00000000000000000000000000000010";
		RF_WrData_sel <= '0';
		RF_B_sel <= '0';
		wait for Clk_period*5;
		reset <= '0';
		Instr <= "100000" & "00010" & "00000" & "00000" & "00000" & "110000"; --add
		RF_WrEn <= '1';
		ALU_out <= "00000000000000000000000000000100";
		MEM_out <= "00000000000000000000000000000010";
		RF_WrData_sel <= '0';
		RF_B_sel <= '0';
		wait for Clk_period*5;
		reset <= '0';
		Instr <= "100000" & "00010" & "00010" & "00001" & "00000" & "110000"; 
		RF_WrEn <= '1';
		ALU_out <= "00000000000000000000000000000100";
		MEM_out <= "00000000000000000000000000000010";
		RF_WrData_sel <= '1';
		RF_B_sel <= '0';
		wait for Clk_period*5;
		reset <= '0';
		Instr <= "100000" & "00001" & "00010" & "00001" & "00000" & "110000"; 
		RF_WrEn <= '1';
		ALU_out <= "00000000000000000000000100000000";
		MEM_out <= "00000000000000000000010000000000";
		RF_WrData_sel <= '1';
		RF_B_sel <= '1';
		wait for Clk_period*5;
		reset <= '0';
		Instr <= "111000" & "00001" & "00101" & "10001" & "00000" & "110000"; --SignExtend(Imm) (li)
		RF_WrEn <= '1';
		ALU_out <= "00000000000000000000000000010000";
		MEM_out <= "00000000000000000000000000000010";
		RF_WrData_sel <= '0';
		RF_B_sel <= '1';
		wait for Clk_period*5;
		reset <= '0';
		Instr <= "111001" & "00001" & "00101" & "10001" & "00000" & "110000"; --Imm<<16(zero-fill) -- lui
		RF_WrEn <= '0';
		ALU_out <= "00000000000000000000000000010000";
		MEM_out <= "00000000000000000000000000000010";
		RF_WrData_sel <= '0';
		RF_B_sel <= '1';
		wait for Clk_period*5;
		reset <= '0';
		Instr <= "110010" & "00001" & "00101" & "10001" & "00000" & "110000"; --ZeroFill(Imm) --nandi
		RF_WrEn <= '0';
		ALU_out <= "00000000000000000000000000010000";
		MEM_out <= "00000000000000000000000000000010";
		RF_WrData_sel <= '0';
		RF_B_sel <= '1';
		wait for Clk_period*5;
		reset <= '0';
		Instr <= "111111" & "00001" & "00101" & "10001" & "00000" & "110000"; --signextend(Imm)<<2 -b
		RF_WrEn <= '0';
		ALU_out <= "00000000000000000000000000010000";
		MEM_out <= "00000000000000000000000000000010";
		RF_WrData_sel <= '0';
		RF_B_sel <= '1';
		wait for Clk_period*5;
		
      -- insert stimulus here 



      wait;
   end process;

END;
