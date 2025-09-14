------------------------------------------------------------------------
-- Engineer:    Dalmasso Loic
-- Create Date: 18/08/2025
-- Module Name: LessOperator
-- Description:
--		Module in charge of applying Less operation on USB Field Value and Expected Value(s)
--
-- Usage:
--		Less Operator embedds Operator Controller (Input/Outputs controller), Memory Controller (Verification Values Controller) and Verification ROM (Verification Values)
--		The Less Operator contains all information regarding each Verification Values Index & Count for each Descriptor Field
--		According to the Descriptor Field & Value inputs, the Less Operator select the right Index & Count and configure the Memory Controller in charge of get Verification Values
--		The enable signal is in charge to reset the Less Operator Module (at low) or to start it (at high)
--		A dedicated signal is used to specify whether a Descriptor Field is present or not
--		Less Operator implements the entire Less operation between Descriptor Value Input & Verification Values:
--			- No Verification Value: Success
--			- Mismatch between Descriptor Value Input & Verification Value Part Number: request next Part Number
--			- Compare each Descriptor Value Input & Verification Value Quartets
--			- All Mandatory Verification Values MUST Success
--			- At least 1 Optional Verification Value MUST Success
--
-- Generics:
--		MEMORY_ADDR_LENGTH: Define the Memory Address Bus Length (in line with the maximum index value)
--		MEMORY_ADDR_MAX_INDEX: Define the Memory Maximum Address (in line with the maximum index value)
--		MEMORY_ADDR_MAX_COUNT: Define the Memory Maximum Address Count (in line with the maximum count value)
--		DEVICE_BLENGTH_INDEX: Device Descriptor Length USB Field Index
--		DEVICE_BLENGTH_COUNT: Device Descriptor Length USB Field Count
--		DEVICE_BCDUSB_INDEX: Device Descriptor USB Release Number Field Index
--		DEVICE_BCDUSB_COUNT: Device Descriptor USB Release Number Field Count
--		DEVICE_BDEVICECLASS_INDEX: Device Descriptor Device Class USB Field Index
--		DEVICE_BDEVICECLASS_COUNT: Device Descriptor Device Class USB Field Count
--		DEVICE_BDEVICESUBCLASS_INDEX: Device Descriptor Device Sub Class USB Field Index
--		DEVICE_BDEVICESUBCLASS_COUNT: Device Descriptor Device Sub Class USB Field Count
--		DEVICE_BDEVICEPROTOCOL_INDEX: Device Descriptor Device Protocol USB Field Index
--		DEVICE_BDEVICEPROTOCOL_COUNT: Device Descriptor Device Protocol USB Field Count
--		DEVICE_BMAXPACKETSIZE0_INDEX: Device Descriptor Max Packet Size0 USB Field Index
--		DEVICE_BMAXPACKETSIZE0_COUNT: Device Descriptor Max Packet Size0 USB Field Count
--		DEVICE_IDVENDOR_INDEX: Device Descriptor Vendor USB Field Index
--		DEVICE_IDVENDOR_COUNT: Device Descriptor Vendor USB Field Count
--		DEVICE_IDPRODUCT_INDEX: Device Descriptor Product USB Field Index
--		DEVICE_IDPRODUCT_COUNT: Device Descriptor Product USB Field Count
--		DEVICE_BCDDEVICE_INDEX: Device Descriptor Device Release Number USB Field Index
--		DEVICE_BCDDEVICE_COUNT: Device Descriptor Device Release Number USB Field Count
--		DEVICE_IMANUFACTURER_BLENGTH_INDEX: Device Descriptor Manufacturer String Length USB Field Index
--		DEVICE_IMANUFACTURER_BLENGTH_COUNT: Device Descriptor Manufacturer String Length USB Field Count
--		DEVICE_IMANUFACTURER_INDEX: Device Descriptor Manufacturer String USB Field Index
--		DEVICE_IMANUFACTURER_COUNT: Device Descriptor Manufacturer String USB Field Count
--		DEVICE_IPRODUCT_BLENGTH_INDEX: Device Descriptor Product String Length USB Field Index
--		DEVICE_IPRODUCT_BLENGTH_COUNT: Device Descriptor Product String Length USB Field Count
--		DEVICE_IPRODUCT_INDEX: Device Descriptor Product String USB Field Index
--		DEVICE_IPRODUCT_COUNT: Device Descriptor Product String USB Field Count
--		DEVICE_ISERIALNUMBER_BLENGTH_INDEX: Device Descriptor Serial Number String Length USB Field Index
--		DEVICE_ISERIALNUMBER_BLENGTH_COUNT: Device Descriptor Serial Number String Length USB Field Count
--		DEVICE_ISERIALNUMBER_INDEX: Device Descriptor Serial Number String USB Field Index
--		DEVICE_ISERIALNUMBER_COUNT: Device Descriptor Serial Number String USB Field Count
--		DEVICE_BNUMCONFIGURATIONS_INDEX: Device Descriptor Num Configuration USB Field Index
--		DEVICE_BNUMCONFIGURATIONS_COUNT: Device Descriptor Num Configuration USB Field Count
--		CONFIGURATION_BLENGTH_INDEX: Configuration Descriptor Length USB Field Index
--		CONFIGURATION_BLENGTH_COUNT: Configuration Descriptor Length USB Field Count
--		CONFIGURATION_WTOTALLENGTH_INDEX: Configuration Descriptor Total Length USB Field Index
--		CONFIGURATION_WTOTALLENGTH_COUNT: Configuration Descriptor Total Length USB Field Count
--		CONFIGURATION_BNUMINTERFACES_INDEX: Configuration Descriptor Num Interfaces USB Field Index
--		CONFIGURATION_BNUMINTERFACES_COUNT: Configuration Descriptor Num Interfaces USB Field Count
--		CONFIGURATION_BCONFIGURATIONVALUE_INDEX: Configuration Descriptor Configuration Value USB Field Index
--		CONFIGURATION_BCONFIGURATIONVALUE_COUNT: Configuration Descriptor Configuration Value USB Field Count
--		CONFIGURATION_ICONFIGURATION_BLENGTH_INDEX: Configuration Descriptor Configuration String Length USB Field Index
--		CONFIGURATION_ICONFIGURATION_BLENGTH_COUNT: Configuration Descriptor Configuration String Length USB Field Count
--		CONFIGURATION_ICONFIGURATION_INDEX: Configuration Descriptor Configuration String USB Field Index
--		CONFIGURATION_ICONFIGURATION_COUNT: Configuration Descriptor Configuration String USB Field Count
--		CONFIGURATION_BMATTRIBUTES_INDEX: Configuration Descriptor Attributes USB Field Index
--		CONFIGURATION_BMATTRIBUTES_COUNT: Configuration Descriptor Attributes USB Field Count
--		CONFIGURATION_BMAXPOWER_INDEX: Configuration Descriptor Max Power USB Field Index
--		CONFIGURATION_BMAXPOWER_COUNT: Configuration Descriptor Max Power USB Field Count
--		INTERFACE_BLENGTH_INDEX: Interface Descriptor Length USB Field Index
--		INTERFACE_BLENGTH_COUNT: Interface Descriptor Length USB Field Count
--		INTERFACE_BINTERFACENUMBER_INDEX: Interface Descriptor Interface Number USB Field Index
--		INTERFACE_BINTERFACENUMBER_COUNT: Interface Descriptor Interface Number USB Field Count
--		INTERFACE_BALTERNATESETTING_INDEX: Interface Descriptor Alternate Setting USB Field Index
--		INTERFACE_BALTERNATESETTING_COUNT: Interface Descriptor Alternate Setting USB Field Count
--		INTERFACE_BNUMENDPOINTS_INDEX: Interface Descriptor Num Endpoints USB Field Index
--		INTERFACE_BNUMENDPOINTS_COUNT: Interface Descriptor Num Endpoints USB Field Count
--		INTERFACE_BINTERFACECLASS_INDEX: Interface Descriptor Interface Class USB Field Index
--		INTERFACE_BINTERFACECLASS_COUNT: Interface Descriptor Interface Class USB Field Count
--		INTERFACE_BINTERFACESUBCLASS_INDEX: Interface Descriptor Interface Sub Class USB Field Index
--		INTERFACE_BINTERFACESUBCLASS_COUNT: Interface Descriptor Interface Sub Class USB Field Count
--		INTERFACE_BINTERFACEPROTOCOL_INDEX: Interface Descriptor Interface Protocol USB Field Index
--		INTERFACE_BINTERFACEPROTOCOL_COUNT: Interface Descriptor Interface Protocol USB Field Count
--		INTERFACE_IINTERFACE_BLENGTH_INDEX: Interface Descriptor Interface String Length USB Field Index
--		INTERFACE_IINTERFACE_BLENGTH_COUNT: Interface Descriptor Interface String Length USB Field Count
--		INTERFACE_IINTERFACE_INDEX: Interface Descriptor Interface String USB Field Index
--		INTERFACE_IINTERFACE_COUNT: Interface Descriptor Interface String USB Field Count
--		HID_BLENGTH_INDEX: HID Descriptor Length USB Field Index
--		HID_BLENGTH_COUNT: HID Descriptor Length USB Field Count
--		HID_BCDHID_INDEX: HID Descriptor HID USB Field Index
--		HID_BCDHID_COUNT: HID Descriptor HID USB Field Count
--		HID_BCOUNTRYCODE_INDEX: HID Descriptor Country Code USB Field Index
--		HID_BCOUNTRYCODE_COUNT: HID Descriptor Country Code USB Field Count
--		HID_BNUMDESCRIPTORS_INDEX: HID Descriptor Num Descriptors USB Field Index
--		HID_BNUMDESCRIPTORS_COUNT: HID Descriptor Num Descriptors USB Field Count
--		HID_BDESCRIPTORTYPE_INDEX: HID Descriptor Descriptor Type USB Field Index
--		HID_BDESCRIPTORTYPE_COUNT: HID Descriptor Descriptor Type USB Field Count
--		HID_WDESCRIPTORLENGTH_INDEX: HID Descriptor Descriptor Length USB Field Index
--		HID_WDESCRIPTORLENGTH_COUNT: HID Descriptor Descriptor Length USB Field Count
--		ENDPOINT_BLENGTH_INDEX: Endpoint Descriptor Length USB Field Index
--		ENDPOINT_BLENGTH_COUNT: Endpoint Descriptor Length USB Field Count
--		ENDPOINT_BENDPOINTADDRESS_INDEX: Endpoint Descriptor Endpoint Address USB Field Index
--		ENDPOINT_BENDPOINTADDRESS_COUNT: Endpoint Descriptor Endpoint Address USB Field Count
--		ENDPOINT_BMATTRIBUTES_INDEX: Endpoint Descriptor Attributes USB Field Index
--		ENDPOINT_BMATTRIBUTES_COUNT: Endpoint Descriptor Attributes USB Field Count
--		ENDPOINT_WMAXPACKETSIZE_INDEX: Endpoint Descriptor Max Packet Size USB Field Index
--		ENDPOINT_WMAXPACKETSIZE_COUNT: Endpoint Descriptor Max Packet Size USB Field Count
--		ENDPOINT_BINTERVAL_INDEX: Endpoint Descriptor Interval USB Field Index
--		ENDPOINT_BINTERVAL_COUNT: Endpoint Descriptor Interval USB Field Count
--		DEVICE_QUALIFIER_BLENGTH_INDEX: Device Qualifier Descriptor Length USB Field Index
--		DEVICE_QUALIFIER_BLENGTH_COUNT: Device Qualifier Descriptor Length USB Field Count
--		DEVICE_QUALIFIER_BCDUSB_INDEX: Device Qualifier Descriptor USB Release Number Field Index
--		DEVICE_QUALIFIER_BCDUSB_COUNT: Device Qualifier Descriptor USB Release Number Field Count
--		DEVICE_QUALIFIER_BDEVICECLASS_INDEX: Device Qualifier Descriptor Device Class USB Field
--		DEVICE_QUALIFIER_BDEVICECLASS_COUNT: Device Qualifier Descriptor Device Class USB Field
--		DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX: Device Qualifier Descriptor Device Sub Class USB Field
--		DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT: Device Qualifier Descriptor Device Sub Class USB Field
--		DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX: Device Qualifier Descriptor Device Protocol USB Field
--		DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT: Device Qualifier Descriptor Device Protocol USB Field
--		DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX: Device Qualifier Descriptor Max Packet Size0 USB Field
--		DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT: Device Qualifier Descriptor Max Packet Size0 USB Field
--		DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX: Device Qualifier Descriptor Num Configuration USB Field
--		DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT: Device Qualifier Descriptor Num Configuration USB Field
--		DEVICE_QUALIFIER_BRESERVED_INDEX: Device Qualifier Descriptor Reserved USB Field Index
--		DEVICE_QUALIFIER_BRESERVED_COUNT: Device Qualifier Descriptor Reserved USB Field Count
--		OTHER_SPEED_BLENGTH_INDEX: Other Speed Descriptor Length USB Field Index
--		OTHER_SPEED_BLENGTH_COUNT: Other Speed Descriptor Length USB Field Count
--		OTHER_SPEED_WTOTALLENGTH_INDEX: Other Speed Descriptor Total Length USB Field Index
--		OTHER_SPEED_WTOTALLENGTH_COUNT: Other Speed Descriptor Total Length USB Field Count
--		OTHER_SPEED_BNUMINTERFACES_INDEX: Other Speed Descriptor Num Interfaces USB Field Index
--		OTHER_SPEED_BNUMINTERFACES_COUNT: Other Speed Descriptor Num Interfaces USB Field Count
--		OTHER_SPEED_BCONFIGURATIONVALUE_INDEX: Other Speed Descriptor Configuration Value USB Field Index
--		OTHER_SPEED_BCONFIGURATIONVALUE_COUNT: Other Speed Descriptor Configuration Value USB Field Count
--		OTHER_SPEED_ICONFIGURATION_BLENGTH_INDEX: Other Speed Descriptor Configuration String Length USB Field Index
--		OTHER_SPEED_ICONFIGURATION_BLENGTH_COUNT: Other Speed Descriptor Configuration String Length USB Field Count
--		OTHER_SPEED_ICONFIGURATION_INDEX: Other Speed Descriptor Configuration String USB Field Index
--		OTHER_SPEED_ICONFIGURATION_COUNT: Other Speed Descriptor Configuration String USB Field Count
--		OTHER_SPEED_BMATTRIBUTES_INDEX: Other Speed Descriptor Attributes USB Field Index
--		OTHER_SPEED_BMATTRIBUTES_COUNT: Other Speed Descriptor Attributes USB Field Count
--		OTHER_SPEED_BMAXPOWER_INDEX: Other Speed Descriptor Max Power USB Field Index
--		OTHER_SPEED_BMAXPOWER_COUNT: Other Speed Descriptor Max Power USB Field Count
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

