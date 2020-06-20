library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity leftShift_26bit is
  port(i_ent   : in std_logic_vector(25 downto 0);
       o_saida : out std_logic_vector(27 downto 0) := (others => '0'));
end leftShift_26bit;

architecture arch_1 of leftShift_26bit is
begin
  o_saida(25 downto 0) <= std_logic_vector(shift_left(unsigned(i_ent), 2));
end architecture;
