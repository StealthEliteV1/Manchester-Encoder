library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity CPU_Top_Level is
	port(
		Master_Reset : in std_logic; --Button 0
		CLK_100M_IN : in std_logic; --CLK100MHZ
		output_inhibit : in std_logic; --inhibits bipolar_out but does not pause controller, Switch 0
		Bipolar_IN : in std_logic; --Manchester Data in, IO0
		Bipolar_OUT : out std_logic; --Manchester Data out, IO1
		send_data : out std_logic; --Output indicating data is being sent, LED2
		take_data : out std_logic; --Output indicating data is being recieved, LED3
		data_word_out : out std_logic_vector(15 downto 0); --decoded Manchester Data Word, IO41 - IO26
		send_word_out : out std_logic; --output write pulse, IO3
		reset_LED : out std_logic; --output write pulse, IO3
		inhibit_LED : out std_logic --output write pulse, IO3
		);
end entity CPU_Top_Level;

architecture Top_Level of CPU_Top_Level is
	
	-- COMPONENT IBUF
		-- generic(
			-- IOSTANDARD : string := "DEFAULT";
			-- IBUF_LOW_PWR : string := "TRUE"
		-- );
		-- port (
			-- O : out std_logic;
			-- I : in std_logic
		-- );
	-- end COMPONENT;

component IO_Registers IS
		port(
			CLK_20M_IN : in std_logic; 
			CLK_40M_IN : in std_logic;
			CLK_80M_IN : in std_logic;
			
			locked : in std_logic;
			Master_Reset : in std_logic; 
			output_inhibit : in std_logic;
			Bipolar_IN : in std_logic; 
			Master_Reset_reg1 : out std_logic; 
			Master_Reset_reg2 : out std_logic; 
			output_inhibit_reg : out std_logic;
			Bipolar_IN_reg : out std_logic 
		);
	end component;
	
    --Component Declaration for Data Path Controller
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
	
	component Manchester_Decoder is
	   port(
		  master_reset : in std_logic := '1'; --Controller Reset
		  data_clk : in std_logic; --100 MHz clock
		  decoder_clk : in std_logic; --400 MHz clock
		  bipolar_in : in std_logic;
		  CMD_Data : out std_logic; --indicates if incoming word is data (0) or a command (1)
		  take_data : out std_logic; --indicates that decoder is processing a manchester word
		  send_word_out : out std_logic; --Pulse goes active when word has been decoded (think Write Enable)
		  parity_bit_out : out std_logic;
		  data_word_out : out std_logic_vector(15 downto 0) --word recieved
		  );
    end component;
	
	component Memory_Handler is
        port(
			master_reset : in std_logic;
			clk_in : in std_logic;
			
			data_word_in : in std_logic_vector(19 downto 0);
			enable : out std_logic;
			write_enable : out std_logic;
			address_out : out std_logic_vector(6 downto 0);
						
			fetch_data : in std_logic; 
			sync_select : out std_logic; --input that tells controller wither word to be sent is a command or data (appends a different sereis of start characters)
		    data_word_out : out std_logic_vector(15 downto 0); --data to be sent
		    encoder_enable : out std_logic 
			);
    end component;
    
	component clk_manchester_0
		port(
			-- Clock in ports
			-- Clock out ports
			clk_out20M          : out    std_logic;
			clk_out40M          : out    std_logic;
			clk_out80M          : out    std_logic;
			-- Status and control signals
			reset             : in     std_logic;
			locked            : out    std_logic;
			clk_in100M           : in     std_logic
			);
		end component;

	COMPONENT blk_mem_gen_0
		PORT (
			clka : IN STD_LOGIC;
			ena : IN STD_LOGIC;
			wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
			addra : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
			dina : IN STD_LOGIC_VECTOR(19 DOWNTO 0);
			douta : OUT STD_LOGIC_VECTOR(19 DOWNTO 0) 
			);
	END COMPONENT;
	
	COMPONENT ila_0 IS
        PORT (
            clk : IN STD_LOGIC;
            trig_out : OUT STD_LOGIC;
            trig_out_ack : IN STD_LOGIC;
            trig_in : IN STD_LOGIC;
            trig_in_ack : OUT STD_LOGIC;
            probe0 : IN STD_LOGIC_VECTOR(127 DOWNTO 0)
            );
    END COMPONENT;

	signal clk_out20M : std_logic;
	signal clk_out40M : std_logic;
	signal clk_out80M : std_logic;
	signal locked : std_logic;
	signal mem_enable : std_logic;
	signal write_enable : std_logic;
	signal mem_address : std_logic_vector(6 downto 0);
	signal sync_select : std_logic; 
	signal data_word : std_logic_vector(15 downto 0); --data to be sent
	signal fetch_data : std_logic; 

	signal mem_data_out : std_logic_vector(19 downto 0);
	signal mem_data_in : std_logic_vector(19 downto 0);
	signal wea : std_logic_vector(0 downto 0);
	signal encoder_enable : std_logic;
	signal bipolar_out_int : std_logic;
	signal CMD_Data : std_logic; --indicates if incoming word is data (0) or a command (1)

	signal parity_bit : std_logic;
	signal send_data_int : std_logic;
	signal reset_20M : std_logic;
	signal reset_80M : std_logic;
	signal output_inhibit_reg : std_logic;
	signal Bipolar_IN_reg : std_logic;
	
	signal trig_out : std_logic;
	signal trig_out_ack : std_logic;
	signal trig_in_ack : std_logic;
	signal probe_data : std_logic_vector(127 downto 0);
	signal CLK_100M_BUF : std_logic;
	
