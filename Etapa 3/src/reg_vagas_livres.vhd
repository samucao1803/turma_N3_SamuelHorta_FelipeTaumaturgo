library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg_vagas_livres is
    port (
        clk                  : in  std_logic;
        reset                : in  std_logic;
        vagas_livres_entrada : in  std_logic_vector(3 downto 0);
        vagas_livres         : out std_logic_vector(3 downto 0)
    );
end entity;

architecture rtl of reg_vagas_livres is
    signal vagas_reg : std_logic_vector(3 downto 0) := (others => '0');
begin
    process (clk, reset)
    begin
        if reset = '1' then
            vagas_reg <= (others => '0');
        elsif rising_edge(clk) then
            vagas_reg <= vagas_livres_entrada;
        end if;
    end process;

    vagas_livres <= vagas_reg;
end architecture;
