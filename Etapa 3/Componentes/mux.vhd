library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux is
    port (
        veiculos_subt     : in  std_logic_vector(3 downto 0);
        veiculos_adc      : in  std_logic_vector(3 downto 0);
        inc_veiculos      : in  std_logic;
        dec_veiculos      : in  std_logic;
        atualiza_veiculos : out std_logic_vector(3 downto 0)
    );
end entity;

architecture rtl of mux is
begin
    process (veiculos_subt, veiculos_adc, inc_veiculos, dec_veiculos)
    begin
        atualiza_veiculos <= (others => '0');

        if inc_veiculos = '1' and dec_veiculos = '0' then
            atualiza_veiculos <= veiculos_adc;
        elsif dec_veiculos = '1' and inc_veiculos = '0' then
            atualiza_veiculos <= veiculos_subt;
        end if;
    end process;
end architecture;
