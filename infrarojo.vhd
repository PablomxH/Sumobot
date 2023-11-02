library ieee;
use ieee.std_logic_1164.all;

entity infrarojo is 
    port (
        clk, infra1, infra2: in std_logic;
        outInfra1, outInfra2: out std_logic
    );
end entity;

architecture arqinfrarojo of infrarojo is
begin
    outInfra1 <= not infra1;
    outInfra2 <= not infra2;
end architecture;