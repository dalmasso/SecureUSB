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
USE IEEE.NUMERIC_STD.ALL;

-- Custom Package: Operator Result Enum
LIBRARY WORK;
USE WORK.OperatorResultEnum.ALL;

ENTITY OperatorAccumulator is

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

END OperatorAccumulator;

ARCHITECTURE Behavioral of OperatorAccumulator is

------------------------------------------------------------------------
-- Component Declarations
------------------------------------------------------------------------
-- Operator Watchdog
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
-- Operators Error Detection (at least 1 Operators in Error)
constant OPERATORS_ERROR_DETECTION_VALUE: UNSIGNED(OPERATORS_NUMBER-1 downto 0) := (0=>'1', others=>'0');

-- Operators Ready
constant OPERATORS_READY_VALUE: STD_LOGIC_VECTOR(OPERATORS_NUMBER-1 downto 0) := (others => '1');

-- Operators Success
constant OPERATORS_SUCCESS_VALUE: STD_LOGIC_VECTOR(OPERATORS_NUMBER-1 downto 0) := (others => OPERATOR_RESULT_SUCCESS);

-- Operators End of Verification Cycle
constant OPERATORS_END_CYCLE_VALUE: STD_LOGIC_VECTOR(OPERATORS_NUMBER-1 downto 0) := (others => '1');

-- Operators Next Part Value (at least 1 Operators request Next Part)
constant OPERATORS_NEXT_PART_VALUE: UNSIGNED(OPERATORS_NUMBER-1 downto 0) := (0=>'1', others=>'0');

------------------------------------------------------------------------
-- Signal Declarations
------------------------------------------------------------------------
-- Operator Accumulator States
TYPE operatorAccumulatorState is (IDLE, WAITING_OPERATORS, NEXT_PART_REQUEST, VERIF_SUCCESS, VERIF_ERROR);
signal state: operatorAccumulatorState := IDLE;
signal next_state: operatorAccumulatorState;

-- Enable Register
signal enable_reg: STD_LOGIC := '0';

-- Operators Inputs Registers
signal operators_ready_reg: STD_LOGIC_VECTOR(OPERATORS_NUMBER-1 downto 0) := (others => '0');
signal operators_result_reg: STD_LOGIC_VECTOR(OPERATORS_NUMBER-1 downto 0) := (others => '0');
signal operators_next_part_request_reg: UNSIGNED(OPERATORS_NUMBER-1 downto 0) := (others => '0');

-- Operators Error Detection
signal operators_error: UNSIGNED(OPERATORS_NUMBER-1 downto 0) := (others => '0');

-- Operators End of Verification Cycle (each Operator with either Ready or Next Part Request signal set)
signal operators_end_cycle: STD_LOGIC_VECTOR(OPERATORS_NUMBER-1 downto 0) := (others => '0');

-- Operator Accumulator Output Registers
signal op_accu_next_part_out_reg: STD_LOGIC:= '0';
signal op_accu_ready_out_reg: STD_LOGIC:= '0';
signal op_accu_result_out_reg: STD_LOGIC:= '0';

-- Watchdog Enable
signal watchdog_en: STD_LOGIC := '0';

-- Watchdog Trigger
signal watchdog_trigger: STD_LOGIC := '0';

