LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TB_ALUSTAGE IS
END TB_ALUSTAGE;
 
ARCHITECTURE behavior OF TB_ALUSTAGE IS 
 
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
 
   --constant <clock>_period : time := 10 ns;
 
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

   -- Clock process definitions
  -- <clock>_process :process
   --begin
		--<clock> <= '0';
	--	wait for <clock>_period/2;
		--<clock> <= '1';
		--wait for <clock>_period/2;
   --end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		
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
      wait for 40 ns;
		--NOT
		--Reset<='0';
		RF_A<="00000000000000000000000000001110";
		RF_B<="00000000000000000000000000000000";
		Immed<="00000000000000000000000100000000";
		ALU_Bin_sel<='0';
		ALU_func<="0100";
      wait for 40 ns;
		--ARITH SHIFT
		--Reset<='0';
		RF_A<="00000000000000000000000001111111";
		RF_B<="00000000000000000000000000000000";
		Immed<="00000000000000000000000100110000";
		ALU_Bin_sel<='0';
		ALU_func<="1000";
      wait for 40 ns;
		--LOG SHIFTR
		--Reset<='0';
		RF_A<="00000000000000000000000001111111";
		RF_B<="00000000000000000000000000000000";
		Immed<="00000000000000000000000100000000";
		ALU_Bin_sel<='0';
		ALU_func<="1001";
      wait for 40 ns;
		--LOG SHIFTL
		--Reset<='0';
		RF_A<="00000000000000000000000001111111";
		RF_B<="00000000000000000000000000000000";
		Immed<="00000000000000000000000100000000";
		ALU_Bin_sel<='0';
		ALU_func<="1010";
      wait for 40 ns;	
		--CYC SHIFTL
		--Reset<='0';
		RF_A<="00000000000000000000000001111111";
		RF_B<="00000000000000000000000000000000";
		Immed<="00000000000000000000000100000000";
		ALU_Bin_sel<='0';
		ALU_func<="1100";
      wait for 40 ns;
		--CYC SHIFTR
		--Reset<='0';
		RF_A<="00000000000000000000000001111111";
		RF_B<="00000000000000000000000000000000";
		Immed<="00000000000000000000000100000000";
		ALU_Bin_sel<='0';
		ALU_func<="1101";
      wait for 40 ns;
		
		
		
		
      wait for 100 ns;	

      

      -- insert stimulus here 

      wait;
   end process;

END;
