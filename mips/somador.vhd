library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity somador is
  port (i_a : IN std_logic_vector(31 downto 0); --entrada do valor A (inteiro)
        i_b : IN std_logic_vector(31 downto 0); --entrada do valor B (inteiro)
        o_c : OUT std_logic_vector(31 downto 0) -- saída do valor C (inteiro)
        );
end somador;

ARCHITECTURE soma OF somador IS
  signal w_a, w_b, w_c : INTEGER;
  BEGIN
    w_a <= to_integer(unsigned(i_a));
    w_b <= to_integer(signed(i_b));
    w_c <= w_a + w_b;
    o_c <= std_logic_vector(to_unsigned(w_c, o_c'length));

END soma;
