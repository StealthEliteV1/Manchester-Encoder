library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Manchester_Encoder is
    port(
        master_reset    : in  std_logic;
        send_clk        : in  std_logic;
        encoder_clk     : in  std_logic;
        encoder_enable  : in  std_logic;
        output_inhibit  : in  std_logic;
        sync_select     : in  std_logic;
        data_word       : in  std_logic_vector(15 downto 0);
        fetch_data      : out std_logic;
        bipolar_out     : out std_logic;
        send_data       : out std_logic
    );
end entity Manchester_Encoder;

architecture behavioral of Manchester_Encoder is

    type state_type is (S_RESET, S_READY, S_START, S_SHIFT_OUT);
    signal current_state : state_type;

    signal shift_reg      : std_logic_vector(19 downto 0);
    signal bit_counter    : unsigned(4 downto 0);
    signal enable_counter : unsigned(4 downto 0);
    signal serial_out     : std_logic;
    signal transmitting   : std_logic;
    signal send_data_int  : std_logic;
    signal fetch_data_int : std_logic;
    signal data_out       : std_logic;

begin

    bipolar_out <= (serial_out xor send_clk) when (transmitting = '1' and output_inhibit = '0') else '0';
    send_data   <= send_data_int;
    fetch_data  <= fetch_data_int;
    data_out    <= serial_out;

    fsm_proc : process(encoder_clk, master_reset)
        variable preamble  : std_logic_vector(2 downto 0);
        variable temp_word : std_logic_vector(18 downto 0);
        variable ones      : integer;
        variable par       : std_logic;
    begin
        if master_reset = '1' then
            current_state  <= S_RESET;
            shift_reg      <= (others => '0');
            bit_counter    <= (others => '0');
            enable_counter <= (others => '0');
            serial_out     <= '0';
            transmitting   <= '0';
            send_data_int  <= '0';
            fetch_data_int <= '0';

        elsif falling_edge(encoder_clk) then
            case current_state is

                when S_RESET =>
                    shift_reg      <= (others => '0');
                    bit_counter    <= (others => '0');
                    enable_counter <= (others => '0');
                    serial_out     <= '0';
                    transmitting   <= '0';
                    send_data_int  <= '0';
                    fetch_data_int <= '0';
                    current_state  <= S_READY;

                when S_READY =>
                    serial_out     <= '0';
                    transmitting   <= '0';
                    send_data_int  <= '0';
                    fetch_data_int <= '0';

                    if encoder_enable = '1' then
                        if enable_counter = 19 then
                            enable_counter <= (others => '0');
                            current_state  <= S_START;
                        else
                            enable_counter <= enable_counter + 1;
                        end if;
                    else
                        enable_counter <= (others => '0');
                    end if;

                when S_START =>
                    fetch_data_int <= '0';
                    send_data_int  <= '0';
                    transmitting   <= '0';
                    serial_out     <= '0';

                    if sync_select = '1' then
                        preamble := "011";
                    else
                        preamble := "010";
                    end if;

                    temp_word := preamble & data_word;

                    ones := 0;
                    for i in 0 to 18 loop
                        if temp_word(i) = '1' then
                            ones := ones + 1;
                        end if;
                    end loop;

                    if (ones mod 2) = 1 then
                        par := '1';
                    else
                        par := '0';
                    end if;

                    shift_reg   <= temp_word & par;
                    bit_counter <= (others => '0');
                    current_state <= S_SHIFT_OUT;

                when S_SHIFT_OUT =>
                    transmitting <= '1';
                    serial_out   <= shift_reg(19);
                    shift_reg    <= shift_reg(18 downto 0) & '0';
                    bit_counter  <= bit_counter + 1;

                    if bit_counter >= 3 then
                        send_data_int <= '1';
                    end if;

                    if bit_counter = 19 then
                        if encoder_enable = '1' then
                            fetch_data_int <= '1';
                            current_state  <= S_START;
                        else
                            current_state <= S_READY;
                        end if;
                    end if;

                when others =>
                    current_state <= S_RESET;

            end case;
        end if;
    end process fsm_proc;

end architecture behavioral;
