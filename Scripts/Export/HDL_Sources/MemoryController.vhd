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

ENTITY MemoryController is

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

END MemoryController;

ARCHITECTURE Behavioral of MemoryController is

------------------------------------------------------------------------
-- Signal Declarations
------------------------------------------------------------------------
-- Memory Controller States
TYPE memoryState is (IDLE, NO_DATA, INIT, WAIT_DATA, DATA_A_READY, DATA_B_READY);
signal state: memoryState := IDLE;
signal next_state: memoryState;

-- Memory Signals
signal mem_ena: STD_LOGIC := '0';
signal mem_enb: STD_LOGIC := '0';
signal mem_addr_count: UNSIGNED(MEMORY_ADDR_LENGTH-1 downto 0) := (others => '0');
signal mem_addra_reg: UNSIGNED(MEMORY_ADDR_LENGTH-1 downto 0) := (others => '0');
signal mem_addrb_reg: UNSIGNED(MEMORY_ADDR_LENGTH-1 downto 0) := (others => '0');
signal mem_data_rega: STD_LOGIC_VECTOR(MEM_TOTAL_DATA_LENGTH-1 downto 0) := (others => '0');
signal mem_data_regb: STD_LOGIC_VECTOR(MEM_TOTAL_DATA_LENGTH-1 downto 0) := (others => '0');

-- Memory Last Data Register
signal mem_data_last_reg: STD_LOGIC := '0';

-- Memory Data Outputs
signal mem_data_out_ready_reg: STD_LOGIC := '0';
signal mem_data_out_reg: UNSIGNED(MEM_TOTAL_DATA_LENGTH-1 downto 0) := (others => '0');
signal mem_data_out_last_reg: STD_LOGIC := '0';

