library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use std.env.all;

entity tb_fsm_estacionamento is
end entity;

architecture tb of tb_fsm_estacionamento is
    signal clk                   : std_logic := '0';
    signal reset                 : std_logic := '1';
    signal req_entrada           : std_logic := '0';
    signal req_saida             : std_logic := '0';
    signal vaga_disponivel       : std_logic := '1';
    signal estacionamento_lotado : std_logic := '0';
    signal estacionamento_vazio  : std_logic := '0';
    signal inc_veiculos          : std_logic;
    signal dec_veiculos          : std_logic;
    signal load_historico        : std_logic;
    signal atualiza_saidas_hex   : std_logic;
    signal reset_regs            : std_logic;

    procedure avanca_ciclo is
    begin
        wait until rising_edge(clk);
        wait for 1 ns;
    end procedure;
begin
    uut: entity work.fsm_estacionamento
        port map (
            clk => clk,
            reset => reset,
            req_entrada => req_entrada,
            req_saida => req_saida,
            vaga_disponivel => vaga_disponivel,
            estacionamento_lotado => estacionamento_lotado,
            estacionamento_vazio => estacionamento_vazio,
            inc_veiculos => inc_veiculos,
            dec_veiculos => dec_veiculos,
            load_historico => load_historico,
            atualiza_saidas_hex => atualiza_saidas_hex,
            reset_regs => reset_regs
        );

    clk <= not clk after 5 ns;

    stim: process
    begin
        wait for 2 ns;
        assert reset_regs = '1' report "Falha: reset_regs inativo durante reset" severity error;
        reset <= '0';
        avanca_ciclo; -- RESET_ST -> ESPERA
        assert reset_regs = '0' report "Falha: reset_regs permaneceu ativo" severity error;

        -- Entrada com vaga disponivel.
        req_entrada <= '1';
        avanca_ciclo; -- ESPERA -> ENTRADA
        req_entrada <= '0';
        avanca_ciclo; -- ENTRADA -> VERIFICA_CAPACIDADE
        avanca_ciclo; -- VERIFICA_CAPACIDADE -> REGISTRA_ENTRADA
        assert inc_veiculos = '1' and load_historico = '1'
            report "Falha: entrada valida nao foi registrada" severity error;
        assert dec_veiculos = '0' severity error;
        avanca_ciclo; -- REGISTRA_ENTRADA -> ATUALIZA_SAIDAS_ST
        assert atualiza_saidas_hex = '1' report "Falha: entrada nao atualizou saidas" severity error;
        avanca_ciclo; -- ATUALIZA_SAIDAS_ST -> ESPERA
        assert atualiza_saidas_hex = '0' severity error;

        -- Tentativa de entrada com estacionamento lotado.
        vaga_disponivel <= '0';
        estacionamento_lotado <= '1';
        req_entrada <= '1';
        avanca_ciclo;
        req_entrada <= '0';
        avanca_ciclo;
        avanca_ciclo; -- VERIFICA_CAPACIDADE -> LOTADO
        assert inc_veiculos = '0' and atualiza_saidas_hex = '0'
            report "Falha: tratamento da entrada em lotacao" severity error;
        avanca_ciclo; -- LOTADO -> ATUALIZA_SAIDAS_ST
        assert atualiza_saidas_hex = '1' severity error;
        avanca_ciclo; -- retorno a ESPERA

        -- Saida com veiculos presentes.
        vaga_disponivel <= '1';
        estacionamento_lotado <= '0';
        estacionamento_vazio <= '0';
        req_saida <= '1';
        avanca_ciclo; -- ESPERA -> SAIDA
        req_saida <= '0';
        avanca_ciclo; -- SAIDA -> REGISTRA_SAIDA
        assert dec_veiculos = '1' and load_historico = '1'
            report "Falha: saida valida nao foi registrada" severity error;
        assert inc_veiculos = '0' severity error;
        avanca_ciclo; -- REGISTRA_SAIDA -> ATUALIZA_SAIDAS_ST
        assert atualiza_saidas_hex = '1' report "Falha: saida nao atualizou displays" severity error;
        avanca_ciclo; -- retorno a ESPERA

        -- Tentativa de saida com estacionamento vazio.
        estacionamento_vazio <= '1';
        req_saida <= '1';
        avanca_ciclo; -- ESPERA -> SAIDA
        req_saida <= '0';
        avanca_ciclo; -- SAIDA -> ATUALIZA_SAIDAS_ST
        assert dec_veiculos = '0' and load_historico = '0'
            report "Falha: estacionamento vazio gerou decremento" severity error;
        assert atualiza_saidas_hex = '1' severity error;
        avanca_ciclo; -- retorno a ESPERA

        -- Prioridade documentada da entrada quando ambas requisicoes chegam juntas.
        estacionamento_vazio <= '0';
        req_entrada <= '1';
        req_saida <= '1';
        avanca_ciclo;
        req_entrada <= '0';
        req_saida <= '0';
        avanca_ciclo;
        avanca_ciclo;
        assert inc_veiculos = '1' and dec_veiculos = '0'
            report "Falha: prioridade de entrada para requisicoes simultaneas" severity error;

        report "tb_fsm_estacionamento concluido com sucesso" severity note;
        stop;
        wait;
    end process;
end architecture;
