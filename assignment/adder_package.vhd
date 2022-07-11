library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

package adder_package is
	component adder is
		port(cin,x,y : in std_logic;
    		 s,cout  : out std_logic);
	end component;
end adder_package;