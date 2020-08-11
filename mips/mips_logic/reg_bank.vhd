library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_bank is
  port(i_clk   : in std_logic;                         -- Clock
       i_w_reg : in std_logic;                         -- Diz se haverá escrita
       i_end1  : in std_logic_vector(4 downto 0);      -- Endereço do rs
       i_end2  : in std_logic_vector(4 downto 0);      -- Endereço do rt
       i_end_w : in std_logic_vector(4 downto 0);      -- Endereço de escrita
       i_din   : in std_logic_vector(31 downto 0);     -- Valor a ser salvo
       o_dout1 : out std_logic_vector(31 downto 0);    -- Valor do rs
       o_dout2 : out std_logic_vector(31 downto 0));   -- Valor de rt
end reg_bank;

architecture arch_1 of reg_bank is
  type t_mem is array (0 to 31) of std_logic_vector(31 downto 0);
  signal w_regs : t_mem := (29 => to_stdlogicvector(x"7fffeffc"), -- stack pointer
									 8  => to_stdlogicvector(x"10010000"), -- 
									 others => (others => '0'));
  begin
	
	o_dout1 <= w_regs(to_integer(unsigned(i_end1)));
	o_dout2 <= w_regs(to_integer(unsigned(i_end2)));
  
  process (i_clk) begin
	if (rising_edge(i_clk)) then
		if(i_w_reg = '1') then
			w_regs(to_integer(unsigned(i_end_w))) <= i_din;
      end if;
	end if;
  end process;
  
end arch_1;
