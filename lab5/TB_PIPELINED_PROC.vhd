--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:23:13 05/19/2019
-- Design Name:   
-- Module Name:   /home/amanesis/HRY312_LAB1/TB_PIPELINED_PROC.vhd
-- Project Name:  HRY312_LAB1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PipelinedProcessor
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
 
ENTITY TB_PIPELINED_PROC IS
END TB_PIPELINED_PROC;
 
ARCHITECTURE behavior OF TB_PIPELINED_PROC IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PipelinedProcessor
    PORT(
         clk : IN  std_logic;
         Reset : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal Reset : std_logic := '0';

   -- Clock period definitions
   constant clk_period : time := 200 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PipelinedProcessor PORT MAP (
          clk => clk,
          Reset => Reset
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
      -- hold reset state for 100 ns.
		Reset<='1';

      wait for clk_period*10;
		Reset<='0';

      -- insert stimulus here 

      wait;
   end process;

END;
