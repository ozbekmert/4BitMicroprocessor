library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity dmem is port
(
    clk     : in std_logic;
    addr    : in std_logic_vector(3 downto 0);
    re      : in std_logic;
    we      : in std_logic;
    dout    : out std_logic_vector(3 downto 0);
    din    :  in std_logic_vector(3 downto 0)
);
end dmem;

architecture Behavioral of dmem is

TYPE ram_t IS ARRAY (7 downto 0) of STD_LOGIC_VECTOR(3 downto 0);
signal ram : ram_t;
begin

dmemx:process(clk)
begin
    if rising_edge(clk) then 
        if(addr(3)='0' and we = '1') then
            ram(to_integer(unsigned(addr(2 downto 0)))) <= din;
        end if;
    end if;
end process;

dout <= ram(to_integer(unsigned(addr(2 downto 0))))  when addr(3) = '0' else "0000";

end Behavioral;
