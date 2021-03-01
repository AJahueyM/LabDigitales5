----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/28/2021 03:14:36 PM
-- Design Name: 
-- Module Name: Counter_MOD6 - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Counter_MOD10 is
    Port ( clock : in STD_LOGIC;
           count : out STD_LOGIC_VECTOR (3 downto 0));
end Counter_MOD10;

architecture Behavioral of Counter_MOD10 is
    component FlipFlopJK is
        Port ( j : in STD_LOGIC;
               k : in STD_LOGIC;
               clock : in STD_LOGIC;
               reset : in STD_LOGIC;
               q : out STD_LOGIC);
    end component;
    signal internal_q : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal helpers_q : STD_LOGIC_VECTOR(1 downto 0) := "00";
    signal reset : STD_LOGIC := '0';
begin

    jk1 : FlipFlopJK port map('1', '1', clock, reset, internal_q(3));
    jk2 : FlipFlopJK port map(internal_q(3), internal_q(3), clock, reset, internal_q(2));
    jk3 : FlipFlopJK port map(helpers_q(1), helpers_q(1), clock, reset, internal_q(1));
    jk4 : FlipFlopJK port map(helpers_q(0), helpers_q(0), clock, reset, internal_q(0));

    helpers_q(1) <= internal_q(3) AND internal_q(2);
    helpers_q(0) <= helpers_q(1) AND internal_q(1);

    count <= internal_q;
    reset <= '1' when internal_q = "0101" else '0';
      
end Behavioral;
