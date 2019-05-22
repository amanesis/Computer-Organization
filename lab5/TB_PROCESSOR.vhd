LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
--USE ieee.numeric_std.ALL;
 
ENTITY TB_PROCESSOR IS
END TB_PROCESSOR;
 
ARCHITECTURE behavior OF TB_PROCESSOR IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT processor
    PORT(
         Clock : IN  std_logic;
         Reset : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Clock : std_logic := '0';
   signal Reset : std_logic := '0';

   -- Clock period definitions
   constant Clock_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: processor PORT MAP (
          Clock => Clock,
          Reset => Reset
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
		Reset <='1';
      wait for Clock_period*4;
		Reset <='0';
      wait;
   end process;

END;
