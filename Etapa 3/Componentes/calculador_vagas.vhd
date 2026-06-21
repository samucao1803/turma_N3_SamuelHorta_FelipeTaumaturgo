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
begin
    vagas_livres <= std_logic_vector(unsigned(capacidade_atual) - unsigned(veiculos_atual))
        when unsigned(capacidade_atual) >= unsigned(veiculos_atual)
        else (others => '0');
end architecture;
