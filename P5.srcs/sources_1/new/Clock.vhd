----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/04/2021 03:26:33 PM
-- Design Name: 
-- Module Name: Clock - Behavioral
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


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;	-- add to do arithmetic operations
use IEEE.std_logic_arith.all;		-- add to do arithmetic operations
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Clock is
  Port ( clock : in std_logic;
         am_pm : out std_logic;
         led : out std_logic;
         seg : out std_logic_vector(7 downto 0);
         an : out std_logic_vector(7 downto 0)
    );
end Clock;

architecture Behavioral of Clock is

component Counter_MOD60_BCD is
   Port ( clock : in STD_LOGIC;
     c_un : out STD_LOGIC_VECTOR (3 downto 0);
     c_dc : out STD_LOGIC_VECTOR (3 downto 0));
  end component;
  component Counter_MOD12_BCD is
      Port ( clock : in STD_LOGIC;
     c_dc : out STD_LOGIC_VECTOR (3 downto 0);
     c_un : out STD_LOGIC_VECTOR (3 downto 0)
     );
  end component;
      component FlipFlopJK is
      Port ( j : in STD_LOGIC;
             k : in STD_LOGIC;
             clock : in STD_LOGIC;
             reset : in STD_LOGIC;
             q : out STD_LOGIC);
  end component;
  
        component sSegDisplay is
  Port(ck : in  std_logic;                          -- 100MHz system clock
       number : in  std_logic_vector (63 downto 0); -- eight digit number to be displayed
       seg : out  std_logic_vector (7 downto 0);    -- display cathodes
       an : out  std_logic_vector (7 downto 0));    -- display anodes (active-low, due to transistor complementing)
end component;
  
  
  signal dec_h : std_logic_vector(63 downto 0);
  signal clock_am_pm :  std_logic := '0';
  signal dc_hrs_h :  std_logic_vector(3 downto 0) := "0000";
  signal un_hrs_h :  std_logic_vector(3 downto 0) := "0000";
  signal clock_hrs : std_logic := '0';
  signal clock_min : std_logic := '0';
  signal dc_min_h :  std_logic_vector(3 downto 0) := "0000";
  signal un_min_h :  std_logic_vector(3 downto 0) := "0000";
  signal dc_seg_h :  std_logic_vector(3 downto 0) := "0000";
  signal un_seg_h :  std_logic_vector(3 downto 0) := "0000";
  signal div_clock : std_logic := '0';

  signal sec_counter : std_logic := '0';
begin

    decoder : sSegDisplay port map(clock, dec_h, seg, an);
    jk1 : FlipFlopJK port map('1', '1', clock_am_pm, '0', am_pm);
    hrs : Counter_MOD12_BCD port map (clock_hrs, dc_hrs_h, un_hrs_h);
    min : Counter_MOD60_BCD port map (clock_min, un_min_h, dc_min_h);
    sec : Counter_MOD60_BCD port map (div_clock, un_seg_h, dc_seg_h);

    
    clock_am_pm <= '1' when (dc_hrs_h = "1000" and un_hrs_h = "1000" and clock_hrs = '1'and clock_min = '1') else '0';
    clock_hrs <= '1' when ( dc_min_h = "1010" and un_min_h = "1001") else '0';
    clock_min <= '1' when ( dc_seg_h = "1010" and un_seg_h = "1001") else '0';
    led <= '1' when (sec_counter = '1') else '0';
process  (clock)
     variable counter : Integer := 0;

    begin

    if clock'event and clock = '1' then
        counter := counter + 1;
    end if;

    if counter = 200000000 then
        counter := 0;
         div_clock <= not div_clock;
         sec_counter <= not sec_counter;
     end if;
   
           case (dc_hrs_h) is
              when "0000" => dec_h(31 downto 24) <= "00000011";
              when "1000" => dec_h(31 downto 24) <= "10011111";
              when "0100" => dec_h(31 downto 24) <= "00100101";
              when "1100" => dec_h(31 downto 24) <= "00001101";
              when "0010" => dec_h(31 downto 24) <= "10011001";
              when "1010" => dec_h(31 downto 24) <= "01001001";
              when "0110" => dec_h(31 downto 24) <= "01000001";
              when "1110" => dec_h(31 downto 24) <= "00011111";
              when "0001" => dec_h(31 downto 24) <= "00000001";
              when "1001" => dec_h(31 downto 24) <= "00001001";
              when others => dec_h(31 downto 24) <= "11111111";
              end case;
     
     
           case (un_hrs_h) is
              when "0000" => dec_h(23 downto 16) <= "00000011";
              when "1000" => dec_h(23 downto 16) <= "10011111";
              when "0100" => dec_h(23 downto 16) <= "00100101";
              when "1100" => dec_h(23 downto 16) <= "00001101";
              when "0010" => dec_h(23 downto 16) <= "10011001";
              when "1010" => dec_h(23 downto 16) <= "01001001";
              when "0110" => dec_h(23 downto 16) <= "01000001";
              when "1110" => dec_h(23 downto 16) <= "00011111";
              when "0001" => dec_h(23 downto 16) <= "00000001";
              when "1001" => dec_h(23 downto 16) <= "00001001";
              when others => dec_h(23 downto 16) <= "11111111";
              end case;
     
           case (dc_min_h) is
              when "0000" => dec_h(15 downto 8) <= "00000011";
              when "1000" => dec_h(15 downto 8) <= "10011111";
              when "0100" => dec_h(15 downto 8) <= "00100101";
              when "1100" => dec_h(15 downto 8) <= "00001101";
              when "0010" => dec_h(15 downto 8) <= "10011001";
              when "1010" => dec_h(15 downto 8) <= "01001001";
              when "0110" => dec_h(15 downto 8) <= "01000001";
              when "1110" => dec_h(15 downto 8) <= "00011111";
              when "0001" => dec_h(15 downto 8) <= "00000001";
              when "1001" => dec_h(15 downto 8) <= "00001001";
              when others => dec_h(15 downto 8) <= "11111111";
              end case;
           
           case (un_min_h) is
                 when "0000" => dec_h(7 downto 0) <= "00000011";
                 when "1000" => dec_h(7 downto 0) <= "10011111";
                 when "0100" => dec_h(7 downto 0) <= "00100101";
                 when "1100" => dec_h(7 downto 0) <= "00001101";
                 when "0010" => dec_h(7 downto 0) <= "10011001";
                 when "1010" => dec_h(7 downto 0) <= "01001001";
                 when "0110" => dec_h(7 downto 0) <= "01000001";
                 when "1110" => dec_h(7 downto 0) <= "00011111";
                 when "0001" => dec_h(7 downto 0) <= "00000001";
                 when "1001" => dec_h(7 downto 0) <= "00001001";
                 when others => dec_h(7 downto 0) <= "11111111";
                 end case;
end process;
end Behavioral;