-- Custom Package: Operator Result Enum
LIBRARY WORK;
USE WORK.OperatorResultEnum.ALL;

-- Custom Package: Memory Data Mapping
LIBRARY WORK;
USE WORK.MemoryDataMapping.ALL;

ENTITY LessOperator is

GENERIC(
	-- Memory Configurations (Address Length, Address Max Index, Address Count Max)
	MEMORY_ADDR_LENGTH: INTEGER := 1;
	MEMORY_ADDR_MAX_INDEX: INTEGER := 0;
	MEMORY_ADDR_MAX_COUNT: INTEGER := 0;
	-- Device Descriptor
	DEVICE_BLENGTH_INDEX: INTEGER := 0;
	DEVICE_BLENGTH_COUNT: INTEGER := 0;
	DEVICE_BCDUSB_INDEX: INTEGER := 0;
	DEVICE_BCDUSB_COUNT: INTEGER := 0;
	DEVICE_BDEVICECLASS_INDEX: INTEGER := 0;
	DEVICE_BDEVICECLASS_COUNT: INTEGER := 0;
	DEVICE_BDEVICESUBCLASS_INDEX: INTEGER := 0;
	DEVICE_BDEVICESUBCLASS_COUNT: INTEGER := 0;
	DEVICE_BDEVICEPROTOCOL_INDEX: INTEGER := 0;
	DEVICE_BDEVICEPROTOCOL_COUNT: INTEGER := 0;
	DEVICE_BMAXPACKETSIZE0_INDEX: INTEGER := 0;
	DEVICE_BMAXPACKETSIZE0_COUNT: INTEGER := 0;
	DEVICE_IDVENDOR_INDEX: INTEGER := 0;
	DEVICE_IDVENDOR_COUNT: INTEGER := 0;
	DEVICE_IDPRODUCT_INDEX: INTEGER := 0;
	DEVICE_IDPRODUCT_COUNT: INTEGER := 0;
	DEVICE_BCDDEVICE_INDEX: INTEGER := 0;
	DEVICE_BCDDEVICE_COUNT: INTEGER := 0;
	DEVICE_IMANUFACTURER_BLENGTH_INDEX: INTEGER := 0;
	DEVICE_IMANUFACTURER_BLENGTH_COUNT: INTEGER := 0;
	DEVICE_IMANUFACTURER_INDEX: INTEGER := 0;
	DEVICE_IMANUFACTURER_COUNT: INTEGER := 0;
	DEVICE_IPRODUCT_BLENGTH_INDEX: INTEGER := 0;
	DEVICE_IPRODUCT_BLENGTH_COUNT: INTEGER := 0;
	DEVICE_IPRODUCT_INDEX: INTEGER := 0;
	DEVICE_IPRODUCT_COUNT: INTEGER := 0;
	DEVICE_ISERIALNUMBER_BLENGTH_INDEX: INTEGER := 0;
	DEVICE_ISERIALNUMBER_BLENGTH_COUNT: INTEGER := 0;
	DEVICE_ISERIALNUMBER_INDEX: INTEGER := 0;
	DEVICE_ISERIALNUMBER_COUNT: INTEGER := 0;
	DEVICE_BNUMCONFIGURATIONS_INDEX: INTEGER := 0;
	DEVICE_BNUMCONFIGURATIONS_COUNT: INTEGER := 0;
	-- Configuration Descriptor
	CONFIGURATION_BLENGTH_INDEX: INTEGER := 0;
	CONFIGURATION_BLENGTH_COUNT: INTEGER := 0;
	CONFIGURATION_WTOTALLENGTH_INDEX: INTEGER := 0;
	CONFIGURATION_WTOTALLENGTH_COUNT: INTEGER := 0;
	CONFIGURATION_BNUMINTERFACES_INDEX: INTEGER := 0;
	CONFIGURATION_BNUMINTERFACES_COUNT: INTEGER := 0;
	CONFIGURATION_BCONFIGURATIONVALUE_INDEX: INTEGER := 0;
	CONFIGURATION_BCONFIGURATIONVALUE_COUNT: INTEGER := 0;
	CONFIGURATION_ICONFIGURATION_BLENGTH_INDEX: INTEGER := 0;
	CONFIGURATION_ICONFIGURATION_BLENGTH_COUNT: INTEGER := 0;
	CONFIGURATION_ICONFIGURATION_INDEX: INTEGER := 0;
	CONFIGURATION_ICONFIGURATION_COUNT: INTEGER := 0;
	CONFIGURATION_BMATTRIBUTES_INDEX: INTEGER := 0;
	CONFIGURATION_BMATTRIBUTES_COUNT: INTEGER := 0;
	CONFIGURATION_BMAXPOWER_INDEX: INTEGER := 0;
	CONFIGURATION_BMAXPOWER_COUNT: INTEGER := 0;
	-- Interface Descriptor
	INTERFACE_BLENGTH_INDEX: INTEGER := 0;
	INTERFACE_BLENGTH_COUNT: INTEGER := 0;
	INTERFACE_BINTERFACENUMBER_INDEX: INTEGER := 0;
	INTERFACE_BINTERFACENUMBER_COUNT: INTEGER := 0;
	INTERFACE_BALTERNATESETTING_INDEX: INTEGER := 0;
	INTERFACE_BALTERNATESETTING_COUNT: INTEGER := 0;
	INTERFACE_BNUMENDPOINTS_INDEX: INTEGER := 0;
	INTERFACE_BNUMENDPOINTS_COUNT: INTEGER := 0;
	INTERFACE_BINTERFACECLASS_INDEX: INTEGER := 0;
	INTERFACE_BINTERFACECLASS_COUNT: INTEGER := 0;
	INTERFACE_BINTERFACESUBCLASS_INDEX: INTEGER := 0;
	INTERFACE_BINTERFACESUBCLASS_COUNT: INTEGER := 0;
	INTERFACE_BINTERFACEPROTOCOL_INDEX: INTEGER := 0;
	INTERFACE_BINTERFACEPROTOCOL_COUNT: INTEGER := 0;
	INTERFACE_IINTERFACE_BLENGTH_INDEX: INTEGER := 0;
	INTERFACE_IINTERFACE_BLENGTH_COUNT: INTEGER := 0;
	INTERFACE_IINTERFACE_INDEX: INTEGER := 0;
	INTERFACE_IINTERFACE_COUNT: INTEGER := 0;
	-- HID Descriptor
	HID_BLENGTH_INDEX: INTEGER := 0;
	HID_BLENGTH_COUNT: INTEGER := 0;
	HID_BCDHID_INDEX: INTEGER := 0;
	HID_BCDHID_COUNT: INTEGER := 0;
	HID_BCOUNTRYCODE_INDEX: INTEGER := 0;
	HID_BCOUNTRYCODE_COUNT: INTEGER := 0;
	HID_BNUMDESCRIPTORS_INDEX: INTEGER := 0;
	HID_BNUMDESCRIPTORS_COUNT: INTEGER := 0;
	HID_BDESCRIPTORTYPE_INDEX: INTEGER := 0;
	HID_BDESCRIPTORTYPE_COUNT: INTEGER := 0;
	HID_WDESCRIPTORLENGTH_INDEX: INTEGER := 0;
	HID_WDESCRIPTORLENGTH_COUNT: INTEGER := 0;
	-- Endpoint Descriptor
	ENDPOINT_BLENGTH_INDEX: INTEGER := 0;
	ENDPOINT_BLENGTH_COUNT: INTEGER := 0;
	ENDPOINT_BENDPOINTADDRESS_INDEX: INTEGER := 0;
	ENDPOINT_BENDPOINTADDRESS_COUNT: INTEGER := 0;
	ENDPOINT_BMATTRIBUTES_INDEX: INTEGER := 0;
	ENDPOINT_BMATTRIBUTES_COUNT: INTEGER := 0;
	ENDPOINT_WMAXPACKETSIZE_INDEX: INTEGER := 0;
	ENDPOINT_WMAXPACKETSIZE_COUNT: INTEGER := 0;
	ENDPOINT_BINTERVAL_INDEX: INTEGER := 0;
	ENDPOINT_BINTERVAL_COUNT: INTEGER := 0;
	-- Device Qualifier Descriptor
	DEVICE_QUALIFIER_BLENGTH_INDEX: INTEGER := 0;
	DEVICE_QUALIFIER_BLENGTH_COUNT: INTEGER := 0;
	DEVICE_QUALIFIER_BCDUSB_INDEX: INTEGER := 0;
	DEVICE_QUALIFIER_BCDUSB_COUNT: INTEGER := 0;
	DEVICE_QUALIFIER_BDEVICECLASS_INDEX: INTEGER := 0;
	DEVICE_QUALIFIER_BDEVICECLASS_COUNT: INTEGER := 0;
	DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX: INTEGER := 0;
	DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT: INTEGER := 0;
	DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX: INTEGER := 0;
	DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT: INTEGER := 0;
	DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX: INTEGER := 0;
	DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT: INTEGER := 0;
	DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX: INTEGER := 0;
	DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT: INTEGER := 0;
	DEVICE_QUALIFIER_BRESERVED_INDEX: INTEGER := 0;
	DEVICE_QUALIFIER_BRESERVED_COUNT: INTEGER := 0;
	-- Other Speed Descriptor
	OTHER_SPEED_BLENGTH_INDEX: INTEGER := 0;
	OTHER_SPEED_BLENGTH_COUNT: INTEGER := 0;
	OTHER_SPEED_WTOTALLENGTH_INDEX: INTEGER := 0;
	OTHER_SPEED_WTOTALLENGTH_COUNT: INTEGER := 0;
	OTHER_SPEED_BNUMINTERFACES_INDEX: INTEGER := 0;
	OTHER_SPEED_BNUMINTERFACES_COUNT: INTEGER := 0;
	OTHER_SPEED_BCONFIGURATIONVALUE_INDEX: INTEGER := 0;
	OTHER_SPEED_BCONFIGURATIONVALUE_COUNT: INTEGER := 0;
	OTHER_SPEED_ICONFIGURATION_BLENGTH_INDEX: INTEGER := 0;
	OTHER_SPEED_ICONFIGURATION_BLENGTH_COUNT: INTEGER := 0;
	OTHER_SPEED_ICONFIGURATION_INDEX: INTEGER := 0;
	OTHER_SPEED_ICONFIGURATION_COUNT: INTEGER := 0;
	OTHER_SPEED_BMATTRIBUTES_INDEX: INTEGER := 0;
	OTHER_SPEED_BMATTRIBUTES_COUNT: INTEGER := 0;
	OTHER_SPEED_BMAXPOWER_INDEX: INTEGER := 0;
	OTHER_SPEED_BMAXPOWER_COUNT: INTEGER := 0
);

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

