library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity subtrator is
  port (i_a : IN std_logic_vector(31 downto 0); --entrada do valor A (inteiro)
        i_b : IN std_logic_vector(31 downto 0); --entrada do valor B (inteiro)
        o_c : OUT std_logic_vector(31 downto 0) -- saída do valor C (inteiro)
        );
end subtrator;

architecture arch_1 of subtrator is
  signal w_a, w_b, w_c : INTEGER;
  BEGIN
    w_a <= to_integer(signed(i_a));
    w_b <= to_integer(signed(i_b));
    w_c <= w_a - w_b;
    o_c <= std_logic_vector(to_signed(w_c, o_c'length));

end architecture;
