library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_decodificador_hex is
end entity;

architecture tb of tb_decodificador_hex is
    signal valor_binario : std_logic_vector(3 downto 0);
    signal segmentos_hex : std_logic_vector(6 downto 0);
begin
    uut: entity work.decodificador_hex
        port map (
            valor_binario => valor_binario,
            segmentos_hex => segmentos_hex
        );

    stim: process
    begin
        valor_binario <= "0000";
        wait for 1 ns;
        assert segmentos_hex = "1000000" report "Falha: HEX 0" severity error;

        valor_binario <= "1001";
        wait for 1 ns;
        assert segmentos_hex = "0010000" report "Falha: HEX 9" severity error;

        valor_binario <= "1111";
        wait for 1 ns;
        assert segmentos_hex = "0001110" report "Falha: HEX F" severity error;

        wait;
    end process;
end architecture;
