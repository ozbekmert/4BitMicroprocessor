library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mem_led is port (
sel  : in std_logic;
clk  : in std_logic;
mem1 : out std_logic;
mem2 : out std_logic
);
end mem_led;

architecture Behavioral of mem_led is

begin    
        mem1 <=  sel;
        mem2 <=  not sel;
end Behavioral;
