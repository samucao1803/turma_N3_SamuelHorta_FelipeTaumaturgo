library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity reg_capacidade is
    port (
        clk                 : in  std_logic;
        reset               : in  std_logic;
        sw0                 : in  std_logic;
        sw1                 : in  std_logic;
        sw2                 : in  std_logic;
        sw3                 : in  std_logic;
        vagas_livres_entrada: out std_logic_vector(3 downto 0)
    );
end entity;

architecture rtl of reg_capacidade is
    signal capacidade_reg : unsigned(3 downto 0) := (others => '0');
begin
    process (clk, reset)
        variable sw_vec : std_logic_vector(3 downto 0);
        variable sw_int : integer;
    begin
        if reset = '1' then
            capacidade_reg <= (others => '0');

        elsif rising_edge(clk) then
            
            sw_vec := sw3 & sw2 & sw1 & sw0;
            sw_int := to_integer(unsigned(sw_vec));

            
            if sw_int >= 9 then
                capacidade_reg <= to_unsigned(9, 4);
            else
                capacidade_reg <= unsigned(sw_vec);
            end if;
        end if;
    end process;

    vagas_livres_entrada <= std_logic_vector(capacidade_reg);
end architecture;
