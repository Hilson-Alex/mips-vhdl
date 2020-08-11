library ieee;
use ieee.std_logic_1164.all;

entity reg is
  port(i_ent    : in  std_logic_vector(31 downto 0) := to_stdlogicvector(x"00400000");
       i_CLK_n  : in  std_logic;
       o_saida  : out std_logic_vector(31 downto 0) := to_stdlogicvector(x"00400000"));
end reg;

architecture arch_1 of reg is
  begin
  process(i_CLK_n)
  begin
    if(rising_edge(i_CLK_n)) then
      o_saida <= i_ent;
    end if;
  end process;
end architecture;
