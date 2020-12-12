library ieee;
use ieee.std_logic_1164.all;

entity CPU_tb is
end entity;

architecture bhv of CPU_tb is
component CPU is
	port (clock,reset : in std_logic);
end component;

	SIGNAL clock : STD_LOGIC := '1' ;
	SIGNAL reset : STD_LOGIC := '1' ;
	-- sigNAL mux_out, inst_bus, mux_instance2_2to1_out, alu_zero_pad_out_mux, data_write: std_LOGIC_vector(15 downto 0);
	-- signal WB, WB_out_ID_RF, WB_out_RF_EX : std_LOGIC_vector(2 downto 0);
	CONSTANT CLK_PERIOD : TIME := 15 NS ;

begin

UUT: CPU port map(clock => clock, reset => reset);


PROCESS 
	BEGIN
		WAIT FOR CLK_PERIOD/2 ;
		clock <= NOT clock ;
		reset <='0' AFTER 3 ns ;
		
END PROCESS ;
end bhv;
