library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_reg_capacidade is
end entity;

architecture tb of tb_reg_capacidade is
    signal clk                : std_logic := '0';
    signal reset              : std_logic := '1';
    signal capacidade_entrada : std_logic_vector(3 downto 0) := (others => '0');
    signal capacidade_atual   : std_logic_vector(3 downto 0);
begin
    uut: entity work.reg_capacidade
        port map (
            clk => clk,
            reset => reset,
            capacidade_entrada => capacidade_entrada,
            capacidade_atual => capacidade_atual
        );

    clk <= not clk after 5 ns;

    stim: process
    begin
        wait for 12 ns;
        reset <= '0';

        capacidade_entrada <= "1010";
        wait for 10 ns;
        assert capacidade_atual = "1010" report "Falha: carga da capacidade" severity error;

        capacidade_entrada <= "0011";
        wait for 10 ns;
        assert capacidade_atual = "0011" report "Falha: atualizacao da capacidade" severity error;

        reset <= '1';
        wait for 2 ns;
        assert capacidade_atual = "0000" report "Falha: reset" severity error;

        wait;
    end process;
end architecture;
