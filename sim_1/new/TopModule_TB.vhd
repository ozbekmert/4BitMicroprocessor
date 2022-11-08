----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.12.2018 22:47:52
-- Design Name: 
-- Module Name: TopModule_TB - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TopModule_TB is
--  Port ( );
end TopModule_TB;

architecture Behavioral of TopModule_TB is
signal clk: std_logic;
signal rst: std_logic;
signal pioport: std_logic_vector(3 downto 0);
signal pio_active_led: std_logic;
signal dmem_active_led:  std_logic;
   
signal   sevenSegments:  std_logic_vector(6 downto 0);
signal   selectDisplay:  std_logic_vector(7 downto 0);

component TopModule is port(
    clk : in std_logic;
    rst : in std_logic;
    
    pio_active_led: out std_logic;
    dmem_active_led: out std_logic;
    
    sevenSegments: out std_logic_vector(6 downto 0);
    selectDisplay: out std_logic_vector(7 downto 0);
    pioport : inout std_logic_vector(3 downto 0)
 );
end component;

component STIM_TB is port( 
    clk : out std_logic;
    rst : out std_logic;
    pioport: inout std_logic_vector(3 downto 0 )
    
);
end component;

begin
uut1: TopModule port map(clk => clk, rst => rst, pio_active_led => pio_active_led,dmem_active_led => dmem_active_led , sevenSegments => sevenSegments,selectDisplay =>selectDisplay , pioport => pioport); 
uut2: STIM_TB port map(clk => clk, rst => rst, pioport => pioport); 


end Behavioral;

   
	
