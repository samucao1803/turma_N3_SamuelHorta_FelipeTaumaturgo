library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_reg_vagas_livres is
end entity;

architecture tb of tb_reg_vagas_livres is
    signal clk                  : std_logic := '0';
    signal reset                : std_logic := '1';
    signal vagas_livres_entrada : std_logic_vector(3 downto 0) := (others => '0');
    signal vagas_livres         : std_logic_vector(3 downto 0);
begin
    uut: entity work.reg_vagas_livres
        port map (
            clk => clk,
            reset => reset,
            vagas_livres_entrada => vagas_livres_entrada,
            vagas_livres => vagas_livres
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

        vagas_livres_entrada <= "1001";
        wait for 10 ns;
        assert vagas_livres = "1001" report "Falha: carga de vagas" severity error;

        vagas_livres_entrada <= "0010";
        wait for 10 ns;
        assert vagas_livres = "0010" report "Falha: atualizacao de vagas" severity error;

        reset <= '1';
        wait for 2 ns;
        assert vagas_livres = "0000" report "Falha: reset" severity error;

        report "tb_reg_vagas_livres concluido com sucesso" severity note;
        wait;
    end process;
end architecture;
