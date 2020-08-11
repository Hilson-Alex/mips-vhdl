library ieee;
use ieee.std_logic_1164.all;

entity lessThan is
  port (i_a : in std_logic_vector(31 downto 0);
        i_b : in std_logic_vector(31 downto 0);
        o_s : out std_logic_vector(31 downto 0));
end lessThan;

architecture arch_1 of  lessThan is
begin
  o_s <= i_a when i_a < i_b else i_b;
end architecture;
