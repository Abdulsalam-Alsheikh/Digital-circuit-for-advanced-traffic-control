LIBRARY ieee;
USE ieee.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity traffic IS 
generic(ClockFrequencyHz:integer:=50000000);
	PORT(	CLK      : IN STD_LOGIC;  
			sensorL : in std_logic;
		    sensorR : in std_logic;
			sensorF : in std_logic;
			sensorB : in std_logic;
			LEDL : buffer std_logic_vector(2 downto 0);
			LEDR : buffer std_logic_vector(2 downto 0);
			LEDF : buffer std_logic_vector(2 downto 0);
			LEDB : buffer std_logic_vector(2 downto 0));
END traffic;

ARCHITECTURE traffic_road OF traffic IS
type led_state is (S0 ,S1 ,S2 ,S3 ,S4 ,S5 ,S6 ,S7 );

signal sensorLR : std_logic;
signal sensorFB : std_logic;

begin
	
	sensorLR <= sensorL AND sensorR;
	sensorFB <= sensorF AND sensorB;
	
	LEDR <= LEDL;
	LEDB <= LEDF;
	
	process(clk)
	
	variable ledst : led_state := S0;
	variable lrfb : STD_LOGIC_VECTOR(1 DOWNTO 0);
	variable count_ledst : integer range 0 to ClockFrequencyHz*5 := 0;
--	variable slr:STD_LOGIC;
--	variable sfb:STD_LOGIC;
	begin
		
		if clk'EVENT and clk = '1' then   
--			slr = sensorLR(1) and sensorLR(0); 1 1 ( 100 )   1S
--			sfb = sensorFB(1) and sensorFB(0); 0 1 (100*8  - 0.001*100 ) 6S - 1ms
--			lrfb := slr & sfb;
			lrfb := sensorLR & sensorFB;

			count_ledst:= count_ledst + 1;
			case ledst is
				when S0 => 
					LEDL <= "100"; --RED
					LEDF <= "100"; --RED 
					if count_ledst = ClockFrequencyHz then
						if lrfb = "00" or lrfb = "01" then 
							ledst := S1;
						elsif lrfb = "10" then
							ledst := S5;
						end if;
						count_ledst:= 0;
					end if;							
				when S1 => 
					LEDL <= "110"; --( yollow - RED)
					LEDF <= "100"; --RED
					if count_ledst= ClockFrequencyHz then
						ledst := S2;
						count_ledst:= 0;
					end if;
				when S2 => 
					LEDL <= "001"; --green
					LEDF <= "100"; --RED
					if count_ledst = ClockFrequencyHz*5 then
						if lrfb = "10" or lrfb = "00" then
							ledst := S3;
						end if;
						count_ledst:= 0;
					end if;
				when S3 => 
					LEDL <= "010"; --YELLOW
					LEDF <= "100"; --RED
					if count_ledst= ClockFrequencyHz then
						ledst := S4;
						count_ledst:= 0;
					end if;
				when S4 => 
					LEDL <= "100"; --RED
					LEDF <= "100"; --RED
					if count_ledst= ClockFrequencyHz then
						ledst := S5;
						count_ledst:= 0;
					end if;
				when S5 => 
					LEDL <= "100"; --RED
					LEDF <= "110"; --( yollow - RED )
					if count_ledst= ClockFrequencyHz then
						ledst := S6;
						count_ledst:= 0;
					end if;
				when S6 => 
					LEDL <= "100"; --RED
					LEDF <= "001"; --green
					if count_ledst= ClockFrequencyHz*5 then
						if lrfb = "01" or lrfb = "00" then
							ledst := S7;
						end if;
						count_ledst:= 0;
					end if;
				when S7 => 
					LEDL <= "100"; --RED
					LEDF <= "010"; --YELLOW
					if count_ledst = ClockFrequencyHz then
						ledst := S0;
						count_ledst:= 0;
					end if;
				when others =>
					ledst := S0;
					count_ledst:= 0;
			end case;
		end if;
	end process;
	
end traffic_road;
					