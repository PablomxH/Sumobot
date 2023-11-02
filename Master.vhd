library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Master is
    port (
		clk 				: in STD_LOGIC;
		infra_1,infra_2		: in STD_LOGIC;
		outInfra1,outInfra2	: out STD_LOGIC;		--salida leds (ver si funciona)
		echo_1,rst			: in STD_LOGIC;
		trig_1		 		: out STD_LOGIC;
		echo_2				: in STD_LOGIC;
		trig_2		 		: out STD_LOGIC;
		ultra1,ultra2			: out STD_LOGIC;		--salida leds (ver si funciona)
		
		motor 				: out STD_LOGIC_VECTOR(3 downto 0);
		y					: out STD_LOGIC_VECTOR(2 downto 0)
);
end entity;

architecture functional of Master is 

signal delayStart, done, done2, done3: STD_LOGIC;					--Señal de inicio Delay y señal de delay cumplido (done)	
signal counterDelay : integer range 0 to 250000000 := 0; --Contador del delay a 2.5s

signal outInfra1_entity, outInfra2_entity, ultra_1_entity, ultra_2_entity : STD_LOGIC;

type states is (S0, S1, S2, S3, S4);
    
signal state_p, state_f : states := S0;

begin
	ultra1 <= ultra_1_entity;
	ultra2 <= ultra_2_entity;
	outInfra1 <= outInfra1_entity;
	outInfra2 <= outInfra2_entity;
	
	Seguidores_de_linea: entity work.infrarojo(arqinfrarojo) port map(clk,infra_1,infra_2,outInfra1_entity,outInfra2_entity);		
	ultrasonico_1: entity work.HCSR05(arqHCSR05) port map(clk,rst,echo_1,trig_1,ultra_1_entity);
	ultrasonico_2: entity work.HCSR05(arqHCSR05) port map(clk,rst,echo_2,trig_2,ultra_2_entity);	
		
	Delay : process(clk)		--Delay para la maquina de estados
    begin
        if rising_edge(clk) then
            if delayStart = '1' then
                if (counterDelay = 25000000) and (state_p /= S0) and (state_p /= S4) then  -- Valor del reloj, Delay de 2s (2.5/20ns) 1/50MHz=20ns
                    counterDelay <= 0;
                    done <= '1';
				  done2 <= '0';
				  done3 <= '0';
			   elsif counterDelay = 250000000 then  -- Valor del reloj, Delay de 5s (2.5/20ns) 1/50MHz=20ns
                    counterDelay <= 0;
                    done2 <= '1';
				  done <= '0';
				  done3 <= '0';
			   elsif (counterDelay = 150000000) and (state_p = S4) then  -- Valor del reloj, Delay de 5s (2.5/20ns) 1/50MHz=20ns
                    counterDelay <= 0;
                    done3 <= '1';
				  done2 <= '0';
				  done <= '0';	  
                else
                    counterDelay <= counterDelay + 1;
                    done <= '0';
				  done2 <= '0';
                end if;
            end if;
        end if;
    end process;
	
    Main: process (outInfra1_entity, outInfra2_entity, ultra_1_entity, ultra_2_entity ,state_p)	 -- Maquina de estados principal
    begin
        if rising_edge(clk) then
			
            case state_p is
                when S0 => y <= "001";	--Estado 1, Delay 5 segundos antes de repartir fuego.
				motor(0)<= '0';
				motor(1)<= '0';
				motor(2)<= '0';
				motor(3)<= '0';
				delayStart <= '1';
				if done2 = '1' then
					state_f <= S1;
				end if;
				
				when S1 => y <= "101";	--Estado 2, Default adelante
				motor(0)<= '0';
				motor(1)<= '1';
				motor(2)<= '0';
				motor(3)<= '1';
				if (ultra_1_entity = '1' and state_p = S1) then
					state_f <= S2;
				end if;
				if (ultra_2_entity = '1' and state_p = S1) then
					state_f <= S3;
				end if;
				if ((outInfra1_entity = '1' or outInfra2_entity = '1'))and (state_p = S1) then
					state_f <= S4;
				end if;
					
                when S2 => y <= "010";  -- Estado 2, Ultrasonico1
				motor(0)<= '0';
				motor(1)<= '1';
				motor(2)<= '1';
				motor(3)<= '0';
				delayStart <= '1';
				if done = '1' then
					state_f <= S1;
				end if;	

                when S3 => y <= "100"; -- Estado 3, Ultrasonico2
				motor(0)<= '1';
				motor(1)<= '0';
				motor(2)<= '0';
				motor(3)<= '1';
				delayStart <= '1';
				if done = '1' then
					state_f <= S1;
				end if;	

                when others => y <= "000"; -- Estado 3, Infrarrojos	 Atras
				motor(0)<= '1';
				motor(1)<= '0';
				motor(2)<= '1';
				motor(3)<= '0';
				delayStart <= '1';
				if done3 = '1' then
					state_f <= S2;
				end if;				
				if (ultra_1_entity = '1' and state_p = S4) then
					state_f <= S2;
				end if;
				if (ultra_2_entity = '1' and state_p = S4) then
					state_f <= S3;
				end if;
				if ((outInfra1_entity = '1' or outInfra2_entity = '1'))and (state_p = S4) then
					state_f <= S4;
				end if;
            end case;
        end if;
    end process;
    
	REG: process(clk)
	begin
		if falling_edge(clk) then				
				state_p <= state_f;
		end if;
	end process;  
		
end architecture;