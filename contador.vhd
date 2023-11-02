library ieee;
use ieee.std_logic_1164.all;

entity contador is 
	port(
	echo,clk1,rst:	in std_logic;
	salida:	out std_logic:= '0'
	);
end entity;

architecture arqcontador of contador is

signal conteo: integer range 0 to 12000:= 0;

begin
	process(echo,clk1,rst)
		begin
			if(rst = '1') then
				conteo <= 0;
				salida <= '0';
			elsif rising_edge(clk1) then
				if (echo = '1') then
					conteo <= conteo + 1;
					salida<= '0';
				else
					if ((conteo>=100) and (conteo<941)) then --2-15 cm
						salida <= '1';
					else
						salida <= '0';
					end if;
				end if;
			end if;
	end process;
end architecture;
		