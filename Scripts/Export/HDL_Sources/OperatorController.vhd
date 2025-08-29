------------------------------------------------------------------------
-- Engineer:    Dalmasso Loic
-- Create Date: 30/07/2025
-- Module Name: OperatorController
-- Description:
--		Module in charge of controlling USB Field Verification
--
-- Usage:
--		The aim of the Operator Controller module is to register all Descriptor inputs and managing the verification operation (outputs Descriptors values & controlling internal memory)
--		The enable signal is in charge to reset the Operator Controller Module (at low) or to start it (at high)
--		After the start, the following steps are to read the Descriptor inputs to verify (Field, Value, Value Enable, Value Part Number and Last Value Part Trigger)
--		A dedicated signal is used to specify whether a Descriptor Field is present or not
--		At any time, the Verification result is evaluated:
--			When a Descriptor Value is ready to verify, the Operator Controller enable the verification (memory enable & verification enable)
--			When a new Descriptor Value part is required, the Operator Controller enable the request to get the next Value part
--			When the Verification result is SUCCESS or ERROR, the Operator Controller set the result output accordingly and set the result ready signal
--		To perform a next Descriptor Verification, the Operator Controller must be reset (enable signal at low) to act as acknowledgement
--
-- Ports
--		Input 	-	i_sys_clock: System Input Clock
--		Input 	-	i_enable: System Input Enable ('0': Disabled, '1': Enabled)
--		Input 	-	i_descriptor_field: Descriptor Field to verify
--		Input 	-	i_descriptor_field_available: Descriptor Field Available ('0': Not Available, '1': Available)
--		Input 	-	i_descriptor_value: Descriptor Value to verify
--		Input 	-	i_descriptor_value_en: Descriptor Value Quartet Enable ('0': Disabled Quartet, '1': Enabled Quartet)
--		Input 	-	i_descriptor_value_total_part_number: Descriptor Value Total Part Number to verify
--		Input 	-	i_descriptor_value_part_number: Descriptor Value Part Number to verify
--		Input 	-	i_descriptor_value_new_part: New Descriptor Value Part ('0': No New Part, '1': New Part)
--		Input 	-	i_operator_result: Operator Result
--		Output 	-	o_descriptor_field: Descriptor Field to verify
--		Output 	-	o_descriptor_field_available: Descriptor Field Available ('0': Not Available, '1': Available)
--		Output 	-	o_descriptor_value: Descriptor Value to verify
--		Output 	-	o_descriptor_value_en: Descriptor Value Quartet Enable ('0': Disabled Quartet, '1': Enabled Quartet)
--		Output 	-	o_descriptor_value_total_part_number: Descriptor Value Total Part Number to verify
--		Output 	-	o_descriptor_value_part_number: Descriptor Value Part Number to verify
--		Output 	-	o_descriptor_value_last_part: Descriptor Value Last Part ('0': Not Last Part, '1': Last Part)
--		Output 	-	o_memory_en: Verification Memory Enable ('0': Disabled, '1': Enabled)
--		Output 	-	o_verification_en: Verification Enable ('0': Disabled, '1': Enabled)
--		Output 	-	o_descriptor_value_next_part_request: Next Descriptor Value Part Request ('0': No Request, '1': New Request)
--		Output 	-	o_ready: Operator Verification Result Ready ('0': Not Ready, '1': Ready)
--		Output 	-	o_result: Operator Verification Result ('0': Error, '1': Success)
------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

-- Custom Package: USB Descriptor Fields
LIBRARY WORK;
USE WORK.USBDescriptorFields.ALL;

-- Custom Package: USB Descriptor Values
LIBRARY WORK;
USE WORK.USBDescriptorValues.ALL;

-- Custom Package: Operator Result Enum
LIBRARY WORK;
USE WORK.OperatorResultEnum.ALL;

ENTITY OperatorController is

