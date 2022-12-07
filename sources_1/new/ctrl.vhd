library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ctrl is port( 

    clk : in std_logic;
    opc : in std_logic_vector(4 downto 0);
    rst : in std_logic;
    cbus: out std_logic_vector(10 downto 0)
);
end ctrl;

architecture Behavioral of ctrl is

type state is (FETCH,DECODE,EXECUTE);
signal current_state,next_state : state;

signal incpc,ldpc,ldir,ldacc,we,re_mem,re_pio: std_logic;


signal alumod,selbus: std_logic_vector(1 downto 0);
begin

fsm_reg: process(rst,clk)
begin
    if(rst ='1') then
    current_state <= FETCH;
    elsif rising_edge(clk) then
    current_state <= next_state;
    end if;
end process;

Transition: process(current_state)
begin
    case current_state is
    
        when FETCH =>
            next_state <= DECODE;
        when DECODE =>
            next_state <= EXECUTE;
        when EXECUTE =>
             next_state <= FETCH;
    end case;   
end process;


IO: process(current_state,opc)
begin
    alumod <= "00"; 
    ldir <= '0'; 
    ldacc <= '0'; 
    we <='0'; 
    incpc <= '0';
    ldpc <= '0'; 
    re_mem <='0';
    re_pio <= '0';
    case current_state is

-- ASK!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
--.If the third bit of the opcode (opc) equals '0', then re_mem is set to '1' if opc(4) equals '0', Otherwise, it is set to '0'. 
-- If the third bit of the opcode       equals '0', then re_pio is set to '0' if opc(4) equals '1'. Otherwise it is set to '0'.      

       
        when FETCH =>
            ldir <= '1'; 
        when DECODE =>
            if opc(4) = '0' then  
                re_pio <= opc(4);
                re_mem <= not opc(4);   
                alumod <= opc(1 downto 0);
            else
                re_pio <= opc(4);
                re_mem <= not opc(4);   
            end if;
        when EXECUTE =>
              
             if opc(3) = '0' then   -- adu sbu lda mov
                    ldacc <= '1'; 
             end if;
             
              if opc(3 downto 2) = "10" then --str
                    we <= '1';
               end if;
               
               if opc(3 downto 0) = "1100" then -- jump  
                    ldpc <= '1';
               else
                    incpc <= '1'; 
               end if;         
    end case; 
    
end process;
    
selbus <= opc(3 downto 2);
cbus <= ldpc &incpc & we & re_mem & re_pio & ldacc & ldir & selbus & alumod;  
--      10    9        8      7     6         5     4          3-2     1-0     
end Behavioral;
