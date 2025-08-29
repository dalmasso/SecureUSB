------------------------------------------------------------------------
-- Engineer:    Dalmasso Loic
-- Create Date: 16/04/2025
-- Module Name: NRZIClockRecovery
-- Description:
--      Non-Return-to-Zero Inverted Clock Recovery module from Sync Pattern (typically: KJ KJ KJ KK) and Bit Stuffing (typically: KK KK KK KJ)
--
--      /!\ The System Clock of this module must be greater than the expected NRZI clock (oversampling) /!\
--
-- Generics
--      SYS_CLOCK_HZ: System Clock Frequency (in HZ)
--      USB_SPEED_BPS: USB Speed (in BPS)
--      K_VALUE: the USB K value
--      J_VALUE: the USB J value
--
-- Ports
--		Input 	-	i_sys_clock: System Input Clock
--		Input 	-	i_reset: System Input Reset ('0': No Reset, '1': Reset)
--		Input 	-	i_nrzi_data: NRZI Data
--		Output 	-	o_nrzi_clock: NRZI Clock (to use as Clock Enable)
------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY NRZIClockRecovery is

GENERIC(
    -- System Configurations
    SYS_CLOCK_HZ: INTEGER := 100_000_000;
    -- USB Configurations
    USB_SPEED_BPS: INTEGER := 12_000_000;
    K_VALUE: STD_LOGIC := '0';
    J_VALUE: STD_LOGIC := '1'
);

PORT(
    i_sys_clock: IN STD_LOGIC;
    i_reset: IN STD_LOGIC;
    i_nrzi_data: IN STD_LOGIC;
    o_nrzi_clock: OUT STD_LOGIC
);

END NRZIClockRecovery;

ARCHITECTURE Behavioral of NRZIClockRecovery is

------------------------------------------------------------------------
-- Constant Declarations
------------------------------------------------------------------------
-- Phase Accumulator Max Value (System Clock / USB Speed)
constant PHASE_ACCUMULATOR_MAX_VALUE: INTEGER := (SYS_CLOCK_HZ / USB_SPEED_BPS);

-- Phase Center Value (Phase Accumulator Max Value / 2) (+1 to anticipate)
constant PHASE_CENTER_VALUE: INTEGER := (PHASE_ACCUMULATOR_MAX_VALUE / 2) +1;

-- End of Sync Pattern
constant END_SYNC_PATTERN: STD_LOGIC_VECTOR(1 downto 0) := K_VALUE & K_VALUE;

------------------------------------------------------------------------
-- Signal Declarations
------------------------------------------------------------------------
-- NRZI Clock Recovery States
TYPE nrziClockRecoveryState is (IDLE, SYNC_PATTERN, TRANSMISSION);
signal state: nrziClockRecoveryState := IDLE;
signal next_state: nrziClockRecoveryState;

-- NRZI Data Sampler Register
signal nrzi_data_sampler_reg: STD_LOGIC := '0';

-- NRZI K & J Edge Detector Registers
signal k_edge_reg: STD_LOGIC := '0';
signal j_edge_reg: STD_LOGIC := '0';

-- NRZI Phase Accumulator
signal nrzi_phase_accumulator: INTEGER range 0 to PHASE_ACCUMULATOR_MAX_VALUE-1 := 0;

-- NRZI Clock Enable Register
signal nrzi_clock_enable_reg: STD_LOGIC := '0';

-- NRZI Sync Pattern Register
signal nrzi_sync_pattern_reg: STD_LOGIC_VECTOR(1 downto 0) := (others => '0');

