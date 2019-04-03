--
--
-- 			COMPUTER ORGANIZATION 	
-- 			LAB 1: REGISTER FILE
--
-- 
-- 

-- 		# WrEn(0)=0 => MIPS $R0=0
-- 		# AND output: 2ns delay
-- 		# DECODER and MUX output: 5ns delay
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.BUS_PKG.ALL;


entity RF is
    Port (		Ard1 	: in  	STD_LOGIC_VECTOR (4 downto 0);
					Ard2 	: in  	STD_LOGIC_VECTOR (4 downto 0);
					Awr 	: in  	STD_LOGIC_VECTOR (4 downto 0);
					Din 	: in  	STD_LOGIC_VECTOR (31 downto 0);
					WrEn	: in 	STD_LOGIC;
					Dout1 : out  STD_LOGIC_VECTOR (31 downto 0);
					Dout2 : out  STD_LOGIC_VECTOR (31 downto 0);
					reset : in  	STD_LOGIC;
					clk 	: in  	STD_LOGIC);
end RF;

architecture structural of RF is

-- RF Modules
--
-- 1. Register 32bit
--

	COMPONENT Reg32
	PORT(
		data : IN std_logic_vector(31 downto 0);
		we : IN std_logic;
		reset : IN std_logic;
		clk : IN std_logic;          
		dout : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
--
--
-- 2. Decoder 5x32

	COMPONENT Decoder5to32
	PORT(
		input : IN std_logic_vector(4 downto 0);          
		output : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

--
--
-- 3. RF_Mux (BUS_32)

	COMPONENT RF_Mux
	PORT(
		input : IN BUS_32;
		control : IN std_logic_vector(4 downto 0);          
		output : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

--
--
-- Inner Signals:

		signal register32out, regDelayedOut: BUS_32;
		signal RFMux32out: BUS_2;
		signal decoderOut, WrEnable: STD_LOGIC_VECTOR (31 downto 0);
		


begin

--
-- PORT MAP:
--

	DECODER: Decoder5to32 port map(input=>Awr, output=>decoderOut);
	
	wrEnable(0)<='0' after 2 ns; --MIPS $R0=0
	
	WrEn_GENERATION: for i in 1 to 31 generate
			wrEnable(i)<= (decoderOut(i) and WrEn) after 2 ns;
	end generate;
	
	Reg32_GENERATION: for i in 0 to 31 generate
		Reg32_GENERATION_i: Reg32 port map(data=>Din, dout=>regDelayedOut(i), we=>wrEnable(i), reset=>reset, clk=>clk);
	end generate;
	 
	register32out<= regDelayedOut after 5 ns;
	
	
	RF_Mux_0: RF_Mux port map(input=>register32out,output=>Dout1, control=>Ard1);
	RF_Mux_1: RF_Mux port map(input=>register32out,output=>Dout2, control=>Ard2);
	

end structural;