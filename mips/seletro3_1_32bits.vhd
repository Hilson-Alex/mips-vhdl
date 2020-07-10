library ieee;
use ieee.std_logic_1164.all;

entity seletor3_1_32bits is
  port( i_a, i_b, i_c : in  std_logic_vector(31 downto 0);
        i_sel         : in  std_logic_vector(1 downto 0);
        o_s           : out std_logic_vector(31 downto 0));
end seletor3_1_32bits;

architecture arch_1 of seletor3_1_32bits is
begin
  o_s <= i_a when i_sel = "00" else i_b when i_sel = "01" else i_c;
end arch_1;
