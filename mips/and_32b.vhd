library ieee;
use ieee.std_logic_1164.all;

entity and_32b is
  port(i_a : in std_logic_vector(31 downto 0);
       i_b : in std_logic_vector(31 downto 0);
       o_s : out std_logic_vector(31 downto 0));
end and_32b;

architecture arch_1 of and_32b is
begin
  o_s <= i_a and i_b;
end arch_1;
