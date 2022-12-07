library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is port 
(
    clk   : in std_logic;
    din   : in std_logic_vector(3 downto 0);
    idacc : in std_logic;
    mode  : in std_logic_vector(1 downto 0);
    rst   : in std_logic;
    dout  : out std_logic_vector(3 downto 0)
 );
end ALU;

architecture Behavioral of ALU is
signal data_s,result,accu : unsigned(3 downto 0);
signal mode_s : std_logic_vector(1 downto 0);
begin

ALU_REG: process(clk,rst)
begin
    if( rst = '1') then
        data_s <= x"0";
        mode_s <= "00";
        accu <= x"0";
     elsif rising_edge(clk) then
        data_s <= unsigned(din);
        mode_s <= mode;
        if(idacc='1') then
            accu <= result;
        end if;
     end if;   
end process;

ALU_CAL: process(accu,data_s,mode_s)
begin
case mode_s is
     when "01" =>  -- adu<addr>
        result <= accu + data_s;
     when "10" =>  -- sbu<addr>
        result <= accu - data_s; 
     --when "10" =>  --str <addr>           
     when others => 
        result <= data_s;
end case;
end process;

dout <= std_logic_vector(accu);

end Behavioral;
