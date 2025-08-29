------------------------------------------------------------------------
-- Engineer:    Dalmasso Loic
-- Create Date: 13/08/2025
-- Module Name: OperatorWatchdog
-- Description:
--		Operator Watchdog is in charge to control the maximum number of allowed clock cycles per verification cycle
--		When the maximum is reached, the Operator Watchdog Output is triggered
--
-- Usage:
--		After enable, the Operator Watchdog count each clock cycles until the next inputs transition
--		If no transition occurs after the maximum number of allowed clock cycles, the Operator Watchdog output is triggered
--
-- Generics:
--		WATCHDOG_LIMIT: Define the maximum number of allowed clock cycles between inputs transition
--		INPUT_LENGTH: Define the Input Length under the Watchdog Control
--
-- Ports
--		Input 	-	i_sys_clock: System Input Clock
--		Input 	-	i_enable: System Input Enable ('0': Disabled, '1': Enabled)
--		Input 	-	i_watching_inputs: Inputs under the Watchdog Control
--		Output 	-	o_watchdog_trigger: Watchdog Trigger ('0': Disabled, '1': Enabled)
------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY OperatorWatchdog is

GENERIC(
	WATCHDOG_LIMIT: INTEGER := 30;
	INPUT_LENGTH: INTEGER := 1
);

PORT(
	i_sys_clock: IN STD_LOGIC;
	i_enable: IN STD_LOGIC;
	i_watching_inputs: IN STD_LOGIC_VECTOR(INPUT_LENGTH-1 downto 0);
	o_watchdog_trigger: OUT STD_LOGIC
);

END OperatorWatchdog;

ARCHITECTURE Behavioral of OperatorWatchdog is

------------------------------------------------------------------------
-- Signal Declarations
------------------------------------------------------------------------
-- Watchdog Counter
signal watchdog_counter: INTEGER range 0 to WATCHDOG_LIMIT := 0;

-- Watching Inputs Registers
signal watching_inputs_reg0: STD_LOGIC_VECTOR(INPUT_LENGTH-1 downto 0) := (others => '0');
signal watching_inputs_reg1: STD_LOGIC_VECTOR(INPUT_LENGTH-1 downto 0) := (others => '0');

-- Inputs Transition
signal watching_inputs_transition: STD_LOGIC := '0';

------------------------------------------------------------------------
-- Module Implementation
------------------------------------------------------------------------
begin

	-------------------------------
	-- Watching Inputs Registers --
	-------------------------------
	process(i_sys_clock)
	begin
		if rising_edge(i_sys_clock) then

			-- Operator Watchdog Enable
			if (i_enable = '1') then
				watching_inputs_reg0 <= i_watching_inputs;
				watching_inputs_reg1 <= watching_inputs_reg0;
			end if;
		end if;
	end process;

	--------------------------------
	-- Watching Inputs Transition --
	--------------------------------
    watching_inputs_transition <= '1' when watching_inputs_reg0 /= watching_inputs_reg1 else '0';

	----------------------
	-- Watchdog Counter --
	----------------------
	process(i_sys_clock)
	begin
		if rising_edge(i_sys_clock) then

			-- Reset Watchdog Counter (Operator Watchdog Disable or Watching Inputs transition)
			if (i_enable = '0') or (watching_inputs_transition = '1') then
				watchdog_counter <= 0;
            
            -- Watchdog Counter Increment
            elsif (watchdog_counter < WATCHDOG_LIMIT) then
                watchdog_counter <= watchdog_counter +1;
			end if;
		end if;
	end process;

    ----------------------
	-- Watchdog Trigger --
	----------------------
    o_watchdog_trigger <= '1' when (watchdog_counter = WATCHDOG_LIMIT) else '0';

end Behavioral;