END LessOperator;

ARCHITECTURE Behavioral of LessOperator is

------------------------------------------------------------------------
-- Component Declarations
------------------------------------------------------------------------
-- Less Operator Controller
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

-- Less Memory Controller
COMPONENT MemoryController is
GENERIC(
	-- Memory Configurations (Address Length, Address Max Index, Address Count Max)
	MEMORY_ADDR_LENGTH: INTEGER := 1;
	MEMORY_ADDR_MAX_INDEX: INTEGER := 0;
	MEMORY_ADDR_MAX_COUNT: INTEGER := 0
);
PORT(
	i_sys_clock: IN STD_LOGIC;
	i_enable: IN STD_LOGIC;
	i_addr_index: IN INTEGER range 0 to MEMORY_ADDR_MAX_INDEX;
	i_addr_count: IN INTEGER range 0 to MEMORY_ADDR_MAX_COUNT;
	i_next_data_request: IN STD_LOGIC;

	-- Memory Signals
	o_mem_clka: OUT STD_LOGIC;
	o_mem_clkb: OUT STD_LOGIC;
	o_mem_ena: OUT STD_LOGIC;
	o_mem_enb: OUT STD_LOGIC;
	o_mem_addra: OUT STD_LOGIC_VECTOR(MEMORY_ADDR_LENGTH-1 downto 0);
	o_mem_addrb: OUT STD_LOGIC_VECTOR(MEMORY_ADDR_LENGTH-1 downto 0);
	i_mem_dataa: IN STD_LOGIC_VECTOR(MEM_TOTAL_DATA_LENGTH-1 downto 0);
	i_mem_datab: IN STD_LOGIC_VECTOR(MEM_TOTAL_DATA_LENGTH-1 downto 0);

	-- Memory Controller Outputs
	o_mem_no_data: OUT STD_LOGIC;
	o_mem_data_ready: OUT STD_LOGIC;
	o_mem_data: OUT UNSIGNED(MEM_DATA_LENGTH-1 downto 0);
	o_mem_data_en: OUT STD_LOGIC_VECTOR(MEM_DATA_QUARTET_ENABLE_LENGTH-1 downto 0);
	o_mem_data_verif_level: OUT STD_LOGIC;
	o_mem_data_part_number: OUT UNSIGNED(MEM_DATA_PART_NUMBER_LENGTH-1 downto 0);
	o_mem_data_last: OUT STD_LOGIC
);
END COMPONENT;