------------------------------------------------------------------------
-- Module Implementation
------------------------------------------------------------------------
begin

	-------------------------------------
	-- Memory Controller State Machine --
	-------------------------------------
	process(i_sys_clock)
	begin
		if rising_edge(i_sys_clock) then

			-- Reset
			if (i_enable = '0') then
				state <= IDLE;

			-- Next State
			else
				state <= next_state;
			end if;
		end if;
	end process;

	-- Memory Controller Next State
	process(state, i_enable, i_addr_count, i_next_data_request, mem_data_last_reg)
	begin
		case state is

			-- IDLE
			when IDLE => 	
						-- Memory Enable
						if (i_enable = '1') then

							-- No Memory Data
							if (i_addr_count = 0) then
								next_state <= NO_DATA;

							-- Memory Data Available
							else
								next_state <= INIT;
							end if;

						else
							next_state <= IDLE;
						end if;

			-- No Memory Data
			when NO_DATA => next_state <= NO_DATA;

			-- Initialize Memory
			when INIT => next_state <= WAIT_DATA;

			-- Waiting Memory Data
			when WAIT_DATA => next_state <= DATA_A_READY;

			-- Memory Data A Ready
			when DATA_A_READY =>
							-- Next Data Request (Memory Data B)
							if (i_next_data_request = '1') and (mem_data_last_reg = '0') then
								next_state <= DATA_B_READY;

							-- Memory Data A
							else
								next_state <= DATA_A_READY;
							end if;

			-- Memory Data B Ready
			when DATA_B_READY =>
							-- Next Data Request (Preparing Memory Data A)
							if (i_next_data_request = '1') and (mem_data_last_reg = '0') then
								next_state <= WAIT_DATA;

							-- Current Data B
							else
								next_state <= DATA_B_READY;
							end if;

			-- Others States
			when others => next_state <= IDLE;
		end case;
	end process;

	--------------------
	-- Memory Enables --
	--------------------
	mem_ena <= '0' when (state = IDLE) or (state = NO_DATA) else '1';
	mem_enb <= '0' when (state = IDLE) or (state = NO_DATA) else '1';

	----------------------------
	-- Memory Address Counter --
	----------------------------
	process(i_sys_clock)
	begin
		if rising_edge(i_sys_clock) then

			-- Init Memory Address Counter
			if (state = IDLE) then
				mem_addr_count <= TO_UNSIGNED(i_addr_count, MEMORY_ADDR_LENGTH) -1;

			-- No More Data
			elsif (mem_data_last_reg = '1') then
				mem_addr_count <= mem_addr_count;

			-- Next Memory Data
			elsif ((state = DATA_A_READY) or (state = DATA_B_READY)) and (i_next_data_request = '1') then
				-- Decrement Memory Address Counter
				mem_addr_count <= mem_addr_count -1;
			end if;
		end if;
	end process;

	------------------------------
	-- Memory Last Data Handler --
	------------------------------
	process(i_sys_clock)
	begin
		if rising_edge(i_sys_clock) then

			-- Last Data Register
			if (mem_addr_count <= 0) then
				mem_data_last_reg <= '1';
			else
				mem_data_last_reg <= '0';
			end if;
		end if;
	end process;

	---------------------------
	-- Memory Address Port A --
	---------------------------
	process(i_sys_clock)
	begin
		if rising_edge(i_sys_clock) then

			-- Init Memory Address Port A
			if (state = IDLE) then
				mem_addra_reg <= TO_UNSIGNED(i_addr_index, MEMORY_ADDR_LENGTH);

			-- No More Data
			elsif (mem_data_last_reg = '1') then
				mem_addra_reg <= mem_addra_reg;

			-- Next Memory Data Port A
			elsif (state = DATA_A_READY) and (i_next_data_request = '1') then
				-- Increment Memory Address Port A (+2 for Dual-Port Memory)
				mem_addra_reg <= mem_addra_reg +2;
			end if;
		end if;
	end process;

	---------------------------
	-- Memory Address Port B --
	---------------------------
	process(i_sys_clock)
	begin
		if rising_edge(i_sys_clock) then

			-- Init Memory Address Port B
			if (state = IDLE) then
				mem_addrb_reg <= TO_UNSIGNED(i_addr_index, MEMORY_ADDR_LENGTH) +1;

			-- No More Data
			elsif (mem_data_last_reg = '1') then
				mem_addrb_reg <= mem_addrb_reg;

				-- Next Memory Data Port B
			elsif (state = DATA_B_READY) and (i_next_data_request = '1') then
				-- Increment Memory Address Port B (+2 for Dual-Port Memory)
				mem_addrb_reg <= mem_addrb_reg +2;
			end if;
		end if;
	end process;

	--------------------------------
	-- Memory Data Output Handler --
	--------------------------------
	process(i_sys_clock)
	begin
		if rising_edge(i_sys_clock) then

			-- Memory Port A
			if (state = DATA_A_READY) then
				mem_data_out_reg <= UNSIGNED(mem_data_rega);
				mem_data_out_ready_reg <= not(i_next_data_request);

			-- Memory Port B
			elsif (state = DATA_B_READY) then
				mem_data_out_reg <= UNSIGNED(mem_data_regb);
				mem_data_out_ready_reg <= not(i_next_data_request);
			
			else
				mem_data_out_reg <= mem_data_out_reg;
				mem_data_out_ready_reg <= '0';
			end if;
		end if;
	end process;

	-------------------------------------
	-- Memory Last Data Output Handler --
	-------------------------------------
	process(i_sys_clock)
	begin
		if rising_edge(i_sys_clock) then

			-- Last Data Output
			if ((state = DATA_A_READY) or (state = DATA_B_READY)) and (mem_data_last_reg = '1') then
				mem_data_out_last_reg <= '1';

			else
				mem_data_out_last_reg <= '0';
			end if;
		end if;
	end process;

	----------------------------
	-- Memory Intputs/Outputs --
	----------------------------
	-- Memory Clocks
	o_mem_clka <= i_sys_clock;
	o_mem_clkb <= i_sys_clock;

	-- Memory Enables
	o_mem_ena <= mem_ena;
	o_mem_enb <= mem_enb;

	-- Memory Addresses
	o_mem_addra <= STD_LOGIC_VECTOR(mem_addra_reg);
	o_mem_addrb <= STD_LOGIC_VECTOR(mem_addrb_reg);

	-- Memory Data
	mem_data_rega <= i_mem_dataa;
	mem_data_regb <= i_mem_datab;

	--------------------------------
	-- Memory Data Outputs Parser --
	--------------------------------
	o_mem_no_data <= '1' when state = NO_DATA else '0';
	o_mem_data_ready <= mem_data_out_ready_reg;
	o_mem_data <= mem_data_out_reg(MEM_DATA_MSB_INDEX downto MEM_DATA_LSB_INDEX);
	o_mem_data_en <= STD_LOGIC_VECTOR(mem_data_out_reg(MEM_DATA_QUARTET_ENABLE_MSB_INDEX downto MEM_DATA_QUARTET_ENABLE_LSB_INDEX));
	o_mem_data_verif_level <= mem_data_out_reg(MEM_DATA_VERIF_LEVEL_INDEX);
	o_mem_data_part_number <= mem_data_out_reg(MEM_DATA_PART_NUMBER_MSB_INDEX downto MEM_DATA_PART_NUMBER_LSB_INDEX);
	o_mem_data_last <= mem_data_out_last_reg;

end Behavioral;