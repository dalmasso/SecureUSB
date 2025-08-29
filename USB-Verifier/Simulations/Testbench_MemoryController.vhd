------------------------------------------------------------------------
-- Engineer:    Dalmasso Loic
-- Create Date: 30/07/2025
-- Module Name: MemoryController
-- Description:
--		Module in charge of controlling Verification Operator Memory (ROM)
--
-- Usage:
--		The enable signal is in charge to reset the Memory Controller Module (at low) or to start it (at high)
--		After the start, the Memory Controller set the Memory Address & Counter according to the inputs, to get the Verification Value from ROM
--		If no Verification Value is available (Memory Address Counter input is 0), the No Data output signal is set
--		If Verification Value is available, the value is get from the ROM (2-cycles are required)
--		To improve behavior, 2 Verification Values are get from ROM at the same time, thanks to the Memory Dual-Port
--		The first Verification Value is output (first Port) and the next one (second Port) is output when the Next Data Request input is triggered
--		Each read from ROM increment the Memory Adress on each Memory Port and decrease the Memory Counter until 0
--		When a Verification Value from ROM is ready, the Ready output signal is set
--		When there is no more Verification, the last Verification Value is output with the Last Data signal enable
--		The Memory Controller parses each part of Verification Value and outputs on dedicated signal below:
--			- Verification Data Value
--			- Verification Value Quartet Enable
--			- Verification Level
--			- Verification Part Number
--
-- Generics:
--		MEMORY_ADDR_LENGTH: Define the Memory Address Bus Length (in line with the maximum index value)
--		MEMORY_ADDR_MAX_INDEX: Define the Memory Maximum Address (in line with the maximum index value)
--		MEMORY_ADDR_MAX_COUNT: Define the Memory Maximum Address Count (in line with the maximum count value)
--
-- Ports
--		Input 	-	i_sys_clock: System Input Clock
--		Input 	-	i_enable: System Input Enable ('0': Disabled, '1': Enabled)
--		Input 	-	i_addr_index: Memory Address Index (corresponding to the Descriptor Field)
--		Input 	-	i_addr_count: Memory Address Count (corresponding to the Descriptor Field)
--		Input 	-	i_next_data_request: Next Memory Data Request ('0': No Request, '1': New Request)
--		Output 	-	o_mem_clka: Memory Port A Clock
--		Output 	-	o_mem_clkb: Memory Port B Clock
--		Output 	-	o_mem_ena: Memory Port A Enable ('0': Disabled, '1': Enabled)
--		Output 	-	o_mem_enb: Memory Port B Enable ('0': Disabled, '1': Enabled)
--		Output 	-	o_mem_addra: Memory Port A Adress
--		Output 	-	o_mem_addrb: Memory Port B Adress
--		Input 	-	i_mem_dataa: Memory Port A Data
--		Input 	-	i_mem_datab: Memory Port B Data
--		Output 	-	o_mem_no_data: No Memory Data available ('0': Disabled, '1': Enabled)
--		Output 	-	o_mem_data_ready: New Memory Data Ready ('0': Not Ready, '1': Ready)
--		Output 	-	o_mem_data: Memory Data
--		Output 	-	o_mem_data_en: Memory Data Quartet Enable ('0': Disabled Quartet, '1': Enabled Quartet)
--		Output 	-	o_mem_data_verif_level: Memory Data Verification Level ('0': Optional, '1': Mandatory)
--		Output 	-	o_mem_data_part_number: Memory Data Part Number
--		Output 	-	o_mem_data_last: Memory Last Data ('0': Not Last Data, '1': Last Data)
------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

-- Custom Package: Memory Data Mapping
LIBRARY WORK;
USE WORK.MemoryDataMapping.ALL;

ENTITY Testbench_MemoryController is
--  Port ( );
END Testbench_MemoryController;

ARCHITECTURE Behavioral of Testbench_MemoryController is

------------------------------------------------------------------------
-- Component Declarations
------------------------------------------------------------------------
COMPONENT MemoryController is

GENERIC(
	-- Memory Configurations (Address Length, Address Max Index, Address Count Max)
	MEMORY_ADDR_LENGTH: INTEGER := 1;
	MEMORY_ADDR_MAX_INDEX: INTEGER := 0;
	MEMORY_ADDR_MAX_COUNT: INTEGER := 0
);

