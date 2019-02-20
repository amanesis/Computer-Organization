--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:02:41 02/20/2019
-- Design Name:   
-- Module Name:   /home/ISC/amanesis/HRY312_LAB1/RF_TB.vhd
-- Project Name:  HRY312_LAB1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RF
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
USE ieee.numeric_std.ALL;
 
ENTITY RF_TB IS
END RF_TB;
 
ARCHITECTURE behavior OF RF_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RF
    PORT(
         Ard1 : IN  std_logic_vector(4 downto 0);
         Ard2 : IN  std_logic_vector(4 downto 0);
         Awr : IN  std_logic_vector(4 downto 0);
         Din : IN  std_logic_vector(31 downto 0);
         WrEn : IN  std_logic;
         Dout1 : OUT  std_logic_vector(31 downto 0);
         Dout2 : OUT  std_logic_vector(31 downto 0);
         reset : IN  std_logic;
         clk : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Ard1 : std_logic_vector(4 downto 0) := (others => '0');
   signal Ard2 : std_logic_vector(4 downto 0) := (others => '0');
   signal Awr : std_logic_vector(4 downto 0) := (others => '0');
   signal Din : std_logic_vector(31 downto 0) := (others => '0');
   signal WrEn : std_logic := '0';
   signal reset : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal Dout1 : std_logic_vector(31 downto 0);
   signal Dout2 : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RF PORT MAP (
          Ard1 => Ard1,
          Ard2 => Ard2,
          Awr => Awr,
          Din => Din,
          WrEn => WrEn,
          Dout1 => Dout1,
          Dout2 => Dout2,
          reset => reset,
          clk => clk
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
      wait for 100 ns;	
				Ard1<="00000";
		Ard2<="00000";
		Awr<="00000";
		Din<=std_logic_vector(to_unsigned(0,32));
		WrEn<='0';
		reset<='1';
      wait for 100 ns;
		reset<='0';
		
		wait for Clk_period*0.5;
		Ard1<="00001";
		Ard2<="00010";
		Awr<="00001";
		Din<=std_logic_vector(to_unsigned(33,32));
		WrEn<='1';
      wait for Clk_period*5;
		Ard1<="00001";
		Ard2<="00010";
		Awr<="00010";
		Din<=std_logic_vector(to_unsigned(36,32));
		WrEn<='1';
      wait for Clk_period*5;
		Ard1<="00001";
		Ard2<="00010";
		Awr<="00011";
		Din<=std_logic_vector(to_unsigned(39,32));
		WrEn<='1';
      wait for Clk_period*5;
		Ard1<="00010";
		Ard2<="00011";
		Awr<="00001";
		Din<=std_logic_vector(to_unsigned(42,32));
		WrEn<='0';
      wait for Clk_period*5;
		Ard1<="00001";
		Ard2<="00010";
		Awr<="00001";
		Din<=std_logic_vector(to_unsigned(45,32));
		WrEn<='1';
      wait for Clk_period*5;
		Ard1<="00001";
		Ard2<="01110";
		Awr<="01110";
		Din<=std_logic_vector(to_unsigned(48,32));
		WrEn<='1';
      wait for Clk_period*5;
		Ard1<="00000";
		Ard2<="01110";
		Awr<="00000";
		Din<=std_logic_vector(to_unsigned(51,32));
		WrEn<='1';
      wait for Clk_period*5;
		wait;

      -- insert stimulus here 

      wait;
   end process;

END;
