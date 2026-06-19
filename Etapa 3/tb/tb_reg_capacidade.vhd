library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_reg_capacidade is
end entity;

architecture tb of tb_reg_capacidade is
    signal clk                  : std_logic := '0';
    signal reset                : std_logic := '1';
    signal sw0, sw1, sw2, sw3   : std_logic := '0';
    signal vagas_livres_entrada : std_logic_vector(3 downto 0);
begin
    uut: entity work.reg_capacidade
        port map (
            clk                  => clk,
            reset                => reset,
            sw0                  => sw0,
            sw1                  => sw1,
            sw2                  => sw2,
            sw3                  => sw3,
            vagas_livres_entrada => vagas_livres_entrada
        );

    
    clock_process : process
    begin
        for i in 1 to 20 loop
            clk <= '0';
            wait for 5 ns;

            clk <= '1';
            wait for 5 ns;
        end loop;

        wait;
    end process;

    stim: process
    begin
        
        wait for 12 ns;
        reset <= '0';
        wait for 10 ns;
        assert vagas_livres_entrada = "0000"
            report "Falha: reset nao inicializou em 0" severity error;

        
        sw3 <= '0'; sw2 <= '0'; sw1 <= '1'; sw0 <= '1';
        wait for 10 ns;
        assert vagas_livres_entrada = "0011"
            report "Falha: carga de 3 vagas" severity error;

       
        sw3 <= '1'; sw2 <= '0'; sw1 <= '0'; sw0 <= '0';
        wait for 10 ns;
        assert vagas_livres_entrada = "1000"
            report "Falha: carga de 8 vagas" severity error;

        
        sw3 <= '1'; sw2 <= '0'; sw1 <= '0'; sw0 <= '1';
        wait for 10 ns;
        assert vagas_livres_entrada = "1001"
            report "Falha: carga de 9 vagas" severity error;

       
        sw3 <= '1'; sw2 <= '0'; sw1 <= '1'; sw0 <= '0';
        wait for 10 ns;
        assert vagas_livres_entrada = "1001"
            report "Falha: nao saturou em 9 para entrada 10" severity error;

        
        sw3 <= '1'; sw2 <= '1'; sw1 <= '1'; sw0 <= '1';
        wait for 10 ns;
        assert vagas_livres_entrada = "1001"
            report "Falha: nao saturou em 9 para entrada 15" severity error;

        
        reset <= '1';
        wait for 2 ns;
        assert vagas_livres_entrada = "0000"
            report "Falha: reset assincrono nao zerou saida" severity error;

        report "tb_reg_capacidade concluido com sucesso" severity note;
        wait;
    end process;
end architecture;