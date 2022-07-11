library ieee;
use ieee.std_logic_1164.all;

entity adder is 
port(cin,x,y : in std_logic;
     s,cout  : out std_logic);
end adder;

architecture arch of adder is
begin 
	s<= x xor y xor cin;
	cout<=(x and y)or(cin and x)or(cin and y);
end arch;




