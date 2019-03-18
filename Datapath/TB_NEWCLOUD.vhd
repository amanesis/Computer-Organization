--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:09:39 03/17/2019
-- Design Name:   
-- Module Name:   /home/amanesis/HRY312_LAB1/TB_NEWCLOUD.vhd
-- Project Name:  HRY312_LAB1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: cloudnew
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
 
ENTITY TB_NEWCLOUD IS
END TB_NEWCLOUD;
 
ARCHITECTURE behavior OF TB_NEWCLOUD IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT cloudnew
    PORT(
         Data : IN  std_logic_vector(15 downto 0);
         Dout : OUT  std_logic_vector(31 downto 0);
         Instr : IN  std_logic_vector(5 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Data : std_logic_vector(15 downto 0) := (others => '0');
   signal Instr : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal Dout : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 --  constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: cloudnew PORT MAP (
          Data => Data,
          Dout => Dout,
          Instr => Instr
        );

   -- Clock process definitions
 --  <clock>_process :process
  -- begin
	--	<clock> <= '0';
		--wait for <clock>_period/2;
		--<clock> <= '1';
	--	wait for <clock>_period/2;
  -- end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
Data<="0000000000001000";
Instr<="110000"; 
     -- wait for <clock>_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
