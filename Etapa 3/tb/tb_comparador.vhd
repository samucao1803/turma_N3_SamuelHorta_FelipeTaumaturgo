library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_comparador is
end entity;

architecture tb of tb_comparador is
    signal veiculos_atual        : std_logic_vector(3 downto 0) := (others => '0');
    signal capacidade_atual      : std_logic_vector(3 downto 0) := (others => '0');
    signal vaga_disponivel       : std_logic;
    signal estacionamento_lotado : std_logic;
    signal estacionamento_vazio  : std_logic;
    signal saida_led0            : std_logic;
    signal saida_led1            : std_logic;
    signal saida_led2            : std_logic;
begin
    uut: entity work.comparador
        port map (
            veiculos_atual => veiculos_atual,
            capacidade_atual => capacidade_atual,
            vaga_disponivel => vaga_disponivel,
            estacionamento_lotado => estacionamento_lotado,
            estacionamento_vazio => estacionamento_vazio,
            saida_led0 => saida_led0,
            saida_led1 => saida_led1,
            saida_led2 => saida_led2
        );

    stim: process
    begin
        capacidade_atual <= "1010";

        
        veiculos_atual <= "0000";
        wait for 1 ns;

        assert vaga_disponivel = '1' severity error;
        assert estacionamento_lotado = '0' severity error;
        assert estacionamento_vazio = '1' severity error;
        assert saida_led0 = '1' severity error;
        assert saida_led1 = '0' severity error;
        assert saida_led2 = '0' severity error;

        
        veiculos_atual <= "0101";
        wait for 1 ns;

        assert vaga_disponivel = '1' severity error;
        assert estacionamento_lotado = '0' severity error;
        assert estacionamento_vazio = '0' severity error;
        assert saida_led0 = '1' severity error;
        assert saida_led1 = '0' severity error;
        assert saida_led2 = '0' severity error;

        
        veiculos_atual <= "1000";
        wait for 1 ns;

        assert vaga_disponivel = '1' severity error;
        assert estacionamento_lotado = '0' severity error;
        assert saida_led0 = '1' severity error;
        assert saida_led1 = '1' severity error;
        assert saida_led2 = '0' severity error;

        
        veiculos_atual <= "1001";
        wait for 1 ns;

        assert vaga_disponivel = '1' severity error;
        assert estacionamento_lotado = '0' severity error;
        assert saida_led0 = '1' severity error;
        assert saida_led1 = '1' severity error;
        assert saida_led2 = '0' severity error;

        wait;
    end process;
end architecture;
