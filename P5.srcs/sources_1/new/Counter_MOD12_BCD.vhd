----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/01/2021 03:24:46 PM
-- Design Name: 
-- Module Name: Counter_MOD12_BCD - Behavioral
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

entity Counter_MOD12_BCD is
    Port ( clock : in STD_LOGIC;
       c_dc : out STD_LOGIC_VECTOR (3 downto 0);
       c_un : out STD_LOGIC_VECTOR (3 downto 0)
       );
end Counter_MOD12_BCD;

architecture Behavioral of Counter_MOD12_BCD is
    component FlipFlopJK is
    Port ( j : in STD_LOGIC;
           k : in STD_LOGIC;
           clock : in STD_LOGIC;
           reset : in STD_LOGIC;
           q : out STD_LOGIC);
end component;

 component Counter_MOD10 is
      Port ( clock : in STD_LOGIC;
             count : out STD_LOGIC_VECTOR (3 downto 0);
             reset_M10 : in STD_LOGIC
             );
  end component;
  signal clock_temp : std_logic := '0';
  signal un_temp : std_logic_vector(3 downto 0) := "0000";
  signal dc_result : std_logic_vector(3 downto 0) := "0000";
  signal reset : std_logic := '0';
begin

    clock_temp <= '1' when un_temp = "1001" else '0';
    
    hrs_dc : FlipFlopJK port map('1','1',clock_temp, reset, dc_result(3)) ;
    c_dc <= dc_result;
    hrs_un : Counter_MOD10 port map(clock, un_temp, reset);
    c_un <= un_temp;
    
    reset  <= '1' when (un_temp = "0100" AND dc_result = "1000") else '0';
end Behavioral;
