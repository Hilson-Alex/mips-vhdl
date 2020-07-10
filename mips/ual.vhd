library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ual is
  port(i_a  : in std_logic_vector(31 downto 0);
       i_b  : in std_logic_vector(31 downto 0);
       i_op : in std_logic_vector(2 downto 0);
       o_z  : out std_logic;
       o_s  : out std_logic_vector(31 downto 0));
end ual;

architecture arch_1 of ual is
  component somador_signed is
    port(i_a : in  std_logic_vector(31 downto 0);
         i_b : in  std_logic_vector(31 downto 0);
         o_s : out std_logic_vector(31 downto 0));
  end component;
  component subtrator is
    port (i_a : IN std_logic_vector(31 downto 0); --entrada do valor A (inteiro)
          i_b : IN std_logic_vector(31 downto 0); --entrada do valor B (inteiro)
          o_c : OUT std_logic_vector(31 downto 0) -- saída do valor C (inteiro)
          );
  end component;
  component and_32b is
    port(i_a : in std_logic_vector(31 downto 0);
         i_b : in std_logic_vector(31 downto 0);
         o_s : out std_logic_vector(31 downto 0));
  end component;
  component or_32b is
    port(i_a : in std_logic_vector(31 downto 0);
         i_b : in std_logic_vector(31 downto 0);
         o_s : out std_logic_vector(31 downto 0));
  end component;

  component lessThan is
    port(i_a : in std_logic_vector(31 downto 0);
         i_b : in std_logic_vector(31 downto 0);
         o_s : out std_logic_vector(31 downto 0));
  end component;

  signal w_soma : std_logic_vector(31 downto 0);
  signal w_subt : std_logic_vector(31 downto 0);
  signal w_and  : std_logic_vector(31 downto 0);
  signal w_or   : std_logic_vector(31 downto 0);
  signal w_less : std_logic_vector(31 downto 0);
begin
  u_0 : somador_signed
    port map(i_a => i_a,
             i_b => i_b,
             o_s => w_soma);

  u_1 : subtrator
    port map(i_a => i_a,
             i_b => i_b,
             o_c => w_subt);

  u_2 : and_32b
    port map(i_a => i_a,
             i_b => i_b,
             o_s => w_and);

  u_3 : or_32b
    port map(i_a => i_a,
             i_b => i_b,
             o_s => w_or);

  u_4 : lessThan
    port map(i_a => i_a,
             i_b => i_b,
             o_s => w_less);

  o_s <= w_soma when i_op = "010" else w_subt when i_op = "110" else w_and when i_op = "000"
			else w_or when i_op = "001" else w_less when i_op = "111" else (others => '0') ;

  o_z <= '1' when to_integer(unsigned(w_subt)) = 0 and i_op = "110" else '0';
end architecture;
