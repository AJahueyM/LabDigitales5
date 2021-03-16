----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/01/2021 12:13:07 AM
-- Design Name: 
-- Module Name: Counter_MOD60_BCD - Behavioral
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


entity Counter_MOD60_BCD is
    Port ( clock : in STD_LOGIC;
        c_un : out STD_LOGIC_VECTOR (3 downto 0);
        c_dc : out STD_LOGIC_VECTOR (3 downto 0));
end Counter_MOD60_BCD;

architecture Behavioral of Counter_MOD60_BCD is
 component Counter_MOD10 is
      Port ( clock : in STD_LOGIC;
             count : out STD_LOGIC_VECTOR (3 downto 0);
             reset_M10 : in STD_LOGIC
             );
   end component;
 component Counter_MOD6 is
        Port ( clock : in STD_LOGIC;
               count : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    signal clk_dc : std_logic := '0';
    signal temp_un : STD_LOGIC_VECTOR (3 downto 0) := "0000";
begin

    clk_dc <= '1' when temp_un = "1001" else '0';

    un : Counter_MOD10 port map(clock, temp_un, '0');
    dc : Counter_MOD6 port map( clk_dc, c_dc);
    c_un <= temp_un;

end Behavioral;
