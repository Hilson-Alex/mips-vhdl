library ieee;
use ieee.std_logic_1164.all;

entity mips is
end mips;

architecture arch_1 of mips is

  component reg is
    port(i_ent    : in  std_logic_vector(31 downto 0);
         i_CLK_n  : in  std_logic;
         o_saida  : out std_logic_vector(31 downto 0));
  end component;

  component inst1 is
    port(addr : in std_logic_vector(31 downto 0);
         ins  : out std_logic_vector(31 downto 0));
  end component;

  component mux2_1_32Bits is
    port(i_a, i_b : in std_logic_vector (31 downto 0) := (others => '0');   --entradas
         i_sel    : in std_logic;                        --seletor
         o_s      : out std_logic_vector (31 downto 0)); --saida
  end component;

  component somador is
    port (i_a : in std_logic_vector(31 downto 0);   --entrada do valor A (inteiro)
          i_b : in std_logic_vector(31 downto 0);   --entrada do valor B (inteiro)
          o_c : out std_logic_vector(31 downto 0)); -- saída do valor C (inteiro)
  end component;

  component ual is
    port(i_a  : in std_logic_vector(31 downto 0);
         i_b  : in std_logic_vector(31 downto 0);
         i_op : in std_logic_vector(2 downto 0);
         o_z  : out std_logic;
         o_s  : out std_logic_vector(31 downto 0));
  end component;

  component ual_ctrl is
    port(i_ual_op : in std_logic_vector(1 downto 0);   -- entrada do controller
         i_funct   : in std_logic_vector(5 downto 0);   -- entrada do campo funct
         o_ual_cd  : out std_logic_vector(2 downto 0)); -- saída para ula
  end component;

  component reg_bank is
    port(i_clk   : in std_logic;                         -- Clock
         i_w_reg : in std_logic;                         -- Diz se haverá escrita
         i_end1  : in std_logic_vector(4 downto 0);      -- Endereço do rs
         i_end2  : in std_logic_vector(4 downto 0);      -- Endereço do rt
         i_end_w : in std_logic_vector(4 downto 0);      -- Endereço de escrita
         i_din   : in std_logic_vector(31 downto 0);     -- Valor a ser salvo
         o_dout1 : out std_logic_vector(31 downto 0);    -- Valor do rs
         o_dout2 : out std_logic_vector(31 downto 0));   -- Valor de rt
  end component;

  component extensor is
    port(i_ent   : in std_logic_vector(15 downto 0);
         o_saida : out std_logic_vector(31 downto 0));
  end component;

  component controller is
    port(i_ent         : in std_logic_vector(5 downto 0);
         o_RegDest     : out std_logic;
         o_Dvi         : out std_logic;
         o_DvC         : out std_logic;
         o_LerMem      : out std_logic;
         o_MemParaReg  : out std_logic;
         o_UALOp       : out std_logic_vector(1 downto 0);
         o_EseMem      : out std_logic;
         o_UALFont     : out std_logic;
         o_EscReg      : out std_logic);
  end component;

  component leftShift is
    port(i_ent   : in std_logic_vector(31 downto 0);
         o_saida : out std_logic_vector(31 downto 0));
  end component;

  component concatenador is
    port(i_ent1  : in std_logic_vector(27 downto 0);
         i_ent2  : in std_logic_vector(3 downto 0);
         o_saida : out std_logic_vector(31 downto 0));
  end component;

  component data_mem is
    port(i_clk  : in std_logic;                       -- Clock
         i_save : in std_logic;                       -- Salva na memória
         i_read : in std_logic;                       -- Pega da memória
         i_addr : in std_logic_vector(31 downto 0);   -- Endereço
         i_din  : in std_logic_vector(31 downto 0);   -- Dado de entrada
         o_dout : out std_logic_vector(31 downto 0)); -- Dado de saída
  end component;

  component seletor_5bit is
    port(i_a     : in std_logic_vector(4 downto 0);
         i_b     : in std_logic_vector(4 downto 0);
         i_sel   : in std_logic;
         o_saida : out std_logic_vector(4 downto 0));
  end component;

  component leftShift_26bit is
    port(i_ent   : in std_logic_vector(25 downto 0);
         o_saida : out std_logic_vector(27 downto 0) := (others => '0'));
  end component;
  
  -- Fios PC

  signal w_PC_ent   : std_logic_vector(31 downto 0) := (others => '0'); -- entrada PC
  signal w_CLK 	  : std_logic := '0';		 									-- clock
  signal w_PC_saida : std_logic_vector(31 downto 0):= (others => '0');	-- saída pc
  
  -- Fios Instrução

  signal w_inst : std_logic_vector(31 downto 0);								-- saída instrução
  
  -- Fios Controller

  signal w_RegDest     : std_logic;													-- registrador de destino
  signal w_Dvi         : std_logic;													-- desvio incondicional
  signal w_DvC         : std_logic;													-- desvio condicional
  signal w_LerMem      : std_logic;													-- ler memória
  signal w_MemParaReg  : std_logic;													-- memória para registrador
  signal w_UALOp       : std_logic_vector(1 downto 0);						-- Operação da ULA
  signal w_EseMem      : std_logic;													-- Escreve memória
  signal w_UALFont     : std_logic;													-- Fonte da ULA
  signal w_EscReg      : std_logic;													-- Escreve em registrador
  
  -- fio mux Banco de Registradores

  signal w_RB_addr : std_logic_vector(4 downto 0);								-- Endereço de escrita
  
  -- fios banco de registradores

  signal w_Din    : std_logic_vector(31 downto 0);								-- valor a ser salvo
  signal w_Dout_1 : std_logic_vector(31 downto 0);								-- saída 1
  signal w_Dout_2 : std_logic_vector(31 downto 0);								-- saída 2

  -- fios mux Imediato
  
  signal w_INST_32b : std_logic_vector(31 downto 0);							-- imediato (extendido)
  signal w_B        : std_logic_vector(31 downto 0);							-- saída

  -- fio controle da ULA
  
  signal w_ual_cd : std_logic_vector(2 downto 0);								-- comando da ULA

  -- fios ULA
  
  signal w_z : std_logic := '0';														-- zero flag
  signal w_s : std_logic_vector(31 downto 0);									-- saída
  
  -- fio RAM

  signal w_MEM_Dout : std_logic_vector(31 downto 0);							-- saída RAM

  -- beq
  
  signal w_AND_s : std_logic := w_z and w_DvC;									-- seletor beq

  signal w_INST_ls : std_logic_vector(31 downto 0);							-- endereço relativo beq
  
  -- fio somador PC

  signal w_soma4 : std_logic_vector(31 downto 0) := (2 => '1', others => '0'); -- constante 4

  signal w_PC : std_logic_vector(31 downto 0); 									-- próxima instrução
  
  -- fios jump 

  signal w_INST_e : std_logic_vector(27 downto 0):= (others => '0');		-- imediato * 4

  signal w_CONC_pc : std_logic_vector(31 downto 0); 							-- saída concatenador
  
  -- mux beq

  signal w_INST_PC : std_logic_vector(31 downto 0);							-- endereço absoluto beq

  signal w_beq : std_logic_vector(31 downto 0);									-- saída mux beq
  
  begin
  
   u_0 : reg
      port map(i_ent   => w_PC_ent,
               i_CLK_n => w_CLK,
               o_saida => w_PC_saida);

    u_1 : inst1
      port map(addr => w_PC_saida,
               ins  => w_inst);

    u_2 : controller
      port map(i_ent         => w_inst(31 downto 26),
               o_RegDest     => w_RegDest,
               o_Dvi         => w_Dvi,
               o_DvC         => w_DvC,
               o_LerMem      => w_LerMem,
               o_MemParaReg  => w_MemParaReg,
               o_UALOp       => w_UALOp,
               o_EseMem      => w_EseMem,
               o_UALFont     => w_UALFont,
               o_EscReg      => w_EscReg);

    u_3 : seletor_5bit
      port map(i_a       => w_inst(20 downto 16),
               i_b       => w_inst(15 downto 11),
               i_sel     => w_RegDest,
               o_saida   => w_RB_addr);

    u_4 : reg_bank
      port map(i_clk   => w_CLK,
               i_w_reg => w_EscReg,
               i_end1  => w_inst(25 downto 21),
               i_end2  => w_inst(20 downto 16),
               i_end_w => w_RB_addr,
               i_din   => w_Din,
               o_dout1 => w_Dout_1,
               o_dout2 => w_Dout_2);

    u_5 : extensor
      port map(i_ent   => w_inst(15 downto 0),
               o_saida => w_INST_32b);

    u_6 : mux2_1_32Bits
      port map(i_a   => w_Dout_2,
               i_b   => w_INST_32b,
               i_sel => w_UALFont,
               o_s   => w_B);

    u_7 : ual_ctrl
      port map(i_ual_op => w_UALOp,
               i_funct  => w_inst(5 downto 0),
               o_ual_cd => w_ual_cd);

    u_8 : ual
      port map(i_a  => w_Dout_1,
               i_b  => w_B,
               i_op => w_ual_cd,
               o_z  => w_z,
               o_s  => w_S);

    u_9 : data_mem
      port map(i_clk  => w_CLK1,
               i_save => w_EseMem,
               i_read => w_LerMem,
               i_addr => w_S,
               i_din  => w_Dout_2,
               o_dout => w_MEM_Dout);

    u_10 : mux2_1_32Bits
      port map(i_a   => w_S,
               i_b   => w_MEM_Dout,
               i_sel => w_MemParaReg,
               o_s   => w_Din);

    u_11 : leftShift
      port map(i_ent   => w_INST_32b,
               o_saida => w_INST_ls);

    u_12 : somador
      port map(i_a => w_PC_saida,
               i_b => w_soma4,
               o_c => w_PC);

    u_13 : somador
      port map(i_a => w_PC,
               i_b => w_INST_ls,
               o_c => w_INST_PC);

    u_14 : leftShift_26bit
      port map(i_ent   => w_inst(25 downto 0),
               o_saida => w_INST_e);

    u_15 : concatenador
      port map(i_ent1  => w_INST_e,
               i_ent2  => w_PC(31 downto 28),
               o_saida => w_CONC_pc);

    u_16 : mux2_1_32Bits
      port map(i_a   => w_PC,
               i_b   => w_INST_PC,
               i_sel => w_AND_s,
               o_s   => w_beq);

    u_17 : mux2_1_32Bits
      port map(i_a   => w_beq,
               i_b   => w_CONC_pc,
               i_sel => w_Dvi,
               o_s   => w_PC_ent);

	 w_CLK <= not (w_CLK) after 20ns;
end arch_1;
