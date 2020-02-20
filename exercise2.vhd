----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/20/2020 12:00:51 AM
-- Design Name: 
-- Module Name: exercise2 - Behavioral
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
entity mux4t1 is --- ENTITY 
    port ( A,B,C,D : in std_logic_vector(7 downto 0); 
           SEL : in std_logic_vector(1 downto 0); 
           M_OUT : out std_logic_vector(7 downto 0)); 
end mux4t1; 

architecture my_mux of mux4t1 is --- ARCHITECTURE 
begin
    process (SEL,A,B,C,D)
    begin
       case SEL is
          when "00" => M_OUT <= A;
          when "01" => M_OUT <= B;
          when "10" => M_OUT <= C;
          when "11" => M_OUT <= D;
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
entity exercise2 is
    Port ( DS : in std_logic;
           X : in STD_LOGIC_VECTOR (7 downto 0);
           Y : in STD_LOGIC_VECTOR (7 downto 0);
           Z : in STD_LOGIC_VECTOR (7 downto 0);
           MS : in STD_LOGIC_VECTOR (1 downto 0);
           CLK : in STD_LOGIC;
           RB : inout STD_LOGIC_VECTOR (7 downto 0);
           RA : inout STD_LOGIC_VECTOR (7 downto 0));
end exercise2;

architecture rtl_structural of exercise2 is

    -- component declaration 
    component mux4t1 
        Port ( A,B,C,D : in std_logic_vector(7 downto 0); 
               SEL : in std_logic_vector(1 downto 0); 
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
    ra2: reg8 
    port map ( REG_IN => s_mux_result, 
                   LD => lda, 
                  CLK => CLK, 
              REG_OUT => RA );
    rb2: reg8 
    port map ( REG_IN => RA, 
                   LD => ldb, 
                  CLK => CLK, 
              REG_OUT => RB );
    m1: mux4t1 
    port map ( D => X, 
               C => Y, 
               B => Z, 
               A => RB, 
             SEL => MS, 
           M_OUT => s_mux_result);
           
    d1: Dec1t2
    port map ( A => DS,
          D_OUT1 => lda,
          D_OUT2 => ldb);



end rtl_structural;
