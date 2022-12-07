library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
LIBRARY work;
use work.program_def.all;

--Task - Program Memory
--The program memory mainly consists of the program counter (PC), the program ROM prom and the instruction register IR. ++
--It is clocked with the rising edge of the clock port. ++

--The program counter selects the current program line in the program ROM. ++
--          It is increased by one if incpc equals '1' during a clock cycle  ++ 
--                                        or
--          it is loaded with the current address within the ir if ldpc equals '1' during a clock cycle. ++
--With rst the pc is set to Zero  ++
-- If ldir occurs during a clock cycle, the program memory loads the current line from the program ROM, current pc value equals current program line, and saves it in the instruction register.++

entity pmem is port 
(
    clk     : in std_logic;
    rst     : in std_logic;
    ldpc    : in std_logic;
    incpc   : in std_logic;
    ldir    : in std_logic;
    const   : out std_logic_vector(3 downto 0);
    opc     : out std_logic_vector(4 downto 0) 
);
end pmem;

architecture Behavioral of pmem is
signal ir : std_logic_vector(7 downto 0); -- Instruction Register
signal pc : unsigned(3 downto 0);  -- Program Counter
begin

pcreg:process(clk,rst)
begin
    if rst = '1' then  --With rst the pc is set to Zero.
       pc <= "0000";
    elsif rising_edge(clk) then
        if ldpc = '1'  then       --          It is increased by one if incpc equals '1' during a clock cycle 
            pc <= unsigned(ir(3 downto 0)); 
         elsif incpc = '1' then   --          it is loaded with the current address within the ir if ldpc equals '1' during a clock cycle. 
            pc <= pc+1;
        end if;
    end if; 
end process;

irom:process(clk)
begin
    if rising_edge(clk) then
        if ldir = '1' then -- If ldir occurs during a clock cycle, the program memory loads the current line from the program ROM, current pc value equals current program line, and saves it in the instruction register.++
            ir <= rom(to_integer(pc));
        end if;
    end if;
end process;
 
const <= ir(3 downto 0);
opc <= ir(3) & ir(7 downto 4);


end Behavioral;
