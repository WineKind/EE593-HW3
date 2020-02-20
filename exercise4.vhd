----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/20/2020 02:22:50 PM
-- Design Name: 
-- Module Name: exercise4 - Behavioral
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

entity exercise4 is
    Port ( LDB : in STD_LOGIC;
           LDA : in STD_LOGIC;
           X : in STD_LOGIC_VECTOR (7 downto 0);
           Y : in STD_LOGIC_VECTOR (7 downto 0);
           S0 : in STD_LOGIC;
           S1 : in STD_LOGIC;
           RD : in STD_LOGIC;
           CLK : in STD_LOGIC;
           RA : out STD_LOGIC_VECTOR (7 downto 0);
           RB : inout STD_LOGIC_VECTOR (7 downto 0));
end exercise4;

architecture rtl_structue of exercise4 is

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
    
    signal s_mux_result_A : std_logic_vector(7 downto 0); 
    signal s_mux_result_B : std_logic_vector(7 downto 0); 
    signal  t_B, t_A  : std_logic; 

begin
    ra4: reg8 
    port map ( REG_IN => s_mux_result_A, 
                   LD => t_A, 
                  CLK => CLK, 
              REG_OUT => RA );
    rb4: reg8 
    port map ( REG_IN => s_mux_result_B, 
                   LD => t_B, 
                  CLK => CLK, 
              REG_OUT => RB );
    m4_1: mux2t1 
    port map ( B => X, 
               A => Y, 
             SEL => S1, 
           M_OUT => s_mux_result_B);
    m4_2: mux2t1 
    port map ( B => RB, 
               A => Y, 
             SEL => S0, 
           M_OUT => s_mux_result_A);
           
    t_A <= LDA AND RD; 
    t_B <= LDB AND NOT RD; 

end rtl_structue;
