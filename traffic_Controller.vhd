library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity traffic_Controller is
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
end traffic_Controller;

architecture archtraffic_Controller of traffic_Controller is
component next_Presnt_StateLogic
    Port ( clk: in std_logic;
			  sensorLR : in std_logic;
			  sensorFB : in std_logic;
			  timerPulse : in std_logic;
			  LED_sens_compin : in std_logic;
			  LED_sens_timer : in std_logic; 
           QA: buffer std_logic;
			  QB: buffer std_logic;
			  QC: buffer std_logic);
end component;

component timer_Pulse
    Port ( QB: in std_logic;
			  QC: in std_logic;
			  clk: in std_logic;
			  LED_sens   : in std_logic;
           timerPulse: buffer std_logic);
end component;

component output_Logic
    Port ( QA: in std_logic;
			  QB : in std_logic;
			  QC : in std_logic;
			  LEDLR : out std_logic_vector(2 downto 0);
			  LEDFB : out std_logic_vector(2 downto 0));
end component;

component signal_stabilizer
    Port ( clk        : in std_logic;
			  sensor_external : in std_logic;
			  green_external : in std_logic;
		     sensorF1 : in std_logic;	
		     sensorB1 : in std_logic;	 
           LED_sens_timer   : OUT std_logic;
			  LED_sens_compin  : OUT std_logic);
end component;

signal QA : std_logic;
signal QB : std_logic;
signal QC : std_logic;

signal sensorLR : std_logic;
signal sensorFB : std_logic;

signal LED_sens_timer : std_logic;
signal LED_sens_compin : std_logic;

signal timerPulse : std_logic;

begin
	sensorLR <= sensorL and sensorR;
	sensorFB <= sensorF and sensorB;

	
	signalstab: signal_stabilizer PORT MAP(clk, sensor_external, green_external, sensorF, sensorB ,LED_sens_timer , LED_sens_compin);
	timer1  : timer_Pulse PORT MAP(QB ,QC ,clk ,LED_sens_timer ,timerPulse);
	NPSL1   : next_Presnt_StateLogic PORT MAP(clk ,sensorLR ,sensorFB ,timerPulse ,LED_sens_compin ,LED_sens_timer ,QA ,QB ,QC);
	output1 : output_Logic PORT MAP(QA ,QB ,QC ,LEDL ,LEDF);
	
	LEDR <= LEDL;
	LEDB <= LEDF;
	
end archtraffic_Controller;
