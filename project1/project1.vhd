

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;




Entity project1 is
    Port (sens1:std_logic;
	       srv:out std_logic;
	       motion:in std_logic;
	       sens: in STD_LOGIC;
	         clk: in STD_LOGIC;
          reset: in STD_LOGIC;
           BCD: out  STD_LOGIC_VECTOR (6 downto 0);
           BCD1: out  STD_LOGIC_VECTOR (6 downto 0);
			  led:out STD_LOGIC);
End project1;

Architecture Behavioral of project1 is
signal q:integer range 0 to 1000000;
signal ct:integer range 0 to 200000;
signal set:std_logic := '1';
signal ps:integer range 0 to 1000;
signal ld: std_logic :='0';
component servo is
  port (
    clk : in std_logic;
    rst : in std_logic;
    position : in integer range 0 to 999;
    pwm : out std_logic
  );
end component;
begin
     led <= ld;
     sel: servo port map(clk,set,ps,srv);
     process(motion,clk,sens)
	  variable sc:integer range 0 to 1;
	  variable sc1:integer range 0 to 1;
	  begin 
	      if(clk' event and clk = '1') then
			    ct <= ct+1;
				 if(ct = 200000) then 
				    ct<= 0;
					 if(sens = '0' and sc =0) then 
					     set <= '0' or ld or reset;
						  ps <= 100;
						  sc:= 1;
					 else if(motion = '1' and sc1 =0) then 
					     set <= '0' or ld or reset;
						  ps <= 950;
						  sc1:= 1;
					 else 
					     set<= '1';
					 end if;
					 end if;
				 end if;
			end if;
			if(sens = '1') then
			     sc:=0;
			end if;
			if(motion = '0') then
			     sc1:=0;
			end if;
	end process;
PROCESS (clk,sens,sens1,reset)
variable f1:integer range 0 to 1;
variable f:integer range 0 to 1;
variable n1:integer range -1 to 10 :=0;
variable n2:integer range -1 to 10 :=0;

begin

if(reset='1') then 
         n1:=0;
         n2:=0;
         ld <= '0';
		
else 
		  	if (clk' EVENT and clk='1' )then
            q <=q+1;
            if (q= 1000000) then 
                q <= 0;
 
               if(sens='0' and f=0 and ld = '0')then
                   n1:=n1+1;
                   f:=1;

                   if(n1=10)then 
                       n1:=0;
                       n2:=n2+1;
                       if (n2=10)then 
                           n2:=0;

                       end if;
                   end if;
            else
               if(sens1='0' and f1=0 )then
                    n1:=n1-1;
                    f1:=1;

                    if(n1<0)then 
                        n1:=9;
                        n2:=n2-1;
                        if(n2<0)then 
                           n2:=0;
                           n1:=0;

                        end if;
                     end if;
               end if;
					end if;
           end if;
    end if;
end if;

if (sens1='1') then
f1:=0;
end if;

if (sens='1') then
f:=0;
end if;

case n1 is
when 0 =>
BCD1 <="1000000"; --0
when 1 =>
BCD1 <= "1111001"; --1
when 2 =>
BCD1 <= "0100100"; --2
when 3 =>
BCD1 <= "0110000"; --3
when 4 =>
BCD1 <= "0011001"; --4
when 5 =>
BCD1 <= "0010010"; --5
when 6 =>
BCD1 <= "0000010"; --6
when 7 =>
BCD1 <= "1111000"; --7
when 8 =>
BCD1 <= "0000000"; --8
when 9 =>
BCD1 <= "0010000"; --9
when others =>null;
end case;



case n2 is
when 0 =>
BCD <="1000000";ld<='0'; --0
when 1 =>
BCD <= "1111001";ld<='0'; --1
when 2 =>
BCD <= "0100100";ld<='0'; --2
when 3 =>
BCD <= "0110000";ld<='0'; --3
when 4 =>
BCD <= "0011001";ld<='0'; --4
when 5 =>
BCD <= "0010010"; ld<='1';--5
when 6 =>
BCD <= "0000010"; --6
when 7 =>
BCD <= "1111000"; --7
when 8 =>
BCD <= "0000000"; --8
when 9 =>
BCD <= "0010000"; --9
when others =>null;
end case;

end process;	
end Behavioral;





