------------------------------------------------------------------------
-- Module Implementation
------------------------------------------------------------------------
begin

    -----------------------
	-- NRZI Data Sampler --
	-----------------------
    process(i_sys_clock)
    begin
        if rising_edge(i_sys_clock) then

            -- NRZI Data Sampler
            nrzi_data_sampler_reg <= i_nrzi_data;
        end if;
    end process;

    ------------------------------
	-- NRZI K & J Edge Detector --
	------------------------------
    process(i_sys_clock)
    begin
        if rising_edge(i_sys_clock) then

            -- NRZI K Edge
            if (i_nrzi_data = K_VALUE) and (nrzi_data_sampler_reg /= K_VALUE) then
                k_edge_reg <= '1';
            else
                k_edge_reg <= '0';
            end if;

            -- NRZI J Edge
            if (i_nrzi_data = J_VALUE) and (nrzi_data_sampler_reg /= J_VALUE) then
                j_edge_reg <= '1';
            else
                j_edge_reg <= '0';
            end if;

        end if;
    end process;

	---------------------------------------
	-- NRZI Clock Recovery State Machine --
	---------------------------------------
	process(i_sys_clock)
	begin
		if rising_edge(i_sys_clock) then

			-- Reset
			if (i_reset = '1') then
				state <= IDLE;

            -- Next State
            else
                state <= next_state;
			end if;
		end if;
	end process;

	-- NRZI Clock Recovery Next State
	process(state, k_edge_reg, nrzi_sync_pattern_reg)
	begin

		case state is

			-- IDLE
			when IDLE => 	if (k_edge_reg = '1') then
								next_state <= SYNC_PATTERN;
							else
								next_state <= IDLE;
							end if;
			
			-- Sync Pattern
			when SYNC_PATTERN =>
							if (nrzi_sync_pattern_reg = END_SYNC_PATTERN) then
								next_state <= TRANSMISSION;
							else
								next_state <= SYNC_PATTERN;
							end if;

			-- Transmission
			when TRANSMISSION => next_state <= TRANSMISSION;

			-- Others states
			when others => next_state <= IDLE;
		end case;
	end process;

    ----------------------------
	-- NRZI Phase Accumulator --
	----------------------------
    process(i_sys_clock)
    begin
        if rising_edge(i_sys_clock) then

            -- Reset NRZI Phase Accumulator
            if (state = IDLE) or (nrzi_phase_accumulator <= 0) then
                nrzi_phase_accumulator <= PHASE_ACCUMULATOR_MAX_VALUE -1;

            else

                -- Decrement NRZI Phase Accumulator
                nrzi_phase_accumulator <= nrzi_phase_accumulator - 1;

                -- NRZI Edge
                if (k_edge_reg = '1') or (j_edge_reg = '1') then

                    -- Smooth Phase Correction: NRZI Phase Accumulator is late (advance it)
                    if (nrzi_phase_accumulator < PHASE_CENTER_VALUE) then

                        -- Handle Minimum Phase Accumulator
                        if (nrzi_phase_accumulator <= 1) then
                            nrzi_phase_accumulator <= PHASE_ACCUMULATOR_MAX_VALUE -1;
                        else
                            nrzi_phase_accumulator <= nrzi_phase_accumulator -2;
                        end if;

                    -- Smooth Phase Correction: NRZI Phase Accumulator in advance (delay it)
                    elsif (nrzi_phase_accumulator > PHASE_CENTER_VALUE) then
                        nrzi_phase_accumulator <= nrzi_phase_accumulator;

                    end if;

                end if;
            end if;
        end if;
    end process;

    -----------------------
	-- NRZI Clock Enable --
	-----------------------
    process(i_sys_clock)
    begin
        if rising_edge(i_sys_clock) then

            -- Set NRZI Clock Enable
            if (nrzi_phase_accumulator = PHASE_CENTER_VALUE) then
                nrzi_clock_enable_reg <= '1';              

            -- Reset NRZI Clock Enable
            else
                nrzi_clock_enable_reg <= '0';
            end if;
        end if;
    end process;
    o_nrzi_clock <= nrzi_clock_enable_reg when (state = TRANSMISSION) else '0';

    ---------------------------------
	-- NRZI Sync Pattern Validator --
	---------------------------------
    process(i_sys_clock)
    begin
        if rising_edge(i_sys_clock) then

            -- Reset NRZI Sync Pattern Register
            if (state = IDLE) then 
                nrzi_sync_pattern_reg <= not(END_SYNC_PATTERN);

            -- NRZI Clock Enable
            elsif (nrzi_clock_enable_reg = '1') then

                -- Left-Shift & Read NRZI Data
                nrzi_sync_pattern_reg <= nrzi_sync_pattern_reg(0) & nrzi_data_sampler_reg;
            end if;
        end if;
    end process;

end Behavioral;