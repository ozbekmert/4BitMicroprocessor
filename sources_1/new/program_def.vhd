library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


package program_def is
  
  --define program rom type
  type ROM_T is array (0 to 15) of STD_LOGIC_VECTOR(7 downto 0);
  
  --define opcodes
  constant adu : STD_LOGIC_VECTOR(3 downto 0) := x"1";
  constant sdu : STD_LOGIC_VECTOR(3 downto 0) := x"2";
  constant lda : STD_LOGIC_VECTOR(3 downto 0) := x"3";
  constant mov : STD_LOGIC_VECTOR(3 downto 0) := x"7";
  constant str : STD_LOGIC_VECTOR(3 downto 0) := x"8";
  constant jmp : STD_LOGIC_VECTOR(3 downto 0) := x"C";
  constant nop : STD_LOGIC_VECTOR(3 downto 0) := x"F";
  
--  Example One:
--  constant rom : ROM_T := (
--    mov & x"0", -- accu <- 0;
--    str & x"c", -- mem[c] <- accu;
--    mov & x"1", -- accu <- 1;
--    str & x"0", -- mem[0] <- accu;
--    mov & x"0", -- accu <- 0;
--    sdu & x"0", -- accu <- accu - mem[0];
--    str & x"a", -- mem[a] <- accu;
--    str & x"7", -- mem[7] <- accu;
--    adu & x"7", -- accu <- accu + mem[7];
--    str & x"a", -- mem[a] <- accu;
--    adu & x"0", -- accu <- accu +  mem[0];
--    str & x"a", -- mem[a] <- accu;
--    adu & x"a", -- accu <- accu + mem[0];
--    str & x"a", -- mem[a] <- accu;
--    nop & x"f", -- nop;
--    jmp & x"0" -- pc <- 0;  
--  );


--mem0 - 5
--mem1 - 8
--mem2 - 2 (18 mod 16)
--mem3 - D (-3 mod 16)



-- Example Two:
  constant rom : ROM_T := (
    mov & x"5", -- accu <- 5;
    str & x"0", -- mem[0] <- accu;
    mov & x"3", -- accu <- 3;
    adu & x"0", -- accu <- accu + mem[0];
    str & x"1", -- mem[1] <- accu;
    mov & x"A", -- accu <- 10;
    adu & x"1", -- accu <- accu + mem[1];  
    str & x"2", -- mem[2] <- accu; 
    sdu & x"0", -- accu <- accu - mem[0];  
    str & x"3", -- mem[3] <- accu;
    jmp & x"0", -- pc <- 0;  
    nop & x"F", -- nop 
    nop & x"F", -- nop
    nop & x"F", -- nop
    nop & x"F", -- nop
    nop & x"F" -- nop    
  );
  
end package program_def;
