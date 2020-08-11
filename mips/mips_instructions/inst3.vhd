library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity inst3 is
  port(
    addr : in std_logic_vector(31 downto 0) := to_stdlogicvector(x"00400000");
    ins  : out std_logic_vector(31 downto 0) := (others => '0'));

end inst3;

architecture arch_1 of inst3 is

begin
  ins <= to_stdlogicvector(x"08100005") when to_integer(unsigned(addr)) - 16#00400000# = 0 else
         to_stdlogicvector(x"00854020") when to_integer(unsigned(addr)) - 16#00400000# = 4 else
         to_stdlogicvector(x"00c74820") when to_integer(unsigned(addr)) - 16#00400000# = 8 else
         to_stdlogicvector(x"01091022") when to_integer(unsigned(addr)) - 16#00400000# = 12 else
         to_stdlogicvector(x"03e00008") when to_integer(unsigned(addr)) - 16#00400000# = 16 else
         to_stdlogicvector(x"20040004") when to_integer(unsigned(addr)) - 16#00400000# = 20 else
         to_stdlogicvector(x"20050003") when to_integer(unsigned(addr)) - 16#00400000# = 24 else
         to_stdlogicvector(x"20060002") when to_integer(unsigned(addr)) - 16#00400000# = 28 else
         to_stdlogicvector(x"20070001") when to_integer(unsigned(addr)) - 16#00400000# = 32 else
         to_stdlogicvector(x"0c100001") when to_integer(unsigned(addr)) - 16#00400000# = 36 else
         to_stdlogicvector(x"00000000") when to_integer(unsigned(addr)) - 16#00400000# = 40 else (others => '0');
end arch_1;
