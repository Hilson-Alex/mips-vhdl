library ieee;
use ieee.std_logic_1164.all;

entity mips is
	port(	i_clk	 : in std_logic;																			  -- clock
			i_inst : in std_logic_vector(31 downto 0);												  -- instrucao para ser executada
			o_addr : out std_logic_vector(31 downto 0) := to_stdlogicvector(x"00400000")); -- endereço da instrucao
			
end mips;

architecture arch_1 of mips is

	component clock_converter is
		port(	i_CLK	: in std_logic;
				o_CLK	: out std_logic);
	end component;

	component reg is
		port(	i_ent    : in  std_logic_vector(31 downto 0);
				i_CLK_n  : in  std_logic;
				o_saida  : out std_logic_vector(31 downto 0));
	end component;

	component seletor3_1_32bits is
		port(	i_a, i_b, i_C : in std_logic_vector (31 downto 0) := (others => '0');   --entradas
				i_sel    : in std_logic_vector(1 downto 0);                        		--seletor
				o_s      : out std_logic_vector (31 downto 0)); 								--saida
	end component;

	component somador is
		port (i_a : in std_logic_vector(31 downto 0);   --entrada do valor A (inteiro)
				i_b : in std_logic_vector(31 downto 0);   --entrada do valor B (inteiro)
				o_c : out std_logic_vector(31 downto 0)); -- saida do valor C (inteiro)
	end component;

	component ual is
		port(	i_a  : in std_logic_vector(31 downto 0);
				i_b  : in std_logic_vector(31 downto 0);
				i_op : in std_logic_vector(2 downto 0);
				o_z  : out std_logic;
				o_s  : out std_logic_vector(31 downto 0));
	end component;

	component ual_ctrl is
		port(	i_ual_op : in std_logic_vector(1 downto 0);    -- entrada do controller
				i_funct   : in std_logic_vector(5 downto 0);   -- entrada do campo funct
				o_ual_cd  : out std_logic_vector(2 downto 0)); -- saida para ula
	end component;

	component reg_bank is
		port(	i_clk   : in std_logic;                         -- Clock
				i_w_reg : in std_logic;                         -- Diz se havera escrita
				i_end1  : in std_logic_vector(4 downto 0);      -- Endereco do rs
				i_end2  : in std_logic_vector(4 downto 0);      -- Endereco do rt
				i_end_w : in std_logic_vector(4 downto 0);      -- Endereco de escrita
				i_din   : in std_logic_vector(31 downto 0);     -- Valor a ser salvo
				o_dout1 : out std_logic_vector(31 downto 0);    -- Valor do rs
				o_dout2 : out std_logic_vector(31 downto 0));   -- Valor de rt
	end component;

	component extensor is
		port(	i_ent   : in std_logic_vector(15 downto 0);
				o_saida : out std_logic_vector(31 downto 0));
	end component;

	component controller is
		port(	i_ent         : in std_logic_vector(5 downto 0);
				o_RegDest     : out std_logic_vector(1 downto 0);
				o_Dvi         : out std_logic_vector(1 downto 0);
				o_DvC         : out std_logic;
				o_LerMem      : out std_logic;
				o_MemParaReg  : out std_logic_vector(1 downto 0);
				o_UALOp       : out std_logic_vector(1 downto 0);
				o_EseMem      : out std_logic;
				o_UALFont     : out std_logic;
				o_EscReg      : out std_logic);
	end component;

	component leftShift is
		port(	i_ent   : in std_logic_vector(31 downto 0);
				o_saida : out std_logic_vector(31 downto 0));
	end component;

	component concatenador is
		port(	i_ent1  : in std_logic_vector(27 downto 0);
				i_ent2  : in std_logic_vector(3 downto 0);
				o_saida : out std_logic_vector(31 downto 0));
	end component;

	component data_mem is
		port(	i_clk  : in std_logic;                       -- Clock
				i_save : in std_logic;                       -- Salva na memoria
				i_read : in std_logic;                       -- Pega da memoria
				i_addr : in std_logic_vector(31 downto 0);   -- Endereco
				i_din  : in std_logic_vector(31 downto 0);   -- Dado de entrada
				o_dout : out std_logic_vector(31 downto 0)); -- Dado de saida
	end component;

	component seletor3_1_5bit is
    port(i_a     : in std_logic_vector(4 downto 0);
         i_b     : in std_logic_vector(4 downto 0);
         i_c     : in std_logic_vector(4 downto 0);
         i_sel   : in std_logic_vector(1 downto 0);
         o_s     : out std_logic_vector(4 downto 0));
  end component;

  component mux2_1_32Bits is
    port(i_a     : in std_logic_vector(31 downto 0);
         i_b     : in std_logic_vector(31 downto 0);
         i_sel   : in std_logic;
         o_s : out std_logic_vector(31 downto 0));
  end component;

	component leftShift_26bit is
		port(	i_ent   : in std_logic_vector(25 downto 0);
				o_saida : out std_logic_vector(27 downto 0) := (others => '0'));
	end component;
	
	-- Fio Constante do $RA

  signal w_RA : std_logic_vector(4 downto 0) := "11111"; -- Registrador RA
  
	-- Fios PC

	signal w_PC_ent   : std_logic_vector(31 downto 0) := (others => '0'); 					 -- entrada PC
	signal w_PC_saida : std_logic_vector(31 downto 0) := to_stdlogicvector(x"00400000"); -- entrada PC
	signal w_CLK 	   : std_logic := '0';		 														 -- clock dividido
  
	-- Fios Controller

	signal w_RegDest     : std_logic_vector(1 downto 0);	-- registrador de destino
	signal w_Dvi         : std_logic_vector(1 downto 0);	-- desvio incondicional
	signal w_DvC         : std_logic;							-- desvio condicional
	signal w_LerMem      : std_logic;							-- ler memoria
	signal w_MemParaReg  : std_logic_vector(1 downto 0);	-- memoria para registrador
	signal w_UALOp       : std_logic_vector(1 downto 0);	-- Operação da ULA
	signal w_EseMem      : std_logic;							-- Escreve memoria
	signal w_UALFont     : std_logic;							-- Fonte da ULA
	signal w_EscReg      : std_logic;							-- Escreve em registrador

	-- fio mux Banco de Registradores

	signal w_RB_addr : std_logic_vector(4 downto 0);	-- Endereco de escrita
  
	-- fios banco de registradores

	signal w_Din    : std_logic_vector(31 downto 0);	-- valor a ser salvo
	signal w_Dout_1 : std_logic_vector(31 downto 0);	-- saida 1
	signal w_Dout_2 : std_logic_vector(31 downto 0);	-- saida 2

	-- fios mux Imediato
  
	signal i_inst_32b : std_logic_vector(31 downto 0);	-- imediato (extendido)
	signal w_B        : std_logic_vector(31 downto 0);	-- saida

	-- fio controle da ULA
  
	signal w_ual_cd : std_logic_vector(2 downto 0);	-- comando da ULA

	-- fios ULA
  
	signal w_z : std_logic := '0';					-- zero flag
	signal w_s : std_logic_vector(31 downto 0);	-- saida
  
	-- fio RAM

	signal w_MEM_Dout : std_logic_vector(31 downto 0);	-- saida RAM

	-- beq
  
	signal w_AND_s : std_logic := w_z and w_DvC;			-- seletor beq
	signal i_inst_ls : std_logic_vector(31 downto 0);	-- endereco relativo beq
  
	-- fio somador PC

	signal w_soma4 : std_logic_vector(31 downto 0) := (2 => '1', others => '0'); 	-- constante 4
	signal w_PC : std_logic_vector(31 downto 0); 											-- proxima instrucao
  
	-- fios jump 

	signal i_inst_e : std_logic_vector(27 downto 0):= (others => '0');	-- imediato * 4
	signal w_CONC_pc : std_logic_vector(31 downto 0); 							-- saida concatenador
  
	-- mux beq

	signal i_inst_PC : std_logic_vector(31 downto 0);	-- endereco absoluto beq
	signal w_beq : std_logic_vector(31 downto 0);		-- saida mux beq
	
	-- jr
	
	signal w_DviJR : std_logic_vector(1 downto 0);
	signal w_escJR : std_logic;
  
