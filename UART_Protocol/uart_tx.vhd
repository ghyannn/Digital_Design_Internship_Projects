library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity uart_tx is
    Port (
        clk       : in STD_LOGIC;
        reset     : in STD_LOGIC;
        tx_start  : in STD_LOGIC;
        data_in   : in STD_LOGIC_VECTOR(7 downto 0);
        tx        : out STD_LOGIC;
        tx_done   : out STD_LOGIC
    );
end uart_tx;

architecture Behavioral of uart_tx is

    type state_type is (IDLE, START_BIT, DATA_BITS, STOP_BIT);
    signal state : state_type := IDLE;

    signal bit_index : integer range 0 to 7 := 0;
    signal tx_reg    : STD_LOGIC := '1';

begin

    tx <= tx_reg;

    process(clk, reset)
    begin
        if reset = '1' then
            state <= IDLE;
            tx_reg <= '1';
            tx_done <= '0';
            bit_index <= 0;

        elsif rising_edge(clk) then
            case state is

                when IDLE =>
                    tx_reg <= '1';
                    tx_done <= '0';

                    if tx_start = '1' then
                        state <= START_BIT;
                    end if;

                when START_BIT =>
                    tx_reg <= '0';
                    bit_index <= 0;
                    state <= DATA_BITS;

                when DATA_BITS =>
                    tx_reg <= data_in(bit_index);

                    if bit_index = 7 then
                        state <= STOP_BIT;
                    else
                        bit_index <= bit_index + 1;
                    end if;

                when STOP_BIT =>
                    tx_reg <= '1';
                    tx_done <= '1';
                    state <= IDLE;

            end case;
        end if;
    end process;

end Behavioral;