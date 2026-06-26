library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_estacionamentoSAMFEL is
end entity;

architecture tb of tb_estacionamentoSAMFEL is

    -- SINAIS E CONSTANTES
    signal CLOCK_50 : std_logic := '0';
    signal KEY      : std_logic_vector(1 downto 0) := (others => '1');
    signal SW       : std_logic_vector(9 downto 0) := (others => '0');
    signal LEDR     : std_logic_vector(9 downto 0);
    signal HEX0     : std_logic_vector(6 downto 0);
    signal HEX1     : std_logic_vector(6 downto 0);
    
    constant HEX_0 : std_logic_vector(6 downto 0) := "1000000";
    constant HEX_1 : std_logic_vector(6 downto 0) := "1111001";
    constant HEX_2 : std_logic_vector(6 downto 0) := "0100100";
    constant HEX_3 : std_logic_vector(6 downto 0) := "0110000";
    constant HEX_4 : std_logic_vector(6 downto 0) := "0011001";
    constant HEX_5 : std_logic_vector(6 downto 0) := "0010010";
    constant HEX_6 : std_logic_vector(6 downto 0) := "0000010";
    constant HEX_7 : std_logic_vector(6 downto 0) := "1111000";
    constant HEX_8 : std_logic_vector(6 downto 0) := "0000000";
    constant HEX_9 : std_logic_vector(6 downto 0) := "0010000";


    -- PROCEDIMENTOS AUXILIARES
    
   procedure avanca_ciclo(signal clk : in std_logic) is
   begin
       wait until rising_edge(clk);
       wait for 1 ns;
   end procedure;

    procedure pulso_entrada(
        signal key0 : inout std_logic;
        signal clk  : in std_logic
    ) is
    begin
        key0 <= '0';

        avanca_ciclo(clk);
        avanca_ciclo(clk);
        avanca_ciclo(clk);

        key0 <= '1';

        avanca_ciclo(clk);
        avanca_ciclo(clk);
    end procedure;

    procedure pulso_saida(
        signal key1 : inout std_logic;
        signal clk  : in std_logic
    ) is
    begin
        key1 <= '0';

        avanca_ciclo(clk);
        avanca_ciclo(clk);
        avanca_ciclo(clk);

        key1 <= '1';

        avanca_ciclo(clk);
        avanca_ciclo(clk);
    end procedure;