PORT(
	i_sys_clock: IN STD_LOGIC;
	i_enable: IN STD_LOGIC;
	i_descriptor_field: IN UNSIGNED(USB_DESCRIPTOR_FIELD_BIT_LENGTH-1 downto 0);
	i_descriptor_field_available: IN STD_LOGIC;
	i_descriptor_value: IN UNSIGNED(USB_DESCRIPTOR_VALUE_DATA_BIT_LENGTH-1 downto 0);
	i_descriptor_value_en: IN STD_LOGIC_VECTOR(USB_DESCRIPTOR_VALUE_QUARTET_EN_BIT_LENGTH-1 downto 0);
	i_descriptor_value_total_part_number: IN UNSIGNED(USB_DESCRIPTOR_VALUE_PART_NUMBER_BIT_LENGTH-1 downto 0);
	i_descriptor_value_part_number: IN UNSIGNED(USB_DESCRIPTOR_VALUE_PART_NUMBER_BIT_LENGTH-1 downto 0);
	i_descriptor_value_new_part: IN STD_LOGIC;

	-- Internal Inputs/Outputs (for Operator)
	i_operator_result: IN OperatorResult;
	o_descriptor_field: OUT UNSIGNED(USB_DESCRIPTOR_FIELD_BIT_LENGTH-1 downto 0);
	o_descriptor_field_available: OUT STD_LOGIC;
	o_descriptor_value: OUT UNSIGNED(USB_DESCRIPTOR_VALUE_DATA_BIT_LENGTH-1 downto 0);
	o_descriptor_value_en: OUT STD_LOGIC_VECTOR(USB_DESCRIPTOR_VALUE_QUARTET_EN_BIT_LENGTH-1 downto 0);
	o_descriptor_value_total_part_number: OUT UNSIGNED(USB_DESCRIPTOR_VALUE_PART_NUMBER_BIT_LENGTH-1 downto 0);
	o_descriptor_value_part_number: OUT UNSIGNED(USB_DESCRIPTOR_VALUE_PART_NUMBER_BIT_LENGTH-1 downto 0);
	o_descriptor_value_last_part: OUT STD_LOGIC;
	o_memory_en: OUT STD_LOGIC;
	o_verification_en: OUT STD_LOGIC;

	-- External Outputs
	o_descriptor_value_next_part_request: OUT STD_LOGIC;
	o_ready: OUT STD_LOGIC;
	o_result: OUT STD_LOGIC
);

END OperatorController;

ARCHITECTURE Behavioral of OperatorController is

------------------------------------------------------------------------
-- Signal Declarations
------------------------------------------------------------------------
-- Operator Controller States
TYPE operatorState is (IDLE, READ_DESCRIPTOR, VERIFICATION, WAITING_NEXT_PART, VERIF_SUCCESS, VERIF_ERROR);
signal state: operatorState := IDLE;
signal next_state: operatorState;

-- Enable Register
signal enable_reg: STD_LOGIC := '0';

-- Descriptor Field
signal descriptor_field_reg: UNSIGNED(USB_DESCRIPTOR_FIELD_BIT_LENGTH-1 downto 0) := (others => '0');

-- Descriptor Field Available Register
signal descriptor_field_available_reg: STD_LOGIC := '0';

-- Descriptor Value Register
signal descriptor_value_reg: UNSIGNED(USB_DESCRIPTOR_VALUE_DATA_BIT_LENGTH-1 downto 0) := (others => '0');

-- Descriptor Value Quartet Enable Register
signal descriptor_value_en_reg: STD_LOGIC_VECTOR(USB_DESCRIPTOR_VALUE_QUARTET_EN_BIT_LENGTH-1 downto 0) := (others => '0');

-- Descriptor Value Total Part Number Register
signal descriptor_value_total_part_number_reg: UNSIGNED(USB_DESCRIPTOR_VALUE_PART_NUMBER_BIT_LENGTH-1 downto 0) := (others => '0');

-- Descriptor Value Part Number Register
signal descriptor_value_part_number_reg: UNSIGNED(USB_DESCRIPTOR_VALUE_PART_NUMBER_BIT_LENGTH-1 downto 0) := (others => '0');

-- New Descriptor Value Part Trigger Register
signal descriptor_value_new_part_reg: STD_LOGIC := '0';

-- Operator Status Register
signal operator_result_reg: OperatorResult := IDLE;

