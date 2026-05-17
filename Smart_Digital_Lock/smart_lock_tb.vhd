library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity smart_lock_tb is
end smart_lock_tb;

architecture Behavioral of smart_lock_tb is

    component lock_controller
        Port (
            clk        : in STD_LOGIC;
            reset      : in STD_LOGIC;
            enter_btn  : in STD_LOGIC;
            digit      : in STD_LOGIC_VECTOR(3 downto 0);
            unlock_led : out STD_LOGIC;
            alarm_led  : out STD_LOGIC
        );
    end component;

    signal clk        : STD_LOGIC := '0';
    signal reset      : STD_LOGIC := '0';
    signal enter_btn  : STD_LOGIC := '0';
    signal digit      : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal unlock_led : STD_LOGIC;
    signal alarm_led  : STD_LOGIC;

begin

    uut: lock_controller
        port map (
            clk => clk,
            reset => reset,
            enter_btn => enter_btn,
            digit => digit,
            unlock_led => unlock_led,
            alarm_led => alarm_led
        );

    -- Clock generation
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
    end process;

    -- Test cases
    stimulus: process
    begin
        -- Reset system
        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        wait for 20 ns;

        ------------------------------------------------
        -- WRONG ATTEMPT 1
        ------------------------------------------------
        digit <= "0001";
        enter_btn <= '1';
        wait for 10 ns;
        enter_btn <= '0';
        wait for 20 ns;

        digit <= "0001";
        enter_btn <= '1';
        wait for 10 ns;
        enter_btn <= '0';
        wait for 20 ns;

        digit <= "0001";
        enter_btn <= '1';
        wait for 10 ns;
        enter_btn <= '0';
        wait for 20 ns;

        digit <= "0001";
        enter_btn <= '1';
        wait for 10 ns;
        enter_btn <= '0';
        wait for 50 ns;

        ------------------------------------------------
        -- WRONG ATTEMPT 2
        ------------------------------------------------
        digit <= "0001";
        enter_btn <= '1';
        wait for 10 ns;
        enter_btn <= '0';
        wait for 20 ns;

        digit <= "0001";
        enter_btn <= '1';
        wait for 10 ns;
        enter_btn <= '0';
        wait for 20 ns;

        digit <= "0001";
        enter_btn <= '1';
        wait for 10 ns;
        enter_btn <= '0';
        wait for 20 ns;

        digit <= "0001";
        enter_btn <= '1';
        wait for 10 ns;
        enter_btn <= '0';
        wait for 50 ns;

        ------------------------------------------------
        -- WRONG ATTEMPT 3
        ------------------------------------------------
        digit <= "0001";
        enter_btn <= '1';
        wait for 10 ns;
        enter_btn <= '0';
        wait for 20 ns;

        digit <= "0001";
        enter_btn <= '1';
        wait for 10 ns;
        enter_btn <= '0';
        wait for 20 ns;

        digit <= "0001";
        enter_btn <= '1';
        wait for 10 ns;
        enter_btn <= '0';
        wait for 20 ns;

        digit <= "0001";
        enter_btn <= '1';
        wait for 10 ns;
        enter_btn <= '0';

        wait for 100 ns;

        wait;
    end process;

end Behavioral;