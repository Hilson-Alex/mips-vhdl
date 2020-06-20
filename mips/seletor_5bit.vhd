library ieee;
use ieee.std_logic_1164.all;

entity seletor_5bit is
  port(i_a     : in std_logic_vector(4 downto 0);
       i_b     : in std_logic_vector(4 downto 0);
       i_sel   : in std_logic;
       o_saida : out std_logic_vector(4 downto 0));
end seletor_5bit;

architecture arch_1 of seletor_5bit is
  begin
    o_saida <= i_a when i_sel = '0' else i_b;

end arch_1;
