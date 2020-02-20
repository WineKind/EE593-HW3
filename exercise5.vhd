----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/20/2020 02:33:28 AM
-- Design Name: 
-- Module Name: exercise5 - rtl_structure
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
entity reg8 is --- ENTITY 
    Port ( REG_IN : in std_logic_vector(7 downto 0); 
           LD,CLK : in std_logic; 
           REG_OUT : out std_logic_vector(7 downto 0)); 
end reg8; 
architecture reg8 of reg8 is
begin 
    reg: process(CLK) 
    begin 
        if (rising_edge(CLK)) then 
            if (LD = '1') then 
                REG_OUT <= REG_IN; 
            end if; 
        end if; 
     end process; 
end reg8;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity mux2t1 is --- ENTITY 
    port ( A,B : in std_logic_vector(7 downto 0); 
           SEL : in std_logic; 
           M_OUT : out std_logic_vector(7 downto 0)); 
end mux2t1; 

architecture my_mux of mux2t1 is --- ARCHITECTURE 
begin
    process (SEL,A,B)
    begin
       case SEL is
          when '0' => M_OUT <= A;
          when '1' => M_OUT <= B;

       end case;
    end process;
end my_mux;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Dec1t2 is --- ENTITY 
    port ( A : in std_logic;  
           D_OUT1 : out std_logic;
           D_OUT2 : out std_logic); 
end Dec1t2; 

architecture my_dec of Dec1t2 is --- ARCHITECTURE 
begin
    process (A)
    begin
       if (A = '0') then
            D_OUT1 <= '1';
            D_OUT2 <= '0';
       else
            D_OUT1 <= '0';
            D_OUT2 <= '1';     
       end if;
    end process;
end my_dec;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity exercise5 is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           C : in STD_LOGIC_VECTOR (7 downto 0);
           SL1 : in STD_LOGIC;
           SL2 : in STD_LOGIC;
           CLK : in STD_LOGIC;
           RAX : out STD_LOGIC_VECTOR (7 downto 0);
           RBX : out STD_LOGIC_VECTOR (7 downto 0));
end exercise5;

architecture rtl_structure of exercise5 is
    -- component declaration 
    component mux2t1 
        Port ( A,B : in std_logic_vector(7 downto 0); 
               SEL : in std_logic; 
             M_OUT : out std_logic_vector(7 downto 0));  
    end component;
    component reg8 
        Port ( REG_IN : in std_logic_vector(7 downto 0); 
               LD,CLK : in std_logic; 
               REG_OUT : out std_logic_vector(7 downto 0)); 
    end component;
    component Dec1t2 
        Port ( A : in std_logic;  
               D_OUT1 : out std_logic;
               D_OUT2 : out std_logic); 
    end component; 
    -- intermditae singal declaration
    signal s_mux_result : std_logic_vector(7 downto 0); 
    signal lda : std_logic;
    signal ldb : std_logic;

begin
    ra5: reg8 
    port map ( REG_IN => A, 
                   LD => lda, 
                  CLK => CLK, 
              REG_OUT => RAX);
    rb5: reg8 
    port map ( REG_IN => s_mux_result, 
                   LD => ldb, 
                  CLK => CLK, 
              REG_OUT => RBX );
    m5: mux2t1 
    port map ( B => B, 
               A => C, 
             SEL => SL2, 
           M_OUT => s_mux_result);
    d5: Dec1t2
    port map ( A => SL1,
          D_OUT1 => ldb,
          D_OUT2 => lda);

end rtl_structure;
