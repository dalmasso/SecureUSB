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

ENTITY Testbench_OperatorController is
--  Port ( );
END Testbench_OperatorController;

ARCHITECTURE Behavioral of Testbench_OperatorController is

------------------------------------------------------------------------
-- Component Declarations
------------------------------------------------------------------------
COMPONENT OperatorController is

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

END COMPONENT;

------------------------------------------------------------------------
-- Signal Declarations
------------------------------------------------------------------------
signal sys_clock: STD_LOGIC := '0';
signal enable: STD_LOGIC := '0';

-- Inputs
signal descriptor_field: UNSIGNED(USB_DESCRIPTOR_FIELD_BIT_LENGTH-1 downto 0) := (others => '0');
signal descriptor_field_available: STD_LOGIC := '0';
signal descriptor_value: UNSIGNED(USB_DESCRIPTOR_VALUE_DATA_BIT_LENGTH-1 downto 0) := (others => '0');
signal descriptor_value_en: STD_LOGIC_VECTOR(USB_DESCRIPTOR_VALUE_QUARTET_EN_BIT_LENGTH-1 downto 0) := (others => '0');
signal descriptor_value_total_part_number: UNSIGNED(USB_DESCRIPTOR_VALUE_PART_NUMBER_BIT_LENGTH-1 downto 0) := (others => '0');
signal descriptor_value_part_number: UNSIGNED(USB_DESCRIPTOR_VALUE_PART_NUMBER_BIT_LENGTH-1 downto 0) := (others => '0');
signal descriptor_value_new_part: STD_LOGIC := '0';
signal operator_result: OperatorResult := IDLE;

-- Outputs
signal out_descriptor_field: UNSIGNED(USB_DESCRIPTOR_FIELD_BIT_LENGTH-1 downto 0) := (others => '0');
signal out_descriptor_field_available: STD_LOGIC := '0';
signal out_descriptor_value: UNSIGNED(USB_DESCRIPTOR_VALUE_DATA_BIT_LENGTH-1 downto 0) := (others => '0');
signal out_descriptor_value_en: STD_LOGIC_VECTOR(USB_DESCRIPTOR_VALUE_QUARTET_EN_BIT_LENGTH-1 downto 0) := (others => '0');
signal out_descriptor_value_total_part_number: UNSIGNED(USB_DESCRIPTOR_VALUE_PART_NUMBER_BIT_LENGTH-1 downto 0) := (others => '0');
signal out_descriptor_value_part_number: UNSIGNED(USB_DESCRIPTOR_VALUE_PART_NUMBER_BIT_LENGTH-1 downto 0) := (others => '0');
signal out_descriptor_value_last_part: STD_LOGIC := '0';
signal memory_en: STD_LOGIC := '0';
signal verification_en: STD_LOGIC := '0';
signal descriptor_value_next_part_request: STD_LOGIC := '0';
signal ready: STD_LOGIC := '0';
signal result: STD_LOGIC := '0';

------------------------------------------------------------------------
-- Module Implementation
------------------------------------------------------------------------
begin

-- System Clock
sys_clock <= not(sys_clock) after 5 ns;

-- Enable
enable <= '0', '1' after 30 ns, '0' after 135 ns, '1' after 145 ns;

-- Descriptor Field & Values Signals
descriptor_field <= DEVICE_BLENGTH_TYPE, DEVICE_BCDUSB_TYPE after 45 ns, DEVICE_BDEVICECLASS_TYPE after 115 ns;
descriptor_field_available <= '0', '1' after 115 ns;
descriptor_value <= x"ABCDEF", x"FFFFFF" after 60 ns, x"012345" after 115 ns;
descriptor_value_en <= "000111", "111111" after 60 ns, "001100" after 115 ns;
descriptor_value_total_part_number <= "00000011";
descriptor_value_part_number <= "00000001", "11000000" after 60 ns, "11010111" after 115 ns;
descriptor_value_new_part <= '0', '1' after 195 ns;
operator_result <= IDLE, IN_PROGRESS after 65 ns, OP_ERROR after 80 ns, OP_SUCCESS after 95 ns, IN_PROGRESS after 115 ns, WAIT_NEXT_PART after 165 ns, OP_SUCCESS after 180 ns;

uut: OperatorController
	PORT MAP (
		i_sys_clock => sys_clock,
		i_enable => enable,
		i_descriptor_field => descriptor_field,
		i_descriptor_field_available => descriptor_field_available,
		i_descriptor_value => descriptor_value,
		i_descriptor_value_en => descriptor_value_en,
		i_descriptor_value_total_part_number => descriptor_value_total_part_number,
		i_descriptor_value_part_number => descriptor_value_part_number,
		i_descriptor_value_new_part => descriptor_value_new_part,

        i_operator_result => operator_result,
        o_descriptor_field => out_descriptor_field,
		o_descriptor_field_available => out_descriptor_field_available,
        o_descriptor_value => out_descriptor_value,
        o_descriptor_value_en => out_descriptor_value_en,
		o_descriptor_value_total_part_number => out_descriptor_value_total_part_number,
        o_descriptor_value_part_number => out_descriptor_value_part_number,
        o_descriptor_value_last_part => out_descriptor_value_last_part,
        o_memory_en => memory_en,
        o_verification_en => verification_en,

        o_descriptor_value_next_part_request => descriptor_value_next_part_request,
        o_ready => ready,
        o_result => result
	);

end Behavioral;