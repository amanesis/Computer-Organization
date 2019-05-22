--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:00:43 03/17/2019
-- Design Name:   
-- Module Name:   /home/amanesis/HRY312_LAB1/TB_CLOUD.vhd
-- Project Name:  HRY312_LAB1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Cloud
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
 
ENTITY TB_CLOUD IS
END TB_CLOUD;
 
ARCHITECTURE behavior OF TB_CLOUD IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Cloud
    PORT(
         Imm : IN  std_logic_vector(15 downto 0);
         code : IN  std_logic_vector(5 downto 0);
         output : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Imm : std_logic_vector(15 downto 0) := (others => '0');
   signal code : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal output : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
  -- constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Cloud PORT MAP (
          Imm => Imm,
          code => code,
          output => output
        );

   -- Clock process definitions
--   <clock>_process :process
--begin
	--	<clock> <= '0';
	--	wait for <clock>_period/2;
		--<clock> <= '1';
	--	wait for <clock>_period/2;
  -- end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
Imm<="0000000000001000";
code<="110000"; 
    --  wait for <clock>_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
