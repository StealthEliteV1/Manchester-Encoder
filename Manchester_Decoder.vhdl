library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Manchester_Decoder is
    port(
        master_reset   : in  std_logic;
        data_clk       : in  std_logic;
        decoder_clk    : in  std_logic;
        bipolar_in     : in  std_logic;
        CMD_Data       : out std_logic;
        take_data      : out std_logic;
        send_word_out  : out std_logic;
        data_word_out  : out std_logic_vector(15 downto 0);
        parity_bit_out : out std_logic
    );
end entity Manchester_Decoder;

architecture behavioral of Manchester_Decoder is

    signal data_in_1         : std_logic;
    signal data_in_2         : std_logic;
    signal transition_data1  : std_logic;
    signal transition_data2  : std_logic;
    signal sample_data       : std_logic;

    signal phase_cnt : unsigned(1 downto 0);
    signal armed    : std_logic;
    signal idle_cnt : unsigned(3 downto 0);

    type state_t is (S_IDLE, S_PRE1, S_PRE2, S_DATA, S_PARITY);
    signal state : state_t;

    signal shift_reg  : std_logic_vector(15 downto 0);
    signal bit_cnt    : unsigned(4 downto 0);
    signal par_calc   : std_logic;

    signal cmd_int       : std_logic;
    signal take_int      : std_logic;
    signal send_int      : std_logic;
    signal data_out_int  : std_logic_vector(15 downto 0);
    signal parity_int    : std_logic;

begin

    transition_data1 <= not(data_in_1 xor data_in_2);

    detect_data_rtl : process(decoder_clk) is
    begin
        if rising_edge(decoder_clk) then
            if master_reset = '1' then
                data_in_1        <= '0';
                data_in_2        <= '0';
                transition_data2 <= '0';
                sample_data      <= '0';
            else
                data_in_1        <= bipolar_in;
                data_in_2        <= data_in_1;
                transition_data2 <= transition_data1;
                if transition_data2 = '0' and transition_data1 = '1' then
                    sample_data <= not sample_data;
                else
                    sample_data <= sample_data;
                end if;
            end if;
        end if;
    end process detect_data_rtl;

    fsm_proc : process(decoder_clk) is
    begin
        if rising_edge(decoder_clk) then
            if master_reset = '1' then
                phase_cnt     <= (others => '0');
                armed         <= '0';
                idle_cnt      <= (others => '0');
                state         <= S_IDLE;
                shift_reg     <= (others => '0');
                bit_cnt       <= (others => '0');
                par_calc      <= '0';
                cmd_int       <= '0';
                take_int      <= '0';
                send_int      <= '0';
                data_out_int  <= (others => '0');
                parity_int    <= '0';
            else
                send_int <= '0';

                if armed = '0' then
                    phase_cnt <= (others => '0');
                    state     <= S_IDLE;
                    take_int  <= '0';

                    if data_in_1 = '0' then
                        if idle_cnt < 8 then
                            idle_cnt <= idle_cnt + 1;
                        end if;
                    else
                        if idle_cnt >= 2 then
                            armed     <= '1';
                            phase_cnt <= "01";
                            par_calc  <= '0';
                            bit_cnt   <= (others => '0');
                        end if;
                        idle_cnt <= (others => '0');
                    end if;
                else
                    phase_cnt <= phase_cnt + 1;

                    if phase_cnt = "11" then
                        case state is
                            when S_IDLE =>
                                if data_in_1 = '0' then
                                    state    <= S_PRE1;
                                    par_calc <= '0';
                                else
                                    armed    <= '0';
                                    idle_cnt <= (others => '0');
                                end if;

                            when S_PRE1 =>
                                if data_in_1 = '1' then
                                    state    <= S_PRE2;
                                    par_calc <= par_calc xor '1';
                                else
                                    armed    <= '0';
                                    idle_cnt <= (others => '0');
                                    state    <= S_IDLE;
                                end if;

                            when S_PRE2 =>
                                cmd_int  <= data_in_1;
                                par_calc <= par_calc xor data_in_1;
                                state    <= S_DATA;
                                bit_cnt  <= (others => '0');
                                take_int <= '1';

                            when S_DATA =>
                                shift_reg <= shift_reg(14 downto 0) & data_in_1;
                                par_calc  <= par_calc xor data_in_1;
                                bit_cnt   <= bit_cnt + 1;
                                if bit_cnt = 15 then
                                    state <= S_PARITY;
                                end if;

                            when S_PARITY =>
                                parity_int    <= data_in_1;
                                take_int      <= '0';
                                data_out_int  <= shift_reg;
                                send_int      <= '1';
                                armed         <= '0';
                                idle_cnt      <= (others => '0');
                                state         <= S_IDLE;

                            when others =>
                                state    <= S_IDLE;
                                armed    <= '0';
                                idle_cnt <= (others => '0');
                        end case;
                    end if;
                end if;
            end if;
        end if;
    end process fsm_proc;

    CMD_Data       <= cmd_int;
    take_data      <= take_int;
    send_word_out  <= send_int;
    data_word_out  <= data_out_int;
    parity_bit_out <= parity_int;

end architecture behavioral;