PORT(
	i_sys_clock: IN STD_LOGIC;
	i_enable: IN STD_LOGIC;
	i_addr_index: IN INTEGER range 0 to MEMORY_ADDR_MAX_INDEX;
	i_addr_count: IN INTEGER range 0 to MEMORY_ADDR_MAX_COUNT;
	i_next_data_request: IN STD_LOGIC;

	-- Memory Signals
	o_mem_clka: OUT STD_LOGIC;
	o_mem_clkb: OUT STD_LOGIC;
	o_mem_ena: OUT STD_LOGIC;
	o_mem_enb: OUT STD_LOGIC;
	o_mem_addra: OUT STD_LOGIC_VECTOR(MEMORY_ADDR_LENGTH-1 downto 0);
	o_mem_addrb: OUT STD_LOGIC_VECTOR(MEMORY_ADDR_LENGTH-1 downto 0);
	i_mem_dataa: IN STD_LOGIC_VECTOR(MEM_TOTAL_DATA_LENGTH-1 downto 0);
	i_mem_datab: IN STD_LOGIC_VECTOR(MEM_TOTAL_DATA_LENGTH-1 downto 0);

	-- Memory Controller Outputs
	o_mem_no_data: OUT STD_LOGIC;
	o_mem_data_ready: OUT STD_LOGIC;
	o_mem_data: OUT UNSIGNED(MEM_DATA_LENGTH-1 downto 0);
	o_mem_data_en: OUT STD_LOGIC_VECTOR(MEM_DATA_QUARTET_ENABLE_LENGTH-1 downto 0);
	o_mem_data_verif_level: OUT STD_LOGIC;
	o_mem_data_part_number: OUT UNSIGNED(MEM_DATA_PART_NUMBER_LENGTH-1 downto 0);
	o_mem_data_last: OUT STD_LOGIC
);

END COMPONENT;

------------------------------------------------------------------------
-- Signal Declarations
------------------------------------------------------------------------
signal sys_clock: STD_LOGIC := '0';
signal enable: STD_LOGIC := '0';

-- Inputs
signal addr_index: INTEGER := 0;
signal addr_count: INTEGER := 0;
signal next_data_request: STD_LOGIC := '0';

-- Outputs
signal mem_clka: STD_LOGIC := '0';
signal mem_clkb: STD_LOGIC := '0';
signal mem_ena: STD_LOGIC := '0';
signal mem_enb: STD_LOGIC := '0';
signal mem_addra: STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
signal mem_addrb: STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
signal mem_dataa: STD_LOGIC_VECTOR(MEM_TOTAL_DATA_LENGTH-1 downto 0) := (others => '0');
signal mem_datab: STD_LOGIC_VECTOR(MEM_TOTAL_DATA_LENGTH-1 downto 0) := (others => '0');

signal mem_no_data: STD_LOGIC := '0';
signal mem_data_ready: STD_LOGIC := '0';
signal mem_data: UNSIGNED(MEM_DATA_LENGTH-1 downto 0) := (others => '0');
signal mem_data_en: STD_LOGIC_VECTOR(MEM_DATA_QUARTET_ENABLE_LENGTH-1 downto 0) := (others => '0');
signal mem_data_verif_level: STD_LOGIC := '0';
signal mem_data_part_number: UNSIGNED(MEM_DATA_PART_NUMBER_LENGTH-1 downto 0) := (others => '0');
signal mem_data_last: STD_LOGIC := '0';

------------------------------------------------------------------------
-- Module Implementation
------------------------------------------------------------------------
begin

-- System Clock
sys_clock <= not(sys_clock) after 5 ns;

-- Enable
enable <= '0', '1' after 30 ns, '0' after 175 ns, '1' after 220 ns, '0' after 400 ns, '1' after 420 ns;

addr_index <= 1, 0 after 420 ns;
addr_count <= 3, 0 after 420 ns;
next_data_request <= '0', '1' after 85 ns, '0' after 95 ns, '1' after 115 ns, '0' after 125 ns, '1' after 155 ns, '0' after 165 ns, '1' after 220 ns;

-- Memory Data
mem_dataa <= (others => '0');
mem_datab <= (others => '1');

uut: MemoryController
    GENERIC MAP (
        MEMORY_ADDR_LENGTH => 2,
        MEMORY_ADDR_MAX_INDEX => 0,
        MEMORY_ADDR_MAX_COUNT => 4
    )

	PORT MAP (
		i_sys_clock => sys_clock,
		i_enable => enable,
        i_addr_index => addr_index,
        i_addr_count => addr_count,
        i_next_data_request => next_data_request,

		o_mem_clka => mem_clka,
		o_mem_clkb => mem_clka,
		o_mem_ena => mem_ena,
		o_mem_enb => mem_enb,
		o_mem_addra => mem_addra,
		o_mem_addrb => mem_addrb,
		i_mem_dataa => mem_dataa,
		i_mem_datab => mem_datab,

        o_mem_no_data => mem_no_data,
        o_mem_data_ready => mem_data_ready,
        o_mem_data => mem_data,
        o_mem_data_en => mem_data_en,
        o_mem_data_verif_level => mem_data_verif_level,
        o_mem_data_part_number => mem_data_part_number,
        o_mem_data_last => mem_data_last
	);

end Behavioral;