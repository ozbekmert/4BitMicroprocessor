library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity BCD_7SEG_DEC is port 
(
              clk_2ms : in std_logic;  
              data : in std_logic_vector(31 downto 0);
              reset : in std_logic;
              sevenSegments: out std_logic_vector(6 downto 0);
			  selectDisplay: out std_logic_vector(7 downto 0)

 );
end BCD_7SEG_DEC;
architecture Behavioral of BCD_7SEG_DEC is
type STATES is (D0,D1,D2,D3,D4,D5,D6,D7);
signal current_s, next_s : STATES;  
begin
-- 7 SEGMENTS REGISTER PROCESS --------------------------------------
SEGMENT_REGISTER_PROCESS:process (clk_2ms)  
begin
 if rising_edge(clk_2ms) then
     if (reset='1') then -- Synchronous Reset 
      current_s <= D0;  --default state on reset see above state info.              
     else
      current_s <= next_s;   --state change.
    end if;
 end if;   
end process;

-- DISPLAY TRANSITION PROCESS ------------------------------------
STATE_TRANSITION_PROCESS: process(current_s)
begin 
     next_s <=  current_s ;
 case current_s is
     when D0 => 
        next_s <=D1; 
     when D1 => 
        next_s <=D2; 
     when D2 => 
        next_s <=D3; 
     when D3 =>
        next_s <=D4; 
     when D4 =>
        next_s <=D5;  
     when D5 => 
        next_s <=D6; 
     when D6 => 
        next_s <=D7; 
     when D7 => 
        next_s <=D0; 
     when others =>
        next_s <=D0;                                                  
end case;
end process;


-- OUTPUT SIGNAL PROCESS ---------------------------------------
OUTPUT_SIGNAL_PROCESS: process(current_s)
begin
case current_s is
when D0 =>
selectDisplay <= "11111110";
case data(3 downto 0) is
        when  "0000" => sevenSegments  <= "0000001";
        when  "0001" => sevenSegments  <= "1001111";
        when  "0010" => sevenSegments  <= "0010010";
        when  "0011" => sevenSegments  <= "0000110";
        when  "0100" => sevenSegments  <= "1001100";
        when  "0101" => sevenSegments  <= "0100100";
        when  "0110" => sevenSegments  <= "0100000";
        when  "0111" => sevenSegments  <= "0001111";
        when  "1000" => sevenSegments  <= "0000000";
        when  "1001" => sevenSegments  <= "0000100";
        when  "1010" => sevenSegments  <= "0000010";
        when  "1011" => sevenSegments  <= "1100000";
        when  "1100" => sevenSegments  <= "0110001";
        when  "1101" => sevenSegments  <= "1000010";
        when  "1110" => sevenSegments  <= "0110000";
        when  "1111" => sevenSegments  <= "0111000";
        when others => sevenSegments  <=  "1111111";      
      end case;     
when D1 =>
selectDisplay <= "11111101";
case data(7 downto 4) is
        when  "0000" => sevenSegments  <= "0000001";
        when  "0001" => sevenSegments  <= "1001111";
        when  "0010" => sevenSegments  <= "0010010";
        when  "0011" => sevenSegments  <= "0000110";
        when  "0100" => sevenSegments  <= "1001100";
        when  "0101" => sevenSegments  <= "0100100";
        when  "0110" => sevenSegments  <= "0100000";
        when  "0111" => sevenSegments  <= "0001111";
        when  "1000" => sevenSegments  <= "0000000";
        when  "1001" => sevenSegments  <= "0000100";
        when  "1010" => sevenSegments  <= "0000010";
        when  "1011" => sevenSegments  <= "1100000";
        when  "1100" => sevenSegments  <= "0110001";
        when  "1101" => sevenSegments  <= "1000010";
        when  "1110" => sevenSegments  <= "0110000";
        when  "1111" => sevenSegments  <= "0111000";          
        when others => sevenSegments  <=  "1111111";      
      end case;     
when D2 =>
selectDisplay <= "11111011";
case data(11 downto 8) is
        when  "0000" => sevenSegments  <= "0000001";
        when  "0001" => sevenSegments  <= "1001111";
        when  "0010" => sevenSegments  <= "0010010";
        when  "0011" => sevenSegments  <= "0000110";
        when  "0100" => sevenSegments  <= "1001100";
        when  "0101" => sevenSegments  <= "0100100";
        when  "0110" => sevenSegments  <= "0100000";
        when  "0111" => sevenSegments  <= "0001111";
        when  "1000" => sevenSegments  <= "0000000";
        when  "1001" => sevenSegments  <= "0000100";
        when  "1010" => sevenSegments  <= "0000010";
        when  "1011" => sevenSegments  <= "1100000";
        when  "1100" => sevenSegments  <= "0110001";
        when  "1101" => sevenSegments  <= "1000010";
        when  "1110" => sevenSegments  <= "0110000";
        when  "1111" => sevenSegments  <= "0111000";                  
        when others => sevenSegments  <=  "1111111";  
      end case;     
