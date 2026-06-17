library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_reg_veiculos is
end entity;

architecture tb of tb_reg_veiculos is
    signal clk            : std_logic := '0';
    signal reset          : std_logic := '1';
    signal inc_veiculos   : std_logic := '0';
    signal dec_veiculos   : std_logic := '0';
    signal veiculos_atual : std_logic_vector(3 downto 0);
begin
    uut: entity work.reg_veiculos
        port map (
            clk => clk,
            reset => reset,
            inc_veiculos => inc_veiculos,
            dec_veiculos => dec_veiculos,
            veiculos_atual => veiculos_atual
        );

    clk <= not clk after 5 ns;

    stim: process
    begin
        wait for 12 ns;
        reset <= '0';

        inc_veiculos <= '1';
        wait for 10 ns;
        inc_veiculos <= '0';
        assert veiculos_atual = "0001" report "Falha: incremento basico" severity error;

        dec_veiculos <= '1';
        wait for 10 ns;
        dec_veiculos <= '0';
        assert veiculos_atual = "0000" report "Falha: decremento basico" severity error;

        dec_veiculos <= '1';
        wait for 10 ns;
        dec_veiculos <= '0';
        assert veiculos_atual = "0000" report "Falha: underflow" severity error;

        for i in 0 to 20 loop
            inc_veiculos <= '1';
            wait for 10 ns;
        end loop;
        inc_veiculos <= '0';
        assert veiculos_atual = "1111" report "Falha: saturacao em 15" severity error;

        wait;
    end process;
end architecture;
