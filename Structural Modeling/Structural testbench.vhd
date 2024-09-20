library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity green_wave_tb is
end entity;
 
architecture sim of green_wave_tb is

 
-- We are using a low clock frequency to speed up the simulation
constant ClockFrequencyHz : integer := 100; -- 100 Hz
constant ClockPeriod : time := 1000 ms / ClockFrequencyHz;

component greenWave_Controller
Port ( clk: in std_logic;
  sensorL1 : in std_logic;
  sensorR1 : in std_logic;
  sensorF1 : in std_logic;
  sensorB1 : in std_logic;
  LEDL1 : buffer std_logic_vector(2 downto 0);
  LEDR1 : buffer std_logic_vector(2 downto 0);
  LEDF1 : buffer std_logic_vector(2 downto 0);
  LEDB1 : buffer std_logic_vector(2 downto 0);
  
  sensorL2 : in std_logic;
  sensorR2 : in std_logic;
  sensorF2 : in std_logic;
  sensorB2 : in std_logic;
  LEDL2 : buffer std_logic_vector(2 downto 0);
  LEDR2 : buffer std_logic_vector(2 downto 0);
  LEDF2 : buffer std_logic_vector(2 downto 0);
  LEDB2 : buffer std_logic_vector(2 downto 0));
end component;

signal clk: std_logic;
signal sensorL1 : std_logic;
signal sensorR1 : std_logic;
signal sensorF1 : std_logic;
signal sensorB1 : std_logic;
signal LEDL1 : std_logic_vector(2 downto 0);
signal LEDR1 : std_logic_vector(2 downto 0);
signal LEDF1 : std_logic_vector(2 downto 0);
signal LEDB1 : std_logic_vector(2 downto 0);

signal sensorL2 : std_logic;
signal sensorR2 : std_logic;
signal sensorF2 : std_logic;
signal sensorB2 : std_logic;
signal LEDL2 : std_logic_vector(2 downto 0);
signal LEDR2 : std_logic_vector(2 downto 0);
signal LEDF2 : std_logic_vector(2 downto 0);
signal LEDB2 : std_logic_vector(2 downto 0);
		
begin
 
	-- The Device Under Test (DUT)
	DUT :greenWave_Controller port map (clk ,
	sensorL1 ,sensorR1 ,sensorF1 ,sensorB1 ,LEDL1 ,LEDR1 ,LEDF1 ,LEDB1,
	sensorL2 ,sensorR2 ,sensorF2 ,sensorB2 ,LEDL2 ,LEDR2 ,LEDF2 ,LEDB2);
	
	main : process
	begin
		-- 1
		sensorL1 <= '0';
		sensorR1 <= '0';
		sensorF1 <= '0';
		sensorB1 <= '0';
		
		sensorL2 <= '0';
		sensorR2 <= '0';
		sensorF2 <= '0';
		sensorB2 <= '0';
		
		wait for 16000 ms;
		
		sensorL1 <= '0';
		sensorR1 <= '0';
		sensorF1 <= '1';
		sensorB1 <= '1';
		
		sensorL2 <= '0';
		sensorR2 <= '0';
		sensorF2 <= '1';
		sensorB2 <= '1';
			
		wait for 10000 ms;		

	end process; 
	clk_process :process
	begin
		clk <= '0';
		wait for ClockPeriod/2;
		clk <= '1';
		wait for ClockPeriod/2;
	end process;

 
end architecture;
