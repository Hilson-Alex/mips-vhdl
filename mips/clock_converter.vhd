library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity clock_converter is
	port(	i_CLK	: in std_logic;
			o_CLK	: out std_logic);
			
end clock_converter;

architecture arch_1 of clock_converter is

	signal w_COUNT : integer :=0;
	signal w_CARRY	: std_logic :='0';

begin

process (i_CLK) 
begin
	if rising_edge(i_CLK) then
		w_COUNT <= w_COUNT + 1;
		if (w_COUNT = 1) then
			w_CARRY <= not w_CARRY;
			w_COUNT <= 1;
		end if;	
	end if;
end process;

o_CLK <= w_CARRY;

end arch_1;