library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity STIM_TB is port( 
    clk : out std_logic;
    rst : out std_logic;
    pioport: inout std_logic_vector(3 downto 0 )
    
);
end STIM_TB;

architecture Behavioral of STIM_TB is


signal tclk,trst: std_logic := '0';
constant master_freq : time := 10ns;
constant reset_time : time := 20ns;

begin

tclk <= not tclk after master_freq;
trst <= '1' after 5ns, '0' after reset_time;
clk  <= tclk;
rst <= trst;

pioport <= "HHHH";


end Behavioral;