begin
    
    
    dut : entity work.estacionamentoSAMFEL
        port map (
            CLOCK_50 => CLOCK_50,
            KEY      => KEY,
            SW       => SW,
            LEDR     => LEDR,
            HEX0     => HEX0,
            HEX1     => HEX1
        );

   
    --CLOCK
   
    clock_process : process
    begin
        for i in 1 to 500 loop
            CLOCK_50 <= '0';
            wait for 5 ns;

            CLOCK_50 <= '1';
            wait for 5 ns;
        end loop;

        wait;
    end process;

    
    stim : process
    begin
        
        -- TESTE RESET INICIAL
        
        report "TESTE 1 - Aplicando reset inicial" severity note;

        SW(9) <= '1';                
        SW(3 downto 0) <= "0101";    
        KEY <= (others => '1');      

        avanca_ciclo(CLOCK_50);
        avanca_ciclo(CLOCK_50);
        avanca_ciclo(CLOCK_50);

        SW(9) <= '0';                 

        avanca_ciclo(CLOCK_50);
        avanca_ciclo(CLOCK_50);
        avanca_ciclo(CLOCK_50);

        assert LEDR(0) = '1'
            report "Falha no TESTE 1: deveria haver vaga disponivel apos reset" severity error;

        assert LEDR(2) = '0'
            report "Falha no TESTE 1: nao deveria estar lotado apos reset" severity error;

        
        -- TESTE capacidade 5 veiculos 0
        
        report "TESTE 2 - Verificando exibicao inicial com capacidade 5 e 0 veiculos" severity note;

        avanca_ciclo(CLOCK_50);
        avanca_ciclo(CLOCK_50);
        avanca_ciclo(CLOCK_50);

        assert HEX0 = HEX_0
            report "Falha no TESTE 2: HEX0 deveria mostrar 0 veiculos" severity error;

        assert HEX1 = HEX_5
            report "Falha no TESTE 2: HEX1 deveria mostrar 5 vagas livres" severity error;

        
        -- TESTE UMA ENTRADA NORMAL
       
        report "TESTE 3 - Realizando uma entrada normal" severity note;

        pulso_entrada(KEY(0), CLOCK_50);
        avanca_ciclo(CLOCK_50);
        avanca_ciclo(CLOCK_50);
        avanca_ciclo(CLOCK_50);
        avanca_ciclo(CLOCK_50);
        avanca_ciclo(CLOCK_50);

        assert HEX0 = HEX_1
            report "Falha no TESTE 3: HEX0 deveria mostrar 1 veiculo" severity error;

        assert HEX1 = HEX_4
            report "Falha no TESTE 3: HEX1 deveria mostrar 4 vagas livres" severity error;

        
        -- TESTE SEGUNDA ENTRADA
        
        report "TESTE 4 - Realizando segunda entrada" severity note;

        pulso_entrada(KEY(0), CLOCK_50);
        avanca_ciclo(CLOCK_50);
        avanca_ciclo(CLOCK_50);
        avanca_ciclo(CLOCK_50);
        avanca_ciclo(CLOCK_50);
        avanca_ciclo(CLOCK_50);

        assert HEX0 = HEX_2
            report "Falha no TESTE 4: HEX0 deveria mostrar 2 veiculos" severity error;

        assert HEX1 = HEX_3
            report "Falha no TESTE 4: HEX1 deveria mostrar 3 vagas livres" severity error;

       
        -- TESTE UMA SAÍDA NORMAL
        
        report "TESTE 5 - Realizando uma saida normal" severity note;

        pulso_saida(KEY(1), CLOCK_50);
        avanca_ciclo(CLOCK_50);
        avanca_ciclo(CLOCK_50);
        avanca_ciclo(CLOCK_50);
        avanca_ciclo(CLOCK_50);
        avanca_ciclo(CLOCK_50);

        assert HEX0 = HEX_1
            report "Falha no TESTE 5: HEX0 deveria mostrar 1 veiculo apos saida" severity error;

        assert HEX1 = HEX_4
            report "Falha no TESTE 5: HEX1 deveria mostrar 4 vagas livres apos saida" severity error;

        
        -- TESTE LOTAR O ESTACIONAMENTO
        
        report "TESTE 6 - Lotando o estacionamento ate a capacidade maxima" severity note;

        for i in 1 to 4 loop
            pulso_entrada(KEY(0), CLOCK_50);
            avanca_ciclo(CLOCK_50);
            avanca_ciclo(CLOCK_50);
            avanca_ciclo(CLOCK_50);
            avanca_ciclo(CLOCK_50);
            avanca_ciclo(CLOCK_50);
        end loop;

        assert HEX0 = HEX_5
            report "Falha no TESTE 6: HEX0 deveria mostrar 5 veiculos" severity error;

        assert HEX1 = HEX_0
            report "Falha no TESTE 6: HEX1 deveria mostrar 0 vagas livres" severity error;

        assert LEDR(2) = '1'
            report "Falha no TESTE 6: LEDR(2) deveria indicar estacionamento lotado" severity error;

       
        -- TESTE ENTRADA COM LOTAÇÃO MÁXIMA
        
        report "TESTE 7 - Tentando entrada quando o estacionamento esta lotado" severity note;

        pulso_entrada(KEY(0), CLOCK_50);
        avanca_ciclo(CLOCK_50);
        avanca_ciclo(CLOCK_50);
        avanca_ciclo(CLOCK_50);
        avanca_ciclo(CLOCK_50);
        avanca_ciclo(CLOCK_50);

        assert HEX0 = HEX_5
            report "Falha no TESTE 7: nao deveria incrementar acima da capacidade" severity error;

        assert HEX1 = HEX_0
            report "Falha no TESTE 7: vagas livres deveriam continuar em 0" severity error;

        assert LEDR(2) = '1'
            report "Falha no TESTE 7: deveria continuar lotado" severity error;

        
        -- TESTE  ESVAZIAR O ESTACIONAMENTO
        
        report "TESTE 8 - Esvaziando o estacionamento" severity note;

        for i in 1 to 5 loop
            pulso_saida(KEY(1), CLOCK_50);
            avanca_ciclo(CLOCK_50);
            avanca_ciclo(CLOCK_50);
            avanca_ciclo(CLOCK_50);
            avanca_ciclo(CLOCK_50);
            avanca_ciclo(CLOCK_50);
        end loop;

        assert HEX0 = HEX_0
            report "Falha no TESTE 8: HEX0 deveria mostrar 0 veiculos" severity error;

        assert HEX1 = HEX_5
            report "Falha no TESTE 8: HEX1 deveria mostrar 5 vagas livres" severity error;

        assert LEDR(0) = '1'
            report "Falha no TESTE 8: deveria haver vaga disponivel" severity error;

        
        -- TESTE SAÍDA COM ESTACIONAMENTO VAZIO
      
        report "TESTE 9 - Tentando saida com estacionamento vazio" severity note;

        pulso_saida(KEY(1), CLOCK_50);
        avanca_ciclo(CLOCK_50);
        avanca_ciclo(CLOCK_50);
        avanca_ciclo(CLOCK_50);
        avanca_ciclo(CLOCK_50);
        avanca_ciclo(CLOCK_50);

        assert HEX0 = HEX_0
            report "Falha no TESTE 9: nao deveria decrementar abaixo de zero" severity error;

        assert HEX1 = HEX_5
            report "Falha no TESTE 9: vagas livres deveriam continuar em 5" severity error;

        
        -- TESTE ENTRADA E SAÍDA SIMULTÂNEAS
        
        report "TESTE 10 - Entrada e saida simultaneas" severity note;

        KEY(0) <= '0';
        KEY(1) <= '0';
        avanca_ciclo(CLOCK_50);
        KEY(0) <= '1';
        KEY(1) <= '1';

        avanca_ciclo(CLOCK_50);
        avanca_ciclo(CLOCK_50);
        avanca_ciclo(CLOCK_50);
        avanca_ciclo(CLOCK_50);
        avanca_ciclo(CLOCK_50);

        assert HEX0 = HEX_1
            report "Falha no TESTE 10: requisicoes simultaneas deveriam priorizar entrada" severity error;

        assert HEX1 = HEX_4
            report "Falha no TESTE 10: vagas livres deveriam cair para 4" severity error;

        
        -- TESTE RESET 
        
        report "TESTE 11 - Aplicando reset durante a operacao" severity note;

        SW(9) <= '1';
        avanca_ciclo(CLOCK_50);
        avanca_ciclo(CLOCK_50);
        SW(9) <= '0';

        avanca_ciclo(CLOCK_50);
        avanca_ciclo(CLOCK_50);
        avanca_ciclo(CLOCK_50);

        assert HEX0 = HEX_0
            report "Falha no TESTE 11: apos reset deveria voltar para 0 veiculos" severity error;

        assert LEDR(2) = '0'
            report "Falha no TESTE 11: apos reset nao deveria estar lotado" severity error;

        report "Todos os testes do tb_estacionamentoSAMFEL foram concluidos com sucesso." severity note;

        
        report "Fim da simulacao." severity note;
        wait;
    end process;

end architecture;