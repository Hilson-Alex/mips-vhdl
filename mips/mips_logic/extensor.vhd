library ieee;
use ieee.std_logic_1164.all;

entity extensor is
  port(i_ent   : in std_logic_vector(15 downto 0);
       o_saida : out std_logic_vector(31 downto 0));
end extensor;

architecture arch_1 of extensor is
begin
  o_saida <= (31 downto 16 => i_ent(15)) & i_ent;
end arch_1;