-- Verification Dual-Port ROM (with Embedded Output Registers)
COMPONENT LessDualPortROM is
GENERIC(
	-- Memory Configurations (Address Length, Data Length)
	MEMORY_ADDR_LENGTH: INTEGER := 1;
	MEMORY_DATA_LENGTH: INTEGER := 39
);
PORT(
	-- Port A
	clka: IN STD_LOGIC;
	ena: IN STD_LOGIC;
	addra: IN STD_LOGIC_VECTOR(MEMORY_ADDR_LENGTH-1 downto 0);
	douta: OUT STD_LOGIC_VECTOR(MEMORY_DATA_LENGTH-1 downto 0);
	-- Port B
	clkb: IN STD_LOGIC;
	enb: IN STD_LOGIC;
	addrb: IN STD_LOGIC_VECTOR(MEMORY_ADDR_LENGTH-1 downto 0);
	doutb: OUT STD_LOGIC_VECTOR(MEMORY_DATA_LENGTH-1 downto 0)
);
END COMPONENT;

------------------------------------------------------------------------
-- Signal Declarations
------------------------------------------------------------------------
-- Less Operator Controller Signals
signal descriptor_field: UNSIGNED(USB_DESCRIPTOR_FIELD_BIT_LENGTH-1 downto 0) := (others => '0');
signal descriptor_field_available: STD_LOGIC := '0';
signal descriptor_value: UNSIGNED(USB_DESCRIPTOR_VALUE_DATA_BIT_LENGTH-1 downto 0) := (others => '0');
signal descriptor_value_en: STD_LOGIC_VECTOR(USB_DESCRIPTOR_VALUE_QUARTET_EN_BIT_LENGTH-1 downto 0) := (others => '0');
signal descriptor_value_total_part_number: UNSIGNED(USB_DESCRIPTOR_VALUE_PART_NUMBER_BIT_LENGTH-1 downto 0) := (others => '0');
signal descriptor_value_part_number: UNSIGNED(USB_DESCRIPTOR_VALUE_PART_NUMBER_BIT_LENGTH-1 downto 0) := (others => '0');
signal descriptor_value_last_part: STD_LOGIC := '0';

