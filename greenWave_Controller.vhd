library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity greenWave_Controller is
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
end greenWave_Controller;

architecture archgreenWave_Controller of greenWave_Controller is

component traffic_Controller
    Port ( clk: in std_logic;
			  sensorL : in std_logic;
			  sensorR : in std_logic;
			  sensorF : in std_logic;
			  sensorB : in std_logic;
			  
			  sensor_external: in std_logic;
			  green_external: in std_logic;
			  
			  LEDL : buffer std_logic_vector(2 downto 0);
			  LEDR : buffer std_logic_vector(2 downto 0);
			  LEDF : buffer std_logic_vector(2 downto 0);
			  LEDB : buffer std_logic_vector(2 downto 0));
end component;

begin
	crossRoad1 : traffic_Controller PORT MAP(clk, sensorL1, sensorR1, sensorF1, sensorB1, sensorL2, LEDL2(0), LEDL1, LEDR1, LEDF1, LEDB1);
	crossRoad2 : traffic_Controller PORT MAP(clk, sensorL2, sensorR2, sensorF2, sensorB2, sensorR1, LEDR1(0), LEDL2, LEDR2, LEDF2, LEDB2);
end archgreenWave_Controller; 
