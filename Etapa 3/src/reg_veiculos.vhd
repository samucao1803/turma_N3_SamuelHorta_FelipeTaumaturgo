library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg_veiculos is
    port (
        clk               : in  std_logic;
        reset             : in  std_logic;
        inc_veiculos      : in  std_logic;
        dec_veiculos      : in  std_logic;
        atualiza_veiculos : in  std_logic_vector(3 downto 0);
        veiculos_atual    : out std_logic_vector(3 downto 0);
        veiculos          : out std_logic_vector(3 downto 0)
    );
end entity;

architecture rtl of reg_veiculos is
    signal veiculos_reg : std_logic_vector(3 downto 0) := (others => '0');
begin
    process (clk, reset)
    begin
        if reset = '1' then
            veiculos_reg <= (others => '0');
        elsif rising_edge(clk) then
            if inc_veiculos = '1' and dec_veiculos = '0' then
                veiculos_reg <= atualiza_veiculos;
            elsif dec_veiculos = '1' and inc_veiculos = '0' then
                veiculos_reg <= atualiza_veiculos;
            end if;
        end if;
    end process;

    veiculos_atual <= veiculos_reg;
    veiculos       <= veiculos_reg;
end architecture;
