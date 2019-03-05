--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:38:20 03/05/2019
-- Design Name:   
-- Module Name:   /home/amanesis/HRY312_LAB1/TB_IFMEM.vhd
-- Project Name:  HRY312_LAB1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MEM
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
 
ENTITY TB_IFMEM IS
END TB_IFMEM;
 
ARCHITECTURE behavior OF TB_IFMEM IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MEM
    PORT(
         PC_Immed : IN  std_logic_vector(31 downto 0);
         PC_sel : IN  std_logic;
         PC_LdEn : IN  std_logic;
         clk : IN  std_logic;
         Mem_WrEn : IN  std_logic;
         reset : IN  std_logic;
         ALU_MEM_Addr : IN  std_logic_vector(31 downto 0);
         MEM_DataIn : IN  std_logic_vector(31 downto 0);
         MEM_DataOut : OUT  std_logic_vector(31 downto 0);
         Instr : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal PC_Immed : std_logic_vector(31 downto 0) := (others => '0');
   signal PC_sel : std_logic := '0';
   signal PC_LdEn : std_logic := '0';
   signal clk : std_logic := '0';
   signal Mem_WrEn : std_logic := '0';
   signal reset : std_logic := '0';
   signal ALU_MEM_Addr : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_DataIn : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal MEM_DataOut : std_logic_vector(31 downto 0);
   signal Instr : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 50 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MEM PORT MAP (
          PC_Immed => PC_Immed,
          PC_sel => PC_sel,
          PC_LdEn => PC_LdEn,
          clk => clk,
          Mem_WrEn => Mem_WrEn,
          reset => reset,
          ALU_MEM_Addr => ALU_MEM_Addr,
          MEM_DataIn => MEM_DataIn,
          MEM_DataOut => MEM_DataOut,
          Instr => Instr
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
wait for clk_period*0.5;
			PC_Immed <= "00000000000000000000000000000000";
         PC_sel <='0';
         PC_LdEn <='0';         
         Mem_WrEn <='0';
         reset <='1';
         ALU_MEM_Addr <= "00000000000000000000000000000001";
         MEM_DataIn <= "00000000000000000000000000000001";
			wait for clk_period*5;
			
			PC_Immed <= "00000000000000000000000000000000";
         PC_sel <='1';
         PC_LdEn <='1';         
         Mem_WrEn <='0';
         reset <='0';
         ALU_MEM_Addr <= "00000000000000000000000000000001";
         MEM_DataIn <= "00000000000000000000000000000001";
			wait for clk_period*5;
			
			PC_Immed <= "00000000000000000000000000000000";
         PC_sel <='0';
         PC_LdEn <='1';         
         Mem_WrEn <='0';
         reset <='0';
         ALU_MEM_Addr <= "00000000000000000000000000000011";
         MEM_DataIn <= "00000000000000000000000000000101";
			wait for clk_period*5;
			
			PC_Immed <= "00000000000000000000000000000000";
         PC_sel <='0';
         PC_LdEn <='1';         
         Mem_WrEn <='1';
         reset <='0';
         ALU_MEM_Addr <= "00000000000000000000000000000011";
         MEM_DataIn <=   "00000000000000000000000000001101";
			wait for clk_period*2;
			PC_Immed <= "00000000000000000000000000000000";
         PC_sel <='0';
         PC_LdEn <='1';         
         Mem_WrEn <='1';
         reset <='0';
         ALU_MEM_Addr <= "00000000000000000000000000000111";
         MEM_DataIn <=   "00000000000000000000000000001111";
			wait for clk_period*2;
			PC_Immed <= "00000000000000000000000000000000";
         PC_sel <='0';
         PC_LdEn <='1';         
         Mem_WrEn <='0';
         reset <='0';
         ALU_MEM_Addr <= "00000000000000000000000000000011";
         MEM_DataIn <=   "00000000000000000000000000001111";
			wait for clk_period*2;
			
			PC_Immed <= "00000000000000000000000000000100";
         PC_sel <='1';
         PC_LdEn <='1';         
         Mem_WrEn <='0';
         reset <='0';
         ALU_MEM_Addr <= "00000000000000000000000000000011";
         MEM_DataIn <=   "00000000000000000000000000001101";
			wait for clk_period;
			PC_Immed <= "00000000000000000000000000000000";
         PC_sel <='0';
         PC_LdEn <='1';         
         Mem_WrEn <='0';
         reset <='0';
         ALU_MEM_Addr <= "00000000000000000000000000000011";
         MEM_DataIn <=   "00000000000000000000000000001101";
			wait for clk_period*5;
			PC_Immed <= "00000000000000000000000000000000";
         PC_sel <='0';
         PC_LdEn <='1';         
         Mem_WrEn <='0';
         reset <='0';
         ALU_MEM_Addr <= "00000000000000000000000000000011";
         MEM_DataIn <=   "00000000000000000000000000001101";
			wait for clk_period*5;
			PC_Immed <= "00000000000000000000000000000000";
         PC_sel <='0';
         PC_LdEn <='1';         
         Mem_WrEn <='0';
         reset <='0';
         ALU_MEM_Addr <= "00000000000000000000000000000011";
         MEM_DataIn <=   "00000000000000000000000000001101";
			wait for clk_period*5;

      -- insert stimulus here 

      wait;
   end process;

END;
