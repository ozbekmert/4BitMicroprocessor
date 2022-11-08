library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TopModule is port(
    clk : in std_logic;
    rst : in std_logic;
    
   
    pio_active_led: out std_logic;
    dmem_active_led: out std_logic;
    
    sevenSegments: out std_logic_vector(6 downto 0);
    selectDisplay: out std_logic_vector(7 downto 0);
    pioport : inout std_logic_vector(3 downto 0)
 );
end TopModule;

architecture Behavioral of TopModule is


signal addr : std_logic_vector(3 downto 0);
signal alubus : std_logic_vector(3 downto 0);
signal cbus : std_logic_vector(10 downto 0);
signal dout : std_logic_vector(3 downto 0);
signal membus : std_logic_vector(3 downto 0);
signal opc : std_logic_vector(4 downto 0);
signal piobus : std_logic_vector(3 downto 0);

signal clk_in: std_logic;
signal data_ram: std_logic_vector(31 downto 0);
component ALU is port 
(
    clk   : in std_logic;
    din   : in std_logic_vector(3 downto 0);
    idacc : in std_logic;
    mode  : in std_logic_vector(1 downto 0);
    rst   : in std_logic;
    dout  : out std_logic_vector(3 downto 0)
 );
 
 end component;
 
component ctrl is port( 
 
     clk : in std_logic;
     opc : in std_logic_vector(4 downto 0);
     rst : in std_logic;
     cbus: out std_logic_vector(10 downto 0)
 );
 end component;
 
component dbus is port 
 (
     alu : in std_logic_vector(3 downto 0);
     con : in std_logic_vector(3 downto 0);
     mem : in std_logic_vector(3 downto 0);
     pio : in std_logic_vector(3 downto 0);
     sel : in std_logic_vector(1 downto 0);
     dout: out std_logic_vector(3 downto 0)  
  );
 end component;
 
 component dmem is port
 (
     clk     : in std_logic;
     addr    : in std_logic_vector(3 downto 0);
     re      : in std_logic;
     we      : in std_logic;
     dout    : out std_logic_vector(3 downto 0);
     din    :  in std_logic_vector(3 downto 0);
     data_ram    : out std_logic_vector(31 downto 0)
 );
 end component;
 
 
 component pio is port( 
 
     addr : in std_logic_vector(3 downto 0);
     clk  : in std_logic;
     din  : in std_logic_vector(3 downto 0);
     rst  : in std_logic;
     re   : in std_logic;
     we   : in std_logic;
     dout : out std_logic_vector(3 downto 0);
     pioport : inout std_logic_vector(3 downto 0)
 );
 end component;
 
component pmem is port 
 (
     clk     : in std_logic;
     rst     : in std_logic;
     ldpc    : in std_logic;
     incpc   : in std_logic;
     ldir    : in std_logic;
     const   : out std_logic_vector(3 downto 0);
     opc     : out std_logic_vector(4 downto 0) 
 );
 end component;


component BCD_7SEG_DEC is port 
(
              clk_2ms : in std_logic;  
              data : in std_logic_vector(31 downto 0);
              reset : in std_logic;
              sevenSegments: out std_logic_vector(6 downto 0);
			  selectDisplay: out std_logic_vector(7 downto 0)
 );
 end component;
 
component Clock_Divider is port 
 (
     clk: in std_logic;
     clk_out_2ms : out std_logic
  );
end component;


component mem_led is port(
    sel  : in std_logic;
    clk : in std_logic;
    mem1 : out std_logic;
    mem2 : out std_logic
);
end component;


begin

uut_memled: mem_led port map(sel =>opc(4),
                             clk => clk,
                             mem1 => pio_active_led,
                             mem2 => dmem_active_led);



uut_clkdiv: Clock_Divider port map(clk => clk,
                                   clk_out_2ms => clk_in);

uut_7seg: BCD_7SEG_DEC port map(clk_2ms => clk_in,
                                data=> data_ram,
                                reset=> rst,
                                sevenSegments => sevenSegments,
                                selectDisplay => selectDisplay);


uut_alu: ALU port map( clk => clk, 
                        din => dout,
                        idacc => cbus(5),
                        mode => cbus(1 downto 0),
                        rst => rst,
                        dout => alubus);



uut_ctrl: ctrl port map( clk => clk,
                        opc => opc,
                        rst => rst,
                        cbus => cbus);



uut_dbus: dbus port map(
                          alu => alubus,
                          con => addr,   
                          mem => membus,
                          pio => piobus,
                          sel => cbus(3 downto 2),
                          dout => dout);

uut_dmem:dmem port map(clk => clk,
                       addr => addr,
                       re => cbus(7),
                       we => cbus(8),
                       dout => membus,
                       din  => dout,
                       data_ram => data_ram);

uut_pio: pio port map(  addr => addr,
                        clk => clk,
                        din => dout,
                        rst => rst,
                        re => cbus(6),
                        we => cbus(8),
                        dout => piobus,
                        pioport => pioport);


uut_pmem: pmem port map( clk => clk,
                         rst => rst,
                         ldpc =>cbus(10),  
                         incpc =>cbus(9),
                         ldir  => cbus(4),
                         const =>addr,
                         opc =>opc);



end Behavioral;
