library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

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
    signal veiculos_reg : unsigned(3 downto 0) := (others => '0');
begin
    process (clk, reset)
        variable in_val : unsigned(3 downto 0);
    begin
        if reset = '1' then
            veiculos_reg <= (others => '0');

        elsif rising_edge(clk) then
            if (inc_veiculos = '1' and dec_veiculos = '0') or
               (dec_veiculos = '1' and inc_veiculos = '0') then

                in_val := unsigned(atualiza_veiculos);

                if in_val <= 9 then
                    veiculos_reg <= in_val;
                else
                    
                    if inc_veiculos = '1' then
                        veiculos_reg <= to_unsigned(9, 4);
                    else
                        veiculos_reg <= to_unsigned(0, 4);
                    end if;
                end if;
            else
                
                veiculos_reg <= veiculos_reg;
            end if;
        end if;
    end process;

    veiculos_atual <= std_logic_vector(veiculos_reg);
    veiculos       <= std_logic_vector(veiculos_reg);
end architecture;