
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.round;

entity servo is
  port (
    clk : in std_logic;
    rst : in std_logic;
    position : in integer range 0 to 999;
    pwm : out std_logic
  );
end servo;

architecture rtl of servo is

  constant max_count : integer := 30000;
  constant cycles_per_step : positive := 30;

  constant counter_max : integer := 200000;
  
  signal counter : integer range 0 to counter_max;

  signal want_cycle : integer range 0 to max_count;

begin

  COUNTER_PROC : process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        counter <= 0;

      else
        if counter < counter_max then
          counter <= counter + 1;
        else
          counter <= 0;
        end if;

      end if;
    end if;
  end process;

  PWM_p : process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        pwm <= '0';

      else
        pwm <= '0';

        if counter < want_cycle then
          pwm <= '1';
        end if;

      end if;
    end if;
  end process;

  DUTY_CYCLE_PROC : process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        want_cycle <= 0;

      else
        want_cycle <= position * cycles_per_step;

      end if;
    end if;
  end process;

end architecture;




















