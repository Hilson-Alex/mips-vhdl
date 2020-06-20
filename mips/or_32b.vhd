library ieee;
use ieee.std_logic_1164.all;

entity or_32b is
  port(i_a : in std_logic_vector(31 downto 0);
       i_b : in std_logic_vector(31 downto 0);
       o_s : out std_logic_vector(31 downto 0));
end or_32b;

architecture arch_1 of or_32b is
begin
  o_s <= i_a or i_b;
end arch_1;
