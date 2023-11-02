library ieee;
use ieee.std_logic_1164.all;

entity HCSR05 is 
	port(
	clk,rst,echo:	in std_logic;
	trig,led:	out std_logic
	);
end entity;

architecture arqHCSR05 of HCSR05 is

signal clkl1, clkl2, tr : std_logic;

begin
	u1: entity work.divf(arqdivf) generic map(25) port map(clk,clkl1);
	u2: entity work.senal(arqsenal) port map(clk,clkl2);
	u3: entity work.trigger(arqtrigger) port map(clkl2,rst,echo,tr);
	trig <= tr;
	u4: entity work.contador(arqcontador) port map(echo,clkl1,tr,led);
	
end architecture;