------------------------------------------------------------------------
-- Engineer:    Dalmasso Loic
-- Create Date: 25/08/2025
-- Module Name: USBVerifierWrapper
-- Description:
--		The USBVerifier Wrapper Module embedds USBVerifier and all components required to perform USB Verification Field Values
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
--		Output 	-	o_descriptor_value_next_part_request: Next Descriptor Value Part Request ('0': No Request, '1': New Request)
--		Output 	-	o_ready: Verification Result Ready ('0': Not Ready, '1': Ready)
--		Output 	-	o_result: Verification Result ('0': Error, '1': Success)
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

ENTITY Testbench_USBVerifierWrapper is
--  Port ( );
END Testbench_USBVerifierWrapper;

ARCHITECTURE Behavioral of Testbench_USBVerifierWrapper is

------------------------------------------------------------------------
-- Component Declarations
------------------------------------------------------------------------
COMPONENT USBVerifierWrapper is

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
signal descriptor_field: UNSIGNED(USB_DESCRIPTOR_FIELD_BIT_LENGTH-1 downto 0) := (others => '0');
signal descriptor_field_available: STD_LOGIC := '0';
signal descriptor_value: UNSIGNED(USB_DESCRIPTOR_VALUE_DATA_BIT_LENGTH-1 downto 0) := (others => '0');
signal descriptor_value_en: STD_LOGIC_VECTOR(USB_DESCRIPTOR_VALUE_QUARTET_EN_BIT_LENGTH-1 downto 0) := (others => '0');
signal descriptor_value_total_part_number: UNSIGNED(USB_DESCRIPTOR_VALUE_PART_NUMBER_BIT_LENGTH-1 downto 0) := (others => '0');
signal descriptor_value_part_number: UNSIGNED(USB_DESCRIPTOR_VALUE_PART_NUMBER_BIT_LENGTH-1 downto 0) := (others => '0');
signal descriptor_value_new_part: STD_LOGIC := '0';
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

-- Descriptor Field & Value
descriptor_field <= DEVICE_BLENGTH_TYPE, DEVICE_BCDUSB_TYPE after 135 ns;
descriptor_field_available <= '0', '1' after 175 ns;
descriptor_value <= (others => '0');
descriptor_value_en <= (others => '1');
descriptor_value_total_part_number <= "00000011";
descriptor_value_part_number <= (others => '0'), "00000001" after 285 ns, "00000010" after 315 ns;
descriptor_value_new_part <= '0', '1' after 285 ns;

uut: USBVerifierWrapper
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
		o_descriptor_value_next_part_request => descriptor_value_next_part_request,
		o_ready => ready,
		o_result => result
	);

end Behavioral;