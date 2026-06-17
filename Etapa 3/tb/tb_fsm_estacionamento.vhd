library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

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
    signal atualiza_saidas_hex   : std_logic := '0';
    signal inc_veiculos          : std_logic;
    signal dec_veiculos          : std_logic;
    signal load_historico        : std_logic;
    signal atualiza_saidas       : std_logic;
    signal reset_regs            : std_logic;

    procedure expect_pulse(signal s: in std_logic; constant timeout: time; constant msg: string) is
        variable elapsed : time := 0 ns;
    begin
        while elapsed < timeout loop
            if s = '1' then
                return;
            end if;
            wait for 1 ns;
            elapsed := elapsed + 1 ns;
        end loop;
        assert false report msg severity error;
    end procedure;

    procedure expect_no_pulse(signal s: in std_logic; constant timeout: time; constant msg: string) is
        variable elapsed : time := 0 ns;
    begin
        while elapsed < timeout loop
            if s = '1' then
                assert false report msg severity error;
            end if;
            wait for 1 ns;
            elapsed := elapsed + 1 ns;
        end loop;
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
            atualiza_saidas_hex => atualiza_saidas_hex,
            inc_veiculos => inc_veiculos,
            dec_veiculos => dec_veiculos,
            load_historico => load_historico,
            atualiza_saidas => atualiza_saidas,
            reset_regs => reset_regs
        );

    clk <= not clk after 5 ns;

    stim: process
    begin
        wait for 2 ns;
        assert reset_regs = '1' report "Falha: reset_regs nao ativo em reset" severity error;

        wait for 10 ns;
        reset <= '0';

        req_entrada <= '1';
        expect_pulse(inc_veiculos, 80 ns, "Falha: entrada nao gerou incremento");
        expect_pulse(load_historico, 80 ns, "Falha: entrada nao atualizou historico");
        expect_pulse(atualiza_saidas, 80 ns, "Falha: entrada nao atualizou saidas");
        req_entrada <= '0';

        atualiza_saidas_hex <= '1';
        wait for 10 ns;
        atualiza_saidas_hex <= '0';

        vaga_disponivel <= '0';
        estacionamento_lotado <= '1';
        req_entrada <= '1';
        expect_no_pulse(inc_veiculos, 50 ns, "Falha: incrementou em estado lotado");
        expect_pulse(atualiza_saidas, 80 ns, "Falha: lotado nao atualizou saidas");
        req_entrada <= '0';

        atualiza_saidas_hex <= '1';
        wait for 10 ns;
        atualiza_saidas_hex <= '0';

        vaga_disponivel <= '1';
        estacionamento_lotado <= '0';
        estacionamento_vazio <= '0';
        req_saida <= '1';
        expect_pulse(dec_veiculos, 80 ns, "Falha: saida nao gerou decremento");
        expect_pulse(load_historico, 80 ns, "Falha: saida nao atualizou historico");
        req_saida <= '0';

        atualiza_saidas_hex <= '1';
        wait for 10 ns;
        atualiza_saidas_hex <= '0';

        estacionamento_vazio <= '1';
        req_saida <= '1';
        expect_no_pulse(dec_veiculos, 60 ns, "Falha: decrementou com estacionamento vazio");
        req_saida <= '0';

        wait;
    end process;
end architecture;
