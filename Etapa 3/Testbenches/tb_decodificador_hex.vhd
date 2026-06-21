library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_decodificador_hex is
end entity;

architecture tb of tb_decodificador_hex is
    signal veiculos_atual     : std_logic_vector(3 downto 0) := (others => '0');
    signal vagas_livres       : std_logic_vector(3 downto 0) := (others => '0');
    signal atualiza_saida_hex : std_logic := '0';
    signal segmentos_hex0     : std_logic_vector(6 downto 0);
    signal segmentos_hex1     : std_logic_vector(6 downto 0);
begin
    uut: entity work.decodificador_hex
        port map (
            veiculos_atual => veiculos_atual,
            vagas_livres => vagas_livres,
            atualiza_saida_hex => atualiza_saida_hex,
            segmentos_hex0 => segmentos_hex0,
            segmentos_hex1 => segmentos_hex1
        );

    stim: process
    begin
        veiculos_atual <= "0000";
        vagas_livres <= "1001";
        wait for 1 ns;
        atualiza_saida_hex <= '1';
        wait for 1 ns;
        atualiza_saida_hex <= '0';
        assert segmentos_hex0 = "1000000" report "Falha: HEX0 nao exibiu 0" severity error;
        assert segmentos_hex1 = "0010000" report "Falha: HEX1 nao exibiu 9" severity error;

        veiculos_atual <= "1111";
        vagas_livres <= "1010";
        wait for 1 ns;
        assert segmentos_hex0 = "1000000" and segmentos_hex1 = "0010000"
            report "Falha: saidas mudaram sem atualizacao" severity error;

        atualiza_saida_hex <= '1';
        wait for 1 ns;
        atualiza_saida_hex <= '0';
        assert segmentos_hex0 = "0001110" report "Falha: HEX0 nao exibiu F" severity error;
        assert segmentos_hex1 = "0001000" report "Falha: HEX1 nao exibiu A" severity error;

        for i in 0 to 15 loop
            veiculos_atual <= std_logic_vector(to_unsigned(i, 4));
            vagas_livres <= std_logic_vector(to_unsigned(15 - i, 4));
            wait for 1 ns;
            atualiza_saida_hex <= '1';
            wait for 1 ns;
            atualiza_saida_hex <= '0';
        end loop;

        wait;
    end process;
end architecture;
