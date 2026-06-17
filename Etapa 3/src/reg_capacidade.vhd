library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg_capacidade is
    port (
        clk                : in  std_logic;
        reset              : in  std_logic;
        capacidade_entrada : in  std_logic_vector(3 downto 0);
        capacidade_atual   : out std_logic_vector(3 downto 0)
    );
end entity;

architecture rtl of reg_capacidade is
    signal capacidade_reg : std_logic_vector(3 downto 0) := (others => '0');
begin
    process (clk, reset)
    begin
        if reset = '1' then
            capacidade_reg <= (others => '0');
        elsif rising_edge(clk) then
            capacidade_reg <= capacidade_entrada;
        end if;
    end process;

    capacidade_atual <= capacidade_reg;
end architecture;
