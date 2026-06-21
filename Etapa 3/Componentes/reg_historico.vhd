library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg_historico is
    port (
        clk              : in  std_logic;
        reset            : in  std_logic;
        load_historico   : in  std_logic;
        historico_entrada: in  std_logic_vector(7 downto 0);
        historico_atual  : out std_logic_vector(7 downto 0)
    );
end entity;

architecture rtl of reg_historico is
    signal historico_reg : std_logic_vector(7 downto 0) := (others => '0');
begin
    process (clk, reset)
    begin
        if reset = '1' then
            historico_reg <= (others => '0');
        elsif rising_edge(clk) then
            if load_historico = '1' then
                historico_reg <= historico_entrada;
            end if;
        end if;
    end process;

    historico_atual <= historico_reg;
end architecture;
