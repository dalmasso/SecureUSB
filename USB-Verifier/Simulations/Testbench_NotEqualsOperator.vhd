------------------------------------------------------------------------
-- Engineer:    Dalmasso Loic
-- Create Date: 30/07/2025
-- Module Name: NotEqualsOperator
-- Description:
--		Module in charge of applying NotEquals operation on USB Field Value and Expected Value(s)
--
-- Usage:
--		NotEquals Operator embedds Operator Controller (Input/Outputs controller), Memory Controller (Verification Values Controller) and Verification ROM (Verification Values)
--		The NotEquals Operator contains all information regarding each Verification Values Index & Count for each Descriptor Field
--		According to the Descriptor Field & Value inputs, the NotEquals Operator select the right Index & Count and configure the Memory Controller in charge of get Verification Values
--		The enable signal is in charge to reset the NotEquals Operator Module (at low) or to start it (at high)
--		A dedicated signal is used to specify whether a Descriptor Field is present or not
--		NotEquals Operator implements the entire NotEquals operation between Descriptor Value Input & Verification Values:
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
--		DEVICE_BNUMCONFIGURATIONS_INDEX: Device Descriptor Num Configuration USB Field Index
--		DEVICE_BNUMCONFIGURATIONS_COUNT: Device Descriptor Num Configuration USB Field Count
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
--		CONFIGURATION_BLENGTH_INDEX: Configuration Descriptor Length USB Field Index
--		CONFIGURATION_BLENGTH_COUNT: Configuration Descriptor Length USB Field Count
--		CONFIGURATION_WTOTALLENGTH_INDEX: Configuration Descriptor Total Length USB Field Index
--		CONFIGURATION_WTOTALLENGTH_COUNT: Configuration Descriptor Total Length USB Field Count
--		CONFIGURATION_BNUMINTERFACES_INDEX: Configuration Descriptor Num Interfaces USB Field Index
--		CONFIGURATION_BNUMINTERFACES_COUNT: Configuration Descriptor Num Interfaces USB Field Count
--		CONFIGURATION_BCONFIGURATIONVALUE_INDEX: Configuration Descriptor Configuration Value USB Field Index
--		CONFIGURATION_BCONFIGURATIONVALUE_COUNT: Configuration Descriptor Configuration Value USB Field Count
--		CONFIGURATION_BMATTRIBUTES_INDEX: Configuration Descriptor Attributes USB Field Index
--		CONFIGURATION_BMATTRIBUTES_COUNT: Configuration Descriptor Attributes USB Field Count
--		CONFIGURATION_BMAXPOWER_INDEX: Configuration Descriptor Max Power USB Field Index
--		CONFIGURATION_BMAXPOWER_COUNT: Configuration Descriptor Max Power USB Field Count
--		OTHER_SPEED_BLENGTH_INDEX: Other Speed Descriptor Length USB Field Index
--		OTHER_SPEED_BLENGTH_COUNT: Other Speed Descriptor Length USB Field Count
--		OTHER_SPEED_WTOTALLENGTH_INDEX: Other Speed Descriptor Total Length USB Field Index
--		OTHER_SPEED_WTOTALLENGTH_COUNT: Other Speed Descriptor Total Length USB Field Count
--		OTHER_SPEED_BNUMINTERFACES_INDEX: Other Speed Descriptor Num Interfaces USB Field Index
--		OTHER_SPEED_BNUMINTERFACES_COUNT: Other Speed Descriptor Num Interfaces USB Field Count
--		OTHER_SPEED_BCONFIGURATIONVALUE_INDEX: Other Speed Descriptor Configuration Value USB Field Index
--		OTHER_SPEED_BCONFIGURATIONVALUE_COUNT: Other Speed Descriptor Configuration Value USB Field Count
--		OTHER_SPEED_BMATTRIBUTES_INDEX: Other Speed Descriptor Attributes USB Field Index
--		OTHER_SPEED_BMATTRIBUTES_COUNT: Other Speed Descriptor Attributes USB Field Count
--		OTHER_SPEED_BMAXPOWER_INDEX: Other Speed Descriptor Max Power USB Field Index
--		OTHER_SPEED_BMAXPOWER_COUNT: Other Speed Descriptor Max Power USB Field Count
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
--		STRING_BLENGTH_INDEX: String Descriptor Length USB Field Index
--		STRING_BLENGTH_COUNT: String Descriptor Length USB Field Count
--		STRING_IMANUFACTURER_INDEX: String Descriptor Manufacturer USB Field Index
--		STRING_IMANUFACTURER_COUNT: String Descriptor Manufacturer USB Field Count
--		STRING_IPRODUCT_INDEX: String Descriptor Product USB Field Index
--		STRING_IPRODUCT_COUNT: String Descriptor Product USB Field Count
--		STRING_ISERIALNUMBER_INDEX: String Descriptor Serial Number USB Field Index
--		STRING_ISERIALNUMBER_COUNT: String Descriptor Serial Number USB Field Count
--		STRING_ICONFIGURATION_INDEX: String Descriptor Configuration USB Field Index
--		STRING_ICONFIGURATION_COUNT: String Descriptor Configuration USB Field Count
--		STRING_IINTERFACE_INDEX: String Descriptor Interface USB Field Index
--		STRING_IINTERFACE_COUNT: String Descriptor Interface USB Field Count
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

