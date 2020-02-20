----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/19/2020 11:48:17 PM
-- Design Name: 
-- Module Name: exercises1 - Behavioral
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

entity exercises1 is
    Port ( LDA : in STD_LOGIC;
           A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           SEL : in STD_LOGIC;
           CLK : in STD_LOGIC;
           F : out STD_LOGIC_VECTOR (7 downto 0));
end exercises1;

architecture Behavioral of exercises1 is
    
    signal s_mux_result : std_logic_vector(7 downto 0); 

begin

    ra: process(CLK) -- process 
    begin 
        if (rising_edge(CLK)) then 
            if (LDA = '1') then 
                F <= s_mux_result; 
            end if; 
        end if; 
    end process;
    
    with SEL select
    s_mux_result <= A when '1', 
                    B when '0', 
                    (others => '0') when others;


end Behavioral;
