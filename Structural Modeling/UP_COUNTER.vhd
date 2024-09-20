library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity UP_COUNTER is
    Port ( clk: in std_logic;
			  enable : in std_logic;
			  reset: in std_logic;	
           counter: out std_logic_vector(28 downto 0) 
     );
end UP_COUNTER;

architecture Behavioral of UP_COUNTER is
signal counter_up: std_logic_vector(28 downto 0):="00000000000000000000000000000";

begin
	process(clk)
	begin
		if(rising_edge(clk)) then
			if(reset = '1') then 
				counter_up <= "00000000000000000000000000000";
			else
				if(enable = '1') then
					counter_up <= counter_up + '1';
				end if;
			end if;
		end if;
end process;
	counter <= counter_up;
end Behavioral;
