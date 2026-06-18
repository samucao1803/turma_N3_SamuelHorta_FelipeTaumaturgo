library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use std.env.all;

entity tb_reg_historico is
end entity;

architecture tb of tb_reg_historico is
    signal clk               : std_logic := '0';
    signal reset             : std_logic := '1';
    signal load_historico    : std_logic := '0';
    signal historico_entrada : std_logic_vector(7 downto 0) := (others => '0');
    signal historico_atual   : std_logic_vector(7 downto 0);
begin
    uut: entity work.reg_historico
        port map (
            clk => clk,
            reset => reset,
            load_historico => load_historico,
            historico_entrada => historico_entrada,
            historico_atual => historico_atual
        );

    clk <= not clk after 5 ns;

    stim: process
    begin
        wait for 12 ns;
        reset <= '0';

        historico_entrada <= x"A5";
        load_historico <= '1';
        wait for 10 ns;
        load_historico <= '0';
        assert historico_atual = x"A5" report "Falha: carga historico" severity error;

        historico_entrada <= x"3C";
        wait for 10 ns;
        assert historico_atual = x"A5" report "Falha: alterou sem load" severity error;

        load_historico <= '1';
        wait for 10 ns;
        load_historico <= '0';
        assert historico_atual = x"3C" report "Falha: segunda carga" severity error;

        reset <= '1';
        wait for 2 ns;
        assert historico_atual = x"00" report "Falha: reset" severity error;

        report "tb_reg_historico concluido com sucesso" severity note;
        stop;
        wait;
    end process;
end architecture;
