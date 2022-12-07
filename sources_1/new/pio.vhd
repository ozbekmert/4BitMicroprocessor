library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--To access external periphery often a parallel-io port is used. In our example, we implement a 4bit parallel-io.
--It consists of three 4bit registers: piomode, pioread and piowrite. ++

--The first two registers are writeonly and the last one is read-only. ++


--piomode chooses for every bit, if a port-pin (pioport) is read-only (input)  PIOMODE(N) = '0' ++
--                               if you can use it as an output (read and write)  PIOMODE(N) = '1'.++ 

--In piowrite one can save the data, which should be written to the port-pins. pioread is updated every clock cycle with the current status of pioport. ++

--Thus, one can read back the values from piowrite, if piomode for a pin is set to '0'. ++
--The following code example shows you program line to implement that behavioral:++
--EXAMPLE
--pioport(n) <= piowrite(n) WHEN piomode(n) = '0' ELSE 'Z';++

--Provide a functionality, that dout is Zero except if re_pio bit in cbus is set to '1'; 

entity pio is port( 

    addr : in std_logic_vector(3 downto 0);
    clk  : in std_logic;
    din  : in std_logic_vector(3 downto 0);
    rst  : in std_logic;
    re   : in std_logic;
    we   : in std_logic;
    dout : out std_logic_vector(3 downto 0);
    pioport : inout std_logic_vector(3 downto 0)
);
end pio;

architecture Behavioral of pio is

signal piomode,pioread,piowrite: std_logic_vector(3 downto 0); --It consists of three 4bit registers: piomode, pioread and piowrite. 
begin

pioreg: process(clk,rst)
begin
    if(rst = '1') then
        piomode <= "1111";
        pioread <= "0000";
        piowrite <= "0000";
     
     elsif(rising_edge(clk) ) then

          pioread <= pioport; -- pioread is updated every clock cycle with the current status of pioport. 
		    
        if(addr(3 downto 2) =  "11" and we = '1') then
            piomode <= din;
        elsif(addr(3 downto 1) =  "101" and we = '1') then
            piowrite <= din;
        end if;

      end if;   
end process;

pioport(3) <= piowrite(3) when piomode(3) = '0' else 'Z';
pioport(2) <= piowrite(2) when piomode(2) = '0' else 'Z';
pioport(1) <= piowrite(1) when piomode(1) = '0' else 'Z';
pioport(0) <= piowrite(0) when piomode(0) = '0' else 'Z';
dout <= pioread when re= '1' else "0000";
    
    
end Behavioral;
