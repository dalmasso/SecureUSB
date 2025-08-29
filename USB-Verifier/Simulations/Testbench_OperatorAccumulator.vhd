------------------------------------------------------------------------
-- Engineer:    Dalmasso Loic
-- Create Date: 12/08/2025
-- Module Name: OperatorAccumulator
-- Description:
--		Operator Accumulator Module is in charge to accumulate all Operators Modules in order to compute global Next Descriptor Value Part and verification Result
--		Operator Accumulator embedds an Operator Watchdog module used to control the maximum number of allowed clock cycles per verification cycle
--		When the maximum number of allowed clock cycles is reached, the Operator Accumulator considers the verification to have failed
--
-- Usage:
--		Once enabled, the Operator Accumulator waits result from each Operator. Each Operator return can be:
--			- Success/Error: final Operator Result (no more verification required)
--			- Require Next Descriptor Value Part (more verification required)
--		When all Operator return Success/Error, Operator Accumulator generates the global verification Result (Success if all Operator Success, else Error) and the verification process should stops (even if more Descriptor Value Part are available)
--		If at least 1 Operator needs a Next Descriptor Value Part, Operator Accumulator waits all Operators ready (Success/Error or Requiring Next Descriptor Value Part) before forwarding the Next Descriptor Value Part Request
--		At any time, if the verification process reachs the maximum number of allowed clock cycles, the Operator Watchdog is triggered, the verification process stops and is considered to have failed
--
-- Generics:
--		OPERATORS_NUMBER: Define the number of Operators
--		WATCHDOG_LIMIT: Define the maximum number of allowed verification clock cycles (in line with all operators latency)
--
-- Ports
--		Input 	-	i_sys_clock: System Input Clock
--		Input 	-	i_enable: System Input Enable ('0': Disabled, '1': Enabled)
--		Input 	-	i_operators_ready: Operators Ready ('0': Not Ready, '1': Ready)
--		Input 	-	i_operators_result: Operators Result ('0': Error, '1': Success)
--		Input 	-	i_operators_next_part_request: Operators Next Descriptor Value Part Request ('0': No Request, '1': New Request)
--		Output 	-	o_next_part_request: Global Operators Next Descriptor Value Part Request ('0': No Request, '1': New Request)
--		Output 	-	o_ready: Global Operators Result Ready ('0': Not Ready, '1': Ready)
--		Output 	-	o_result: Global Operators Result ('0': Error, '1': Success)
------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Testbench_OperatorAccumulator is
--  Port ( );
END Testbench_OperatorAccumulator;

ARCHITECTURE Behavioral of Testbench_OperatorAccumulator is

------------------------------------------------------------------------
-- Component Declarations
------------------------------------------------------------------------
COMPONENT OperatorAccumulator is

GENERIC(
	OPERATORS_NUMBER: INTEGER := 10;
	WATCHDOG_LIMIT: INTEGER := 18
);

PORT(
	i_sys_clock: IN STD_LOGIC;
	i_enable: IN STD_LOGIC;
	i_operators_ready: IN STD_LOGIC_VECTOR(OPERATORS_NUMBER-1 downto 0);
	i_operators_result: IN STD_LOGIC_VECTOR(OPERATORS_NUMBER-1 downto 0);
	i_operators_next_part_request: IN STD_LOGIC_VECTOR(OPERATORS_NUMBER-1 downto 0);
	o_next_part_request: OUT STD_LOGIC;
	o_ready: OUT STD_LOGIC;
	o_result: OUT STD_LOGIC
);

END COMPONENT;

------------------------------------------------------------------------
-- Constant Declarations
------------------------------------------------------------------------
constant OPERATORS_NUMBER: INTEGER := 3;

------------------------------------------------------------------------
-- Signal Declarations
------------------------------------------------------------------------
signal sys_clock: STD_LOGIC := '0';
signal enable: STD_LOGIC := '0';

-- Operators Inputs
signal operators_ready: STD_LOGIC_VECTOR(OPERATORS_NUMBER-1 downto 0) := (others => '0');
signal operators_result: STD_LOGIC_VECTOR(OPERATORS_NUMBER-1 downto 0) := (others => '0');
signal operators_next_part_request: STD_LOGIC_VECTOR(OPERATORS_NUMBER-1 downto 0) := (others => '0');

-- Operator Accumulator Outputs
signal next_part_request: STD_LOGIC := '0';
signal ready: STD_LOGIC := '0';
signal result: STD_LOGIC := '0';

------------------------------------------------------------------------
-- Module Implementation
------------------------------------------------------------------------
begin

-- System Clock
sys_clock <= not(sys_clock) after 5 ns;

-- Enable
enable <= '0', '1' after 30 ns, '0' after 200 ns, '1' after 215 ns, '0' after 300 ns, '1' after 315 ns, '0' after 450 ns, '1' after 465 ns, '0' after 640 ns, '1' after 650 ns;

-- Operators Inputs
operators_ready <= (others => '0'), "001" after 220 ns, "010" after 250 ns, "111" after 270 ns, "000" after 320 ns, "111" after 350 ns, "000" after 470 ns, "011" after 565 ns, "001" after 650 ns;
operators_result <= (others => '0'), "001" after 220 ns, "010" after 250 ns, "111" after 270 ns, "001" after 320 ns, "011" after 350 ns, "000" after 470 ns, "001" after 565 ns;
operators_next_part_request <= (others => '0'), "001" after 500 ns, "010" after 525 ns, "111" after 535 ns, "000" after 575 ns, "100" after 595 ns;

uut: OperatorAccumulator
	GENERIC MAP (
		OPERATORS_NUMBER => OPERATORS_NUMBER,
		WATCHDOG_LIMIT => 18
	)
	PORT MAP (
		i_sys_clock => sys_clock,
		i_enable => enable,
		i_operators_ready => operators_ready,
        i_operators_result => operators_result,
        i_operators_next_part_request => operators_next_part_request,
        o_next_part_request => next_part_request,
        o_ready => ready,
        o_result => result
	);

end Behavioral;