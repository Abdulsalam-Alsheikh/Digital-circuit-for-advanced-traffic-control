library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity signal_stabilizer is
    Port ( clk        : in std_logic;
			  sensor_external : in std_logic;
			  green_external : in std_logic;
			  sensorF1 : in std_logic;	
		     sensorB1 : in std_logic;	 
           LED_sens_timer   : OUT std_logic;
			  LED_sens_compin  : OUT std_logic);
end signal_stabilizer;

architecture Behavioral of signal_stabilizer is
component UP_COUNTER_6Bit
    Port ( clk: in std_logic;
			  enable : in std_logic;
			  reset: in std_logic;	
           counter: out std_logic_vector(5 downto 0) 
     );
end component;
component UP_COUNTER
    Port ( clk: in std_logic;
			  enable : in std_logic;
			  reset: in std_logic;	
           counter: out std_logic_vector(28 downto 0) 
     );
end component;

component DFF1 
port( Clk :in std_logic;   
		D :in  std_logic;
		Q : out std_logic);
end component;

signal carpulse : std_logic;
signal counter1 : std_logic_vector(5 downto 0);
signal counter2 : std_logic_vector(5 downto 0);
signal counter3 : std_logic_vector(28 downto 0);
signal counter4 : std_logic_vector(28 downto 0);

signal clkcon1  : std_logic;
signal clkcon2  : std_logic;
signal clkcon3  : std_logic;
signal clkcon4  : std_logic;

begin
carpulse <= (not sensor_external) and (green_external) and (sensorF1 and sensorB1);

counter6bitEna5s   : UP_COUNTER_6Bit PORT MAP(carpulse,'1',clkcon3,counter1);
counter6bitEna7s   : UP_COUNTER_6Bit PORT MAP(carpulse,'1',clkcon4,counter2);
counter29bit5s     : UP_COUNTER      PORT MAP(clk,clkcon1,clkcon3,counter3);
counter29bit7s     : UP_COUNTER      PORT MAP(clk,clkcon2,clkcon4,counter4);

clkcon1 <= counter1(0) or counter1(1) or counter1(2) or counter1(3) or counter1(4) or counter1(5);
clkcon2 <= counter2(0) or counter2(1) or counter2(2) or counter2(3) or counter2(4) or counter2(5);
	
clkcon3 <= (not counter3(0)) and (not counter3(1)) and (not counter3(2))
				and (not counter3(3)) and (not counter3(4)) and (not counter3(5))
				and (not counter3(6)) and ( counter3(7)) and (not counter3(8))
				and (counter3(9)) and (not counter3(10)) and (not counter3(11))
				and (counter3(12)) and (counter3(13))and (not counter3(14))
				and (counter3(15))and (not counter3(16))   and (counter3(17))
				and (counter3(18))and (not counter3(19))and (not counter3(20))
				and (counter3(21))and (counter3(22))and (counter3(23))
				and (not counter3(24))and (counter3(25))and (counter3(26))
				and (counter3(27)) and (not counter3(28));

clkcon4 <= (counter3(0)) and (counter4(1)) and (counter4(2)) -- 000
				and (counter4(3)) and (counter4(4)) and (counter4(5)) -- 000
				and (counter4(6)) and (not counter4(7)) and (counter4(8)) -- 110
				and (counter4(9)) and (not counter4(10)) and (not counter4(11)) -- 001
				and (counter4(12)) and (not counter4(13))and (not counter4(14)) -- 001
				and (counter4(15))and (not counter4(16))   and (not counter4(17)) -- 001
				and (counter4(18))and (counter4(19))and (counter4(20)) -- 111
				and (not counter4(21))and (counter4(22))and (counter4(23)) -- 110
				and (not counter4(24))and (not counter4(25))and (counter4(26)) -- 100
				and (not counter4(27)) and (counter4(28)); -- 010
				
LED_sens_timer  <= clkcon1 and (not clkcon3);
LED_sens_compin <= clkcon2 and (not clkcon4);
end Behavioral;
