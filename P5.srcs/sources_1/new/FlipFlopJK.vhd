----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/28/2021 02:52:12 PM
-- Design Name: 
-- Module Name: FlipFlopJK - Behavioral
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

entity FlipFlopJK is
    Port ( j : in STD_LOGIC;
           k : in STD_LOGIC;
           clock : in STD_LOGIC;
          reset : in STD_LOGIC;
           q : out STD_LOGIC);
end FlipFlopJK;

architecture Behavioral of FlipFlopJK is

signal q_helper : STD_LOGIC := '0';
begin
    process (clock, j, k, reset)
        begin
            if(reset = '1') then
                q_helper <= '0';
            elsif (clock = '0' and clock'event) then
                if (j = '1' and k = '1') then
                    q_helper <= not q_helper;
                elsif (j = '1' and k = '0') then
                    q_helper <= '1';
                elsif (j = '0' and k = '1') then
                    q_helper <= '0';
                end if;
            end if;
    end process;
    q <= q_helper;
end Behavioral;
