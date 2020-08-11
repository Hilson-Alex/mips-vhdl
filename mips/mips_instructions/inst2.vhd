library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity inst2 is
  port(
    addr : in std_logic_vector(31 downto 0) := to_stdlogicvector(x"00400000");
    ins  : out std_logic_vector(31 downto 0) := (others => '0'));
end inst2;

architecture arch_1 of inst2 is

begin
  ins <= to_stdlogicvector(x"20100001") when to_integer(unsigned(addr)) - 16#00400000# = 0 else
         to_stdlogicvector(x"22100002") when to_integer(unsigned(addr)) - 16#00400000# = 4 else
         to_stdlogicvector(x"08100001") when to_integer(unsigned(addr)) - 16#00400000# = 8 else (others => '0');
end arch_1;
