library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity somador_signed is
  port(i_a : in  std_logic_vector(31 downto 0);
       i_b : in  std_logic_vector(31 downto 0);
       o_s : out std_logic_vector(31 downto 0));
end somador_signed;

architecture arch_1 of somador_signed is
  signal w_a, w_b, w_c : INTEGER;
  BEGIN
    w_a <= to_integer(signed(i_a));
    w_b <= to_integer(signed(i_b));
    w_c <= w_a + w_b;
    o_s <= std_logic_vector(to_signed(w_c, o_s'length));
end architecture;
