------------------------------------------------------------------------
-- Engineer:    Dalmasso Loic
-- Create Date: 30/07/2025
-- Package Name: MemoryDataMapping
-- Description:
--		Package defining Memory DataFormat: Value Part Number (8 bits) - Expected Value (24 bits) - Quartet Enable (6 bits) - Verification Level (1 bit)
--		Package defining Memory Data Bit Lengths & Indexes (Part Number, Expected Value, Quartet Enable, Verification Level)
--		Package defining Memory Unknown Address Index & Count Values
------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Custom Package: USB Descriptor Values
LIBRARY WORK;
USE WORK.USBDescriptorValues.ALL;

PACKAGE MemoryDataMapping is

	-- Memory Data Total Length
	constant MEM_TOTAL_DATA_LENGTH: INTEGER := USB_DESCRIPTOR_VALUE_TOTAL_BIT_LENGTH;

	-- Memory Data Part Number Length & Indexes
	constant MEM_DATA_PART_NUMBER_LENGTH: INTEGER := USB_DESCRIPTOR_VALUE_PART_NUMBER_BIT_LENGTH;
	constant MEM_DATA_PART_NUMBER_MSB_INDEX: INTEGER := 38;
	constant MEM_DATA_PART_NUMBER_LSB_INDEX: INTEGER := 31;

	-- Memory Data Length & Indexes
	constant MEM_DATA_LENGTH: INTEGER := USB_DESCRIPTOR_VALUE_DATA_BIT_LENGTH;
	constant MEM_DATA_MSB_INDEX: INTEGER := 30;
	constant MEM_DATA_LSB_INDEX: INTEGER := 7;

	-- Memory Data Quartet Indexes
	constant MEM_DATA_QUARTET_MSB_INDEX: INTEGER := MEM_DATA_LENGTH-1;
	constant MEM_DATA_QUARTET_LSB_INDEX: INTEGER := MEM_DATA_LENGTH-4;

	-- Memory Data Quartet Enable Length & Indexes
	constant MEM_DATA_QUARTET_ENABLE_LENGTH: INTEGER := USB_DESCRIPTOR_VALUE_QUARTET_EN_BIT_LENGTH;
	constant MEM_DATA_QUARTET_ENABLE_MSB_INDEX: INTEGER := 6;
	constant MEM_DATA_QUARTET_ENABLE_LSB_INDEX: INTEGER := 1;
	constant MEM_DATA_QUARTET_INCREMENT_INDEX: INTEGER := 4;

	-- Memory Data Quartets Enable/Disable
	constant MEM_DATA_QUARTET_Q5_Q0_ENABLE: STD_LOGIC_VECTOR(MEM_DATA_QUARTET_ENABLE_LENGTH-1 downto 0) := (others => '1');
	constant MEM_DATA_QUARTET_Q4_Q0_ENABLE: STD_LOGIC_VECTOR(MEM_DATA_QUARTET_ENABLE_LENGTH-1 downto 0) := (MEM_DATA_QUARTET_ENABLE_LENGTH-1 => '0', others => '1');
	constant MEM_DATA_QUARTET_Q3_Q0_ENABLE: STD_LOGIC_VECTOR(MEM_DATA_QUARTET_ENABLE_LENGTH-1 downto 0) := (MEM_DATA_QUARTET_ENABLE_LENGTH-1 => '0', MEM_DATA_QUARTET_ENABLE_LENGTH-2 => '0', others => '1');
	constant MEM_DATA_QUARTET_Q2_Q0_ENABLE: STD_LOGIC_VECTOR(MEM_DATA_QUARTET_ENABLE_LENGTH-1 downto 0) := (MEM_DATA_QUARTET_ENABLE_LENGTH-1 => '0', MEM_DATA_QUARTET_ENABLE_LENGTH-2 => '0', MEM_DATA_QUARTET_ENABLE_LENGTH-3 => '0', others => '1');
	constant MEM_DATA_QUARTET_Q1_Q0_ENABLE: STD_LOGIC_VECTOR(MEM_DATA_QUARTET_ENABLE_LENGTH-1 downto 0) := (MEM_DATA_QUARTET_ENABLE_LENGTH-1 => '0', MEM_DATA_QUARTET_ENABLE_LENGTH-2 => '0', MEM_DATA_QUARTET_ENABLE_LENGTH-3 => '0', MEM_DATA_QUARTET_ENABLE_LENGTH-4 => '0', others => '1');
	constant MEM_DATA_QUARTET_Q0_Q0_ENABLE: STD_LOGIC_VECTOR(MEM_DATA_QUARTET_ENABLE_LENGTH-1 downto 0) := (MEM_DATA_QUARTET_ENABLE_LENGTH-1 => '0', MEM_DATA_QUARTET_ENABLE_LENGTH-2 => '0', MEM_DATA_QUARTET_ENABLE_LENGTH-3 => '0', MEM_DATA_QUARTET_ENABLE_LENGTH-4 => '0', MEM_DATA_QUARTET_ENABLE_LENGTH-5 => '0', others => '1');

	-- Memory Data Quartets All Disable
	constant MEM_DATA_QUARTET_ALL_DISABLE: STD_LOGIC_VECTOR(MEM_DATA_QUARTET_ENABLE_LENGTH-1 downto 0) := (others => '0');

	-- Memory Data Quartets Shifter
	constant MEM_DATA_QUARTET_SHIFTER: STD_LOGIC_VECTOR(MEM_DATA_QUARTET_INCREMENT_INDEX-1 downto 0) := (others => '0');

	-- Memory Data Verification Level Index
	constant MEM_DATA_VERIF_LEVEL_INDEX: INTEGER := 0;

	-- Memory Unknown Index & Count Values
	constant MEM_UNKNOWN_INDEX: INTEGER := 0;
	constant MEM_UNKNOWN_COUNT: INTEGER := 0;

END PACKAGE MemoryDataMapping;