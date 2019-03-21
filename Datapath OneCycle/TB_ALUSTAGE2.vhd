--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:02:09 03/05/2019
-- Design Name:   
-- Module Name:   /home/amanesis/HRY312_LAB1/TB_ALUSTAGE2.vhd
-- Project Name:  HRY312_LAB1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALUSTAGE
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
 
ENTITY TB_ALUSTAGE2 IS
END TB_ALUSTAGE2;
 
ARCHITECTURE behavior OF TB_ALUSTAGE2 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALUSTAGE
    PORT(
         RF_A : IN  std_logic_vector(31 downto 0);
         RF_B : IN  std_logic_vector(31 downto 0);
         Immed : IN  std_logic_vector(31 downto 0);
         ALU_Bin_sel : IN  std_logic;
         ALU_func : IN  std_logic_vector(3 downto 0);
         ALU_out : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal RF_A : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_B : std_logic_vector(31 downto 0) := (others => '0');
   signal Immed : std_logic_vector(31 downto 0) := (others => '0');
   signal ALU_Bin_sel : std_logic := '0';
   signal ALU_func : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal ALU_out : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALUSTAGE PORT MAP (
          RF_A => RF_A,
          RF_B => RF_B,
          Immed => Immed,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_func => ALU_func,
          ALU_out => ALU_out
        );

 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

 		--Reset<='1';
		RF_A<="00000000000000000000000000000000";
		RF_B<="00000000000000000000000000000000";
		Immed<="00000000000000000000000000000000";
		ALU_Bin_sel<='0';
		ALU_func<="0000";
      wait for 40 ns;
		--ADD
		--Reset<='0';
		RF_A<="00000000000000000000000000000100";
		RF_B<="00000000000000000000000000010000";
		Immed<="00000000000000000000000000000000";
		ALU_Bin_sel<='0';
		ALU_func<="0000";
      wait for 40 ns;
		--ADD
		--Reset<='0';
		RF_A<="00000000000000000000000000000100";
		RF_B<="00000000000000000000000000010000";
		Immed<="00000000000000000000000000011000";
		ALU_Bin_sel<='1';
		ALU_func<="0000";
      wait for 40 ns;
		--ADD Cout
		--Reset<='0';
		RF_A<="11111111111111111111111111111111";
		RF_B<="00000000000000000000000000000010";
		Immed<="00000000000000000000000100000000";
		ALU_Bin_sel<='0';
		ALU_func<="0000";
      wait for 40 ns;
		--ADD Ovf
		--Reset<='0';
		RF_A<="01111111111111111111111111111111";
		RF_B<="01111111111111111111111111111111";
		Immed<="00000000000000000000000100000000";
		ALU_Bin_sel<='0';
		ALU_func<="0000";
      wait for 40 ns;
		--SUB
		--Reset<='0';
		RF_A<="00000000000000000000000001000000";
		RF_B<="00000000000000000000000000001000";
		Immed<="00000000000000000000000100000100";
		ALU_Bin_sel<='0';
		ALU_func<="0001";
      wait for 40 ns;
		--SUB Ovf
		--Reset<='0';
		RF_A<="01111111111111111111111111111111";
		RF_B<="10000000000000000000000000001000";
		Immed<="00000000000000000000000100000100";
		ALU_Bin_sel<='0';
		ALU_func<="0001";
      wait for 40 ns;
		--SUB 000
		--Reset<='0';
		RF_A<="00000000000000000000000000000000";
		RF_B<="00000000000000000000000000000000";
		Immed<="00000000000000000000000100000100";
		ALU_Bin_sel<='0';
      ALU_func<="0001";
      wait for 40 ns;
		--NAND
		--Reset<='0';
		RF_A<="00000000000000000000000000100100";
		RF_B<="00000000000000000000000100100110";
		Immed<="00000000000000000000100100000100";
		
		ALU_Bin_sel<='1';

		ALU_func<="0110";
      wait for 40 ns;	
		--OR
		--Reset<='0';
		RF_A<="00000000000000000000000000001111";
		RF_B<="00000000000000000000000001111111";
		Immed<="00000000000000000000000100000100";
		ALU_Bin_sel<='1';
		ALU_func<="0111";
      -- insert stimulus here 

      wait;
   end process;

END;