begin
   	DEBUGGER : ila_0
        PORT MAP(
            clk => clk_out80M,
            trig_out => trig_out,
            trig_out_ack => '0',
            trig_in => send_data_int,
            trig_in_ack => trig_in_ack,
            probe0 => probe_data
            );
   	
	probe_data(15 downto 0) <= data_word;
	probe_data(16) <= encoder_enable;
	probe_data(17) <= output_inhibit_reg;
	probe_data(18) <= sync_select;
	probe_data(19) <= fetch_data;
	probe_data(20) <= bipolar_out_int;
	probe_data(21) <= send_data_int;
	probe_data(127 downto 22) <= (others => '0');
   	
   	bipolar_out <= bipolar_out_int;
   	mem_data_in <= (others => '0');
	reset_LED <= reset_20M;
	inhibit_LED <= output_inhibit_reg;
	send_data <= send_data_int;
	
   	wea(0) <= write_enable;
   
	-- CLKBUF : IBUF
		-- generic map(
			-- IOSTANDARD => "DEFAULT",
			-- IBUF_LOW_PWR => "TRUE"
		-- )
		-- port map (
			-- O => CLK_100M_BUF, -- Buffer output to internal logic
			-- I => CLK_100M_IN   --Buffer input to top-level port
		-- );
	
	Registers : IO_Registers 
		port map(
			CLK_20M_IN => clk_out20M, 
			CLK_40M_IN => clk_out40M,
			CLK_80M_IN => clk_out80M,
			
			locked => locked,
			Master_Reset => Master_Reset,
			output_inhibit => output_inhibit,
			Bipolar_IN => Bipolar_IN,
			Master_Reset_reg1 => reset_20M,
			Master_Reset_reg2 => reset_80M,
			output_inhibit_reg => output_inhibit_reg,
			Bipolar_IN_reg => Bipolar_in_reg
		);
	
	
	Encoder : Manchester_Encoder 
		port map(
			master_reset => reset_20M,
			send_clk => clk_out40M,
			encoder_clk => clk_out20M,
			encoder_enable => encoder_enable,
			output_inhibit => output_inhibit_reg,
			sync_select => sync_select,
			data_word => data_word,
			fetch_data => fetch_data, 
			bipolar_out => bipolar_out_int,
			send_data => send_data_int
			);

	Decoder : Manchester_Decoder 
	   port map(
		  master_reset => reset_80M,
		  data_clk => clk_out20M,
		  decoder_clk => clk_out80M,
		  bipolar_in => Bipolar_IN_reg, --out_int,
		  CMD_Data => CMD_Data,
		  take_data => take_data,
		  send_word_out => send_word_out,
		  parity_bit_out => parity_bit,
		  data_word_out => data_word_out
		  );
    
    
	Mem_Handler : Memory_Handler 
        port map(
			master_reset => reset_20M,
			clk_in => clk_out20M,
			
			data_word_in => mem_data_out,
			enable => mem_enable,
			write_enable => write_enable,
			address_out => mem_address,
						
			fetch_data => fetch_data, 
			sync_select => sync_select,
		    data_word_out => data_word,
		    encoder_enable => encoder_enable 
			);
	

	Internal_Mem : blk_mem_gen_0
		PORT MAP (
			clka => clk_out20M,
			ena => mem_enable,
			wea => wea,
			addra => mem_address,
			dina => mem_data_in,
			douta => mem_data_out
			);

	Master_CLK : clk_manchester_0
		port map ( 
			-- Clock out ports  
			clk_out20M => clk_out20M,
			clk_out40M => clk_out40M,
			clk_out80M => clk_out80M,
			-- Status and control signals                
			reset => Master_Reset,
			locked => locked,
			-- Clock in ports
			clk_in100M => CLK_100M_IN
			);
		
end architecture Top_Level;
	