-- Operator Result Registers
signal ready_reg: STD_LOGIC:= '0';
signal result_reg: STD_LOGIC:= '0';

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

	-------------------------------------
	-- Descriptor Field Inputs Handler --
	-------------------------------------
	process(i_sys_clock)
	begin
		if rising_edge(i_sys_clock) then

			-- Read Descriptor Field Input
			if (state = READ_DESCRIPTOR) then
				descriptor_field_reg <= i_descriptor_field;
				descriptor_field_available_reg <= i_descriptor_field_available;
			end if;
		end if;
	end process;

	--------------------------------------
	-- Descriptor Values Inputs Handler --
	--------------------------------------
	process(i_sys_clock)
	begin
		if rising_edge(i_sys_clock) then

			-- Read Descriptor Values Inputs
			if (state = READ_DESCRIPTOR) then
				descriptor_value_reg <= i_descriptor_value;
				descriptor_value_en_reg <= i_descriptor_value_en;
				descriptor_value_total_part_number_reg <= i_descriptor_value_total_part_number;
				descriptor_value_part_number_reg <= i_descriptor_value_part_number;

			-- Read Descriptor Values Inputs (Do Not Read again Total Part Number)
			elsif (state = WAITING_NEXT_PART) and (descriptor_value_new_part_reg = '1') then
				descriptor_value_reg <= i_descriptor_value;
				descriptor_value_en_reg <= i_descriptor_value_en;
				descriptor_value_part_number_reg <= i_descriptor_value_part_number;
			end if;
		end if;
	end process;

	----------------------------------------
	-- New Descriptor Value Input Handler --
	----------------------------------------
	process(i_sys_clock)
	begin
		if rising_edge(i_sys_clock) then

			-- Read Descriptor Value Input
			descriptor_value_new_part_reg <= i_descriptor_value_new_part;
		end if;
	end process;

	-----------------------------------
	-- Operator Status Input Handler --
	-----------------------------------
	process(i_sys_clock)
	begin
		if rising_edge(i_sys_clock) then

			-- Read Operator Status Input
			operator_result_reg <= i_operator_result;
		end if;
	end process;

	---------------------------------------
	-- Operator Controller State Machine --
	---------------------------------------
	process(i_sys_clock)
	begin
		if rising_edge(i_sys_clock) then

			-- Reset
			if (enable_reg = '0') then
				state <= IDLE;

			-- Next State
			else
				state <= next_state;
			end if;
		end if;
	end process;

	-- Operator Controller Next State
	process(state, enable_reg, operator_result_reg, descriptor_value_new_part_reg)
	begin
		case state is

			-- IDLE
			when IDLE => 	if (enable_reg = '1') then
								next_state <= READ_DESCRIPTOR;
							else
								next_state <= IDLE;
							end if;

			-- Read Descriptor Inputs
			when READ_DESCRIPTOR => next_state <= VERIFICATION;

			-- Verification
			when VERIFICATION =>
							-- Error
							if (operator_result_reg = OP_ERROR) then
								next_state <= VERIF_ERROR;
							
							-- Success
							elsif (operator_result_reg = OP_SUCCESS) then
								next_state <= VERIF_SUCCESS;

							-- Require Next Value Part
							elsif (operator_result_reg = WAIT_NEXT_PART) then
								next_state <= WAITING_NEXT_PART;					

							-- Continue to Verify same Value Part
							else
								next_state <= VERIFICATION;
							end if;

			-- Waiting Next Value Part to Verify
			when WAITING_NEXT_PART =>
								-- New Next Value Part
								if (descriptor_value_new_part_reg = '1') then
									next_state <= VERIFICATION;
								
								-- Waiting Next Value Part
								else
									next_state <= WAITING_NEXT_PART;
								end if;

			-- Verification Error
			when VERIF_ERROR => next_state <= VERIF_ERROR;

			-- Verification Success
			when VERIF_SUCCESS => next_state <= VERIF_SUCCESS;

			-- Others States
			when others => next_state <= IDLE;
		end case;
	end process;

	---------------------------------
	-- Operator Controller Outputs --
	---------------------------------
	-- Descriptor Field & Values
	o_descriptor_field <= descriptor_field_reg;
	o_descriptor_field_available <= descriptor_field_available_reg;
	o_descriptor_value <= descriptor_value_reg;
	o_descriptor_value_en <= descriptor_value_en_reg;
	o_descriptor_value_total_part_number <= descriptor_value_total_part_number_reg;
	o_descriptor_value_part_number <= descriptor_value_part_number_reg;
	o_descriptor_value_last_part <= '1' when (descriptor_value_total_part_number_reg - descriptor_value_part_number_reg = 0) else '0';

	-- Memory Enable
	o_memory_en <= '1' when (state = VERIFICATION) or (state = WAITING_NEXT_PART) else '0';

	-- Verification Enable
	o_verification_en <= '1' when (state = VERIFICATION) else '0';

	-- Next Descriptor Value Part Request
	o_descriptor_value_next_part_request <= '1' when (state = WAITING_NEXT_PART) else '0';

	-----------------------------------------------
	-- Operator Controller Result Ready Register --
	-----------------------------------------------
	process(i_sys_clock)
	begin
		if rising_edge(i_sys_clock) then

			-- Operator Result Ready
			if (state = VERIF_SUCCESS) or (state = VERIF_ERROR) then
				ready_reg <= '1';
			else
				ready_reg <= '0';
			end if;
		end if;
	end process;
	o_ready <= ready_reg;

	-----------------------------------------
	-- Operator Controller Result Register --
	-----------------------------------------
	process(i_sys_clock)
	begin
		if rising_edge(i_sys_clock) then

			-- Operator Result Success
			if (state = VERIF_SUCCESS) then
				result_reg <= OPERATOR_RESULT_SUCCESS;
			else
				result_reg <= OPERATOR_RESULT_ERROR;
			end if;
		end if;
	end process;
	o_result <= result_reg;

end Behavioral;