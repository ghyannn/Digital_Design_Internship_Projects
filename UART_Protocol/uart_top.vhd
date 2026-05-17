library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity uart_top is
    Port (
        clk       : in STD_LOGIC;
        reset     : in STD_LOGIC;
        tx_start  : in STD_LOGIC;
        data_in   : in STD_LOGIC_VECTOR(7 downto 0);
        data_out  : out STD_LOGIC_VECTOR(7 downto 0);
        tx_done   : out STD_LOGIC;
        rx_done   : out STD_LOGIC
    );
end uart_top;

architecture Behavioral of uart_top is

    signal tx_line : STD_LOGIC;

    component uart_tx
        Port (
            clk       : in STD_LOGIC;
            reset     : in STD_LOGIC;
            tx_start  : in STD_LOGIC;
            data_in   : in STD_LOGIC_VECTOR(7 downto 0);
            tx        : out STD_LOGIC;
            tx_done   : out STD_LOGIC
        );
    end component;

    component uart_rx
        Port (
            clk       : in STD_LOGIC;
            reset     : in STD_LOGIC;
            rx        : in STD_LOGIC;
            data_out  : out STD_LOGIC_VECTOR(7 downto 0);
            rx_done   : out STD_LOGIC
        );
    end component;

begin

    TX_UNIT: uart_tx
        port map (
            clk => clk,
            reset => reset,
            tx_start => tx_start,
            data_in => data_in,
            tx => tx_line,
            tx_done => tx_done
        );

    RX_UNIT: uart_rx
        port map (
            clk => clk,
            reset => reset,
            rx => tx_line,
            data_out => data_out,
            rx_done => rx_done
        );

end Behavioral;