when D3 =>
selectDisplay <= "11110111";
case data(15 downto 12) is
        when  "0000" => sevenSegments  <= "0000001";
        when  "0001" => sevenSegments  <= "1001111";
        when  "0010" => sevenSegments  <= "0010010";
        when  "0011" => sevenSegments  <= "0000110";
        when  "0100" => sevenSegments  <= "1001100";
        when  "0101" => sevenSegments  <= "0100100";
        when  "0110" => sevenSegments  <= "0100000";
        when  "0111" => sevenSegments  <= "0001111";
        when  "1000" => sevenSegments  <= "0000000";
        when  "1001" => sevenSegments  <= "0000100";
        when  "1010" => sevenSegments  <= "0000010";
        when  "1011" => sevenSegments  <= "1100000";
        when  "1100" => sevenSegments  <= "0110001";
        when  "1101" => sevenSegments  <= "1000010";
        when  "1110" => sevenSegments  <= "0110000";
        when  "1111" => sevenSegments  <= "0111000";                  
        when others => sevenSegments  <=  "1111111";    
      end case;     
when D4 =>
selectDisplay <= "11101111";
case data(19 downto 16) is
        when  "0000" => sevenSegments  <= "0000001";
        when  "0001" => sevenSegments  <= "1001111";
        when  "0010" => sevenSegments  <= "0010010";
        when  "0011" => sevenSegments  <= "0000110";
        when  "0100" => sevenSegments  <= "1001100";
        when  "0101" => sevenSegments  <= "0100100";
        when  "0110" => sevenSegments  <= "0100000";
        when  "0111" => sevenSegments  <= "0001111";
        when  "1000" => sevenSegments  <= "0000000";
        when  "1001" => sevenSegments  <= "0000100";
        when  "1010" => sevenSegments  <= "0000010";
        when  "1011" => sevenSegments  <= "1100000";
        when  "1100" => sevenSegments  <= "0110001";
        when  "1101" => sevenSegments  <= "1000010";
        when  "1110" => sevenSegments  <= "0110000";
        when  "1111" => sevenSegments  <= "0111000";                  
        when others => sevenSegments  <=  "1111111"; 
      end case;     
when D5 =>
selectDisplay <= "11011111";
case data(23 downto 20) is
        when  "0000" => sevenSegments  <= "0000001";
        when  "0001" => sevenSegments  <= "1001111";
        when  "0010" => sevenSegments  <= "0010010";
        when  "0011" => sevenSegments  <= "0000110";
        when  "0100" => sevenSegments  <= "1001100";
        when  "0101" => sevenSegments  <= "0100100";
        when  "0110" => sevenSegments  <= "0100000";
        when  "0111" => sevenSegments  <= "0001111";
        when  "1000" => sevenSegments  <= "0000000";
        when  "1001" => sevenSegments  <= "0000100";
        when  "1010" => sevenSegments  <= "0000010";
        when  "1011" => sevenSegments  <= "1100000";
        when  "1100" => sevenSegments  <= "0110001";
        when  "1101" => sevenSegments  <= "1000010";
        when  "1110" => sevenSegments  <= "0110000";
        when  "1111" => sevenSegments  <= "0111000";                  
        when others => sevenSegments  <=  "1111111";      
      end case;     
when D6 =>
selectDisplay <= "10111111";
case data(27 downto 24) is
        when  "0000" => sevenSegments  <= "0000001";
        when  "0001" => sevenSegments  <= "1001111";
        when  "0010" => sevenSegments  <= "0010010";
        when  "0011" => sevenSegments  <= "0000110";
        when  "0100" => sevenSegments  <= "1001100";
        when  "0101" => sevenSegments  <= "0100100";
        when  "0110" => sevenSegments  <= "0100000";
        when  "0111" => sevenSegments  <= "0001111";
        when  "1000" => sevenSegments  <= "0000000";
        when  "1001" => sevenSegments  <= "0000100";
        when  "1010" => sevenSegments  <= "0000010";
        when  "1011" => sevenSegments  <= "1100000";
        when  "1100" => sevenSegments  <= "0110001";
        when  "1101" => sevenSegments  <= "1000010";
        when  "1110" => sevenSegments  <= "0110000";
        when  "1111" => sevenSegments  <= "0111000";                  
        when others => sevenSegments  <=  "1111111";     
              end case;     
when D7 =>
selectDisplay <= "01111111";
case data(31 downto 28) is
        when  "0000" => sevenSegments  <= "0000001";
        when  "0001" => sevenSegments  <= "1001111";
        when  "0010" => sevenSegments  <= "0010010";
        when  "0011" => sevenSegments  <= "0000110";
        when  "0100" => sevenSegments  <= "1001100";
        when  "0101" => sevenSegments  <= "0100100";
        when  "0110" => sevenSegments  <= "0100000";
        when  "0111" => sevenSegments  <= "0001111";
        when  "1000" => sevenSegments  <= "0000000";
        when  "1001" => sevenSegments  <= "0000100";
        when  "1010" => sevenSegments  <= "0000010";
        when  "1011" => sevenSegments  <= "1100000";
        when  "1100" => sevenSegments  <= "0110001";
        when  "1101" => sevenSegments  <= "1000010";
        when  "1110" => sevenSegments  <= "0110000";
        when  "1111" => sevenSegments  <= "0111000";                  
        when others => sevenSegments  <=  "1111111";    
      end case;     
end case;
end process;

end Behavioral;
