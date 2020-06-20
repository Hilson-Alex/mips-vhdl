library ieee;
use ieee.std_logic_1164.all;

entity concatenador is
  port(i_ent1  : in std_logic_vector(27 downto 0);
       i_ent2  : in std_logic_vector(3 downto 0);
       o_saida : out std_logic_vector(31 downto 0) := (others => '0'));
end concatenador;

architecture arch_1 of concatenador is
begin
  o_saida(27 downto 0) <= i_ent1;
  o_saida(31 downto 28) <= i_ent2;

end architecture;
