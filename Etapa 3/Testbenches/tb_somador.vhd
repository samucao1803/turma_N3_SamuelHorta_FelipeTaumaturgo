library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_somador is
end entity;

architecture tb of tb_somador is
    signal veiculos         : std_logic_vector(3 downto 0);
    signal veiculos_mais_um : std_logic_vector(3 downto 0);
begin
    uut: entity work.somador
        port map (
            veiculos => veiculos,
            veiculos_mais_um => veiculos_mais_um
        );

    stim: process
    begin
        veiculos <= "0000";
        wait for 1 ns;
        assert veiculos_mais_um = "0001" report "Falha: 0 + 1" severity error;

        veiculos <= "0111";
        wait for 1 ns;
        assert veiculos_mais_um = "1000" report "Falha: 7 + 1" severity error;

        veiculos <= "1111";
        wait for 1 ns;
        assert veiculos_mais_um = "0000" report "Falha: overflow modular" severity error;

        wait;
    end process;
end architecture;
