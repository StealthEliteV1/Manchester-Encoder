library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity Memory_Handler is
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

end entity Memory_Handler;

architecture behavioral of Memory_Handler is
	
	--Program Memory Interface
	signal address : unsigned (6 downto 0);
	

begin
 
	address_out <= std_logic_vector(address);
	write_enable <= '0';
	
	mem_control : process (clk_in) is 
    begin
		if rising_edge(clk_in) then 
			if master_reset = '1' then
				data_word_out <= x"ABCD";
				encoder_enable <= '0';
				sync_select <= '0';
				address <= (others => '0');
				enable <= '0';
			else
				data_word_out <= data_word_in(15 downto 0);
				sync_select <= data_word_in(17);
				encoder_enable <= data_word_in(16);
				enable <= '1';
			end if;
			
			if fetch_data = '1' then
				address <= address + 1;
			end if;
		end if;
    end process mem_control;   
		
end architecture behavioral;
	