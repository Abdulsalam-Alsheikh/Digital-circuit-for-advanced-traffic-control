library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity output_Logic is
    Port ( QA: in std_logic;
			  QB : in std_logic;
			  QC : in std_logic;
			  LEDLR : out std_logic_vector(2 downto 0);
			  LEDFB : out std_logic_vector(2 downto 0));
end output_Logic;
architecture archoutput_Logic of output_Logic is

begin
	
	LEDLR(2) <= ((not QB) AND (not QC)) OR ((not QB) AND (not QA)) OR (QA AND QB) OR (QA AND QC);
	LEDLR(1) <= QC AND (not QA);
	LEDLR(0) <= QB AND (not QA) AND (not QC);
	LEDFB(2) <= (not QB) OR (not QA) ;
	LEDFB(1) <= QA AND QC;
	LEDFB(0) <= QA AND QB AND (not QC);
	
end archoutput_Logic;