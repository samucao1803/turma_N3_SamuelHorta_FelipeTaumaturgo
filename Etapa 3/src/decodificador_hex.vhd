library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decodificador_hex is
    port (
        valor_binario : in  std_logic_vector(3 downto 0);
        segmentos_hex : out std_logic_vector(6 downto 0)
    );
end entity;

architecture rtl of decodificador_hex is
begin
    process (valor_binario)
    begin
        case valor_binario is
            when "0000" => segmentos_hex <= "1000000"; -- 0
            when "0001" => segmentos_hex <= "1111001"; -- 1
            when "0010" => segmentos_hex <= "0100100"; -- 2
            when "0011" => segmentos_hex <= "0110000"; -- 3
            when "0100" => segmentos_hex <= "0011001"; -- 4
            when "0101" => segmentos_hex <= "0010010"; -- 5
            when "0110" => segmentos_hex <= "0000010"; -- 6
            when "0111" => segmentos_hex <= "1111000"; -- 7
            when "1000" => segmentos_hex <= "0000000"; -- 8
            when "1001" => segmentos_hex <= "0010000"; -- 9
            when "1010" => segmentos_hex <= "0001000"; -- A
            when "1011" => segmentos_hex <= "0000011"; -- b
            when "1100" => segmentos_hex <= "1000110"; -- C
            when "1101" => segmentos_hex <= "0100001"; -- d
            when "1110" => segmentos_hex <= "0000110"; -- E
            when others => segmentos_hex <= "0001110"; -- F
        end case;
    end process;
end architecture;
