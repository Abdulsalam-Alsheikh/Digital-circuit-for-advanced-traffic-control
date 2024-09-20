library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity next_Presnt_StateLogic is
    Port ( clk: in std_logic;
			  sensorLR : in std_logic;
			  sensorFB : in std_logic;
			  timerPulse : in std_logic;
			  LED_sens_compin : in std_logic;
			  LED_sens_timer : in std_logic; 
           QA: buffer std_logic;
			  QB: buffer std_logic;
			  QC: buffer std_logic);
end next_Presnt_StateLogic;

architecture archnext_Presnt_StateLogic of next_Presnt_StateLogic is

component DFF1 
port( Clk :in std_logic;   
		D :in  std_logic;
		Q : out std_logic);
end component;

signal inDA : std_logic;
signal inDB : std_logic;
signal inDC : std_logic;

begin
	inDA <= (QA AND ( not timerPulse) ) OR (sensorLR AND timerPulse AND ( not LED_sens_compin)and (not LED_sens_timer)and ( not QA)and ( not QB)and ( not QC)and( not sensorFB))OR(QB and QC and timerPulse AND( not LED_sens_compin) and( not LED_sens_timer)and( not QA))OR(QA and timerPulse and ( not LED_sens_compin)and( not LED_sens_timer)and( not QC))OR(QA and timerPulse AND ( not LED_sens_compin)and( not LED_sens_timer)and( not QB));
	inDB <= (QB and ( not timerPulse))OR(QC and timerPulse and ( not LED_sens_compin) and ( not LED_sens_timer) and ( not QB))OR(QB AND timerPulse and ( not LED_sens_compin) and ( not LED_sens_timer) and ( not QC));
	inDC <= (timerPulse and ( not LED_sens_compin) and ( not LED_sens_timer) and ( not QC) and ( not sensorLR) and ( not QB))OR(timerPulse and ( not LED_sens_compin) and ( not LED_sens_timer) and ( not QC) and ( not sensorLR)AND QA)OR(QC and ( not timerPulse))OR(timerPulse AND LED_sens_compin and ( not LED_sens_timer))OR(timerPulse and ( not LED_sens_compin) and ( not LED_sens_timer) and ( not QA) and ( not QC) and ( not sensorFB)AND sensorLR)OR(timerPulse and ( not LED_sens_compin) and ( not LED_sens_timer) and ( not QA) and ( not QC) and (not sensorFB)AND QB)OR(QA AND timerPulse and ( not LED_sens_compin) and ( not LED_sens_timer) and ( not QC) and ( not QB));
	
	DFFQA : DFF1 PORT MAP(clk,inDA,QA);
	DFFQB : DFF1 PORT MAP(clk,inDB,QB);
	DFFQC : DFF1 PORT MAP(clk,inDC,QC);

end archnext_Presnt_StateLogic;