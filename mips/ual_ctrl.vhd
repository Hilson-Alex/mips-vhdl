library ieee;
use ieee.std_logic_1164.all;

entity ual_ctrl is
  port(i_ual_op : in std_logic_vector(1 downto 0);   -- entrada do controller
      i_funct   : in std_logic_vector(5 downto 0);   -- entrada do campo funct
      o_ual_cd  : out std_logic_vector(2 downto 0)); -- saída para ula
end ual_ctrl;

architecture arch_1 of ual_ctrl is
  begin

    o_ual_cd(2) <= i_ual_op(0) or (i_ual_op(1) and i_funct(1));
    o_ual_cd(1) <= not i_ual_op(1) or not i_funct(2);
    o_ual_cd(0) <= (i_funct(3) or i_funct(0)) and i_ual_op(1);

end arch_1;
