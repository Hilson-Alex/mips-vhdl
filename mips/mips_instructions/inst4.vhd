library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity inst4 is
  port(
    addr : in std_logic_vector(31 downto 0) := to_stdlogicvector(x"00400000");
    ins  : out std_logic_vector(31 downto 0) := (others => '0'));
end inst4;

architecture arch_1 of inst4 is

begin
  ins <= to_stdlogicvector(x"20100005") when to_integer(unsigned(addr)) - 16#00400000# = 0 else
         to_stdlogicvector(x"afb00000") when to_integer(unsigned(addr)) - 16#00400000# = 4 else
         to_stdlogicvector(x"8fb10000") when to_integer(unsigned(addr)) - 16#00400000# = 8 else (others => '0');
end arch_1;