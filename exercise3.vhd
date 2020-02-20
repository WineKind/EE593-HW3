----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/20/2020 02:14:22 AM
-- Design Name: 
-- Module Name: exercise3 - rtl_structure
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
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
entity exercise3 is
    Port ( LDB : in STD_LOGIC;
           LDA : in STD_LOGIC;
           X : in STD_LOGIC_VECTOR (7 downto 0);
           S0 : in STD_LOGIC;
           S1 : in STD_LOGIC;
           CLK : in STD_LOGIC;
           Y : in STD_LOGIC_VECTOR (7 downto 0);
           RB : inout STD_LOGIC_VECTOR (7 downto 0));
end exercise3;

architecture rtl_structure of exercise3 is
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
    -- intermditae singal declaration
    signal s_mux_result_A : std_logic_vector(7 downto 0); 
    signal s_mux_result_B : std_logic_vector(7 downto 0); 
    signal s_mux_reg : std_logic_vector(7 downto 0); 

begin
    ra3: reg8 
    port map ( REG_IN => s_mux_result_A, 
                   LD => lda, 
                  CLK => CLK, 
              REG_OUT => s_mux_reg );
    rb3: reg8 
    port map ( REG_IN => s_mux_result_B, 
                   LD => ldb, 
                  CLK => CLK, 
              REG_OUT => RB );
    m3_1: mux2t1 
    port map ( B => X, 
               A => RB, 
             SEL => S1, 
           M_OUT => s_mux_result_A);
    m3_2: mux2t1 
    port map ( B => s_mux_reg, 
               A => Y, 
             SEL => S0, 
           M_OUT => s_mux_result_B);
end rtl_structure;
