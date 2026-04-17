library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use STD.textio.all;
use IEEE.std_logic_textio.all;


entity Project4_Test_Bench is
end entity Project4_Test_Bench;

architecture simple_TB of Project4_Test_Bench is

    constant RAM_DEPTH : natural := 104;
    constant RAM_WIDTH : natural := 20;
    subtype word_t is std_logic_vector(RAM_WIDTH - 1 downto 0);
    type ram_t is array (0 to RAM_DEPTH - 1) of word_t;

    impure function init_ram_from_file(FileName : STRING) return ram_t is
        file FileHandle : TEXT open READ_MODE is FileName;
        variable CurrentLine : LINE;
        variable TempWord    : std_logic_vector(RAM_WIDTH - 1 downto 0);
        variable Result      : ram_t := (others => (others => '0'));
    begin
        for i in 0 to RAM_DEPTH - 1 loop
            exit when endfile(FileHandle);
            readline(FileHandle, CurrentLine);
            hread(CurrentLine, TempWord);
            Result(i) := TempWord;
        end loop;
        file_close(FileHandle);
        return Result;
    end function;

    component Manchester_Encoder is
        port(
            master_reset    : in  std_logic := '1';
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
    end component;

    component Manchester_Decoder is
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
    end component;

    signal send_clk    : std_logic := '1';
    signal data_clk    : std_logic := '0';
    signal decoder_clk : std_logic := '0';
    signal reset       : std_logic := '1';

    constant data_period    : time := 50 ns;
    constant send_period    : time := 25 ns;
    constant decoder_period : time := 12500 ps;

    signal address : unsigned(7 downto 0) := (others => '0');
    signal TB_ROM  : ram_t := init_ram_from_file("man_dat.txt");

    signal master_reset    : std_logic := '1';
    signal bipolar_line    : std_logic;
    signal send_data       : std_logic;
    signal output_inhibit  : std_logic;
    signal encoder_enable  : std_logic;
    signal sync_select     : std_logic;
    signal data_word       : std_logic_vector(15 downto 0);
    signal fetch_data      : std_logic;

    signal cmd_data_out    : std_logic;
    signal take_data       : std_logic;
    signal send_word_out   : std_logic;
    signal data_word_out   : std_logic_vector(15 downto 0);
    signal parity_bit_out  : std_logic;

begin

    ENC : Manchester_Encoder
        port map(
            master_reset   => master_reset,
            send_clk       => send_clk,
            encoder_clk    => data_clk,
            encoder_enable => encoder_enable,
            output_inhibit => output_inhibit,
            sync_select    => sync_select,
            data_word      => data_word,
            fetch_data     => fetch_data,
            bipolar_out    => bipolar_line,
            send_data      => send_data
        );

    DEC : Manchester_Decoder
        port map(
            master_reset   => master_reset,
            data_clk       => data_clk,
            decoder_clk    => decoder_clk,
            bipolar_in     => bipolar_line,
            CMD_Data       => cmd_data_out,
            take_data      => take_data,
            send_word_out  => send_word_out,
            data_word_out  => data_word_out,
            parity_bit_out => parity_bit_out
        );

    send_clk    <= not send_clk    after send_period/2;
    data_clk    <= not data_clk    after data_period/2;
    decoder_clk <= not decoder_clk after decoder_period/2;

    reset_process : process is
    begin
        reset <= '1';
        output_inhibit <= '0';
        wait for 60 ns;
        reset <= '0';
        wait;
    end process reset_process;

    clocked_reset : process (data_clk) is
    begin
        if rising_edge(data_clk) then
            master_reset <= reset;
        end if;
    end process clocked_reset;

    data_word      <= TB_ROM(to_integer(address))(15 downto 0);
    sync_select    <= TB_ROM(to_integer(address))(17);
    encoder_enable <= TB_ROM(to_integer(address))(16);

    address_proc : process (data_clk) is
    begin
        if rising_edge(data_clk) then
            if master_reset = '1' then
                address <= (others => '0');
            elsif fetch_data = '1' then
                address <= address + 1;
            end if;
        end if;
    end process address_proc;

end architecture simple_TB;
