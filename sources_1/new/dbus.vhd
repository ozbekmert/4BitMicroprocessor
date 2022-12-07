library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dbus is port 
(
    alu : in std_logic_vector(3 downto 0);
    con : in std_logic_vector(3 downto 0);
    mem : in std_logic_vector(3 downto 0);
    pio : in std_logic_vector(3 downto 0);
    sel : in std_logic_vector(1 downto 0);
    dout: out std_logic_vector(3 downto 0)  
 );
end dbus;

architecture Behavioral of dbus is
signal membus : std_logic_vector(3 downto 0 );
begin

membus <= mem or pio;

busmux : process(sel,con,alu,membus,pio)
begin
case sel is
    when "00" => dout <= membus;
    when "01" => dout <= con;
    when "10"| "11" => dout <= alu;
    when others => dout <= "0000" ;
end case;
end process;
end Behavioral;
