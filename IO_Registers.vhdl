library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity IO_Registers IS
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
end entity IO_Registers;

architecture behave of IO_Registers is
    signal reset_20 : std_logic;
	signal reset_80 : std_logic;
begin

	Master_Reset_reg1 <= Master_Reset or reset_20 or not locked;
	Master_Reset_reg2 <= Master_Reset or reset_80 or not locked;
	Reg20M : process(CLK_20M_IN) is 
    begin
		if rising_edge(CLK_20M_IN) then
			reset_20 <= Master_Reset and not locked;
		end if;
	end process;
	
	Reg40M : process(CLK_40M_IN) is 
    begin
		if rising_edge(CLK_40M_IN) then
			output_inhibit_reg <= output_inhibit;
		end if;
	end process;

	Reg80M : process(CLK_80M_IN) is 
    begin
		if rising_edge(CLK_80M_IN) then
			reset_80 <= Master_Reset and not locked;
			Bipolar_IN_reg <= Bipolar_IN;
		end if;
	end process;
end architecture behave;


