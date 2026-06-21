library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity subtrator is
    port (
        veiculos           : in  std_logic_vector(3 downto 0);
        veiculos_menos_um  : out std_logic_vector(3 downto 0)
    );
end entity;

architecture rtl of subtrator is
begin
    veiculos_menos_um <= std_logic_vector(unsigned(veiculos) - 1);
end architecture;
