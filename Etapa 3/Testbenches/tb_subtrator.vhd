library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_subtrator is
end entity;

architecture tb of tb_subtrator is
    signal veiculos          : std_logic_vector(3 downto 0);
    signal veiculos_menos_um : std_logic_vector(3 downto 0);
begin
    uut: entity work.subtrator
        port map (
            veiculos => veiculos,
            veiculos_menos_um => veiculos_menos_um
        );

    stim: process
    begin
        veiculos <= "0101";
        wait for 1 ns;
        assert veiculos_menos_um = "0100" report "Falha: 5 - 1" severity error;

        veiculos <= "0001";
        wait for 1 ns;
        assert veiculos_menos_um = "0000" report "Falha: 1 - 1" severity error;

        veiculos <= "0000";
        wait for 1 ns;
        assert veiculos_menos_um = "1111" report "Falha: underflow modular" severity error;

        wait;
    end process;
end architecture;
