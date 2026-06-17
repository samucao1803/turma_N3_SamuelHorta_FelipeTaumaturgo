library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity reg_veiculos is
    port (
        clk            : in  std_logic;
        reset          : in  std_logic;
        inc_veiculos   : in  std_logic;
        dec_veiculos   : in  std_logic;
        veiculos_atual : out std_logic_vector(3 downto 0)
    );
end entity;

architecture rtl of reg_veiculos is
    signal veiculos_reg : unsigned(3 downto 0) := (others => '0');
begin
    process (clk, reset)
    begin
        if reset = '1' then
            veiculos_reg <= (others => '0');
        elsif rising_edge(clk) then
            if inc_veiculos = '1' and dec_veiculos = '0' then
                if veiculos_reg < 15 then
                    veiculos_reg <= veiculos_reg + 1;
                end if;
            elsif dec_veiculos = '1' and inc_veiculos = '0' then
                if veiculos_reg > 0 then
                    veiculos_reg <= veiculos_reg - 1;
                end if;
            end if;
        end if;
    end process;

    veiculos_atual <= std_logic_vector(veiculos_reg);
end architecture;