-- Less Memory Controller Signals
signal mem_en: STD_LOGIC := '0';
signal mem_addr_index: INTEGER range 0 to MEMORY_ADDR_MAX_INDEX := 0;
signal mem_addr_count_init: INTEGER range 0 to MEMORY_ADDR_MAX_COUNT := 0;
signal mem_next_data_request: STD_LOGIC := '0';
signal mem_clka: STD_LOGIC := '0';
signal mem_clkb: STD_LOGIC := '0';
signal mem_ena: STD_LOGIC := '0';
signal mem_enb: STD_LOGIC := '0';
signal mem_addra: STD_LOGIC_VECTOR(MEMORY_ADDR_LENGTH-1 downto 0) := (others => '0');
signal mem_addrb: STD_LOGIC_VECTOR(MEMORY_ADDR_LENGTH-1 downto 0) := (others => '0');
signal mem_dataa: STD_LOGIC_VECTOR(MEM_TOTAL_DATA_LENGTH-1 downto 0) := (others => '0');
signal mem_datab: STD_LOGIC_VECTOR(MEM_TOTAL_DATA_LENGTH-1 downto 0) := (others => '0');
signal mem_no_data: STD_LOGIC := '0';
signal mem_data_ready: STD_LOGIC := '0';
signal mem_data: UNSIGNED(MEM_DATA_LENGTH-1 downto 0) := (others => '0');
signal mem_data_en: STD_LOGIC_VECTOR(MEM_DATA_QUARTET_ENABLE_LENGTH-1 downto 0) := (others => '0');
signal mem_data_verif_level: STD_LOGIC := '0';
signal mem_data_part_number: UNSIGNED(MEM_DATA_PART_NUMBER_LENGTH-1 downto 0) := (others => '0');
signal mem_data_last: STD_LOGIC := '0';

-- Less Verification Enable
signal verification_en: STD_LOGIC := '0';

-- Less Operator Signals
signal less_quartet_operator: STD_LOGIC_VECTOR(USB_DESCRIPTOR_VALUE_QUARTET_EN_BIT_LENGTH-1 downto 0) := (others => '0');
signal less_operator: STD_LOGIC := '0';

-- Less Operator Result
signal less_operator_result: OperatorResult := IDLE;