ENTITY Testbench_NotEqualsOperator is
--  Port ( );
END Testbench_NotEqualsOperator;

ARCHITECTURE Behavioral of Testbench_NotEqualsOperator is

------------------------------------------------------------------------
-- Component Declarations
------------------------------------------------------------------------
COMPONENT NotEqualsOperator is

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
	DEVICE_BNUMCONFIGURATIONS_INDEX: INTEGER := 0;
	DEVICE_BNUMCONFIGURATIONS_COUNT: INTEGER := 0;
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
	-- Configuration Descriptor
	CONFIGURATION_BLENGTH_INDEX: INTEGER := 0;
	CONFIGURATION_BLENGTH_COUNT: INTEGER := 0;
	CONFIGURATION_WTOTALLENGTH_INDEX: INTEGER := 0;
	CONFIGURATION_WTOTALLENGTH_COUNT: INTEGER := 0;
	CONFIGURATION_BNUMINTERFACES_INDEX: INTEGER := 0;
	CONFIGURATION_BNUMINTERFACES_COUNT: INTEGER := 0;
	CONFIGURATION_BCONFIGURATIONVALUE_INDEX: INTEGER := 0;
	CONFIGURATION_BCONFIGURATIONVALUE_COUNT: INTEGER := 0;
	CONFIGURATION_BMATTRIBUTES_INDEX: INTEGER := 0;
	CONFIGURATION_BMATTRIBUTES_COUNT: INTEGER := 0;
	CONFIGURATION_BMAXPOWER_INDEX: INTEGER := 0;
	CONFIGURATION_BMAXPOWER_COUNT: INTEGER := 0;
	-- Other Speed Descriptor
	OTHER_SPEED_BLENGTH_INDEX: INTEGER := 0;
	OTHER_SPEED_BLENGTH_COUNT: INTEGER := 0;
	OTHER_SPEED_WTOTALLENGTH_INDEX: INTEGER := 0;
	OTHER_SPEED_WTOTALLENGTH_COUNT: INTEGER := 0;
	OTHER_SPEED_BNUMINTERFACES_INDEX: INTEGER := 0;
	OTHER_SPEED_BNUMINTERFACES_COUNT: INTEGER := 0;
	OTHER_SPEED_BCONFIGURATIONVALUE_INDEX: INTEGER := 0;
	OTHER_SPEED_BCONFIGURATIONVALUE_COUNT: INTEGER := 0;
	OTHER_SPEED_BMATTRIBUTES_INDEX: INTEGER := 0;
	OTHER_SPEED_BMATTRIBUTES_COUNT: INTEGER := 0;
	OTHER_SPEED_BMAXPOWER_INDEX: INTEGER := 0;
	OTHER_SPEED_BMAXPOWER_COUNT: INTEGER := 0;
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
	-- String Descriptor
	STRING_BLENGTH_INDEX: INTEGER := 0;
	STRING_BLENGTH_COUNT: INTEGER := 0;
	STRING_IMANUFACTURER_INDEX: INTEGER := 0;
	STRING_IMANUFACTURER_COUNT: INTEGER := 0;
	STRING_IPRODUCT_INDEX: INTEGER := 0;
	STRING_IPRODUCT_COUNT: INTEGER := 0;
	STRING_ISERIALNUMBER_INDEX: INTEGER := 0;
	STRING_ISERIALNUMBER_COUNT: INTEGER := 0;
	STRING_ICONFIGURATION_INDEX: INTEGER := 0;
	STRING_ICONFIGURATION_COUNT: INTEGER := 0;
	STRING_IINTERFACE_INDEX: INTEGER := 0;
	STRING_IINTERFACE_COUNT: INTEGER := 0
);

