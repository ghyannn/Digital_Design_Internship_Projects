library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity uart_rx is
    Port (
        clk       : in STD_LOGIC;
        reset     : in STD_LOGIC;
        rx        : in STD_LOGIC;
        data_out  : out STD_LOGIC_VECTOR(7 downto 0);
        rx_done   : out STD_LOGIC
    );
end uart_rx;

architecture Behavioral of uart_rx is

    type state_type is (IDLE, DATA_BITS, STOP_BIT);
    signal state : state_type := IDLE;

    signal bit_index : integer range 0 to 7 := 0;
    signal data_reg  : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');

begin

    data_out <= data_reg;

    process(clk, reset)
    begin
        if reset = '1' then
            state <= IDLE;
            rx_done <= '0';
            bit_index <= 0;
            data_reg <= (others => '0');

        elsif rising_edge(clk) then
            case state is

                when IDLE =>
                    rx_done <= '0';

                    if rx = '0' then   -- start bit detected
                        bit_index <= 0;
                        state <= DATA_BITS;
                    end if;

                when DATA_BITS =>
                    data_reg(bit_index) <= rx;

                    if bit_index = 7 then
                        state <= STOP_BIT;
                    else
                        bit_index <= bit_index + 1;
                    end if;

                when STOP_BIT =>
                    rx_done <= '1';
                    state <= IDLE;

            end case;
        end if;
    end process;

end Behavioral;