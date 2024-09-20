library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity timer_Pulse is
    Port ( QB         : in std_logic;
			  QC         : in std_logic;
			  clk        : in std_logic;
			  LED_sens   : in std_logic;
           timerPulse : buffer std_logic);
end timer_Pulse;

architecture archtimer_Pulse of timer_Pulse is

component UP_COUNTER
Port ( clk: in std_logic;
	    reset: in std_logic;
		 enable : in std_logic; 
		 counter: out std_logic_vector(28 downto 0) 
	  );
end component;

signal counter1 : std_logic_vector(28 downto 0);
signal counter2 : std_logic_vector(28 downto 0);
signal counter3 : std_logic_vector(28 downto 0);
signal clkcon1 : std_logic;
signal clkcon2 : std_logic;
signal clkcon3 : std_logic;
signal enable : std_logic;
signal notenable : std_logic;
signal reset_counters : std_logic;

begin

	enable <= QB AND (NOT QC);
	
	notenable <= not enable;
	
	reset_counters <= LED_sens or timerPulse; 
	coun1s:UP_COUNTER PORT MAP(clk,reset_counters,notenable,counter1);
	coun5s:UP_COUNTER PORT MAP(clk,reset_counters,enable,counter2);
	coun5s2:UP_COUNTER PORT MAP(clk,timerPulse,LED_sens,counter3);
		
	--0010111110101111000010000000 = 50,000,000
	--0010111110101111000001111111 = 49,999,999
	clkcon1 <= ( counter1(0)) and ( counter1(1)) and ( counter1(2))
					and ( counter1(3)) and ( counter1(4)) and ( counter1(5))
					and ( counter1(6)) and (not counter1(7)) and (not counter1(8))
					and (not counter1(9)) and (not counter1(10)) and (not counter1(11))
					and (counter1(12)) and (counter1(13))and (counter1(14))
					and (counter1(15))and (not counter1(16))   and (counter1(17))
					and (not counter1(18))and (counter1(19))and (counter1(20))
					and (counter1(21))and (counter1(22))and (counter1(23))
					and (not counter1(24))and (counter1(25))and (not counter1(26))
					and (not counter1(27))and (not counter1(28));
					
	--1110111001101011001010000000 = 50,000,000*5
	--1110111001101011001001111111 = 50,000,000*5 - 1 	
	clkcon2 <= ( counter2(0)) and ( counter2(1)) and ( counter2(2))
					and ( counter2(3)) and ( counter2(4)) and ( counter2(5))
					and ( counter2(6)) and (not counter2(7)) and (not counter2(8))
					and (counter2(9)) and (not counter2(10)) and (not counter2(11))
					and (counter2(12)) and (counter2(13))and (not counter2(14))
					and (counter2(15))and (not counter2(16))   and (counter2(17))
					and (counter2(18))and (not counter2(19))and (not counter2(20))
					and (counter2(21))and (counter2(22))and (counter2(23))
					and (not counter2(24))and (counter2(25))and (counter2(26))
					and (counter2(27)) and (not counter2(28));

	clkcon3 <= (counter3(0)) and ( counter3(1)) and ( counter3(2))
					and ( counter3(3)) and ( counter3(4)) and ( counter3(5))
					and ( counter3(6)) and (not counter3(7)) and (not counter3(8))
					and ( counter3(9)) and (not counter3(10)) and (not counter3(11))
					and ( counter3(12))and (counter3(13))and (not counter3(14))
					and ( counter3(15))and (not counter3(16))   and (counter3(17))
					and ( counter3(18))and (not counter3(19))and (not counter3(20))
					and ( counter3(21))and (counter3(22))and (counter3(23))
					and (not counter3(24))and (counter3(25))and (counter3(26))
					and (counter3(27)) and (not counter3(28));
					
	timerPulse <= clkcon1 or clkcon2 or clkcon3;
	
end archtimer_Pulse;
