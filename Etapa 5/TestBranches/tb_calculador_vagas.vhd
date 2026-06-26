library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_calculador_vagas is
end entity;

architecture tb of tb_calculador_vagas is
    signal capacidade_atual : std_logic_vector(3 downto 0) := (others => '0');
    signal veiculos_atual   : std_logic_vector(3 downto 0) := (others => '0');
    signal vagas_livres     : std_logic_vector(3 downto 0);
begin
    uut: entity work.calculador_vagas
        port map (
            capacidade_atual => capacidade_atual,
            veiculos_atual => veiculos_atual,
            vagas_livres => vagas_livres
        );

    stim: process
    begin
        capacidade_atual <= "1001";

        veiculos_atual <= "0011";
        wait for 1 ns;
        assert vagas_livres = "0110" report "Falha: 9-3" severity error;

        veiculos_atual <= "1001";
        wait for 1 ns;
        assert vagas_livres = "0000" report "Falha: 9-9" severity error;

        veiculos_atual <= "1010";
        wait for 1 ns;
        assert vagas_livres = "0000" report "Falha: saturacao abaixo de 0" severity error;

        wait;
    end process;
end architecture;
