------------------------------------------------------------------------
-- Engineer:    Dalmasso Loic
-- Create Date: 13/08/2025
-- Module Name: OperatorWatchdog
-- Description:
--		Operator Watchdog is in charge to control the maximum number of allowed clock cycles per verification
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

ENTITY Testbench_OperatorWatchdog is
--  Port ( );
END Testbench_OperatorWatchdog;

ARCHITECTURE Behavioral of Testbench_OperatorWatchdog is

------------------------------------------------------------------------
-- Component Declarations
------------------------------------------------------------------------
COMPONENT OperatorWatchdog is

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
END COMPONENT;

------------------------------------------------------------------------
-- Constant Declarations
------------------------------------------------------------------------
constant INPUT_LENGTH: INTEGER := 3;

------------------------------------------------------------------------
-- Signal Declarations
------------------------------------------------------------------------
signal sys_clock: STD_LOGIC := '0';
signal enable: STD_LOGIC := '0';

-- Inputs
signal watching_inputs: STD_LOGIC_VECTOR(INPUT_LENGTH-1 downto 0) := (others => '0');

-- Output
signal watchdog_trigger: STD_LOGIC := '0';

------------------------------------------------------------------------
-- Module Implementation
------------------------------------------------------------------------
begin

-- System Clock
sys_clock <= not(sys_clock) after 5 ns;

-- Enable
enable <= '0', '1' after 30 ns, '0' after 200 ns, '1' after 215 ns;

-- Watching Inputs
watching_inputs <= 	-- Init
					"000",
					-- Transition 1
					"001" after 45 ns,
					-- Transition 2
					"010" after 55 ns,
					-- Transition 3
					"011" after 65 ns,
					-- Transition 4
					"100" after 95 ns,
					-- Transition 5
					"101" after 105 ns,
					-- Transition 6
					"110" after 115 ns,
					-- Transition 7
					"111" after 135 ns;

uut: OperatorWatchdog
	GENERIC MAP (
		WATCHDOG_LIMIT => 30,
		INPUT_LENGTH => INPUT_LENGTH
	)
	PORT MAP (
		i_sys_clock => sys_clock,
		i_enable => enable,
		i_watching_inputs => watching_inputs,
        o_watchdog_trigger => watchdog_trigger
	);

end Behavioral;