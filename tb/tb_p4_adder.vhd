library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.math_real.all;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL; -- Optional, used in some older codebases
use IEEE.STD_LOGIC_UNSIGNED.ALL; -- Optional, used in some older codebases
use IEEE.NUMERIC_STD.ALL;


entity TB_P4_ADDER is
end TB_P4_ADDER;

architecture TEST of TB_P4_ADDER is
	
	-- P4 component declaration
	component P4_ADDER is
		generic (
			NBIT : 	integer := 32;
                        NBIT_PER_BLOCK: integer := 4);
		port (
			A :    	in	std_logic_vector(NBIT-1 downto 0);
			B :    	in	std_logic_vector(NBIT-1 downto 0);
			Cin :	in	std_logic;
			S :    	out	std_logic_vector(NBIT-1 downto 0);
			Cout :	out	std_logic);
	end component;

        constant NBIT : integer := 32;
        constant NBIT_PER_BLOCK : integer := 4;
        signal A1, B1 : std_logic_vector (NBIT-1 downto 0);
        signal ci : std_logic;
	signal sum : std_logic_vector (NBIT downto 0);
        
begin
	-- P4 instantiation
         DUT: P4_ADDER
         generic map (32, 4)
         port map (A1, B1, ci, sum(NBIT-1 downto 0), sum(NBIT));

         --PROCESS FOR TESTING TEST
         
         ptest: process
         begin

           A1 <= (others => '1');
           B1 <= (others => '1');
           ci <= '1';
           wait for 20 ns;

           A1 <= "00000000000000000000000000011110";
           B1 <= "00000000000000000000000000001110";
           ci <= '1';
           wait for 20 ns;

           A1 <= std_logic_vector(to_unsigned(10,32));
           B1 <= std_logic_vector(to_unsigned(7,32));
           ci <= '1';
           wait for 20 ns;

           A1 <= std_logic_vector(to_unsigned(12,32));
           B1 <= std_logic_vector(to_unsigned(12,32));
           ci <= '1';
           wait for 20 ns;
           
           A1 <= "00000000000000000000000000001110";
           B1 <= "00000000000000000000000001111111";
           ci <= '0';
           wait for 30 ns;
          

           A1 <= "00000000000000000000000000000001";
           B1 <= (others =>'1');
           ci <= '0';
            wait for 20 ns;
           

           A1 <= (others => '1');
           B1 <= (others => '0');
           ci <= '1';
           wait for 20 ns;
           

           A1 <= "00000000000000000000000001000000";
           B1 <= "00000000000000000000000001110110";
           ci <= '0';
           wait for 20 ns;
           

           A1 <= "00000000000000000000000000000101";
           B1 <= "00000000000000000000000001100110";
           ci <= '0';
           

           wait;

        end process ptest;
         
	
end TEST;

configuration P4ADDER_TEST of TB_P4_ADDER is
  for TEST
    for DUT: P4_ADDER
         use configuration WORK.CFG_P4ADDER;
    end for;
  end for;
end configuration;
