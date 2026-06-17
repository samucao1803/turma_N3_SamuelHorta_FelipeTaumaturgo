library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fsm_estacionamento is
    port (
        clk                   : in  std_logic;
        reset                 : in  std_logic;
        req_entrada           : in  std_logic;
        req_saida             : in  std_logic;
        vaga_disponivel       : in  std_logic;
        estacionamento_lotado : in  std_logic;
        estacionamento_vazio  : in  std_logic;
        atualiza_saidas_hex   : in  std_logic;
        inc_veiculos          : out std_logic;
        dec_veiculos          : out std_logic;
        load_historico        : out std_logic;
        atualiza_saidas       : out std_logic;
        reset_regs            : out std_logic
    );
end entity;

architecture rtl of fsm_estacionamento is
    type estado_t is (
        RESET_ST,
        ESPERA,
        ENTRADA,
        VERIFICA_CAPACIDADE,
        REGISTRA_ENTRADA,
        SAIDA,
        REGISTRA_SAIDA,
        LOTADO,
        ATUALIZA_SAIDAS_ST
    );

    signal estado_atual, proximo_estado : estado_t := RESET_ST;
begin
    process (clk, reset)
    begin
        if reset = '1' then
            estado_atual <= RESET_ST;
        elsif rising_edge(clk) then
            estado_atual <= proximo_estado;
        end if;
    end process;

    process (estado_atual, req_entrada, req_saida, vaga_disponivel, estacionamento_lotado, estacionamento_vazio, atualiza_saidas_hex)
    begin
        proximo_estado <= estado_atual;

        case estado_atual is
            when RESET_ST =>
                proximo_estado <= ESPERA;

            when ESPERA =>
                if req_entrada = '1' then
                    proximo_estado <= ENTRADA;
                elsif req_saida = '1' then
                    proximo_estado <= SAIDA;
                end if;

            when ENTRADA =>
                proximo_estado <= VERIFICA_CAPACIDADE;

            when VERIFICA_CAPACIDADE =>
                if vaga_disponivel = '1' and estacionamento_lotado = '0' then
                    proximo_estado <= REGISTRA_ENTRADA;
                else
                    proximo_estado <= LOTADO;
                end if;

            when REGISTRA_ENTRADA =>
                proximo_estado <= ATUALIZA_SAIDAS_ST;

            when SAIDA =>
                if estacionamento_vazio = '0' then
                    proximo_estado <= REGISTRA_SAIDA;
                else
                    proximo_estado <= ATUALIZA_SAIDAS_ST;
                end if;

            when REGISTRA_SAIDA =>
                proximo_estado <= ATUALIZA_SAIDAS_ST;

            when LOTADO =>
                proximo_estado <= ATUALIZA_SAIDAS_ST;

            when ATUALIZA_SAIDAS_ST =>
                if atualiza_saidas_hex = '1' then
                    proximo_estado <= ESPERA;
                end if;
        end case;
    end process;

    process (estado_atual)
    begin
        inc_veiculos    <= '0';
        dec_veiculos    <= '0';
        load_historico  <= '0';
        atualiza_saidas <= '0';
        reset_regs      <= '0';

        case estado_atual is
            when RESET_ST =>
                reset_regs <= '1';

            when REGISTRA_ENTRADA =>
                inc_veiculos   <= '1';
                load_historico <= '1';

            when REGISTRA_SAIDA =>
                dec_veiculos   <= '1';
                load_historico <= '1';

            when LOTADO | ATUALIZA_SAIDAS_ST =>
                atualiza_saidas <= '1';

            when others =>
                null;
        end case;
    end process;
end architecture;
