library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity calculador_vagas is
    port (
        capacidade_atual : in  std_logic_vector(3 downto 0);
        veiculos_atual   : in  std_logic_vector(3 downto 0);
        vagas_livres     : out std_logic_vector(3 downto 0)
    );
end entity;

architecture rtl of calculador_vagas is
    signal capacidade_u : unsigned(3 downto 0);
    signal veiculos_u   : unsigned(3 downto 0);
begin
    capacidade_u <= unsigned(capacidade_atual);
    veiculos_u   <= unsigned(veiculos_atual);

    vagas_livres <= std_logic_vector(capacidade_u - veiculos_u) when capacidade_u >= veiculos_u else (others => '0');
end architecture;
