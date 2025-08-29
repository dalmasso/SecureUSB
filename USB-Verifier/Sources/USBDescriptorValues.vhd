------------------------------------------------------------------------
-- Engineer:    Dalmasso Loic
-- Create Date: 30/07/2025
-- Package Name: USBDescriptorValues
-- Description:
--		Package defining USB Descriptor Value Lengths
--		Package defining Mandatory/Optional Verification Level Values
--		Package defining Value Quartet Indexes & Validity
------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

PACKAGE USBDescriptorValues is

	-- USB Descriptor Value Part Number Bit Length
	constant USB_DESCRIPTOR_VALUE_PART_NUMBER_BIT_LENGTH: INTEGER := 8;

	-- USB Descriptor Value Part Number Matching
	constant USB_DESCRIPTOR_VALUE_PART_NUMBER_MATCH: UNSIGNED(USB_DESCRIPTOR_VALUE_PART_NUMBER_BIT_LENGTH-1 downto 0) := (others => '0');

	-- USB Descriptor Value Data Bit Length
	constant USB_DESCRIPTOR_VALUE_DATA_BIT_LENGTH: INTEGER := 24;

	-- USB Descriptor Value Quartet Enable Bit Length
	constant USB_DESCRIPTOR_VALUE_QUARTET_EN_BIT_LENGTH: INTEGER := 6;

	-- USB Descriptor Value Quartet Enable Indexes
	-- Quartet 5: 23-20
	-- Quartet 4: 19-16
	-- Quartet 3: 15-12
	-- Quartet 2: 11-8
	-- Quartet 1: 7-4
	-- Quartet 0: 3-0
	constant USB_DESCRIPTOR_VALUE_QUARTET_MSB_INDEX: INTEGER := 3;
	constant USB_DESCRIPTOR_VALUE_QUARTET_LSB_INDEX: INTEGER := 0;
	constant USB_DESCRIPTOR_VALUE_QUARTET_INCREMENT_INDEX: INTEGER := 4;

	-- USB Descriptor Value Operator Quartet Enable Length
	constant USB_DESCRIPTOR_VALUE_QUARTET_Q0_Q0_OPERATOR_LENGTH: INTEGER := USB_DESCRIPTOR_VALUE_QUARTET_EN_BIT_LENGTH-1;
	constant USB_DESCRIPTOR_VALUE_QUARTET_Q1_Q0_OPERATOR_LENGTH: INTEGER := USB_DESCRIPTOR_VALUE_QUARTET_EN_BIT_LENGTH-2;
	constant USB_DESCRIPTOR_VALUE_QUARTET_Q2_Q0_OPERATOR_LENGTH: INTEGER := USB_DESCRIPTOR_VALUE_QUARTET_EN_BIT_LENGTH-3;
	constant USB_DESCRIPTOR_VALUE_QUARTET_Q3_Q0_OPERATOR_LENGTH: INTEGER := USB_DESCRIPTOR_VALUE_QUARTET_EN_BIT_LENGTH-4;
	constant USB_DESCRIPTOR_VALUE_QUARTET_Q4_Q0_OPERATOR_LENGTH: INTEGER := USB_DESCRIPTOR_VALUE_QUARTET_EN_BIT_LENGTH-5;
	constant USB_DESCRIPTOR_VALUE_QUARTET_Q5_Q0_OPERATOR_LENGTH: INTEGER := USB_DESCRIPTOR_VALUE_QUARTET_EN_BIT_LENGTH-6;

	-- USB Descriptor Value Quartets Enable
	constant USB_DESCRIPTOR_VALUE_QUARTET_EN_1: STD_LOGIC := '1';
	constant USB_DESCRIPTOR_VALUE_QUARTET_EN_2: STD_LOGIC_VECTOR(1 downto 0) := (others => '1');
	constant USB_DESCRIPTOR_VALUE_QUARTET_EN_3: STD_LOGIC_VECTOR(2 downto 0) := (others => '1');
	constant USB_DESCRIPTOR_VALUE_QUARTET_EN_4: STD_LOGIC_VECTOR(3 downto 0) := (others => '1');
	constant USB_DESCRIPTOR_VALUE_QUARTET_EN_5: STD_LOGIC_VECTOR(4 downto 0) := (others => '1');
	constant USB_DESCRIPTOR_VALUE_QUARTET_EN_6: STD_LOGIC_VECTOR(5 downto 0) := (others => '1');

	-- USB Descriptor Value All Valud Quartets Reference Value
	constant USB_DESCRIPTOR_VALUE_ALL_QUARTETS_VALID: STD_LOGIC_VECTOR(USB_DESCRIPTOR_VALUE_QUARTET_EN_BIT_LENGTH-1 downto 0) := (others => '1');

	-- USB Descriptor Value Verification Level Bit Length & Values
	constant USB_DESCRIPTOR_VALUE_VERIF_LEVEL_BIT_LENGTH: INTEGER := 1;
	constant USB_DESCRIPTOR_VALUE_VERIF_MANDATORY_LEVEL: STD_LOGIC := '1';
	constant USB_DESCRIPTOR_VALUE_VERIF_OPTIONAL_LEVEL: STD_LOGIC := '0';

	-- USB Descriptor Value Total Bit Length
	constant USB_DESCRIPTOR_VALUE_TOTAL_BIT_LENGTH: INTEGER := USB_DESCRIPTOR_VALUE_PART_NUMBER_BIT_LENGTH + USB_DESCRIPTOR_VALUE_DATA_BIT_LENGTH + USB_DESCRIPTOR_VALUE_QUARTET_EN_BIT_LENGTH + USB_DESCRIPTOR_VALUE_VERIF_LEVEL_BIT_LENGTH;

END PACKAGE USBDescriptorValues;