library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity leftShift is
  port(i_ent   : in std_logic_vector(31 downto 0);
       o_saida : out std_logic_vector(31 downto 0));
end leftShift;

architecture arch_1 of leftShift is
begin
  o_saida <= std_logic_vector(shift_left(unsigned(i_ent), 2));
end architecture;