------------------------------------------------------------------------
-- Module Implementation
------------------------------------------------------------------------
begin

	--------------------------
	-- Enable Input Handler --
	--------------------------
	process(i_sys_clock)
	begin
		if rising_edge(i_sys_clock) then

			-- Read Enable Input
			enable_reg <= i_enable;
		end if;
	end process;

	------------------------------
	-- Operators Inputs Handler --
	------------------------------
	process(i_sys_clock)
	begin
		if rising_edge(i_sys_clock) then

			-- Read Operators Inputs
			if (enable_reg = '1') then
				operators_ready_reg <= i_operators_ready;
				operators_result_reg <= i_operators_result;
				operators_next_part_request_reg <= UNSIGNED(i_operators_next_part_request);
			end if;
		end if;
	end process;

	-------------------------------
	-- Operators Error Detection --
	-------------------------------
	ops_error_detection: for i in 0 to OPERATORS_NUMBER-1 generate
		operators_error(i) <= '1' when (operators_ready_reg(i) = '1') and (operators_result_reg(i) = OPERATOR_RESULT_ERROR) else '0';
	end generate ops_error_detection;

	-----------------------------------------
	-- Operators End of Verification Cycle --
	-----------------------------------------
	ops_end_cycle: for i in 0 to OPERATORS_NUMBER-1 generate
		operators_end_cycle(i) <= '1' when (operators_ready_reg(i) = '1') or (operators_next_part_request_reg(i) = '1') else '0';
	end generate ops_end_cycle;

	----------------------------------------
	-- Operator Accumulator State Machine --
	----------------------------------------
	process(i_sys_clock)
	begin
		if rising_edge(i_sys_clock) then

			-- Reset
			if (enable_reg = '0') then
				state <= IDLE;

			-- Watchdog Trigger
			elsif (watchdog_trigger = '1') then
				state <= VERIF_ERROR;
				
			-- Next State
			else
				state <= next_state;
			end if;
		end if;
	end process;

	-- Operator Accumulator Next State
	process(state, enable_reg, operators_error, operators_end_cycle, operators_next_part_request_reg, operators_ready_reg, operators_result_reg)
	begin
		case state is

			-- IDLE
			when IDLE => 	if (enable_reg = '1') then
								next_state <= WAITING_OPERATORS;
							else
								next_state <= IDLE;
							end if;

			-- Waiting Operators
			when WAITING_OPERATORS =>
							-- Operator Error Detection (at least 1 Operators in Error)
							if (operators_error >= OPERATORS_ERROR_DETECTION_VALUE) then
								next_state <= VERIF_ERROR;
							
							-- Operators Next Part Request (all Operators ends verification cycle and at least 1 Operators request Next Part)
							elsif (operators_end_cycle = OPERATORS_END_CYCLE_VALUE) and (operators_next_part_request_reg >= OPERATORS_NEXT_PART_VALUE) then
								next_state <= NEXT_PART_REQUEST;

							-- Operators Ready
							elsif (operators_ready_reg = OPERATORS_READY_VALUE) then

								-- Verification Success
								if (operators_result_reg = OPERATORS_SUCCESS_VALUE) then
									next_state <= VERIF_SUCCESS;

								-- Verification Error
								else
									next_state <= VERIF_ERROR;
								end if;

							-- Operator Accumulator Not Ready
							else
								next_state <= WAITING_OPERATORS;
							end if;

			-- Next Part Request
			when NEXT_PART_REQUEST => next_state <= WAITING_OPERATORS;
		
			-- Verification Error
			when VERIF_ERROR => next_state <= VERIF_ERROR;

			-- Verification Success
			when VERIF_SUCCESS => next_state <= VERIF_SUCCESS;

			-- Others states
			when others => next_state <= IDLE;
		end case;
	end process;

	---------------------------------------------------
	-- Operator Accumulator Next Part Request Output --
	---------------------------------------------------
	process(i_sys_clock)
	begin
		if rising_edge(i_sys_clock) then

			-- Next Part Request
			if (state = NEXT_PART_REQUEST) then
				op_accu_next_part_out_reg <= '1';
			else
				op_accu_next_part_out_reg <= '0';
			end if;
		end if;
	end process;
	o_next_part_request <= op_accu_next_part_out_reg;

	---------------------------------------
	-- Operator Accumulator Ready Output --
	---------------------------------------
	process(i_sys_clock)
	begin
		if rising_edge(i_sys_clock) then

			-- Operator Accumulator Result Ready
			if (state = VERIF_SUCCESS) or (state = VERIF_ERROR) then
				op_accu_ready_out_reg <= '1';
			else
				op_accu_ready_out_reg <= '0';
			end if;
		end if;
	end process;
	o_ready <= op_accu_ready_out_reg;

	----------------------------------------
	-- Operator Accumulator Result Output --
	----------------------------------------
	process(i_sys_clock)
	begin
		if rising_edge(i_sys_clock) then

			-- Operator Accumulator Result Success
			if (state = VERIF_SUCCESS) then
				op_accu_result_out_reg <= OPERATOR_RESULT_SUCCESS;
			else
				op_accu_result_out_reg <= OPERATOR_RESULT_ERROR;
			end if;
		end if;
	end process;
	o_result <= op_accu_result_out_reg;

	------------------------------
	-- Operator Watchdog Enable --
	------------------------------
	watchdog_en <= '1' when (state = WAITING_OPERATORS) or (state = NEXT_PART_REQUEST) else '0';

	-----------------------
	-- Operator Watchdog --
	-----------------------
	operatorAccuWatchdog: OperatorWatchdog
		GENERIC MAP (
			WATCHDOG_LIMIT => WATCHDOG_LIMIT,
			INPUT_LENGTH => OPERATORS_NUMBER
		)
		PORT MAP (
			i_sys_clock => i_sys_clock,
			i_enable => watchdog_en,
			i_watching_inputs => operators_end_cycle,
			o_watchdog_trigger => watchdog_trigger
		);

end Behavioral;