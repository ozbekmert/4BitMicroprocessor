library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Clock_Divider is port 
(
    clk: in std_logic;
    clk_out_2ms : out std_logic
 );
end Clock_Divider;

architecture Behavioral of Clock_Divider is
signal clk_div_pos: unsigned (19 downto 0) := x"00000";
begin
process(clk)
begin
    if rising_edge(clk) then
        
        if(clk_div_pos <= x"186A0") then  -- gives exactly 2ms clock cycle
            clk_out_2ms <= '1';
            clk_div_pos <= clk_div_pos +1;
        elsif(clk_div_pos >= x"186A1" and  clk_div_pos <= x"30D40" ) then
            clk_out_2ms <= '0';
            clk_div_pos <= clk_div_pos +1;
        else
            clk_div_pos <=  x"00000";
        end if;
    end if;
end process;





end Behavioral;
