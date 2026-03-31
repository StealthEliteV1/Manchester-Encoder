library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use STD.textio.all; -- Required for file I/O
use IEEE.std_logic_textio.all;


entity Project3_Test_Bench is
end entity Project3_Test_Bench;

architecture simple_TB of Project3_Test_Bench is
	----------------------------------------------------------------------------------
	------------------------ Initialize Read Only Code Memory ------------------------
	----------------------------------------------------------------------------------
    --Required for opening and reading and external file
    constant RAM_DEPTH : natural := 104;
    constant RAM_WIDTH : natural := 20;
    subtype word_t is std_logic_vector(RAM_WIDTH - 1 downto 0);
    type ram_t is array (0 to RAM_DEPTH - 1) of word_t;
    
    -- Function to read a file and return a ram_t array
    impure function init_ram_from_file(FileName : STRING) return ram_t is
        file FileHandle : TEXT open READ_MODE is FileName;
        variable CurrentLine : LINE;
        variable TempWord    : std_logic_vector(RAM_WIDTH - 1 downto 0);
        variable Result      : ram_t := (others => (others => '0'));
        variable ReadValue   : natural; -- For reading decimal integers
    
    begin
        for i in 0 to RAM_DEPTH - 1 loop
            exit when endfile(FileHandle);
            readline(FileHandle, CurrentLine);
            -- Use standard read for decimal integers or hread for hex (if available/using specific libraries)
            -- The example below reads decimal integers
            --read(CurrentLine, ReadValue); 
            --Result(i) := std_logic_vector(to_unsigned(ReadValue, RAM_WIDTH));
    
            -- If reading hexadecimal values (common for memory init), you might use:
            hread(CurrentLine, TempWord); 
            Result(i) := TempWord;
        end loop;
        file_close(FileHandle);
        return Result;
    end function;
	----------------------------------------------------------------------------------
	----------------------------------------------------------------------------------
	
    --Component Declaration for the UUT
	component Manchester_Encoder is
		port(
			master_reset : in std_logic := '1'; --Controller Reset
			send_clk : in std_logic;
			encoder_clk : in std_logic; 
			encoder_enable : in std_logic; --encoder enable input, must be high for 20 bit durations
			output_inhibit : in std_logic; --inhibits bipolar_out but does not pause controller
			sync_select : in std_logic; --input that tells controller wither word to be sent is a command or data (appends a different sereis of start characters)
			data_word : in std_logic_vector(15 downto 0); --data to be sent
			fetch_data : out std_logic; 
			bipolar_out : out std_logic; --Manchester encoded output
			send_data : out std_logic --Output indicating data is being sent
			);
	end component;
	
	---------------------------------------------------------------------------------
	------------------------------ Internal TB Signals ------------------------------
	---------------------------------------------------------------------------------
	--General Use
	signal send_clk : std_logic := '1'; 
	signal encoder_clk : std_logic := '0';
	signal reset : std_logic := '1' ;
	
	constant encoder_period : time := 10 ns; -- 100 MHz
	constant send_period : time := 5 ns; -- 200 MHz
    
	--Program Memory Interface
	signal re : std_logic;
	signal address : unsigned (7 downto 0);
	signal TB_ROM : ram_t := init_ram_from_file("man_dat.txt");
	
    --Encoder signals
	signal master_reset : std_logic := '1'; --Controller Reset
	signal bipolar_out : std_logic; --Manchester encoded output
	signal send_data : std_logic; --Output indicating data is being sent
	signal output_inhibit : std_logic; --inhibits bipolar_out but does not pause controller
	signal encoder_enable : std_logic; --encoder enable input, must be high for 20 bit durations
	signal enable : std_logic; --asynchronous enable
	signal sync_select : std_logic; --input that tells controller wither word to be sent is a command or data (appends a different sereis of start characters)
	signal select_1 : std_logic; --asynchronous sync select
	signal data_word : std_logic_vector(15 downto 0); --data to be sent
	signal fetch_data : std_logic; 
	
	-- TEST SIGNALS --
	signal test_enable : std_logic;
	signal test_select_l : std_logic;
	signal test_data_word : std_logic_vector(15 downto 0);
	signal test_address : unsigned(7 downto 0);
	signal fetch_data_ever : std_logic;
	
	
	
begin
  
	UUT_Instance : Manchester_Encoder 
	port map(
			master_reset => master_reset,
			send_clk => send_clk,
			encoder_clk => encoder_clk,
			encoder_enable => encoder_enable,
			output_inhibit => output_inhibit,
			sync_select => sync_select,
			data_word => data_word,
			fetch_data => fetch_data, 
			bipolar_out => bipolar_out,
			send_data => send_data
		);    
		
	--Generate clock (200MHz)  
    send_clk <= not send_clk after send_period/2; --clock gets it's inverse after 1/2 period
	--Generate clock (100MHz) 
	encoder_clk <= not encoder_clk after encoder_period/2; --clock gets it's inverse after 1/2 period
        
    --generates an asynchronous reset pulse 20ns long
	reset_process : process is	
    begin
	    reset <= '1';
	    --enable <= '0';
		output_inhibit <= '0';
        wait for 20 ns;
        reset <= '0';
        wait for 50 ns;
        --enable <= '1'; --encoder_enable <= '1';
		--select_1 <= '1'; --sync_select <= '1';
        wait for 220 ns;
        --enable <= '0'; --encoder_enable <= '0';
		--data_word <= x"ABCD";
        wait;
    end process reset_process;
    
    clocked_reset : process (encoder_clk) is --sync the asynchronous reset pulse to clk1
    begin
		if rising_edge(encoder_clk) then 
			master_reset <= reset;
			--encoder_enable <= enable;
			--sync_select <= select_1;
		end if;
    end process clocked_reset;   
	
	manchester_data_input : process (encoder_clk) is 
    begin
		if rising_edge(encoder_clk) then 
			if master_reset = '1' then
				test_enable <= '0';
				test_select_l <= '0';
				test_data_word <= x"ABCD";
				test_address <= (others => '0');
				encoder_enable <= '0';
				sync_select <= '0';
				data_word <= x"ABCD";
				address <= (others => '0');
				fetch_data_ever <= '0';
			else
				test_data_word <= TB_ROM(to_integer(test_address))(15 downto 0);
				test_select_l <= TB_ROM(to_integer(test_address))(17);
				test_enable <= TB_ROM(to_integer(test_address))(16);
				data_word <= TB_ROM(to_integer(address))(15 downto 0);
				sync_select <= TB_ROM(to_integer(address))(17);
				encoder_enable <= TB_ROM(to_integer(address))(16);
				
			end if;
			
			if fetch_data = '1' then
				--if fetch_data_ever = '1' then
					test_address <= test_address + 1;
					address <= address + 1;
				--else
				--	fetch_data_ever <= '1';
				--end if;
			end if;
		end if;
    end process manchester_data_input;   
		
end architecture simple_TB;
	