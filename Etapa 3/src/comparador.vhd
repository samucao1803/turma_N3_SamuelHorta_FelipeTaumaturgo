library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity comparador is
    port (
        veiculos_atual        : in  std_logic_vector(3 downto 0);
        capacidade_atual      : in  std_logic_vector(3 downto 0);
        vaga_disponivel       : out std_logic;
        estacionamento_lotado : out std_logic;
        estacionamento_vazio  : out std_logic;
        saida_led0            : out std_logic;
        saida_led1            : out std_logic;
        saida_led2            : out std_logic
    );
end entity;

architecture rtl of comparador is
begin
    vaga_disponivel       <= '1' when unsigned(veiculos_atual) < unsigned(capacidade_atual) else '0';
    estacionamento_lotado <= '1' when unsigned(veiculos_atual) >= unsigned(capacidade_atual) else '0';
    estacionamento_vazio  <= '1' when unsigned(veiculos_atual) = 0 else '0';

    saida_led0 <= '1' when unsigned(veiculos_atual) < unsigned(capacidade_atual) else '0';
    saida_led1 <= '1' when (unsigned(capacidade_atual) - unsigned(veiculos_atual)) <= 2 and unsigned(veiculos_atual) < unsigned(capacidade_atual) else '0';
    saida_led2 <= '1' when unsigned(veiculos_atual) >= unsigned(capacidade_atual) else '0';
end architecture;
