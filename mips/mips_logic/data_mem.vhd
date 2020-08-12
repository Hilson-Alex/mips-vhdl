library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_mem is
  port(i_clk  : in std_logic;                       -- Clock
       i_save : in std_logic;                       -- Salva na memória
       i_read : in std_logic;                       -- Pega da memória
       i_addr : in std_logic_vector(31 downto 0);   -- Endereço
       i_din  : in std_logic_vector(31 downto 0);   -- Dado de entrada
       o_dout : out std_logic_vector(31 downto 0)); -- Dado de saída
end data_mem;

architecture arch_1 of data_mem is
  type t_mem is array (0 to (2**8)-1) of std_logic_vector(31 downto 0); -- Memória endereçada em 8 bits e nao 32 bits
  signal w_regs : t_mem := (others => (others => '0'));
  begin

  process(i_clk)
  begin
      if (rising_edge(i_clk)) then
          if (i_save = '1') then
              w_regs(to_integer(unsigned(i_addr(7 downto 0)))) <= i_din;
          end if;
      end if;
	end process;
		
   o_dout <= w_regs(to_integer(unsigned(i_addr(7 downto 0)))) when i_read = '1' else
				 (others => '0');
      
end arch_1;
