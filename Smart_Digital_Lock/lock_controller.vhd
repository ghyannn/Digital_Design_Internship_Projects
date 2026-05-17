library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity lock_controller is
    Port (
        clk        : in STD_LOGIC;
        reset      : in STD_LOGIC;
        enter_btn  : in STD_LOGIC;
        digit      : in STD_LOGIC_VECTOR(3 downto 0);
        unlock_led : out STD_LOGIC;
        alarm_led  : out STD_LOGIC
    );
end lock_controller;

architecture Behavioral of lock_controller is

    type state_type is (IDLE, INPUT1, INPUT2, INPUT3, INPUT4, CHECK, UNLOCK, ALARM);
    signal state : state_type := IDLE;

    signal d1, d2, d3, d4 : STD_LOGIC_VECTOR(3 downto 0);
    signal attempts : integer range 0 to 3 := 0;

begin

process(clk, reset)
begin
    if reset = '1' then
        state <= IDLE;
        attempts <= 0;
        unlock_led <= '0';
        alarm_led <= '0';

    elsif rising_edge(clk) then
        case state is

            when IDLE =>
                unlock_led <= '0';
                alarm_led <= '0';
                if enter_btn = '1' then
                    d1 <= digit;
                    state <= INPUT1;
                end if;

            when INPUT1 =>
                if enter_btn = '1' then
                    d2 <= digit;
                    state <= INPUT2;
                end if;

            when INPUT2 =>
                if enter_btn = '1' then
                    d3 <= digit;
                    state <= INPUT3;
                end if;

            when INPUT3 =>
                if enter_btn = '1' then
                    d4 <= digit;
                    state <= CHECK;
                end if;

            when CHECK =>
                if d1 = "0001" and d2 = "0010" and d3 = "0011" and d4 = "0100" then
                    state <= UNLOCK;
                else
                    attempts <= attempts + 1;
                    if attempts = 2 then
                        state <= ALARM;
                    else
                        state <= IDLE;
                    end if;
                end if;

            when UNLOCK =>
                unlock_led <= '1';

            when ALARM =>
                alarm_led <= '1';

            when others =>
                state <= IDLE;

        end case;
    end if;
end process;

end Behavioral;