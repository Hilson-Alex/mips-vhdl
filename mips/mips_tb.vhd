library ieee;
use ieee.std_logic_1164.all;

entity mips_tb is
end mips_tb;

architecture arch_1 of mips_tb is

	component inst2 is
		port(	addr : in std_logic_vector(31 downto 0);
				ins  : out std_logic_vector(31 downto 0));
	end component;

	component mips is
		port(	i_clk	 : in std_logic;								-- clock
				i_inst : in std_logic_vector(31 downto 0);	-- instrucao para ser executada
				o_addr : out std_logic_vector(31 downto 0)); -- endereço da instrucao
	end component;
	
	signal w_inst : std_logic_vector(31 downto 0);
	signal w_addr : std_logic_vector(31 downto 0);
	signal w_CLK  : std_logic := '0';

begin

	u_mips : mips
		port map(i_CLK	 => w_CLK,
					i_inst => w_inst,
					o_addr => w_addr);
  
	u_inst : inst2
		port map(addr => w_addr,
               ins  => w_inst);

	 w_CLK <= not (w_CLK) after 20ns;

end arch_1;
