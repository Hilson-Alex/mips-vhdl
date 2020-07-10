	library ieee;
use ieee.std_logic_1164.all;

entity controller is
  port(i_ent         : in std_logic_vector(5 downto 0);
       o_RegDest     : out std_logic_vector(1 downto 0);
       o_Dvi         : out std_logic_vector(1 downto 0);
       o_DvC         : out std_logic;
       o_LerMem      : out std_logic;
       o_MemParaReg  : out std_logic_vector(1 downto 0);
       o_UALOp       : out std_logic_vector(1 downto 0);
       o_EseMem      : out std_logic;
       o_UALFont     : out std_logic;
       o_EscReg      : out std_logic);
end controller;

architecture arch_1 of controller is
  begin
    o_RegDest    <= "01" when i_ent = "000000" else "10" when i_ent = "000011" else "00";
    o_Dvi        <= "01" when i_ent ="000010" or i_ent = "000011" else "00";
    o_DvC        <= '1' when i_ent = "000100" else '0';
    o_LerMem     <= '1' when i_ent = "100011" else '0';
    o_MemParaReg <= "01" when i_ent = "100011" else "10" when i_ent = "000011" else "00";
    o_UALOp      <= "01" when i_ent = "000100" else "10" when i_ent = "000000" else "00";
    o_EseMem     <= '1' when i_ent = "101011" else '0';
    o_UALFont    <= '1' when i_ent = "001000" else '0';
    o_EscReg     <= '1' when i_ent = "000000" or i_ent = "001000" or i_ent="000011" else '0';
end arch_1;
