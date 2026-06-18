library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_mux is
end entity;

architecture tb of tb_mux is
    signal veiculos_subt     : std_logic_vector(3 downto 0) := "0100";
    signal veiculos_adc      : std_logic_vector(3 downto 0) := "0110";
    signal inc_veiculos      : std_logic := '0';
    signal dec_veiculos      : std_logic := '0';
    signal atualiza_veiculos : std_logic_vector(3 downto 0);
begin
    uut: entity work.mux
        port map (
            veiculos_subt => veiculos_subt,
            veiculos_adc => veiculos_adc,
            inc_veiculos => inc_veiculos,
            dec_veiculos => dec_veiculos,
            atualiza_veiculos => atualiza_veiculos
        );

    stim: process
    begin
        wait for 1 ns;
        assert atualiza_veiculos = "0000" report "Falha: MUX sem operacao" severity error;

        inc_veiculos <= '1';
        wait for 1 ns;
        assert atualiza_veiculos = "0110" report "Falha: selecao do somador" severity error;

        inc_veiculos <= '0';
        dec_veiculos <= '1';
        wait for 1 ns;
        assert atualiza_veiculos = "0100" report "Falha: selecao do subtrator" severity error;

        inc_veiculos <= '1';
        wait for 1 ns;
        assert atualiza_veiculos = "0000" report "Falha: controles simultaneos" severity error;

        wait;
    end process;
end architecture;
