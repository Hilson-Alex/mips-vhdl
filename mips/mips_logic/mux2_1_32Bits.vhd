library ieee;
use ieee.std_logic_1164.all;

ENTITY mux2_1_32Bits IS
  PORT(i_a, i_b : IN std_logic_vector (31 downto 0) := (others => '0'); --entradas
       i_sel    : IN std_logic; --seletor
       o_s      : OUT std_logic_vector (31 downto 0)); --saida
END mux2_1_32Bits;

ARCHITECTURE seletor OF mux2_1_32Bits IS
  BEGIN
    o_s <= i_a WHEN i_sel = '0' ELSE i_b;
END seletor;
