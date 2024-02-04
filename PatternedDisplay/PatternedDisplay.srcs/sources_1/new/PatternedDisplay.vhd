library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use IEEE.NUMERIC_STD.ALL;

entity PatternedDisplay is
  Port (switches: in STD_LOGIC_VECTOR(15 downto 0);
        clock: in STD_LOGIC;
        control: out STD_LOGIC_VECTOR(6 downto 0);
        decimal: out STD_LOGIC;
        anodes: out STD_LOGIC_VECTOR(7 downto 0));
end PatternedDisplay;

architecture Behavioral of PatternedDisplay is

	signal clockdivision: STD_LOGIC_VECTOR(20 downto 0);
	signal temp_anodes: STD_LOGIC_VECTOR(7 downto 0);

begin

    clock_divider: process(clock)
    begin
		if (rising_edge(clock)) then
			clockdivision <= clockdivision +1;
		end if;
    end process clock_divider;

    process(switches)
    begin
            case switches(4 downto 0) is
                when "00001" => 
                    if (anodes <= "11111110")then
                            control <= "0000000"; --8
                            decimal <= '0';
                    else
                        control <= "1111110"; --8
                        decimal <= '0';
                    end if;
                
                when "00010" =>
                    if (anodes <= "01111111") then
                            control <= "0001000"; --A
                            decimal <= '1';
                    elsif (anodes <= "10111111") then
                            control <= "0000000"; --B
                            decimal <= '0';
                    elsif (anodes <= "11011111") then
                            control <= "1000110"; --C
                            decimal <= '1';
                    elsif (anodes <= "11101111") then
                            control <= "1000000"; --D
                            decimal <= '0';
                    elsif (anodes <= "11110111") then
                            control <= "0000110"; --E
                            decimal <= '1';
                    elsif (anodes <= "11111011") then
                            control <= "0001110"; --F
                            decimal <= '0';
                    elsif (anodes <= "11111101") then
                            control <= "1111001"; --1
                            decimal <= '1';
                    elsif (anodes <= "11111110") then
                            control <= "0100100"; --2
                            decimal <= '0';
                    end if;
                    
                when "00100" =>
                    if (anodes <= "01111111") then
                             control <= "0000000"; --8
                             decimal <= '1';
                    elsif (anodes <= "10111111") then
                             control <= "1111000"; --7
                             decimal <= '0';
                    elsif (anodes <= "11011111") then
                             control <= "0000010"; --6
                             decimal <= '1';
                    elsif (anodes <= "11101111") then
                             control <= "0010010"; --5
                             decimal <= '1';
                    elsif (anodes <= "11110111") then
                             control <= "0011001"; --4
                             decimal <= '1';
                    elsif (anodes <= "11111011") then
                             control <= "0110000"; --3
                             decimal <= '1';
                    elsif (anodes <= "11111101") then
                             control <= "0100100"; --2
                             decimal <= '1';
                    elsif (anodes <= "11111110") then
                             control <= "1111001"; --1
                             decimal <= '1';
                    end if;
                     
                when "01000" =>
                                   if (anodes <= "01111111") then
                                            control <= "0100100"; --2
                                            decimal <= '1';
                                   elsif (anodes <= "10111111") then
                                            control <= "1000000"; --0
                                            decimal <= '1';
                                   elsif (anodes <= "11011111") then
                                            control <= "1111001"; --1
                                            decimal <= '1';
                                   elsif (anodes <= "11101111") then 
                                            control <= "0011000"; --9
                                            decimal <= '1';
                                   elsif (anodes <= "11110111") then
                                            control <= "0100100"; --2
                                            decimal <= '1';
                                   elsif (anodes <= "11111011") then
                                            control <= "1000000"; --0
                                            decimal <= '1';
                                   elsif (anodes <= "11111101") then
                                            control <= "0100100"; --2
                                            decimal <= '1';
                                   elsif (anodes <= "11111110") then
                                            control <= "1000000"; --0
                                            decimal <= '1';
                                   end if;
                                   
                  when "10000" =>
                                   if (anodes <= "01111111") then
                                            control <= "1000000"; --0
                                            decimal <= '0';
                                   elsif (anodes <= "10111111") then
                                            control <= "0000000"; --B
                                            decimal <= '1';
                                   elsif (anodes <= "11011111") then
                                            control <= "0001000"; --A
                                            decimal <= '1';
                                   elsif (anodes <= "11101111") then 
                                            control <= "1000000"; --D
                                            decimal <= '0';
                                   elsif (anodes <= "11110111") then
                                            control <= "1000110"; --C
                                            decimal <= '1';
                                   elsif (anodes <= "11111011") then
                                            control <= "1000000"; --0
                                            decimal <= '1';
                                   elsif (anodes <= "11111101") then
                                            control <= "1000000"; --D
                                            decimal <= '1';
                                   elsif (anodes <= "11111110") then
                                            control <= "0000110"; --E
                                            decimal <= '1';
                                   end if; 
                    
                 when others =>
                    control <= "0001110";
                    decimal <= '0';
             end case;
    end process;
    
    
    rotate_anodes: process(clockdivision(10))
        begin
                if (rising_edge(clockdivision(10))) then
                        case temp_anodes is
                                        when "11111110"  => 
                                            temp_anodes <= "11111101";
                                        when "11111101"  => 
                                            temp_anodes <= "11111011";
                                        when "11111011"  => 
                                            temp_anodes <= "11110111";
                                        when "11110111"  => 
                                            temp_anodes <= "11101111";
                                        when "11101111" => 
                                            temp_anodes <= "11011111";
                                        when "11011111" => 
                                            temp_anodes <= "10111111";
                                        when "10111111" => 
                                            temp_anodes <= "01111111";
                                        when "01111111" => 
                                            temp_anodes <= "11111110";
                                        when others =>
                                            temp_anodes <= "11111110";
                                    end case;
                end if;
    end process rotate_anodes;              
    anodes <= temp_anodes;

end Behavioral;