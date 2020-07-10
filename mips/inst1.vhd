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
  ins <= to_stdlogicvector(x"20100000") when to_integer(unsigned(addr)) - 16#00400000# = 0 else
         to_stdlogicvector(x"20110001") when to_integer(unsigned(addr)) - 16#00400000# = 4 else
         to_stdlogicvector(x"20120002") when to_integer(unsigned(addr)) - 16#00400000# = 8 else
         to_stdlogicvector(x"20130003") when to_integer(unsigned(addr)) - 16#00400000# = 12 else
         to_stdlogicvector(x"20140004") when to_integer(unsigned(addr)) - 16#00400000# = 16 else
         to_stdlogicvector(x"12740001") when to_integer(unsigned(addr)) - 16#00400000# = 20 else
         to_stdlogicvector(x"02328020") when to_integer(unsigned(addr)) - 16#00400000# = 24 else
         to_stdlogicvector(x"02138022") when to_integer(unsigned(addr)) - 16#00400000# = 28 else (others => '0');
end arch_1;