begin

	u_clk	: clock_converter
		port map(i_CLK	=> i_clk,
					o_CLK	=> w_CLK);
  
	u_pc : reg
		port map(i_ent   => w_PC_ent,
               i_CLK_n => w_CLK,
               o_saida => w_PC_saida);

	u_ctrl : controller
      port map(i_ent         => i_inst(31 downto 26),
               o_RegDest     => w_RegDest,
               o_Dvi         => w_Dvi,
               o_DvC         => w_DvC,
               o_LerMem      => w_LerMem,
               o_MemParaReg  => w_MemParaReg,
               o_UALOp       => w_UALOp,
               o_EseMem      => w_EseMem,
               o_UALFont     => w_UALFont,
               o_EscReg      => w_EscReg);

	u_reg_write : seletor3_1_5bit
      port map(i_a       => i_inst(20 downto 16),
               i_b       => i_inst(15 downto 11),
               i_c       => w_RA,
               i_sel     => w_RegDest,
               o_s       => w_RB_addr);

	u_reg_bank	: reg_bank
      port map(i_clk   => i_clk,
               i_w_reg => w_EscReg,
               i_end1  => i_inst(25 downto 21),
               i_end2  => i_inst(20 downto 16),
               i_end_w => w_RB_addr,
               i_din   => w_Din,
               o_dout1 => w_Dout_1,
               o_dout2 => w_Dout_2);

	u_imed	   : extensor
      port map(i_ent   => i_inst(15 downto 0),
               o_saida => i_inst_32b);

   u_ual_font :  mux2_1_32Bits
      port map(i_a   => w_Dout_2,
               i_b   => i_inst_32b,
               i_sel => w_UALFont,
               o_s   => w_B);

   u_ual_ctrl : ual_ctrl
      port map(i_ual_op => w_UALOp,
               i_funct  => i_inst(5 downto 0),
               o_ual_cd => w_ual_cd);

   u_ual : ual
      port map(i_a  => w_Dout_1,
               i_b  => w_B,
               i_op => w_ual_cd,
               o_z  => w_z,
               o_s  => w_S);

   u_data_mem : data_mem
      port map(i_clk  => i_clk,
               i_save => w_EseMem,
               i_read => w_LerMem,
               i_addr => w_S,
               i_din  => w_Dout_2,
               o_dout => w_MEM_Dout);

   u_wr_value : seletor3_1_32bits
		port map(i_a   => w_S,
               i_b   => w_MEM_Dout,
               i_c   => w_PC,
               i_sel => w_MemParaReg,
               o_s   => w_Din);

	u_beq_ls : leftShift
      port map(i_ent   => i_inst_32b,
               o_saida => i_inst_ls);

   u_nx_inst : somador
      port map(i_a => w_PC_saida,
               i_b => w_soma4,
               o_c => w_PC);

   u_beq_inst : somador
      port map(i_a => w_PC,
               i_b => i_inst_ls,
               o_c => i_inst_PC);

   u_j_ls	 	: leftShift_26bit
      port map(i_ent   => i_inst(25 downto 0),
               o_saida => i_inst_e);

   u_j_conc	: concatenador
      port map(i_ent1  => i_inst_e,
               i_ent2  => w_PC(31 downto 28),
               o_saida => w_CONC_pc);

   u_beq_mux	: mux2_1_32Bits
      port map(i_a   => w_PC,
               i_b   => i_inst_PC,
               i_sel => w_AND_s,
               o_s   => w_beq);

   u_j_mux		: seletor3_1_32bits
      port map(i_a   => w_beq,
               i_b   => w_CONC_pc,
               i_c   => w_Dout_1,
               i_sel => w_DviJR,
               o_s   => w_PC_ent);
	 
	w_DviJR <= "10" when (i_inst(31 downto 26) = "000000" and i_inst(5 downto 0) = "001000") else w_Dvi;
	w_escJR <= '0' when i_inst(5 downto 0) = "001000" else w_EscReg;
	o_addr <= w_PC_saida;

end arch_1;