PORT(
	i_sys_clock: IN STD_LOGIC;
	i_enable: IN STD_LOGIC;
	i_descriptor_field: IN UNSIGNED(USB_DESCRIPTOR_FIELD_BIT_LENGTH-1 downto 0);
	i_descriptor_value: IN UNSIGNED(USB_DESCRIPTOR_VALUE_DATA_BIT_LENGTH-1 downto 0);
	i_descriptor_field_available: IN STD_LOGIC;
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

uut: NotEqualsOperator
	GENERIC MAP (
		-- Memory Configurations (Address Length, Address Max Index, Address Count Max)
		MEMORY_ADDR_LENGTH => 2,
		MEMORY_ADDR_MAX_INDEX => 0,
		MEMORY_ADDR_MAX_COUNT => 4,
		-- Device Descriptor
		DEVICE_BLENGTH_INDEX => 0,
		DEVICE_BLENGTH_COUNT => 0,
		DEVICE_BCDUSB_INDEX => 0,
		DEVICE_BCDUSB_COUNT => 3,
		DEVICE_BDEVICECLASS_INDEX => 0,
		DEVICE_BDEVICECLASS_COUNT => 0,
		DEVICE_BDEVICESUBCLASS_INDEX => 0,
		DEVICE_BDEVICESUBCLASS_COUNT => 0,
		DEVICE_BDEVICEPROTOCOL_INDEX => 0,
		DEVICE_BDEVICEPROTOCOL_COUNT => 0,
		DEVICE_BMAXPACKETSIZE0_INDEX => 0,
		DEVICE_BMAXPACKETSIZE0_COUNT => 0,
		DEVICE_IDVENDOR_INDEX => 0,
		DEVICE_IDVENDOR_COUNT => 0,
		DEVICE_IDPRODUCT_INDEX => 0,
		DEVICE_IDPRODUCT_COUNT => 0,
		DEVICE_BCDDEVICE_INDEX => 0,
		DEVICE_BCDDEVICE_COUNT => 0,
		DEVICE_BNUMCONFIGURATIONS_INDEX => 0,
		DEVICE_BNUMCONFIGURATIONS_COUNT => 0,
		-- Device Qualifier Descriptor
		DEVICE_QUALIFIER_BLENGTH_INDEX => 0,
		DEVICE_QUALIFIER_BLENGTH_COUNT => 0,
		DEVICE_QUALIFIER_BCDUSB_INDEX => 0,
		DEVICE_QUALIFIER_BCDUSB_COUNT => 3,
		DEVICE_QUALIFIER_BDEVICECLASS_INDEX => 0,
		DEVICE_QUALIFIER_BDEVICECLASS_COUNT => 0,
		DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX => 0,
		DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT => 0,
		DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX => 0,
		DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT => 0,
		DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX => 0,
		DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT => 0,
		DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX => 0,
		DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT => 0,
		DEVICE_QUALIFIER_BRESERVED_INDEX => 0,
		DEVICE_QUALIFIER_BRESERVED_COUNT => 0,
		-- Configuration Descriptor
		CONFIGURATION_BLENGTH_INDEX => 0,
		CONFIGURATION_BLENGTH_COUNT => 0,
		CONFIGURATION_WTOTALLENGTH_INDEX => 0,
		CONFIGURATION_WTOTALLENGTH_COUNT => 0,
		CONFIGURATION_BNUMINTERFACES_INDEX => 0,
		CONFIGURATION_BNUMINTERFACES_COUNT => 0,
		CONFIGURATION_BCONFIGURATIONVALUE_INDEX => 0,
		CONFIGURATION_BCONFIGURATIONVALUE_COUNT => 0,
		CONFIGURATION_BMATTRIBUTES_INDEX => 0,
		CONFIGURATION_BMATTRIBUTES_COUNT => 0,
		CONFIGURATION_BMAXPOWER_INDEX => 0,
		CONFIGURATION_BMAXPOWER_COUNT => 0,
		-- Other Speed Descriptor
		OTHER_SPEED_BLENGTH_INDEX => 0,
		OTHER_SPEED_BLENGTH_COUNT => 0,
		OTHER_SPEED_WTOTALLENGTH_INDEX => 0,
		OTHER_SPEED_WTOTALLENGTH_COUNT => 0,
		OTHER_SPEED_BNUMINTERFACES_INDEX => 0,
		OTHER_SPEED_BNUMINTERFACES_COUNT => 0,
		OTHER_SPEED_BCONFIGURATIONVALUE_INDEX => 0,
		OTHER_SPEED_BCONFIGURATIONVALUE_COUNT => 0,
		OTHER_SPEED_BMATTRIBUTES_INDEX => 0,
		OTHER_SPEED_BMATTRIBUTES_COUNT => 0,
		OTHER_SPEED_BMAXPOWER_INDEX => 0,
		OTHER_SPEED_BMAXPOWER_COUNT => 0,
		-- Interface Descriptor
		INTERFACE_BLENGTH_INDEX => 0,
		INTERFACE_BLENGTH_COUNT => 0,
		INTERFACE_BINTERFACENUMBER_INDEX => 0,
		INTERFACE_BINTERFACENUMBER_COUNT => 0,
		INTERFACE_BALTERNATESETTING_INDEX => 0,
		INTERFACE_BALTERNATESETTING_COUNT => 0,
		INTERFACE_BNUMENDPOINTS_INDEX => 0,
		INTERFACE_BNUMENDPOINTS_COUNT => 0,
		INTERFACE_BINTERFACECLASS_INDEX => 0,
		INTERFACE_BINTERFACECLASS_COUNT => 0,
		INTERFACE_BINTERFACESUBCLASS_INDEX => 0,
		INTERFACE_BINTERFACESUBCLASS_COUNT => 0,
		INTERFACE_BINTERFACEPROTOCOL_INDEX => 0,
		INTERFACE_BINTERFACEPROTOCOL_COUNT => 0,
		-- Endpoint Descriptor
		ENDPOINT_BLENGTH_INDEX => 0,
		ENDPOINT_BLENGTH_COUNT => 0,
		ENDPOINT_BENDPOINTADDRESS_INDEX => 0,
		ENDPOINT_BENDPOINTADDRESS_COUNT => 0,
		ENDPOINT_BMATTRIBUTES_INDEX => 0,
		ENDPOINT_BMATTRIBUTES_COUNT => 0,
		ENDPOINT_WMAXPACKETSIZE_INDEX => 0,
		ENDPOINT_WMAXPACKETSIZE_COUNT => 0,
		ENDPOINT_BINTERVAL_INDEX => 0,
		ENDPOINT_BINTERVAL_COUNT => 0,
		-- HID Descriptor
		HID_BLENGTH_INDEX => 0,
		HID_BLENGTH_COUNT => 0,
		HID_BCDHID_INDEX => 0,
		HID_BCDHID_COUNT => 0,
		HID_BCOUNTRYCODE_INDEX => 0,
		HID_BCOUNTRYCODE_COUNT => 0,
		HID_BNUMDESCRIPTORS_INDEX => 0,
		HID_BNUMDESCRIPTORS_COUNT => 0,
		HID_BDESCRIPTORTYPE_INDEX => 0,
		HID_BDESCRIPTORTYPE_COUNT => 0,
		HID_WDESCRIPTORLENGTH_INDEX => 0,
		HID_WDESCRIPTORLENGTH_COUNT => 0,
		-- String Descriptor
		STRING_BLENGTH_INDEX => 0,
		STRING_BLENGTH_COUNT => 0,
		STRING_IMANUFACTURER_INDEX => 0,
		STRING_IMANUFACTURER_COUNT => 0,
		STRING_IPRODUCT_INDEX => 0,
		STRING_IPRODUCT_COUNT => 0,
		STRING_ISERIALNUMBER_INDEX => 0,
		STRING_ISERIALNUMBER_COUNT => 0,
		STRING_ICONFIGURATION_INDEX => 0,
		STRING_ICONFIGURATION_COUNT => 0,
		STRING_IINTERFACE_INDEX => 0,
		STRING_IINTERFACE_COUNT => 0
	)

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