------------------------------------------------------------------------
-- Module Implementation
------------------------------------------------------------------------
begin

	------------------------------
	-- Less Operator Controller --
	------------------------------
	LessOperatorController: OperatorController
		PORT MAP(
			i_sys_clock => i_sys_clock,
			i_enable => i_enable,
			i_descriptor_field => i_descriptor_field,
			i_descriptor_field_available => i_descriptor_field_available,
			i_descriptor_value => i_descriptor_value,
			i_descriptor_value_en => i_descriptor_value_en,
			i_descriptor_value_total_part_number => i_descriptor_value_total_part_number,
			i_descriptor_value_part_number => i_descriptor_value_part_number,
			i_descriptor_value_new_part => i_descriptor_value_new_part,

			-- Internal Inputs/Outputs (for Operator)
			i_operator_result => Less_operator_result,
			o_descriptor_field => descriptor_field,
			o_descriptor_field_available => descriptor_field_available,
			o_descriptor_value => descriptor_value,
			o_descriptor_value_en => descriptor_value_en,
			o_descriptor_value_total_part_number => descriptor_value_total_part_number,
			o_descriptor_value_part_number => descriptor_value_part_number,
			o_descriptor_value_last_part => descriptor_value_last_part,
			o_memory_en => mem_en,
			o_verification_en => verification_en,

			-- External Outputs
			o_descriptor_value_next_part_request => o_descriptor_value_next_part_request,
			o_ready => o_ready,
			o_result => o_result
	);

	-----------------------------------
	-- Memory Address Index Selector --
	-----------------------------------
	with descriptor_field select
		mem_addr_index <= 
						-- Device Descriptor Field
						DEVICE_BLENGTH_INDEX when DEVICE_BLENGTH_TYPE,
						DEVICE_BCDUSB_INDEX when DEVICE_BCDUSB_TYPE,
						DEVICE_BDEVICECLASS_INDEX when DEVICE_BDEVICECLASS_TYPE,
						DEVICE_BDEVICESUBCLASS_INDEX when DEVICE_BDEVICESUBCLASS_TYPE,
						DEVICE_BDEVICEPROTOCOL_INDEX when DEVICE_BDEVICEPROTOCOL_TYPE,
						DEVICE_BMAXPACKETSIZE0_INDEX when DEVICE_BMAXPACKETSIZE0_TYPE,
						DEVICE_IDVENDOR_INDEX when DEVICE_IDVENDOR_TYPE,
						DEVICE_IDPRODUCT_INDEX when DEVICE_IDPRODUCT_TYPE,
						DEVICE_BCDDEVICE_INDEX when DEVICE_BCDDEVICE_TYPE,
						DEVICE_IMANUFACTURER_BLENGTH_INDEX when DEVICE_IMANUFACTURER_BLENGTH_TYPE,
						DEVICE_IMANUFACTURER_INDEX when DEVICE_IMANUFACTURER_TYPE,
						DEVICE_IPRODUCT_BLENGTH_INDEX when DEVICE_IPRODUCT_BLENGTH_TYPE,
						DEVICE_IPRODUCT_INDEX when DEVICE_IPRODUCT_TYPE,
						DEVICE_ISERIALNUMBER_BLENGTH_INDEX when DEVICE_ISERIALNUMBER_BLENGTH_TYPE,
						DEVICE_ISERIALNUMBER_INDEX when DEVICE_ISERIALNUMBER_TYPE,
						DEVICE_BNUMCONFIGURATIONS_INDEX when DEVICE_BNUMCONFIGURATIONS_TYPE,
						-- Configuration Descriptor
						CONFIGURATION_BLENGTH_INDEX when CONFIGURATION_BLENGTH_TYPE,
						CONFIGURATION_WTOTALLENGTH_INDEX when CONFIGURATION_WTOTALLENGTH_TYPE,
						CONFIGURATION_BNUMINTERFACES_INDEX when CONFIGURATION_BNUMINTERFACES_TYPE,
						CONFIGURATION_BCONFIGURATIONVALUE_INDEX when CONFIGURATION_BCONFIGURATIONVALUE_TYPE,
						CONFIGURATION_ICONFIGURATION_BLENGTH_INDEX when CONFIGURATION_ICONFIGURATION_BLENGTH_TYPE,
						CONFIGURATION_ICONFIGURATION_INDEX when CONFIGURATION_ICONFIGURATION_TYPE,
						CONFIGURATION_BMATTRIBUTES_INDEX when CONFIGURATION_BMATTRIBUTES_TYPE,
						CONFIGURATION_BMAXPOWER_INDEX when CONFIGURATION_BMAXPOWER_TYPE,
						-- Interface Descriptor
						INTERFACE_BLENGTH_INDEX when INTERFACE_BLENGTH_TYPE,
						INTERFACE_BINTERFACENUMBER_INDEX when INTERFACE_BINTERFACENUMBER_TYPE,
						INTERFACE_BALTERNATESETTING_INDEX when INTERFACE_BALTERNATESETTING_TYPE,
						INTERFACE_BNUMENDPOINTS_INDEX when INTERFACE_BNUMENDPOINTS_TYPE,
						INTERFACE_BINTERFACECLASS_INDEX when INTERFACE_BINTERFACECLASS_TYPE,
						INTERFACE_BINTERFACESUBCLASS_INDEX when INTERFACE_BINTERFACESUBCLASS_TYPE,
						INTERFACE_BINTERFACEPROTOCOL_INDEX when INTERFACE_BINTERFACEPROTOCOL_TYPE,
						INTERFACE_IINTERFACE_BLENGTH_INDEX when INTERFACE_IINTERFACE_BLENGTH_TYPE,
						INTERFACE_IINTERFACE_INDEX when INTERFACE_IINTERFACE_TYPE,
						-- HID Descriptor
						HID_BLENGTH_INDEX when HID_BLENGTH_TYPE,
						HID_BCDHID_INDEX when HID_BCDHID_TYPE,
						HID_BCOUNTRYCODE_INDEX when HID_BCOUNTRYCODE_TYPE,
						HID_BNUMDESCRIPTORS_INDEX when HID_BNUMDESCRIPTORS_TYPE,
						HID_BDESCRIPTORTYPE_INDEX when HID_BDESCRIPTORTYPE_TYPE,
						HID_WDESCRIPTORLENGTH_INDEX when HID_WDESCRIPTORLENGTH_TYPE,
						-- Endpoint Descriptor
						ENDPOINT_BLENGTH_INDEX when ENDPOINT_BLENGTH_TYPE,
						ENDPOINT_BENDPOINTADDRESS_INDEX when ENDPOINT_BENDPOINTADDRESS_TYPE,
						ENDPOINT_BMATTRIBUTES_INDEX when ENDPOINT_BMATTRIBUTES_TYPE,
						ENDPOINT_WMAXPACKETSIZE_INDEX when ENDPOINT_WMAXPACKETSIZE_TYPE,
						ENDPOINT_BINTERVAL_INDEX when ENDPOINT_BINTERVAL_TYPE,
						-- Device Qualifier Descriptor Field
						DEVICE_QUALIFIER_BLENGTH_INDEX when DEVICE_QUALIFIER_BLENGTH_TYPE,
						DEVICE_QUALIFIER_BCDUSB_INDEX when DEVICE_QUALIFIER_BCDUSB_TYPE,
						DEVICE_QUALIFIER_BDEVICECLASS_INDEX when DEVICE_QUALIFIER_BDEVICECLASS_TYPE,
						DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX when DEVICE_QUALIFIER_BDEVICESUBCLASS_TYPE,
						DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX when DEVICE_QUALIFIER_BDEVICEPROTOCOL_TYPE,
						DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX when DEVICE_QUALIFIER_BMAXPACKETSIZE0_TYPE,
						DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX when DEVICE_QUALIFIER_BNUMCONFIGURATIONS_TYPE,
						DEVICE_QUALIFIER_BRESERVED_INDEX when DEVICE_QUALIFIER_BRESERVED_TYPE,
						-- Other Speed Descriptor
						OTHER_SPEED_BLENGTH_INDEX when OTHER_SPEED_BLENGTH_TYPE,
						OTHER_SPEED_WTOTALLENGTH_INDEX when OTHER_SPEED_WTOTALLENGTH_TYPE,
						OTHER_SPEED_BNUMINTERFACES_INDEX when OTHER_SPEED_BNUMINTERFACES_TYPE,
						OTHER_SPEED_BCONFIGURATIONVALUE_INDEX when OTHER_SPEED_BCONFIGURATIONVALUE_TYPE,
						OTHER_SPEED_ICONFIGURATION_BLENGTH_INDEX when OTHER_SPEED_ICONFIGURATION_BLENGTH_TYPE,
						OTHER_SPEED_ICONFIGURATION_INDEX when OTHER_SPEED_ICONFIGURATION_TYPE,
						OTHER_SPEED_BMATTRIBUTES_INDEX when OTHER_SPEED_BMATTRIBUTES_TYPE,
						OTHER_SPEED_BMAXPOWER_INDEX when OTHER_SPEED_BMAXPOWER_TYPE,
						-- Unknown Descriptor Field
						MEM_UNKNOWN_INDEX when others;

	-------------------------------------
	-- Memory Address Counter Selector --
	-------------------------------------
	with descriptor_field select
		mem_addr_count_init <=
							-- Device Descriptor Field
							DEVICE_BLENGTH_COUNT when DEVICE_BLENGTH_TYPE,
							DEVICE_BCDUSB_COUNT when DEVICE_BCDUSB_TYPE,
							DEVICE_BDEVICECLASS_COUNT when DEVICE_BDEVICECLASS_TYPE,
							DEVICE_BDEVICESUBCLASS_COUNT when DEVICE_BDEVICESUBCLASS_TYPE,
							DEVICE_BDEVICEPROTOCOL_COUNT when DEVICE_BDEVICEPROTOCOL_TYPE,
							DEVICE_BMAXPACKETSIZE0_COUNT when DEVICE_BMAXPACKETSIZE0_TYPE,
							DEVICE_IDVENDOR_COUNT when DEVICE_IDVENDOR_TYPE,
							DEVICE_IDPRODUCT_COUNT when DEVICE_IDPRODUCT_TYPE,
							DEVICE_BCDDEVICE_COUNT when DEVICE_BCDDEVICE_TYPE,
							DEVICE_IMANUFACTURER_BLENGTH_COUNT when DEVICE_IMANUFACTURER_BLENGTH_TYPE,
							DEVICE_IMANUFACTURER_COUNT when DEVICE_IMANUFACTURER_TYPE,
							DEVICE_IPRODUCT_BLENGTH_COUNT when DEVICE_IPRODUCT_BLENGTH_TYPE,
							DEVICE_IPRODUCT_COUNT when DEVICE_IPRODUCT_TYPE,
							DEVICE_ISERIALNUMBER_BLENGTH_COUNT when DEVICE_ISERIALNUMBER_BLENGTH_TYPE,
							DEVICE_ISERIALNUMBER_COUNT when DEVICE_ISERIALNUMBER_TYPE,
							DEVICE_BNUMCONFIGURATIONS_COUNT when DEVICE_BNUMCONFIGURATIONS_TYPE,
							-- Configuration Descriptor
							CONFIGURATION_BLENGTH_COUNT when CONFIGURATION_BLENGTH_TYPE,
							CONFIGURATION_WTOTALLENGTH_COUNT when CONFIGURATION_WTOTALLENGTH_TYPE,
							CONFIGURATION_BNUMINTERFACES_COUNT when CONFIGURATION_BNUMINTERFACES_TYPE,
							CONFIGURATION_BCONFIGURATIONVALUE_COUNT when CONFIGURATION_BCONFIGURATIONVALUE_TYPE,
							CONFIGURATION_ICONFIGURATION_BLENGTH_COUNT when CONFIGURATION_ICONFIGURATION_BLENGTH_TYPE,
							CONFIGURATION_ICONFIGURATION_COUNT when CONFIGURATION_ICONFIGURATION_TYPE,
							CONFIGURATION_BMATTRIBUTES_COUNT when CONFIGURATION_BMATTRIBUTES_TYPE,
							CONFIGURATION_BMAXPOWER_COUNT when CONFIGURATION_BMAXPOWER_TYPE,
							-- Interface Descriptor
							INTERFACE_BLENGTH_COUNT when INTERFACE_BLENGTH_TYPE,
							INTERFACE_BINTERFACENUMBER_COUNT when INTERFACE_BINTERFACENUMBER_TYPE,
							INTERFACE_BALTERNATESETTING_COUNT when INTERFACE_BALTERNATESETTING_TYPE,
							INTERFACE_BNUMENDPOINTS_COUNT when INTERFACE_BNUMENDPOINTS_TYPE,
							INTERFACE_BINTERFACECLASS_COUNT when INTERFACE_BINTERFACECLASS_TYPE,
							INTERFACE_BINTERFACESUBCLASS_COUNT when INTERFACE_BINTERFACESUBCLASS_TYPE,
							INTERFACE_BINTERFACEPROTOCOL_COUNT when INTERFACE_BINTERFACEPROTOCOL_TYPE,
							INTERFACE_IINTERFACE_BLENGTH_COUNT when INTERFACE_IINTERFACE_BLENGTH_TYPE,
							INTERFACE_IINTERFACE_COUNT when INTERFACE_IINTERFACE_TYPE,
							-- HID Descriptor
							HID_BLENGTH_COUNT when HID_BLENGTH_TYPE,
							HID_BCDHID_COUNT when HID_BCDHID_TYPE,
							HID_BCOUNTRYCODE_COUNT when HID_BCOUNTRYCODE_TYPE,
							HID_BNUMDESCRIPTORS_COUNT when HID_BNUMDESCRIPTORS_TYPE,
							HID_BDESCRIPTORTYPE_COUNT when HID_BDESCRIPTORTYPE_TYPE,
							HID_WDESCRIPTORLENGTH_COUNT when HID_WDESCRIPTORLENGTH_TYPE,
							-- Endpoint Descriptor
							ENDPOINT_BLENGTH_COUNT when ENDPOINT_BLENGTH_TYPE,
							ENDPOINT_BENDPOINTADDRESS_COUNT when ENDPOINT_BENDPOINTADDRESS_TYPE,
							ENDPOINT_BMATTRIBUTES_COUNT when ENDPOINT_BMATTRIBUTES_TYPE,
							ENDPOINT_WMAXPACKETSIZE_COUNT when ENDPOINT_WMAXPACKETSIZE_TYPE,
							ENDPOINT_BINTERVAL_COUNT when ENDPOINT_BINTERVAL_TYPE,
							-- Device Qualifier Descriptor Field
							DEVICE_QUALIFIER_BLENGTH_COUNT when DEVICE_QUALIFIER_BLENGTH_TYPE,
							DEVICE_QUALIFIER_BCDUSB_COUNT when DEVICE_QUALIFIER_BCDUSB_TYPE,
							DEVICE_QUALIFIER_BDEVICECLASS_COUNT when DEVICE_QUALIFIER_BDEVICECLASS_TYPE,
							DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT when DEVICE_QUALIFIER_BDEVICESUBCLASS_TYPE,
							DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT when DEVICE_QUALIFIER_BDEVICEPROTOCOL_TYPE,
							DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT when DEVICE_QUALIFIER_BMAXPACKETSIZE0_TYPE,
							DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT when DEVICE_QUALIFIER_BNUMCONFIGURATIONS_TYPE,
							DEVICE_QUALIFIER_BRESERVED_COUNT when DEVICE_QUALIFIER_BRESERVED_TYPE,
							-- Other Speed Descriptor
							OTHER_SPEED_BLENGTH_COUNT when OTHER_SPEED_BLENGTH_TYPE,
							OTHER_SPEED_WTOTALLENGTH_COUNT when OTHER_SPEED_WTOTALLENGTH_TYPE,
							OTHER_SPEED_BNUMINTERFACES_COUNT when OTHER_SPEED_BNUMINTERFACES_TYPE,
							OTHER_SPEED_BCONFIGURATIONVALUE_COUNT when OTHER_SPEED_BCONFIGURATIONVALUE_TYPE,
							OTHER_SPEED_ICONFIGURATION_BLENGTH_COUNT when OTHER_SPEED_ICONFIGURATION_BLENGTH_TYPE,
							OTHER_SPEED_ICONFIGURATION_COUNT when OTHER_SPEED_ICONFIGURATION_TYPE,
							OTHER_SPEED_BMATTRIBUTES_COUNT when OTHER_SPEED_BMATTRIBUTES_TYPE,
							OTHER_SPEED_BMAXPOWER_COUNT when OTHER_SPEED_BMAXPOWER_TYPE,
							-- Unknown Descriptor Field
							MEM_UNKNOWN_COUNT when others;

	----------------------------
	-- Less Memory Controller --
	----------------------------
	LessMemoryController: MemoryController
		GENERIC MAP(
			MEMORY_ADDR_LENGTH => MEMORY_ADDR_LENGTH,
			MEMORY_ADDR_MAX_INDEX => MEMORY_ADDR_MAX_INDEX,
			MEMORY_ADDR_MAX_COUNT => MEMORY_ADDR_MAX_COUNT
		)
		PORT MAP(
			i_sys_clock => i_sys_clock,
			i_enable => mem_en,
			i_addr_index => mem_addr_index,
			i_addr_count => mem_addr_count_init,
			i_next_data_request => mem_next_data_request,
			o_mem_clka => mem_clka,
			o_mem_clkb => mem_clkb,
			o_mem_ena => mem_ena,
			o_mem_enb => mem_enb,
			o_mem_addra => mem_addra,
			o_mem_addrb => mem_addrb,
			i_mem_dataa => mem_dataa,
			i_mem_datab => mem_datab,
			o_mem_no_data => mem_no_data,
			o_mem_data_ready => mem_data_ready,
			o_mem_data => mem_data,
			o_mem_data_en => mem_data_en,
			o_mem_data_verif_level => mem_data_verif_level,
			o_mem_data_part_number => mem_data_part_number,
			o_mem_data_last => mem_data_last
	);

	------------------------
	-- Less Dual-Port ROM --
	------------------------
	lessDualPortROM_inst: LessDualPortROM
		GENERIC MAP(
			MEMORY_ADDR_LENGTH => MEMORY_ADDR_LENGTH,
			MEMORY_DATA_LENGTH => MEM_TOTAL_DATA_LENGTH
		)
		PORT MAP(
			clka => mem_clka,
			ena => mem_ena,
			addra => mem_addra,
			douta => mem_dataa,
			clkb => mem_clkb,
			enb => mem_enb,
			addrb => mem_addrb,
			doutb => mem_datab
	);

	------------------------------
	-- Memory Next Data Request --
	------------------------------
	mem_next_data_request <= '1' when (Less_operator_result = IN_PROGRESS) else '0';

	--------------------------------
	-- Less Operator (by Quartet) --
	--------------------------------
	-- Quartet MSB
	less_quartet_operator(USB_DESCRIPTOR_VALUE_QUARTET_EN_BIT_LENGTH-1) <=	-- Memory Data Quartet Disable (Success, no matter Descriptor Quartet Value)
																			'1' when (mem_data_en(USB_DESCRIPTOR_VALUE_QUARTET_EN_BIT_LENGTH-1) = '0') else
																			-- Descriptor Quartet Enable < Value Quartet Enable (Error)
																			'0' when (mem_data_en(USB_DESCRIPTOR_VALUE_QUARTET_EN_BIT_LENGTH-1) = '1') and (descriptor_value_en(USB_DESCRIPTOR_VALUE_QUARTET_EN_BIT_LENGTH-1) = '0') else
																			-- Quartet Enable Matching: Compute Less Operator with Success
																			'1' when (mem_data_en(USB_DESCRIPTOR_VALUE_QUARTET_EN_BIT_LENGTH-1) = '1') and (descriptor_value_en(USB_DESCRIPTOR_VALUE_QUARTET_EN_BIT_LENGTH-1) = '1') and (descriptor_value(USB_DESCRIPTOR_VALUE_QUARTET_MSB_INDEX+(USB_DESCRIPTOR_VALUE_QUARTET_INCREMENT_INDEX*(USB_DESCRIPTOR_VALUE_QUARTET_EN_BIT_LENGTH-1)) downto USB_DESCRIPTOR_VALUE_QUARTET_LSB_INDEX+(USB_DESCRIPTOR_VALUE_QUARTET_INCREMENT_INDEX*(USB_DESCRIPTOR_VALUE_QUARTET_EN_BIT_LENGTH-1))) < mem_data(USB_DESCRIPTOR_VALUE_QUARTET_MSB_INDEX+(USB_DESCRIPTOR_VALUE_QUARTET_INCREMENT_INDEX*(USB_DESCRIPTOR_VALUE_QUARTET_EN_BIT_LENGTH-1)) downto USB_DESCRIPTOR_VALUE_QUARTET_LSB_INDEX+(USB_DESCRIPTOR_VALUE_QUARTET_INCREMENT_INDEX*(USB_DESCRIPTOR_VALUE_QUARTET_EN_BIT_LENGTH-1))))
																			-- Quartet Enable Matching: Compute Less Operator with Error
																			else '0';

	-- Next Quartets
	less_quartet_operators: for i in USB_DESCRIPTOR_VALUE_QUARTET_EN_BIT_LENGTH-2 to 0 generate
		less_quartet_operator(i) <=	-- Previous Quartet Success
									'1' when less_quartet_operator(i-1) = '1' else
									-- Memory Data Quartet Disable (Success, no matter Descriptor Quartet Value)
									'1' when (mem_data_en(i) = '0') else
									-- Descriptor Quartet Enable < Value Quartet Enable (Error)
									'0' when (mem_data_en(i) = '1') and (descriptor_value_en(i) = '0') else
									-- Quartet Enable Matching: Compute Less Operator with Success
									'1' when (mem_data_en(i) = '1') and (descriptor_value_en(i) = '1') and (descriptor_value(USB_DESCRIPTOR_VALUE_QUARTET_MSB_INDEX+(USB_DESCRIPTOR_VALUE_QUARTET_INCREMENT_INDEX*i) downto USB_DESCRIPTOR_VALUE_QUARTET_LSB_INDEX+(USB_DESCRIPTOR_VALUE_QUARTET_INCREMENT_INDEX*i)) < mem_data(USB_DESCRIPTOR_VALUE_QUARTET_MSB_INDEX+(USB_DESCRIPTOR_VALUE_QUARTET_INCREMENT_INDEX*i) downto USB_DESCRIPTOR_VALUE_QUARTET_LSB_INDEX+(USB_DESCRIPTOR_VALUE_QUARTET_INCREMENT_INDEX*i)))
									-- Quartet Enable Matching: Compute Less Operator with Error
									else '0';
	end generate less_quartet_operators;

	-------------------
	-- Less Operator --
	-------------------
	less_operator <= '1' when (less_quartet_operator = USB_DESCRIPTOR_VALUE_ALL_QUARTETS_VALID) else '0';

	--------------------------
	-- Less Operator Result --
	--------------------------
	process(verification_en, mem_no_data, mem_data_ready, descriptor_field_available, descriptor_value_part_number, mem_data_part_number, descriptor_value_last_part, mem_data_last, mem_data_verif_level, less_operator)
	begin

		-- No Verification Enable
		if (verification_en = '0') then
			less_operator_result <= IDLE;

		-- Verification Enable
		else

			-- No Memory Data
			if (mem_no_data = '1') then
				less_operator_result <= OP_SUCCESS;

			-- Memory Data Ready
			elsif (mem_data_ready = '1') then

				-- Memory Data Ready & Descriptor Field Not Available
				if (descriptor_field_available = '0') then
					less_operator_result <= OP_ERROR;

				-- Value Part Number mismatch (Require Next Descriptor Value Part)
				elsif (descriptor_value_part_number /= mem_data_part_number) then

					-- Already Last Part
					if (descriptor_value_last_part = '1') then
						less_operator_result <= OP_ERROR;

					-- Waiting Next Part
					else
						less_operator_result <= WAIT_NEXT_PART;
					end if;

				-- Process Value Verification (Same Descriptor Value Part number)
				else

					-- Less Operator Success
					if (less_operator = '1') then

						-- Last Memory Data or Optional Verification
						if (mem_data_last = '1') or (mem_data_verif_level /= USB_DESCRIPTOR_VALUE_VERIF_MANDATORY_LEVEL) then
							less_operator_result <= OP_SUCCESS;

						-- Mandatory Verification (Next Verification Value)
						else
							less_operator_result <= IN_PROGRESS;
						end if;

					-- Less Operator Error
					else

						-- Last Memory Data or Mandatory Verification
						if (mem_data_last = '1') or (mem_data_verif_level = USB_DESCRIPTOR_VALUE_VERIF_MANDATORY_LEVEL) then
							less_operator_result <= OP_ERROR;

						-- Optional Verification (Next Verification Value)
						else
							less_operator_result <= IN_PROGRESS;
						end if;
					end if;
				end if;

			-- Memory Data Not Ready
			else
				less_operator_result <= IDLE;
			end if;
		end if;
	end process;

end Behavioral;
