library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity inst1 is
  port(
    addr : in std_logic_vector(31 downto 0) := to_stdlogicvector(x"00400000");
    ins  : out std_logic_vector(31 downto 0) := (others => '0'));
	 
end inst1;

architecture arch_1 of inst1 is
	
begin
  ins <= to_stdlogicvector(x"20100001") when to_integer(unsigned(addr)) = 0 else
         to_stdlogicvector(x"20100001") when to_integer(unsigned(addr)) = 4 else
         to_stdlogicvector(x"20100001") when to_integer(unsigned(addr)) = 8 else
         to_stdlogicvector(x"20100001") when to_integer(unsigned(addr)) = 12 else
         to_stdlogicvector(x"20100001") when to_integer(unsigned(addr)) = 16 else
         to_stdlogicvector(x"20100001") when to_integer(unsigned(addr)) = 20 else
         to_stdlogicvector(x"20100001") when to_integer(unsigned(addr)) = 24 else
         to_stdlogicvector(x"20100001") when to_integer(unsigned(addr)) = 28 else (others => '0');
end arch_1;
