library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use work.adder_package.all;


entity assignment is
port(
	x    :in std_logic_vector(2 downto 0) ;
	y    :in std_logic_vector(2 downto 0) ;
	s   :out std_logic_vector(3 downto 0);
	BCD :out std_logic_vector(13 downto 0));
end assignment;

architecture arch of assignment is 

signal c: std_logic_vector(2 downto 0);
signal tmp:std_logic_vector(3 downto 0);

begin
stage0: adder port map('0',x(0),y(0),tmp(0),c(0));
stage1: adder port map(c(0),x(1),y(1),tmp(1),c(1));
stage2: adder port map(c(1),x(2),y(2),tmp(2),tmp(3));
s <= tmp;

process(tmp)
begin
case tmp is
when "0000" =>
BCD <= "10000001000000"; --0
when "0001" =>
BCD <= "10000001111001"; --1
when "0010" =>
BCD <= "10000000100100"; --2
when "0011" =>
BCD <= "10000000110000"; --3
when "0100" =>
BCD <= "10000000011001"; --4
when "0101" =>
BCD <= "10000000010010"; --5
when "0110" =>
BCD <= "10000000000010"; --6
when "0111" =>
BCD <= "10000001111000"; --7
when "1000" =>
BCD <= "10000000000000"; --8
when "1001" =>
BCD <= "10000000010000"; --9
when "1010" =>
BCD <= "11110011000000"; ---10
when "1011" =>
BCD <= "11110011111001"; --11
when "1100" =>
BCD <= "11110010100100"; --12
when "1101" =>
BCD <= "11110010110000"; --13
when "1110" =>
BCD <= "11110010011001"; --14
when others => 
BCD <= "00000000000000";
end case;
 
end process;


end arch;


























