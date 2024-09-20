Library IEEE;
USE IEEE.Std_logic_1164.all;

entity DFF1 is 
   port( Clk :in std_logic;   
			D :in  std_logic;
			Q : out std_logic);
end DFF1;
architecture DFFarch of DFF1 is
signal d_in : std_logic:='0';
begin  
	process(Clk)
	begin 
		if(rising_edge(Clk)) then
			d_in <= D; 
		end if;       
	end process;
   Q <= d_in;	
end DFFarch;