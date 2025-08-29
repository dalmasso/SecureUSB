------------------------------------------------------------------------
-- Engineer:    Dalmasso Loic
-- Create Date: 21/08/2025
-- Module Name: USBVerifier
-- Description:
--		The USBVerifier Module is in charge of applying all verification operations on USB Field Values
--		The USBVerifier Module embeds the following Operator Modules:
--			- Equals
--			- NotEquals
--			- Greater
--			- GreaterEquals
--			- Less
--			- LessEquals
--			- StartsWith
--			- EndsWith
--			- Contains
--			- NotContains
--
-- Usage:
--		Once enabled, the USB Verifier get USB Field & Values infos and apply them to all operators
--		When all operator verifications ends, the USB Verifier result is ready:
--			- All operators success, the USB Verifier result is successful
--			- At least 1 operator fails, the USB Verifier result is error
--
-- Generics:
--		EQUALS_OPERATOR_ENABLE: Define if the Equals Operator is Enable/Disable ('0': Disabled, '1': Enabled)
--		NOT_EQUALS_OPERATOR_ENABLE: Define if the NotEquals Operator is Enable/Disable ('0': Disabled, '1': Enabled)
--		GREATER_OPERATOR_ENABLE: Define if the Greater Operator is Enable/Disable ('0': Disabled, '1': Enabled)
--		GREATER_EQUALS_OPERATOR_ENABLE: Define if the GreaterEquals Operator is Enable/Disable ('0': Disabled, '1': Enabled)
--		LESS_OPERATOR_ENABLE: Define if the Less Operator is Enable/Disable ('0': Disabled, '1': Enabled)
--		LESS_EQUALS_OPERATOR_ENABLE: Define if the LessEquals Operator is Enable/Disable ('0': Disabled, '1': Enabled)
--		STARTS_WITH_OPERATOR_ENABLE: Define if the StartsWith Operator is Enable/Disable ('0': Disabled, '1': Enabled)
--		ENDS_WITH_OPERATOR_ENABLE: Define if the EndsWith Operator is Enable/Disable ('0': Disabled, '1': Enabled)
--		CONTAINS_OPERATOR_ENABLE: Define if the Contains Operator is Enable/Disable ('0': Disabled, '1': Enabled)
--		NOT_CONTAINS_OPERATOR_ENABLE: Define if the NotContains Operator is Enable/Disable ('0': Disabled, '1': Enabled)
--		WATCHDOG_LIMIT: Define the maximum number of allowed verification clock cycles (in line with all operators latency)

--		EQUALS_MEMORY_ADDR_LENGTH: Define the Memory Address Bus Length for Equals Operator (in line with the maximum index value)
--		EQUALS_MEMORY_ADDR_MAX_INDEX: Define the Memory Maximum Address for Equals Operator (in line with the maximum index value)
--		EQUALS_MEMORY_ADDR_MAX_COUNT: Define the Memory Maximum Address Count for Equals Operator (in line with the maximum count value)
--		EQUALS_DEVICE_BLENGTH_INDEX: Device Descriptor Length USB Field Index for Equals Operator
--		EQUALS_DEVICE_BLENGTH_COUNT: Device Descriptor Length USB Field Count for Equals Operator
--		EQUALS_DEVICE_BCDUSB_INDEX: Device Descriptor USB Release Number Field Index for Equals Operator
--		EQUALS_DEVICE_BCDUSB_COUNT: Device Descriptor USB Release Number Field Count for Equals Operator
--		EQUALS_DEVICE_BDEVICECLASS_INDEX: Device Descriptor Device Class USB Field Index for Equals Operator
--		EQUALS_DEVICE_BDEVICECLASS_COUNT: Device Descriptor Device Class USB Field Count for Equals Operator
--		EQUALS_DEVICE_BDEVICESUBCLASS_INDEX: Device Descriptor Device Sub Class USB Field Index for Equals Operator
--		EQUALS_DEVICE_BDEVICESUBCLASS_COUNT: Device Descriptor Device Sub Class USB Field Count for Equals Operator
--		EQUALS_DEVICE_BDEVICEPROTOCOL_INDEX: Device Descriptor Device Protocol USB Field Index for Equals Operator
--		EQUALS_DEVICE_BDEVICEPROTOCOL_COUNT: Device Descriptor Device Protocol USB Field Count for Equals Operator
--		EQUALS_DEVICE_BMAXPACKETSIZE0_INDEX: Device Descriptor Max Packet Size0 USB Field Index for Equals Operator
--		EQUALS_DEVICE_BMAXPACKETSIZE0_COUNT: Device Descriptor Max Packet Size0 USB Field Count for Equals Operator
--		EQUALS_DEVICE_IDVENDOR_INDEX: Device Descriptor Vendor USB Field Index for Equals Operator
--		EQUALS_DEVICE_IDVENDOR_COUNT: Device Descriptor Vendor USB Field Count for Equals Operator
--		EQUALS_DEVICE_IDPRODUCT_INDEX: Device Descriptor Product USB Field Index for Equals Operator
--		EQUALS_DEVICE_IDPRODUCT_COUNT: Device Descriptor Product USB Field Count for Equals Operator
--		EQUALS_DEVICE_BCDDEVICE_INDEX: Device Descriptor Device Release Number USB Field Index for Equals Operator
--		EQUALS_DEVICE_BCDDEVICE_COUNT: Device Descriptor Device Release Number USB Field Count for Equals Operator
--		EQUALS_DEVICE_BNUMCONFIGURATIONS_INDEX: Device Descriptor Num Configuration USB Field Index for Equals Operator
--		EQUALS_DEVICE_BNUMCONFIGURATIONS_COUNT: Device Descriptor Num Configuration USB Field Count for Equals Operator
--		EQUALS_DEVICE_QUALIFIER_BLENGTH_INDEX: Device Qualifier Descriptor Length USB Field Index for Equals Operator
--		EQUALS_DEVICE_QUALIFIER_BLENGTH_COUNT: Device Qualifier Descriptor Length USB Field Count for Equals Operator
--		EQUALS_DEVICE_QUALIFIER_BCDUSB_INDEX: Device Qualifier Descriptor USB Release Number Field Index for Equals Operator
--		EQUALS_DEVICE_QUALIFIER_BCDUSB_COUNT: Device Qualifier Descriptor USB Release Number Field Count for Equals Operator
--		EQUALS_DEVICE_QUALIFIER_BDEVICECLASS_INDEX: Device Qualifier Descriptor Device Class USB Field Index for Equals Operator
--		EQUALS_DEVICE_QUALIFIER_BDEVICECLASS_COUNT: Device Qualifier Descriptor Device Class USB Field Count for Equals Operator
--		EQUALS_DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX: Device Qualifier Descriptor Device Sub Class USB Field Index for Equals Operator
--		EQUALS_DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT: Device Qualifier Descriptor Device Sub Class USB Field Count for Equals Operator
--		EQUALS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX: Device Qualifier Descriptor Device Protocol USB Field Index for Equals Operator
--		EQUALS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT: Device Qualifier Descriptor Device Protocol USB Field Count for Equals Operator
--		EQUALS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX: Device Qualifier Descriptor Max Packet Size0 USB Field Index for Equals Operator
--		EQUALS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT: Device Qualifier Descriptor Max Packet Size0 USB Field Count for Equals Operator
--		EQUALS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX: Device Qualifier Descriptor Num Configuration USB Field Index for Equals Operator
--		EQUALS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT: Device Qualifier Descriptor Num Configuration USB Field Count for Equals Operator
--		EQUALS_DEVICE_QUALIFIER_BRESERVED_INDEX: Device Qualifier Descriptor Reserved USB Field Index for Equals Operator
--		EQUALS_DEVICE_QUALIFIER_BRESERVED_COUNT: Device Qualifier Descriptor Reserved USB Field Count for Equals Operator
--		EQUALS_CONFIGURATION_BLENGTH_INDEX: Configuration Descriptor Length USB Field Index for Equals Operator
--		EQUALS_CONFIGURATION_BLENGTH_COUNT: Configuration Descriptor Length USB Field Count for Equals Operator
--		EQUALS_CONFIGURATION_WTOTALLENGTH_INDEX: Configuration Descriptor Total Length USB Field Index for Equals Operator
--		EQUALS_CONFIGURATION_WTOTALLENGTH_COUNT: Configuration Descriptor Total Length USB Field Count for Equals Operator
--		EQUALS_CONFIGURATION_BNUMINTERFACES_INDEX: Configuration Descriptor Num Interfaces USB Field Index for Equals Operator
--		EQUALS_CONFIGURATION_BNUMINTERFACES_COUNT: Configuration Descriptor Num Interfaces USB Field Count for Equals Operator
--		EQUALS_CONFIGURATION_BCONFIGURATIONVALUE_INDEX: Configuration Descriptor Configuration Value USB Field Index for Equals Operator
--		EQUALS_CONFIGURATION_BCONFIGURATIONVALUE_COUNT: Configuration Descriptor Configuration Value USB Field Count for Equals Operator
--		EQUALS_CONFIGURATION_BMATTRIBUTES_INDEX: Configuration Descriptor Attributes USB Field Index for Equals Operator
--		EQUALS_CONFIGURATION_BMATTRIBUTES_COUNT: Configuration Descriptor Attributes USB Field Count for Equals Operator
--		EQUALS_CONFIGURATION_BMAXPOWER_INDEX: Configuration Descriptor Max Power USB Field Index for Equals Operator
--		EQUALS_CONFIGURATION_BMAXPOWER_COUNT: Configuration Descriptor Max Power USB Field Count for Equals Operator
--		EQUALS_OTHER_SPEED_BLENGTH_INDEX: Other Speed Descriptor Length USB Field Index for Equals Operator
--		EQUALS_OTHER_SPEED_BLENGTH_COUNT: Other Speed Descriptor Length USB Field Count for Equals Operator
--		EQUALS_OTHER_SPEED_WTOTALLENGTH_INDEX: Other Speed Descriptor Total Length USB Field Index for Equals Operator
--		EQUALS_OTHER_SPEED_WTOTALLENGTH_COUNT: Other Speed Descriptor Total Length USB Field Count for Equals Operator
--		EQUALS_OTHER_SPEED_BNUMINTERFACES_INDEX: Other Speed Descriptor Num Interfaces USB Field Index for Equals Operator
--		EQUALS_OTHER_SPEED_BNUMINTERFACES_COUNT: Other Speed Descriptor Num Interfaces USB Field Count for Equals Operator
--		EQUALS_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX: Other Speed Descriptor Configuration Value USB Field Index for Equals Operator
--		EQUALS_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT: Other Speed Descriptor Configuration Value USB Field Count for Equals Operator
--		EQUALS_OTHER_SPEED_BMATTRIBUTES_INDEX: Other Speed Descriptor Attributes USB Field Index for Equals Operator
--		EQUALS_OTHER_SPEED_BMATTRIBUTES_COUNT: Other Speed Descriptor Attributes USB Field Count for Equals Operator
--		EQUALS_OTHER_SPEED_BMAXPOWER_INDEX: Other Speed Descriptor Max Power USB Field Index for Equals Operator
--		EQUALS_OTHER_SPEED_BMAXPOWER_COUNT: Other Speed Descriptor Max Power USB Field Count for Equals Operator
--		EQUALS_INTERFACE_BLENGTH_INDEX: Interface Descriptor Length USB Field Index for Equals Operator
--		EQUALS_INTERFACE_BLENGTH_COUNT: Interface Descriptor Length USB Field Count for Equals Operator
--		EQUALS_INTERFACE_BINTERFACENUMBER_INDEX: Interface Descriptor Interface Number USB Field Index for Equals Operator
--		EQUALS_INTERFACE_BINTERFACENUMBER_COUNT: Interface Descriptor Interface Number USB Field Count for Equals Operator
--		EQUALS_INTERFACE_BALTERNATESETTING_INDEX: Interface Descriptor Alternate Setting USB Field Index for Equals Operator
--		EQUALS_INTERFACE_BALTERNATESETTING_COUNT: Interface Descriptor Alternate Setting USB Field Count for Equals Operator
--		EQUALS_INTERFACE_BNUMENDPOINTS_INDEX: Interface Descriptor Num Endpoints USB Field Index for Equals Operator
--		EQUALS_INTERFACE_BNUMENDPOINTS_COUNT: Interface Descriptor Num Endpoints USB Field Count for Equals Operator
--		EQUALS_INTERFACE_BINTERFACECLASS_INDEX: Interface Descriptor Interface Class USB Field Index for Equals Operator
--		EQUALS_INTERFACE_BINTERFACECLASS_COUNT: Interface Descriptor Interface Class USB Field Count for Equals Operator
--		EQUALS_INTERFACE_BINTERFACESUBCLASS_INDEX: Interface Descriptor Interface Sub Class USB Field Index for Equals Operator
--		EQUALS_INTERFACE_BINTERFACESUBCLASS_COUNT: Interface Descriptor Interface Sub Class USB Field Count for Equals Operator
--		EQUALS_INTERFACE_BINTERFACEPROTOCOL_INDEX: Interface Descriptor Interface Protocol USB Field Index for Equals Operator
--		EQUALS_INTERFACE_BINTERFACEPROTOCOL_COUNT: Interface Descriptor Interface Protocol USB Field Count for Equals Operator
--		EQUALS_ENDPOINT_BLENGTH_INDEX: Endpoint Descriptor Length USB Field Index for Equals Operator
--		EQUALS_ENDPOINT_BLENGTH_COUNT: Endpoint Descriptor Length USB Field Count for Equals Operator
--		EQUALS_ENDPOINT_BENDPOINTADDRESS_INDEX: Endpoint Descriptor Endpoint Address USB Field Index for Equals Operator
--		EQUALS_ENDPOINT_BENDPOINTADDRESS_COUNT: Endpoint Descriptor Endpoint Address USB Field Count for Equals Operator
--		EQUALS_ENDPOINT_BMATTRIBUTES_INDEX: Endpoint Descriptor Attributes USB Field Index for Equals Operator
--		EQUALS_ENDPOINT_BMATTRIBUTES_COUNT: Endpoint Descriptor Attributes USB Field Count for Equals Operator
--		EQUALS_ENDPOINT_WMAXPACKETSIZE_INDEX: Endpoint Descriptor Max Packet Size USB Field Index for Equals Operator
--		EQUALS_ENDPOINT_WMAXPACKETSIZE_COUNT: Endpoint Descriptor Max Packet Size USB Field Count for Equals Operator
--		EQUALS_ENDPOINT_BINTERVAL_INDEX: Endpoint Descriptor Interval USB Field Index for Equals Operator
--		EQUALS_ENDPOINT_BINTERVAL_COUNT: Endpoint Descriptor Interval USB Field Count for Equals Operator
--		EQUALS_HID_BLENGTH_INDEX: HID Descriptor Length USB Field Index for Equals Operator
--		EQUALS_HID_BLENGTH_COUNT: HID Descriptor Length USB Field Count for Equals Operator
--		EQUALS_HID_BCDHID_INDEX: HID Descriptor HID USB Field Index for Equals Operator
--		EQUALS_HID_BCDHID_COUNT: HID Descriptor HID USB Field Count for Equals Operator
--		EQUALS_HID_BCOUNTRYCODE_INDEX: HID Descriptor Country Code USB Field Index for Equals Operator
--		EQUALS_HID_BCOUNTRYCODE_COUNT: HID Descriptor Country Code USB Field Count for Equals Operator
--		EQUALS_HID_BNUMDESCRIPTORS_INDEX: HID Descriptor Num Descriptors USB Field Index for Equals Operator
--		EQUALS_HID_BNUMDESCRIPTORS_COUNT: HID Descriptor Num Descriptors USB Field Count for Equals Operator
--		EQUALS_HID_BDESCRIPTORTYPE_INDEX: HID Descriptor Descriptor Type USB Field Index for Equals Operator
--		EQUALS_HID_BDESCRIPTORTYPE_COUNT: HID Descriptor Descriptor Type USB Field Count for Equals Operator
--		EQUALS_HID_WDESCRIPTORLENGTH_INDEX: HID Descriptor Descriptor Length USB Field Index for Equals Operator
--		EQUALS_HID_WDESCRIPTORLENGTH_COUNT: HID Descriptor Descriptor Length USB Field Count for Equals Operator
--		EQUALS_STRING_BLENGTH_INDEX: String Descriptor Length USB Field Index for Equals Operator
--		EQUALS_STRING_BLENGTH_COUNT: String Descriptor Length USB Field Count for Equals Operator
--		EQUALS_STRING_IMANUFACTURER_INDEX: String Descriptor Manufacturer USB Field Index for Equals Operator
--		EQUALS_STRING_IMANUFACTURER_COUNT: String Descriptor Manufacturer USB Field Count for Equals Operator
--		EQUALS_STRING_IPRODUCT_INDEX: String Descriptor Product USB Field Index for Equals Operator
--		EQUALS_STRING_IPRODUCT_COUNT: String Descriptor Product USB Field Count for Equals Operator
--		EQUALS_STRING_ISERIALNUMBER_INDEX: String Descriptor Serial Number USB Field Index for Equals Operator
--		EQUALS_STRING_ISERIALNUMBER_COUNT: String Descriptor Serial Number USB Field Count for Equals Operator
--		EQUALS_STRING_ICONFIGURATION_INDEX: String Descriptor Configuration USB Field Index for Equals Operator
--		EQUALS_STRING_ICONFIGURATION_COUNT: String Descriptor Configuration USB Field Count for Equals Operator
--		EQUALS_STRING_IINTERFACE_INDEX: String Descriptor Interface USB Field Index for Equals Operator
--		EQUALS_STRING_IINTERFACE_COUNT: String Descriptor Interface USB Field Count for Equals Operator
--
--		NOT_EQUALS_MEMORY_ADDR_LENGTH: Define the Memory Address Bus Length for NotEquals Operator (in line with the maximum index value)
--		NOT_EQUALS_MEMORY_ADDR_MAX_INDEX: Define the Memory Maximum Address for NotEquals Operator (in line with the maximum index value)
--		NOT_EQUALS_MEMORY_ADDR_MAX_COUNT: Define the Memory Maximum Address Count for NotEquals Operator (in line with the maximum count value)
--		NOT_EQUALS_DEVICE_BLENGTH_INDEX: Device Descriptor Length USB Field Index for NotEquals Operator
--		NOT_EQUALS_DEVICE_BLENGTH_COUNT: Device Descriptor Length USB Field Count for NotEquals Operator
--		NOT_EQUALS_DEVICE_BCDUSB_INDEX: Device Descriptor USB Release Number Field Index for NotEquals Operator
--		NOT_EQUALS_DEVICE_BCDUSB_COUNT: Device Descriptor USB Release Number Field Count for NotEquals Operator
--		NOT_EQUALS_DEVICE_BDEVICECLASS_INDEX: Device Descriptor Device Class USB Field Index for NotEquals Operator
--		NOT_EQUALS_DEVICE_BDEVICECLASS_COUNT: Device Descriptor Device Class USB Field Count for NotEquals Operator
--		NOT_EQUALS_DEVICE_BDEVICESUBCLASS_INDEX: Device Descriptor Device Sub Class USB Field Index for NotEquals Operator
--		NOT_EQUALS_DEVICE_BDEVICESUBCLASS_COUNT: Device Descriptor Device Sub Class USB Field Count for NotEquals Operator
--		NOT_EQUALS_DEVICE_BDEVICEPROTOCOL_INDEX: Device Descriptor Device Protocol USB Field Index for NotEquals Operator
--		NOT_EQUALS_DEVICE_BDEVICEPROTOCOL_COUNT: Device Descriptor Device Protocol USB Field Count for NotEquals Operator
--		NOT_EQUALS_DEVICE_BMAXPACKETSIZE0_INDEX: Device Descriptor Max Packet Size0 USB Field Index for NotEquals Operator
--		NOT_EQUALS_DEVICE_BMAXPACKETSIZE0_COUNT: Device Descriptor Max Packet Size0 USB Field Count for NotEquals Operator
--		NOT_EQUALS_DEVICE_IDVENDOR_INDEX: Device Descriptor Vendor USB Field Index for NotEquals Operator
--		NOT_EQUALS_DEVICE_IDVENDOR_COUNT: Device Descriptor Vendor USB Field Count for NotEquals Operator
--		NOT_EQUALS_DEVICE_IDPRODUCT_INDEX: Device Descriptor Product USB Field Index for NotEquals Operator
--		NOT_EQUALS_DEVICE_IDPRODUCT_COUNT: Device Descriptor Product USB Field Count for NotEquals Operator
--		NOT_EQUALS_DEVICE_BCDDEVICE_INDEX: Device Descriptor Device Release Number USB Field Index for NotEquals Operator
--		NOT_EQUALS_DEVICE_BCDDEVICE_COUNT: Device Descriptor Device Release Number USB Field Count for NotEquals Operator
--		NOT_EQUALS_DEVICE_BNUMCONFIGURATIONS_INDEX: Device Descriptor Num Configuration USB Field Index for NotEquals Operator
--		NOT_EQUALS_DEVICE_BNUMCONFIGURATIONS_COUNT: Device Descriptor Num Configuration USB Field Count for NotEquals Operator
--		NOT_EQUALS_DEVICE_QUALIFIER_BLENGTH_INDEX: Device Qualifier Descriptor Length USB Field Index for NotEquals Operator
--		NOT_EQUALS_DEVICE_QUALIFIER_BLENGTH_COUNT: Device Qualifier Descriptor Length USB Field Count for NotEquals Operator
--		NOT_EQUALS_DEVICE_QUALIFIER_BCDUSB_INDEX: Device Qualifier Descriptor USB Release Number Field Index for NotEquals Operator
--		NOT_EQUALS_DEVICE_QUALIFIER_BCDUSB_COUNT: Device Qualifier Descriptor USB Release Number Field Count for NotEquals Operator
--		NOT_EQUALS_DEVICE_QUALIFIER_BDEVICECLASS_INDEX: Device Qualifier Descriptor Device Class USB Field Index for NotEquals Operator
--		NOT_EQUALS_DEVICE_QUALIFIER_BDEVICECLASS_COUNT: Device Qualifier Descriptor Device Class USB Field Count for NotEquals Operator
--		NOT_EQUALS_DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX: Device Qualifier Descriptor Device Sub Class USB Field Index for NotEquals Operator
--		NOT_EQUALS_DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT: Device Qualifier Descriptor Device Sub Class USB Field Count for NotEquals Operator
--		NOT_EQUALS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX: Device Qualifier Descriptor Device Protocol USB Field Index for NotEquals Operator
--		NOT_EQUALS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT: Device Qualifier Descriptor Device Protocol USB Field Count for NotEquals Operator
--		NOT_EQUALS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX: Device Qualifier Descriptor Max Packet Size0 USB Field Index for NotEquals Operator
--		NOT_EQUALS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT: Device Qualifier Descriptor Max Packet Size0 USB Field Count for NotEquals Operator
--		NOT_EQUALS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX: Device Qualifier Descriptor Num Configuration USB Field Index for NotEquals Operator
--		NOT_EQUALS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT: Device Qualifier Descriptor Num Configuration USB Field Count for NotEquals Operator
--		NOT_EQUALS_DEVICE_QUALIFIER_BRESERVED_INDEX: Device Qualifier Descriptor Reserved USB Field Index for NotEquals Operator
--		NOT_EQUALS_DEVICE_QUALIFIER_BRESERVED_COUNT: Device Qualifier Descriptor Reserved USB Field Count for NotEquals Operator
--		NOT_EQUALS_CONFIGURATION_BLENGTH_INDEX: Configuration Descriptor Length USB Field Index for NotEquals Operator
--		NOT_EQUALS_CONFIGURATION_BLENGTH_COUNT: Configuration Descriptor Length USB Field Count for NotEquals Operator
--		NOT_EQUALS_CONFIGURATION_WTOTALLENGTH_INDEX: Configuration Descriptor Total Length USB Field Index for NotEquals Operator
--		NOT_EQUALS_CONFIGURATION_WTOTALLENGTH_COUNT: Configuration Descriptor Total Length USB Field Count for NotEquals Operator
--		NOT_EQUALS_CONFIGURATION_BNUMINTERFACES_INDEX: Configuration Descriptor Num Interfaces USB Field Index for NotEquals Operator
--		NOT_EQUALS_CONFIGURATION_BNUMINTERFACES_COUNT: Configuration Descriptor Num Interfaces USB Field Count for NotEquals Operator
--		NOT_EQUALS_CONFIGURATION_BCONFIGURATIONVALUE_INDEX: Configuration Descriptor Configuration Value USB Field Index for NotEquals Operator
--		NOT_EQUALS_CONFIGURATION_BCONFIGURATIONVALUE_COUNT: Configuration Descriptor Configuration Value USB Field Count for NotEquals Operator
--		NOT_EQUALS_CONFIGURATION_BMATTRIBUTES_INDEX: Configuration Descriptor Attributes USB Field Index for NotEquals Operator
--		NOT_EQUALS_CONFIGURATION_BMATTRIBUTES_COUNT: Configuration Descriptor Attributes USB Field Count for NotEquals Operator
--		NOT_EQUALS_CONFIGURATION_BMAXPOWER_INDEX: Configuration Descriptor Max Power USB Field Index for NotEquals Operator
--		NOT_EQUALS_CONFIGURATION_BMAXPOWER_COUNT: Configuration Descriptor Max Power USB Field Count for NotEquals Operator
--		NOT_EQUALS_OTHER_SPEED_BLENGTH_INDEX: Other Speed Descriptor Length USB Field Index for NotEquals Operator
--		NOT_EQUALS_OTHER_SPEED_BLENGTH_COUNT: Other Speed Descriptor Length USB Field Count for NotEquals Operator
--		NOT_EQUALS_OTHER_SPEED_WTOTALLENGTH_INDEX: Other Speed Descriptor Total Length USB Field Index for NotEquals Operator
--		NOT_EQUALS_OTHER_SPEED_WTOTALLENGTH_COUNT: Other Speed Descriptor Total Length USB Field Count for NotEquals Operator
--		NOT_EQUALS_OTHER_SPEED_BNUMINTERFACES_INDEX: Other Speed Descriptor Num Interfaces USB Field Index for NotEquals Operator
--		NOT_EQUALS_OTHER_SPEED_BNUMINTERFACES_COUNT: Other Speed Descriptor Num Interfaces USB Field Count for NotEquals Operator
--		NOT_EQUALS_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX: Other Speed Descriptor Configuration Value USB Field Index for NotEquals Operator
--		NOT_EQUALS_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT: Other Speed Descriptor Configuration Value USB Field Count for NotEquals Operator
--		NOT_EQUALS_OTHER_SPEED_BMATTRIBUTES_INDEX: Other Speed Descriptor Attributes USB Field Index for NotEquals Operator
--		NOT_EQUALS_OTHER_SPEED_BMATTRIBUTES_COUNT: Other Speed Descriptor Attributes USB Field Count for NotEquals Operator
--		NOT_EQUALS_OTHER_SPEED_BMAXPOWER_INDEX: Other Speed Descriptor Max Power USB Field Index for NotEquals Operator
--		NOT_EQUALS_OTHER_SPEED_BMAXPOWER_COUNT: Other Speed Descriptor Max Power USB Field Count for NotEquals Operator
--		NOT_EQUALS_INTERFACE_BLENGTH_INDEX: Interface Descriptor Length USB Field Index for NotEquals Operator
--		NOT_EQUALS_INTERFACE_BLENGTH_COUNT: Interface Descriptor Length USB Field Count for NotEquals Operator
--		NOT_EQUALS_INTERFACE_BINTERFACENUMBER_INDEX: Interface Descriptor Interface Number USB Field Index for NotEquals Operator
--		NOT_EQUALS_INTERFACE_BINTERFACENUMBER_COUNT: Interface Descriptor Interface Number USB Field Count for NotEquals Operator
--		NOT_EQUALS_INTERFACE_BALTERNATESETTING_INDEX: Interface Descriptor Alternate Setting USB Field Index for NotEquals Operator
--		NOT_EQUALS_INTERFACE_BALTERNATESETTING_COUNT: Interface Descriptor Alternate Setting USB Field Count for NotEquals Operator
--		NOT_EQUALS_INTERFACE_BNUMENDPOINTS_INDEX: Interface Descriptor Num Endpoints USB Field Index for NotEquals Operator
--		NOT_EQUALS_INTERFACE_BNUMENDPOINTS_COUNT: Interface Descriptor Num Endpoints USB Field Count for NotEquals Operator
--		NOT_EQUALS_INTERFACE_BINTERFACECLASS_INDEX: Interface Descriptor Interface Class USB Field Index for NotEquals Operator
--		NOT_EQUALS_INTERFACE_BINTERFACECLASS_COUNT: Interface Descriptor Interface Class USB Field Count for NotEquals Operator
--		NOT_EQUALS_INTERFACE_BINTERFACESUBCLASS_INDEX: Interface Descriptor Interface Sub Class USB Field Index for NotEquals Operator
--		NOT_EQUALS_INTERFACE_BINTERFACESUBCLASS_COUNT: Interface Descriptor Interface Sub Class USB Field Count for NotEquals Operator
--		NOT_EQUALS_INTERFACE_BINTERFACEPROTOCOL_INDEX: Interface Descriptor Interface Protocol USB Field Index for NotEquals Operator
--		NOT_EQUALS_INTERFACE_BINTERFACEPROTOCOL_COUNT: Interface Descriptor Interface Protocol USB Field Count for NotEquals Operator
--		NOT_EQUALS_ENDPOINT_BLENGTH_INDEX: Endpoint Descriptor Length USB Field Index for NotEquals Operator
--		NOT_EQUALS_ENDPOINT_BLENGTH_COUNT: Endpoint Descriptor Length USB Field Count for NotEquals Operator
--		NOT_EQUALS_ENDPOINT_BENDPOINTADDRESS_INDEX: Endpoint Descriptor Endpoint Address USB Field Index for NotEquals Operator
--		NOT_EQUALS_ENDPOINT_BENDPOINTADDRESS_COUNT: Endpoint Descriptor Endpoint Address USB Field Count for NotEquals Operator
--		NOT_EQUALS_ENDPOINT_BMATTRIBUTES_INDEX: Endpoint Descriptor Attributes USB Field Index for NotEquals Operator
--		NOT_EQUALS_ENDPOINT_BMATTRIBUTES_COUNT: Endpoint Descriptor Attributes USB Field Count for NotEquals Operator
--		NOT_EQUALS_ENDPOINT_WMAXPACKETSIZE_INDEX: Endpoint Descriptor Max Packet Size USB Field Index for NotEquals Operator
--		NOT_EQUALS_ENDPOINT_WMAXPACKETSIZE_COUNT: Endpoint Descriptor Max Packet Size USB Field Count for NotEquals Operator
--		NOT_EQUALS_ENDPOINT_BINTERVAL_INDEX: Endpoint Descriptor Interval USB Field Index for NotEquals Operator
--		NOT_EQUALS_ENDPOINT_BINTERVAL_COUNT: Endpoint Descriptor Interval USB Field Count for NotEquals Operator
--		NOT_EQUALS_HID_BLENGTH_INDEX: HID Descriptor Length USB Field Index for NotEquals Operator
--		NOT_EQUALS_HID_BLENGTH_COUNT: HID Descriptor Length USB Field Count for NotEquals Operator
--		NOT_EQUALS_HID_BCDHID_INDEX: HID Descriptor HID USB Field Index for NotEquals Operator
--		NOT_EQUALS_HID_BCDHID_COUNT: HID Descriptor HID USB Field Count for NotEquals Operator
--		NOT_EQUALS_HID_BCOUNTRYCODE_INDEX: HID Descriptor Country Code USB Field Index for NotEquals Operator
--		NOT_EQUALS_HID_BCOUNTRYCODE_COUNT: HID Descriptor Country Code USB Field Count for NotEquals Operator
--		NOT_EQUALS_HID_BNUMDESCRIPTORS_INDEX: HID Descriptor Num Descriptors USB Field Index for NotEquals Operator
--		NOT_EQUALS_HID_BNUMDESCRIPTORS_COUNT: HID Descriptor Num Descriptors USB Field Count for NotEquals Operator
--		NOT_EQUALS_HID_BDESCRIPTORTYPE_INDEX: HID Descriptor Descriptor Type USB Field Index for NotEquals Operator
--		NOT_EQUALS_HID_BDESCRIPTORTYPE_COUNT: HID Descriptor Descriptor Type USB Field Count for NotEquals Operator
--		NOT_EQUALS_HID_WDESCRIPTORLENGTH_INDEX: HID Descriptor Descriptor Length USB Field Index for NotEquals Operator
--		NOT_EQUALS_HID_WDESCRIPTORLENGTH_COUNT: HID Descriptor Descriptor Length USB Field Count for NotEquals Operator
--		NOT_EQUALS_STRING_BLENGTH_INDEX: String Descriptor Length USB Field Index for NotEquals Operator
--		NOT_EQUALS_STRING_BLENGTH_COUNT: String Descriptor Length USB Field Count for NotEquals Operator
--		NOT_EQUALS_STRING_IMANUFACTURER_INDEX: String Descriptor Manufacturer USB Field Index for NotEquals Operator
--		NOT_EQUALS_STRING_IMANUFACTURER_COUNT: String Descriptor Manufacturer USB Field Count for NotEquals Operator
--		NOT_EQUALS_STRING_IPRODUCT_INDEX: String Descriptor Product USB Field Index for NotEquals Operator
--		NOT_EQUALS_STRING_IPRODUCT_COUNT: String Descriptor Product USB Field Count for NotEquals Operator
--		NOT_EQUALS_STRING_ISERIALNUMBER_INDEX: String Descriptor Serial Number USB Field Index for NotEquals Operator
--		NOT_EQUALS_STRING_ISERIALNUMBER_COUNT: String Descriptor Serial Number USB Field Count for NotEquals Operator
--		NOT_EQUALS_STRING_ICONFIGURATION_INDEX: String Descriptor Configuration USB Field Index for NotEquals Operator
--		NOT_EQUALS_STRING_ICONFIGURATION_COUNT: String Descriptor Configuration USB Field Count for NotEquals Operator
--		NOT_EQUALS_STRING_IINTERFACE_INDEX: String Descriptor Interface USB Field Index for NotEquals Operator
--		NOT_EQUALS_STRING_IINTERFACE_COUNT: String Descriptor Interface USB Field Count for NotEquals Operator
--
--		GREATER_MEMORY_ADDR_LENGTH: Define the Memory Address Bus Length for Greater Operator (in line with the maximum index value)
--		GREATER_MEMORY_ADDR_MAX_INDEX: Define the Memory Maximum Address for Greater Operator (in line with the maximum index value)
--		GREATER_MEMORY_ADDR_MAX_COUNT: Define the Memory Maximum Address Count for Greater Operator (in line with the maximum count value)
--		GREATER_DEVICE_BLENGTH_INDEX: Device Descriptor Length USB Field Index for Greater Operator
--		GREATER_DEVICE_BLENGTH_COUNT: Device Descriptor Length USB Field Count for Greater Operator
--		GREATER_DEVICE_BCDUSB_INDEX: Device Descriptor USB Release Number Field Index for Greater Operator
--		GREATER_DEVICE_BCDUSB_COUNT: Device Descriptor USB Release Number Field Count for Greater Operator
--		GREATER_DEVICE_BDEVICECLASS_INDEX: Device Descriptor Device Class USB Field Index for Greater Operator
--		GREATER_DEVICE_BDEVICECLASS_COUNT: Device Descriptor Device Class USB Field Count for Greater Operator
--		GREATER_DEVICE_BDEVICESUBCLASS_INDEX: Device Descriptor Device Sub Class USB Field Index for Greater Operator
--		GREATER_DEVICE_BDEVICESUBCLASS_COUNT: Device Descriptor Device Sub Class USB Field Count for Greater Operator
--		GREATER_DEVICE_BDEVICEPROTOCOL_INDEX: Device Descriptor Device Protocol USB Field Index for Greater Operator
--		GREATER_DEVICE_BDEVICEPROTOCOL_COUNT: Device Descriptor Device Protocol USB Field Count for Greater Operator
--		GREATER_DEVICE_BMAXPACKETSIZE0_INDEX: Device Descriptor Max Packet Size0 USB Field Index for Greater Operator
--		GREATER_DEVICE_BMAXPACKETSIZE0_COUNT: Device Descriptor Max Packet Size0 USB Field Count for Greater Operator
--		GREATER_DEVICE_IDVENDOR_INDEX: Device Descriptor Vendor USB Field Index for Greater Operator
--		GREATER_DEVICE_IDVENDOR_COUNT: Device Descriptor Vendor USB Field Count for Greater Operator
--		GREATER_DEVICE_IDPRODUCT_INDEX: Device Descriptor Product USB Field Index for Greater Operator
--		GREATER_DEVICE_IDPRODUCT_COUNT: Device Descriptor Product USB Field Count for Greater Operator
--		GREATER_DEVICE_BCDDEVICE_INDEX: Device Descriptor Device Release Number USB Field Index for Greater Operator
--		GREATER_DEVICE_BCDDEVICE_COUNT: Device Descriptor Device Release Number USB Field Count for Greater Operator
--		GREATER_DEVICE_BNUMCONFIGURATIONS_INDEX: Device Descriptor Num Configuration USB Field Index for Greater Operator
--		GREATER_DEVICE_BNUMCONFIGURATIONS_COUNT: Device Descriptor Num Configuration USB Field Count for Greater Operator
--		GREATER_DEVICE_QUALIFIER_BLENGTH_INDEX: Device Qualifier Descriptor Length USB Field Index for Greater Operator
--		GREATER_DEVICE_QUALIFIER_BLENGTH_COUNT: Device Qualifier Descriptor Length USB Field Count for Greater Operator
--		GREATER_DEVICE_QUALIFIER_BCDUSB_INDEX: Device Qualifier Descriptor USB Release Number Field Index for Greater Operator
--		GREATER_DEVICE_QUALIFIER_BCDUSB_COUNT: Device Qualifier Descriptor USB Release Number Field Count for Greater Operator
--		GREATER_DEVICE_QUALIFIER_BDEVICECLASS_INDEX: Device Qualifier Descriptor Device Class USB Field Index for Greater Operator
--		GREATER_DEVICE_QUALIFIER_BDEVICECLASS_COUNT: Device Qualifier Descriptor Device Class USB Field Count for Greater Operator
--		GREATER_DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX: Device Qualifier Descriptor Device Sub Class USB Field Index for Greater Operator
--		GREATER_DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT: Device Qualifier Descriptor Device Sub Class USB Field Count for Greater Operator
--		GREATER_DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX: Device Qualifier Descriptor Device Protocol USB Field Index for Greater Operator
--		GREATER_DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT: Device Qualifier Descriptor Device Protocol USB Field Count for Greater Operator
--		GREATER_DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX: Device Qualifier Descriptor Max Packet Size0 USB Field Index for Greater Operator
--		GREATER_DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT: Device Qualifier Descriptor Max Packet Size0 USB Field Count for Greater Operator
--		GREATER_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX: Device Qualifier Descriptor Num Configuration USB Field Index for Greater Operator
--		GREATER_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT: Device Qualifier Descriptor Num Configuration USB Field Count for Greater Operator
--		GREATER_DEVICE_QUALIFIER_BRESERVED_INDEX: Device Qualifier Descriptor Reserved USB Field Index for Greater Operator
--		GREATER_DEVICE_QUALIFIER_BRESERVED_COUNT: Device Qualifier Descriptor Reserved USB Field Count for Greater Operator
--		GREATER_CONFIGURATION_BLENGTH_INDEX: Configuration Descriptor Length USB Field Index for Greater Operator
--		GREATER_CONFIGURATION_BLENGTH_COUNT: Configuration Descriptor Length USB Field Count for Greater Operator
--		GREATER_CONFIGURATION_WTOTALLENGTH_INDEX: Configuration Descriptor Total Length USB Field Index for Greater Operator
--		GREATER_CONFIGURATION_WTOTALLENGTH_COUNT: Configuration Descriptor Total Length USB Field Count for Greater Operator
--		GREATER_CONFIGURATION_BNUMINTERFACES_INDEX: Configuration Descriptor Num Interfaces USB Field Index for Greater Operator
--		GREATER_CONFIGURATION_BNUMINTERFACES_COUNT: Configuration Descriptor Num Interfaces USB Field Count for Greater Operator
--		GREATER_CONFIGURATION_BCONFIGURATIONVALUE_INDEX: Configuration Descriptor Configuration Value USB Field Index for Greater Operator
--		GREATER_CONFIGURATION_BCONFIGURATIONVALUE_COUNT: Configuration Descriptor Configuration Value USB Field Count for Greater Operator
--		GREATER_CONFIGURATION_BMATTRIBUTES_INDEX: Configuration Descriptor Attributes USB Field Index for Greater Operator
--		GREATER_CONFIGURATION_BMATTRIBUTES_COUNT: Configuration Descriptor Attributes USB Field Count for Greater Operator
--		GREATER_CONFIGURATION_BMAXPOWER_INDEX: Configuration Descriptor Max Power USB Field Index for Greater Operator
--		GREATER_CONFIGURATION_BMAXPOWER_COUNT: Configuration Descriptor Max Power USB Field Count for Greater Operator
--		GREATER_OTHER_SPEED_BLENGTH_INDEX: Other Speed Descriptor Length USB Field Index for Greater Operator
--		GREATER_OTHER_SPEED_BLENGTH_COUNT: Other Speed Descriptor Length USB Field Count for Greater Operator
--		GREATER_OTHER_SPEED_WTOTALLENGTH_INDEX: Other Speed Descriptor Total Length USB Field Index for Greater Operator
--		GREATER_OTHER_SPEED_WTOTALLENGTH_COUNT: Other Speed Descriptor Total Length USB Field Count for Greater Operator
--		GREATER_OTHER_SPEED_BNUMINTERFACES_INDEX: Other Speed Descriptor Num Interfaces USB Field Index for Greater Operator
--		GREATER_OTHER_SPEED_BNUMINTERFACES_COUNT: Other Speed Descriptor Num Interfaces USB Field Count for Greater Operator
--		GREATER_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX: Other Speed Descriptor Configuration Value USB Field Index for Greater Operator
--		GREATER_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT: Other Speed Descriptor Configuration Value USB Field Count for Greater Operator
--		GREATER_OTHER_SPEED_BMATTRIBUTES_INDEX: Other Speed Descriptor Attributes USB Field Index for Greater Operator
--		GREATER_OTHER_SPEED_BMATTRIBUTES_COUNT: Other Speed Descriptor Attributes USB Field Count for Greater Operator
--		GREATER_OTHER_SPEED_BMAXPOWER_INDEX: Other Speed Descriptor Max Power USB Field Index for Greater Operator
--		GREATER_OTHER_SPEED_BMAXPOWER_COUNT: Other Speed Descriptor Max Power USB Field Count for Greater Operator
--		GREATER_INTERFACE_BLENGTH_INDEX: Interface Descriptor Length USB Field Index for Greater Operator
--		GREATER_INTERFACE_BLENGTH_COUNT: Interface Descriptor Length USB Field Count for Greater Operator
--		GREATER_INTERFACE_BINTERFACENUMBER_INDEX: Interface Descriptor Interface Number USB Field Index for Greater Operator
--		GREATER_INTERFACE_BINTERFACENUMBER_COUNT: Interface Descriptor Interface Number USB Field Count for Greater Operator
--		GREATER_INTERFACE_BALTERNATESETTING_INDEX: Interface Descriptor Alternate Setting USB Field Index for Greater Operator
--		GREATER_INTERFACE_BALTERNATESETTING_COUNT: Interface Descriptor Alternate Setting USB Field Count for Greater Operator
--		GREATER_INTERFACE_BNUMENDPOINTS_INDEX: Interface Descriptor Num Endpoints USB Field Index for Greater Operator
--		GREATER_INTERFACE_BNUMENDPOINTS_COUNT: Interface Descriptor Num Endpoints USB Field Count for Greater Operator
--		GREATER_INTERFACE_BINTERFACECLASS_INDEX: Interface Descriptor Interface Class USB Field Index for Greater Operator
--		GREATER_INTERFACE_BINTERFACECLASS_COUNT: Interface Descriptor Interface Class USB Field Count for Greater Operator
--		GREATER_INTERFACE_BINTERFACESUBCLASS_INDEX: Interface Descriptor Interface Sub Class USB Field Index for Greater Operator
--		GREATER_INTERFACE_BINTERFACESUBCLASS_COUNT: Interface Descriptor Interface Sub Class USB Field Count for Greater Operator
--		GREATER_INTERFACE_BINTERFACEPROTOCOL_INDEX: Interface Descriptor Interface Protocol USB Field Index for Greater Operator
--		GREATER_INTERFACE_BINTERFACEPROTOCOL_COUNT: Interface Descriptor Interface Protocol USB Field Count for Greater Operator
--		GREATER_ENDPOINT_BLENGTH_INDEX: Endpoint Descriptor Length USB Field Index for Greater Operator
--		GREATER_ENDPOINT_BLENGTH_COUNT: Endpoint Descriptor Length USB Field Count for Greater Operator
--		GREATER_ENDPOINT_BENDPOINTADDRESS_INDEX: Endpoint Descriptor Endpoint Address USB Field Index for Greater Operator
--		GREATER_ENDPOINT_BENDPOINTADDRESS_COUNT: Endpoint Descriptor Endpoint Address USB Field Count for Greater Operator
--		GREATER_ENDPOINT_BMATTRIBUTES_INDEX: Endpoint Descriptor Attributes USB Field Index for Greater Operator
--		GREATER_ENDPOINT_BMATTRIBUTES_COUNT: Endpoint Descriptor Attributes USB Field Count for Greater Operator
--		GREATER_ENDPOINT_WMAXPACKETSIZE_INDEX: Endpoint Descriptor Max Packet Size USB Field Index for Greater Operator
--		GREATER_ENDPOINT_WMAXPACKETSIZE_COUNT: Endpoint Descriptor Max Packet Size USB Field Count for Greater Operator
--		GREATER_ENDPOINT_BINTERVAL_INDEX: Endpoint Descriptor Interval USB Field Index for Greater Operator
--		GREATER_ENDPOINT_BINTERVAL_COUNT: Endpoint Descriptor Interval USB Field Count for Greater Operator
--		GREATER_HID_BLENGTH_INDEX: HID Descriptor Length USB Field Index for Greater Operator
--		GREATER_HID_BLENGTH_COUNT: HID Descriptor Length USB Field Count for Greater Operator
--		GREATER_HID_BCDHID_INDEX: HID Descriptor HID USB Field Index for Greater Operator
--		GREATER_HID_BCDHID_COUNT: HID Descriptor HID USB Field Count for Greater Operator
--		GREATER_HID_BCOUNTRYCODE_INDEX: HID Descriptor Country Code USB Field Index for Greater Operator
--		GREATER_HID_BCOUNTRYCODE_COUNT: HID Descriptor Country Code USB Field Count for Greater Operator
--		GREATER_HID_BNUMDESCRIPTORS_INDEX: HID Descriptor Num Descriptors USB Field Index for Greater Operator
--		GREATER_HID_BNUMDESCRIPTORS_COUNT: HID Descriptor Num Descriptors USB Field Count for Greater Operator
--		GREATER_HID_BDESCRIPTORTYPE_INDEX: HID Descriptor Descriptor Type USB Field Index for Greater Operator
--		GREATER_HID_BDESCRIPTORTYPE_COUNT: HID Descriptor Descriptor Type USB Field Count for Greater Operator
--		GREATER_HID_WDESCRIPTORLENGTH_INDEX: HID Descriptor Descriptor Length USB Field Index for Greater Operator
--		GREATER_HID_WDESCRIPTORLENGTH_COUNT: HID Descriptor Descriptor Length USB Field Count for Greater Operator
--		GREATER_STRING_BLENGTH_INDEX: String Descriptor Length USB Field Index for Greater Operator
--		GREATER_STRING_BLENGTH_COUNT: String Descriptor Length USB Field Count for Greater Operator
--		GREATER_STRING_IMANUFACTURER_INDEX: String Descriptor Manufacturer USB Field Index for Greater Operator
--		GREATER_STRING_IMANUFACTURER_COUNT: String Descriptor Manufacturer USB Field Count for Greater Operator
--		GREATER_STRING_IPRODUCT_INDEX: String Descriptor Product USB Field Index for Greater Operator
--		GREATER_STRING_IPRODUCT_COUNT: String Descriptor Product USB Field Count for Greater Operator
--		GREATER_STRING_ISERIALNUMBER_INDEX: String Descriptor Serial Number USB Field Index for Greater Operator
--		GREATER_STRING_ISERIALNUMBER_COUNT: String Descriptor Serial Number USB Field Count for Greater Operator
--		GREATER_STRING_ICONFIGURATION_INDEX: String Descriptor Configuration USB Field Index for Greater Operator
--		GREATER_STRING_ICONFIGURATION_COUNT: String Descriptor Configuration USB Field Count for Greater Operator
--		GREATER_STRING_IINTERFACE_INDEX: String Descriptor Interface USB Field Index for Greater Operator
--		GREATER_STRING_IINTERFACE_COUNT: String Descriptor Interface USB Field Count for Greater Operator
--
--		GREATER_EQUALS_MEMORY_ADDR_LENGTH: Define the Memory Address Bus Length for GreaterEquals Operator (in line with the maximum index value)
--		GREATER_EQUALS_MEMORY_ADDR_MAX_INDEX: Define the Memory Maximum Address for GreaterEquals Operator (in line with the maximum index value)
--		GREATER_EQUALS_MEMORY_ADDR_MAX_COUNT: Define the Memory Maximum Address Count for GreaterEquals Operator (in line with the maximum count value)
--		GREATER_EQUALS_DEVICE_BLENGTH_INDEX: Device Descriptor Length USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_DEVICE_BLENGTH_COUNT: Device Descriptor Length USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_DEVICE_BCDUSB_INDEX: Device Descriptor USB Release Number Field Index for GreaterEquals Operator
--		GREATER_EQUALS_DEVICE_BCDUSB_COUNT: Device Descriptor USB Release Number Field Count for GreaterEquals Operator
--		GREATER_EQUALS_DEVICE_BDEVICECLASS_INDEX: Device Descriptor Device Class USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_DEVICE_BDEVICECLASS_COUNT: Device Descriptor Device Class USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_DEVICE_BDEVICESUBCLASS_INDEX: Device Descriptor Device Sub Class USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_DEVICE_BDEVICESUBCLASS_COUNT: Device Descriptor Device Sub Class USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_DEVICE_BDEVICEPROTOCOL_INDEX: Device Descriptor Device Protocol USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_DEVICE_BDEVICEPROTOCOL_COUNT: Device Descriptor Device Protocol USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_DEVICE_BMAXPACKETSIZE0_INDEX: Device Descriptor Max Packet Size0 USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_DEVICE_BMAXPACKETSIZE0_COUNT: Device Descriptor Max Packet Size0 USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_DEVICE_IDVENDOR_INDEX: Device Descriptor Vendor USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_DEVICE_IDVENDOR_COUNT: Device Descriptor Vendor USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_DEVICE_IDPRODUCT_INDEX: Device Descriptor Product USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_DEVICE_IDPRODUCT_COUNT: Device Descriptor Product USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_DEVICE_BCDDEVICE_INDEX: Device Descriptor Device Release Number USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_DEVICE_BCDDEVICE_COUNT: Device Descriptor Device Release Number USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_DEVICE_BNUMCONFIGURATIONS_INDEX: Device Descriptor Num Configuration USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_DEVICE_BNUMCONFIGURATIONS_COUNT: Device Descriptor Num Configuration USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_DEVICE_QUALIFIER_BLENGTH_INDEX: Device Qualifier Descriptor Length USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_DEVICE_QUALIFIER_BLENGTH_COUNT: Device Qualifier Descriptor Length USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_DEVICE_QUALIFIER_BCDUSB_INDEX: Device Qualifier Descriptor USB Release Number Field Index for GreaterEquals Operator
--		GREATER_EQUALS_DEVICE_QUALIFIER_BCDUSB_COUNT: Device Qualifier Descriptor USB Release Number Field Count for GreaterEquals Operator
--		GREATER_EQUALS_DEVICE_QUALIFIER_BDEVICECLASS_INDEX: Device Qualifier Descriptor Device Class USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_DEVICE_QUALIFIER_BDEVICECLASS_COUNT: Device Qualifier Descriptor Device Class USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX: Device Qualifier Descriptor Device Sub Class USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT: Device Qualifier Descriptor Device Sub Class USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX: Device Qualifier Descriptor Device Protocol USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT: Device Qualifier Descriptor Device Protocol USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX: Device Qualifier Descriptor Max Packet Size0 USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT: Device Qualifier Descriptor Max Packet Size0 USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX: Device Qualifier Descriptor Num Configuration USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT: Device Qualifier Descriptor Num Configuration USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_DEVICE_QUALIFIER_BRESERVED_INDEX: Device Qualifier Descriptor Reserved USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_DEVICE_QUALIFIER_BRESERVED_COUNT: Device Qualifier Descriptor Reserved USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_CONFIGURATION_BLENGTH_INDEX: Configuration Descriptor Length USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_CONFIGURATION_BLENGTH_COUNT: Configuration Descriptor Length USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_CONFIGURATION_WTOTALLENGTH_INDEX: Configuration Descriptor Total Length USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_CONFIGURATION_WTOTALLENGTH_COUNT: Configuration Descriptor Total Length USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_CONFIGURATION_BNUMINTERFACES_INDEX: Configuration Descriptor Num Interfaces USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_CONFIGURATION_BNUMINTERFACES_COUNT: Configuration Descriptor Num Interfaces USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_CONFIGURATION_BCONFIGURATIONVALUE_INDEX: Configuration Descriptor Configuration Value USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_CONFIGURATION_BCONFIGURATIONVALUE_COUNT: Configuration Descriptor Configuration Value USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_CONFIGURATION_BMATTRIBUTES_INDEX: Configuration Descriptor Attributes USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_CONFIGURATION_BMATTRIBUTES_COUNT: Configuration Descriptor Attributes USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_CONFIGURATION_BMAXPOWER_INDEX: Configuration Descriptor Max Power USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_CONFIGURATION_BMAXPOWER_COUNT: Configuration Descriptor Max Power USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_OTHER_SPEED_BLENGTH_INDEX: Other Speed Descriptor Length USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_OTHER_SPEED_BLENGTH_COUNT: Other Speed Descriptor Length USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_OTHER_SPEED_WTOTALLENGTH_INDEX: Other Speed Descriptor Total Length USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_OTHER_SPEED_WTOTALLENGTH_COUNT: Other Speed Descriptor Total Length USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_OTHER_SPEED_BNUMINTERFACES_INDEX: Other Speed Descriptor Num Interfaces USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_OTHER_SPEED_BNUMINTERFACES_COUNT: Other Speed Descriptor Num Interfaces USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX: Other Speed Descriptor Configuration Value USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT: Other Speed Descriptor Configuration Value USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_OTHER_SPEED_BMATTRIBUTES_INDEX: Other Speed Descriptor Attributes USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_OTHER_SPEED_BMATTRIBUTES_COUNT: Other Speed Descriptor Attributes USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_OTHER_SPEED_BMAXPOWER_INDEX: Other Speed Descriptor Max Power USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_OTHER_SPEED_BMAXPOWER_COUNT: Other Speed Descriptor Max Power USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_INTERFACE_BLENGTH_INDEX: Interface Descriptor Length USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_INTERFACE_BLENGTH_COUNT: Interface Descriptor Length USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_INTERFACE_BINTERFACENUMBER_INDEX: Interface Descriptor Interface Number USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_INTERFACE_BINTERFACENUMBER_COUNT: Interface Descriptor Interface Number USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_INTERFACE_BALTERNATESETTING_INDEX: Interface Descriptor Alternate Setting USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_INTERFACE_BALTERNATESETTING_COUNT: Interface Descriptor Alternate Setting USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_INTERFACE_BNUMENDPOINTS_INDEX: Interface Descriptor Num Endpoints USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_INTERFACE_BNUMENDPOINTS_COUNT: Interface Descriptor Num Endpoints USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_INTERFACE_BINTERFACECLASS_INDEX: Interface Descriptor Interface Class USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_INTERFACE_BINTERFACECLASS_COUNT: Interface Descriptor Interface Class USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_INTERFACE_BINTERFACESUBCLASS_INDEX: Interface Descriptor Interface Sub Class USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_INTERFACE_BINTERFACESUBCLASS_COUNT: Interface Descriptor Interface Sub Class USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_INTERFACE_BINTERFACEPROTOCOL_INDEX: Interface Descriptor Interface Protocol USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_INTERFACE_BINTERFACEPROTOCOL_COUNT: Interface Descriptor Interface Protocol USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_ENDPOINT_BLENGTH_INDEX: Endpoint Descriptor Length USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_ENDPOINT_BLENGTH_COUNT: Endpoint Descriptor Length USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_ENDPOINT_BENDPOINTADDRESS_INDEX: Endpoint Descriptor Endpoint Address USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_ENDPOINT_BENDPOINTADDRESS_COUNT: Endpoint Descriptor Endpoint Address USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_ENDPOINT_BMATTRIBUTES_INDEX: Endpoint Descriptor Attributes USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_ENDPOINT_BMATTRIBUTES_COUNT: Endpoint Descriptor Attributes USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_ENDPOINT_WMAXPACKETSIZE_INDEX: Endpoint Descriptor Max Packet Size USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_ENDPOINT_WMAXPACKETSIZE_COUNT: Endpoint Descriptor Max Packet Size USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_ENDPOINT_BINTERVAL_INDEX: Endpoint Descriptor Interval USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_ENDPOINT_BINTERVAL_COUNT: Endpoint Descriptor Interval USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_HID_BLENGTH_INDEX: HID Descriptor Length USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_HID_BLENGTH_COUNT: HID Descriptor Length USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_HID_BCDHID_INDEX: HID Descriptor HID USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_HID_BCDHID_COUNT: HID Descriptor HID USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_HID_BCOUNTRYCODE_INDEX: HID Descriptor Country Code USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_HID_BCOUNTRYCODE_COUNT: HID Descriptor Country Code USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_HID_BNUMDESCRIPTORS_INDEX: HID Descriptor Num Descriptors USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_HID_BNUMDESCRIPTORS_COUNT: HID Descriptor Num Descriptors USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_HID_BDESCRIPTORTYPE_INDEX: HID Descriptor Descriptor Type USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_HID_BDESCRIPTORTYPE_COUNT: HID Descriptor Descriptor Type USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_HID_WDESCRIPTORLENGTH_INDEX: HID Descriptor Descriptor Length USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_HID_WDESCRIPTORLENGTH_COUNT: HID Descriptor Descriptor Length USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_STRING_BLENGTH_INDEX: String Descriptor Length USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_STRING_BLENGTH_COUNT: String Descriptor Length USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_STRING_IMANUFACTURER_INDEX: String Descriptor Manufacturer USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_STRING_IMANUFACTURER_COUNT: String Descriptor Manufacturer USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_STRING_IPRODUCT_INDEX: String Descriptor Product USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_STRING_IPRODUCT_COUNT: String Descriptor Product USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_STRING_ISERIALNUMBER_INDEX: String Descriptor Serial Number USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_STRING_ISERIALNUMBER_COUNT: String Descriptor Serial Number USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_STRING_ICONFIGURATION_INDEX: String Descriptor Configuration USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_STRING_ICONFIGURATION_COUNT: String Descriptor Configuration USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_STRING_IINTERFACE_INDEX: String Descriptor Interface USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_STRING_IINTERFACE_COUNT: String Descriptor Interface USB Field Count for GreaterEquals Operator
--
--		LESS_MEMORY_ADDR_LENGTH: Define the Memory Address Bus Length for Less Operator (in line with the maximum index value)
--		LESS_MEMORY_ADDR_MAX_INDEX: Define the Memory Maximum Address for Less Operator (in line with the maximum index value)
--		LESS_MEMORY_ADDR_MAX_COUNT: Define the Memory Maximum Address Count for Less Operator (in line with the maximum count value)
--		LESS_DEVICE_BLENGTH_INDEX: Device Descriptor Length USB Field Index for Less Operator
--		LESS_DEVICE_BLENGTH_COUNT: Device Descriptor Length USB Field Count for Less Operator
--		LESS_DEVICE_BCDUSB_INDEX: Device Descriptor USB Release Number Field Index for Less Operator
--		LESS_DEVICE_BCDUSB_COUNT: Device Descriptor USB Release Number Field Count for Less Operator
--		LESS_DEVICE_BDEVICECLASS_INDEX: Device Descriptor Device Class USB Field Index for Less Operator
--		LESS_DEVICE_BDEVICECLASS_COUNT: Device Descriptor Device Class USB Field Count for Less Operator
--		LESS_DEVICE_BDEVICESUBCLASS_INDEX: Device Descriptor Device Sub Class USB Field Index for Less Operator
--		LESS_DEVICE_BDEVICESUBCLASS_COUNT: Device Descriptor Device Sub Class USB Field Count for Less Operator
--		LESS_DEVICE_BDEVICEPROTOCOL_INDEX: Device Descriptor Device Protocol USB Field Index for Less Operator
--		LESS_DEVICE_BDEVICEPROTOCOL_COUNT: Device Descriptor Device Protocol USB Field Count for Less Operator
--		LESS_DEVICE_BMAXPACKETSIZE0_INDEX: Device Descriptor Max Packet Size0 USB Field Index for Less Operator
--		LESS_DEVICE_BMAXPACKETSIZE0_COUNT: Device Descriptor Max Packet Size0 USB Field Count for Less Operator
--		LESS_DEVICE_IDVENDOR_INDEX: Device Descriptor Vendor USB Field Index for Less Operator
--		LESS_DEVICE_IDVENDOR_COUNT: Device Descriptor Vendor USB Field Count for Less Operator
--		LESS_DEVICE_IDPRODUCT_INDEX: Device Descriptor Product USB Field Index for Less Operator
--		LESS_DEVICE_IDPRODUCT_COUNT: Device Descriptor Product USB Field Count for Less Operator
--		LESS_DEVICE_BCDDEVICE_INDEX: Device Descriptor Device Release Number USB Field Index for Less Operator
--		LESS_DEVICE_BCDDEVICE_COUNT: Device Descriptor Device Release Number USB Field Count for Less Operator
--		LESS_DEVICE_BNUMCONFIGURATIONS_INDEX: Device Descriptor Num Configuration USB Field Index for Less Operator
--		LESS_DEVICE_BNUMCONFIGURATIONS_COUNT: Device Descriptor Num Configuration USB Field Count for Less Operator
--		LESS_DEVICE_QUALIFIER_BLENGTH_INDEX: Device Qualifier Descriptor Length USB Field Index for Less Operator
--		LESS_DEVICE_QUALIFIER_BLENGTH_COUNT: Device Qualifier Descriptor Length USB Field Count for Less Operator
--		LESS_DEVICE_QUALIFIER_BCDUSB_INDEX: Device Qualifier Descriptor USB Release Number Field Index for Less Operator
--		LESS_DEVICE_QUALIFIER_BCDUSB_COUNT: Device Qualifier Descriptor USB Release Number Field Count for Less Operator
--		LESS_DEVICE_QUALIFIER_BDEVICECLASS_INDEX: Device Qualifier Descriptor Device Class USB Field Index for Less Operator
--		LESS_DEVICE_QUALIFIER_BDEVICECLASS_COUNT: Device Qualifier Descriptor Device Class USB Field Count for Less Operator
--		LESS_DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX: Device Qualifier Descriptor Device Sub Class USB Field Index for Less Operator
--		LESS_DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT: Device Qualifier Descriptor Device Sub Class USB Field Count for Less Operator
--		LESS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX: Device Qualifier Descriptor Device Protocol USB Field Index for Less Operator
--		LESS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT: Device Qualifier Descriptor Device Protocol USB Field Count for Less Operator
--		LESS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX: Device Qualifier Descriptor Max Packet Size0 USB Field Index for Less Operator
--		LESS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT: Device Qualifier Descriptor Max Packet Size0 USB Field Count for Less Operator
--		LESS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX: Device Qualifier Descriptor Num Configuration USB Field Index for Less Operator
--		LESS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT: Device Qualifier Descriptor Num Configuration USB Field Count for Less Operator
--		LESS_DEVICE_QUALIFIER_BRESERVED_INDEX: Device Qualifier Descriptor Reserved USB Field Index for Less Operator
--		LESS_DEVICE_QUALIFIER_BRESERVED_COUNT: Device Qualifier Descriptor Reserved USB Field Count for Less Operator
--		LESS_CONFIGURATION_BLENGTH_INDEX: Configuration Descriptor Length USB Field Index for Less Operator
--		LESS_CONFIGURATION_BLENGTH_COUNT: Configuration Descriptor Length USB Field Count for Less Operator
--		LESS_CONFIGURATION_WTOTALLENGTH_INDEX: Configuration Descriptor Total Length USB Field Index for Less Operator
--		LESS_CONFIGURATION_WTOTALLENGTH_COUNT: Configuration Descriptor Total Length USB Field Count for Less Operator
--		LESS_CONFIGURATION_BNUMINTERFACES_INDEX: Configuration Descriptor Num Interfaces USB Field Index for Less Operator
--		LESS_CONFIGURATION_BNUMINTERFACES_COUNT: Configuration Descriptor Num Interfaces USB Field Count for Less Operator
--		LESS_CONFIGURATION_BCONFIGURATIONVALUE_INDEX: Configuration Descriptor Configuration Value USB Field Index for Less Operator
--		LESS_CONFIGURATION_BCONFIGURATIONVALUE_COUNT: Configuration Descriptor Configuration Value USB Field Count for Less Operator
--		LESS_CONFIGURATION_BMATTRIBUTES_INDEX: Configuration Descriptor Attributes USB Field Index for Less Operator
--		LESS_CONFIGURATION_BMATTRIBUTES_COUNT: Configuration Descriptor Attributes USB Field Count for Less Operator
--		LESS_CONFIGURATION_BMAXPOWER_INDEX: Configuration Descriptor Max Power USB Field Index for Less Operator
--		LESS_CONFIGURATION_BMAXPOWER_COUNT: Configuration Descriptor Max Power USB Field Count for Less Operator
--		LESS_OTHER_SPEED_BLENGTH_INDEX: Other Speed Descriptor Length USB Field Index for Less Operator
--		LESS_OTHER_SPEED_BLENGTH_COUNT: Other Speed Descriptor Length USB Field Count for Less Operator
--		LESS_OTHER_SPEED_WTOTALLENGTH_INDEX: Other Speed Descriptor Total Length USB Field Index for Less Operator
--		LESS_OTHER_SPEED_WTOTALLENGTH_COUNT: Other Speed Descriptor Total Length USB Field Count for Less Operator
--		LESS_OTHER_SPEED_BNUMINTERFACES_INDEX: Other Speed Descriptor Num Interfaces USB Field Index for Less Operator
--		LESS_OTHER_SPEED_BNUMINTERFACES_COUNT: Other Speed Descriptor Num Interfaces USB Field Count for Less Operator
--		LESS_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX: Other Speed Descriptor Configuration Value USB Field Index for Less Operator
--		LESS_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT: Other Speed Descriptor Configuration Value USB Field Count for Less Operator
--		LESS_OTHER_SPEED_BMATTRIBUTES_INDEX: Other Speed Descriptor Attributes USB Field Index for Less Operator
--		LESS_OTHER_SPEED_BMATTRIBUTES_COUNT: Other Speed Descriptor Attributes USB Field Count for Less Operator
--		LESS_OTHER_SPEED_BMAXPOWER_INDEX: Other Speed Descriptor Max Power USB Field Index for Less Operator
--		LESS_OTHER_SPEED_BMAXPOWER_COUNT: Other Speed Descriptor Max Power USB Field Count for Less Operator
--		LESS_INTERFACE_BLENGTH_INDEX: Interface Descriptor Length USB Field Index for Less Operator
--		LESS_INTERFACE_BLENGTH_COUNT: Interface Descriptor Length USB Field Count for Less Operator
--		LESS_INTERFACE_BINTERFACENUMBER_INDEX: Interface Descriptor Interface Number USB Field Index for Less Operator
--		LESS_INTERFACE_BINTERFACENUMBER_COUNT: Interface Descriptor Interface Number USB Field Count for Less Operator
--		LESS_INTERFACE_BALTERNATESETTING_INDEX: Interface Descriptor Alternate Setting USB Field Index for Less Operator
--		LESS_INTERFACE_BALTERNATESETTING_COUNT: Interface Descriptor Alternate Setting USB Field Count for Less Operator
--		LESS_INTERFACE_BNUMENDPOINTS_INDEX: Interface Descriptor Num Endpoints USB Field Index for Less Operator
--		LESS_INTERFACE_BNUMENDPOINTS_COUNT: Interface Descriptor Num Endpoints USB Field Count for Less Operator
--		LESS_INTERFACE_BINTERFACECLASS_INDEX: Interface Descriptor Interface Class USB Field Index for Less Operator
--		LESS_INTERFACE_BINTERFACECLASS_COUNT: Interface Descriptor Interface Class USB Field Count for Less Operator
--		LESS_INTERFACE_BINTERFACESUBCLASS_INDEX: Interface Descriptor Interface Sub Class USB Field Index for Less Operator
--		LESS_INTERFACE_BINTERFACESUBCLASS_COUNT: Interface Descriptor Interface Sub Class USB Field Count for Less Operator
--		LESS_INTERFACE_BINTERFACEPROTOCOL_INDEX: Interface Descriptor Interface Protocol USB Field Index for Less Operator
--		LESS_INTERFACE_BINTERFACEPROTOCOL_COUNT: Interface Descriptor Interface Protocol USB Field Count for Less Operator
--		LESS_ENDPOINT_BLENGTH_INDEX: Endpoint Descriptor Length USB Field Index for Less Operator
--		LESS_ENDPOINT_BLENGTH_COUNT: Endpoint Descriptor Length USB Field Count for Less Operator
--		LESS_ENDPOINT_BENDPOINTADDRESS_INDEX: Endpoint Descriptor Endpoint Address USB Field Index for Less Operator
--		LESS_ENDPOINT_BENDPOINTADDRESS_COUNT: Endpoint Descriptor Endpoint Address USB Field Count for Less Operator
--		LESS_ENDPOINT_BMATTRIBUTES_INDEX: Endpoint Descriptor Attributes USB Field Index for Less Operator
--		LESS_ENDPOINT_BMATTRIBUTES_COUNT: Endpoint Descriptor Attributes USB Field Count for Less Operator
--		LESS_ENDPOINT_WMAXPACKETSIZE_INDEX: Endpoint Descriptor Max Packet Size USB Field Index for Less Operator
--		LESS_ENDPOINT_WMAXPACKETSIZE_COUNT: Endpoint Descriptor Max Packet Size USB Field Count for Less Operator
--		LESS_ENDPOINT_BINTERVAL_INDEX: Endpoint Descriptor Interval USB Field Index for Less Operator
--		LESS_ENDPOINT_BINTERVAL_COUNT: Endpoint Descriptor Interval USB Field Count for Less Operator
--		LESS_HID_BLENGTH_INDEX: HID Descriptor Length USB Field Index for Less Operator
--		LESS_HID_BLENGTH_COUNT: HID Descriptor Length USB Field Count for Less Operator
--		LESS_HID_BCDHID_INDEX: HID Descriptor HID USB Field Index for Less Operator
--		LESS_HID_BCDHID_COUNT: HID Descriptor HID USB Field Count for Less Operator
--		LESS_HID_BCOUNTRYCODE_INDEX: HID Descriptor Country Code USB Field Index for Less Operator
--		LESS_HID_BCOUNTRYCODE_COUNT: HID Descriptor Country Code USB Field Count for Less Operator
--		LESS_HID_BNUMDESCRIPTORS_INDEX: HID Descriptor Num Descriptors USB Field Index for Less Operator
--		LESS_HID_BNUMDESCRIPTORS_COUNT: HID Descriptor Num Descriptors USB Field Count for Less Operator
--		LESS_HID_BDESCRIPTORTYPE_INDEX: HID Descriptor Descriptor Type USB Field Index for Less Operator
--		LESS_HID_BDESCRIPTORTYPE_COUNT: HID Descriptor Descriptor Type USB Field Count for Less Operator
--		LESS_HID_WDESCRIPTORLENGTH_INDEX: HID Descriptor Descriptor Length USB Field Index for Less Operator
--		LESS_HID_WDESCRIPTORLENGTH_COUNT: HID Descriptor Descriptor Length USB Field Count for Less Operator
--		LESS_STRING_BLENGTH_INDEX: String Descriptor Length USB Field Index for Less Operator
--		LESS_STRING_BLENGTH_COUNT: String Descriptor Length USB Field Count for Less Operator
--		LESS_STRING_IMANUFACTURER_INDEX: String Descriptor Manufacturer USB Field Index for Less Operator
--		LESS_STRING_IMANUFACTURER_COUNT: String Descriptor Manufacturer USB Field Count for Less Operator
--		LESS_STRING_IPRODUCT_INDEX: String Descriptor Product USB Field Index for Less Operator
--		LESS_STRING_IPRODUCT_COUNT: String Descriptor Product USB Field Count for Less Operator
--		LESS_STRING_ISERIALNUMBER_INDEX: String Descriptor Serial Number USB Field Index for Less Operator
--		LESS_STRING_ISERIALNUMBER_COUNT: String Descriptor Serial Number USB Field Count for Less Operator
--		LESS_STRING_ICONFIGURATION_INDEX: String Descriptor Configuration USB Field Index for Less Operator
--		LESS_STRING_ICONFIGURATION_COUNT: String Descriptor Configuration USB Field Count for Less Operator
--		LESS_STRING_IINTERFACE_INDEX: String Descriptor Interface USB Field Index for Less Operator
--		LESS_STRING_IINTERFACE_COUNT: String Descriptor Interface USB Field Count for Less Operator
--
--		LESS_EQUALS_MEMORY_ADDR_LENGTH: Define the Memory Address Bus Length for LessEquals Operator (in line with the maximum index value)
--		LESS_EQUALS_MEMORY_ADDR_MAX_INDEX: Define the Memory Maximum Address for LessEquals Operator (in line with the maximum index value)
--		LESS_EQUALS_MEMORY_ADDR_MAX_COUNT: Define the Memory Maximum Address Count for LessEquals Operator (in line with the maximum count value)
--		LESS_EQUALS_DEVICE_BLENGTH_INDEX: Device Descriptor Length USB Field Index for LessEquals Operator
--		LESS_EQUALS_DEVICE_BLENGTH_COUNT: Device Descriptor Length USB Field Count for LessEquals Operator
--		LESS_EQUALS_DEVICE_BCDUSB_INDEX: Device Descriptor USB Release Number Field Index for LessEquals Operator
--		LESS_EQUALS_DEVICE_BCDUSB_COUNT: Device Descriptor USB Release Number Field Count for LessEquals Operator
--		LESS_EQUALS_DEVICE_BDEVICECLASS_INDEX: Device Descriptor Device Class USB Field Index for LessEquals Operator
--		LESS_EQUALS_DEVICE_BDEVICECLASS_COUNT: Device Descriptor Device Class USB Field Count for LessEquals Operator
--		LESS_EQUALS_DEVICE_BDEVICESUBCLASS_INDEX: Device Descriptor Device Sub Class USB Field Index for LessEquals Operator
--		LESS_EQUALS_DEVICE_BDEVICESUBCLASS_COUNT: Device Descriptor Device Sub Class USB Field Count for LessEquals Operator
--		LESS_EQUALS_DEVICE_BDEVICEPROTOCOL_INDEX: Device Descriptor Device Protocol USB Field Index for LessEquals Operator
--		LESS_EQUALS_DEVICE_BDEVICEPROTOCOL_COUNT: Device Descriptor Device Protocol USB Field Count for LessEquals Operator
--		LESS_EQUALS_DEVICE_BMAXPACKETSIZE0_INDEX: Device Descriptor Max Packet Size0 USB Field Index for LessEquals Operator
--		LESS_EQUALS_DEVICE_BMAXPACKETSIZE0_COUNT: Device Descriptor Max Packet Size0 USB Field Count for LessEquals Operator
--		LESS_EQUALS_DEVICE_IDVENDOR_INDEX: Device Descriptor Vendor USB Field Index for LessEquals Operator
--		LESS_EQUALS_DEVICE_IDVENDOR_COUNT: Device Descriptor Vendor USB Field Count for LessEquals Operator
--		LESS_EQUALS_DEVICE_IDPRODUCT_INDEX: Device Descriptor Product USB Field Index for LessEquals Operator
--		LESS_EQUALS_DEVICE_IDPRODUCT_COUNT: Device Descriptor Product USB Field Count for LessEquals Operator
--		LESS_EQUALS_DEVICE_BCDDEVICE_INDEX: Device Descriptor Device Release Number USB Field Index for LessEquals Operator
--		LESS_EQUALS_DEVICE_BCDDEVICE_COUNT: Device Descriptor Device Release Number USB Field Count for LessEquals Operator
--		LESS_EQUALS_DEVICE_BNUMCONFIGURATIONS_INDEX: Device Descriptor Num Configuration USB Field Index for LessEquals Operator
--		LESS_EQUALS_DEVICE_BNUMCONFIGURATIONS_COUNT: Device Descriptor Num Configuration USB Field Count for LessEquals Operator
--		LESS_EQUALS_DEVICE_QUALIFIER_BLENGTH_INDEX: Device Qualifier Descriptor Length USB Field Index for LessEquals Operator
--		LESS_EQUALS_DEVICE_QUALIFIER_BLENGTH_COUNT: Device Qualifier Descriptor Length USB Field Count for LessEquals Operator
--		LESS_EQUALS_DEVICE_QUALIFIER_BCDUSB_INDEX: Device Qualifier Descriptor USB Release Number Field Index for LessEquals Operator
--		LESS_EQUALS_DEVICE_QUALIFIER_BCDUSB_COUNT: Device Qualifier Descriptor USB Release Number Field Count for LessEquals Operator
--		LESS_EQUALS_DEVICE_QUALIFIER_BDEVICECLASS_INDEX: Device Qualifier Descriptor Device Class USB Field Index for LessEquals Operator
--		LESS_EQUALS_DEVICE_QUALIFIER_BDEVICECLASS_COUNT: Device Qualifier Descriptor Device Class USB Field Count for LessEquals Operator
--		LESS_EQUALS_DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX: Device Qualifier Descriptor Device Sub Class USB Field Index for LessEquals Operator
--		LESS_EQUALS_DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT: Device Qualifier Descriptor Device Sub Class USB Field Count for LessEquals Operator
--		LESS_EQUALS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX: Device Qualifier Descriptor Device Protocol USB Field Index for LessEquals Operator
--		LESS_EQUALS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT: Device Qualifier Descriptor Device Protocol USB Field Count for LessEquals Operator
--		LESS_EQUALS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX: Device Qualifier Descriptor Max Packet Size0 USB Field Index for LessEquals Operator
--		LESS_EQUALS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT: Device Qualifier Descriptor Max Packet Size0 USB Field Count for LessEquals Operator
--		LESS_EQUALS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX: Device Qualifier Descriptor Num Configuration USB Field Index for LessEquals Operator
--		LESS_EQUALS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT: Device Qualifier Descriptor Num Configuration USB Field Count for LessEquals Operator
--		LESS_EQUALS_DEVICE_QUALIFIER_BRESERVED_INDEX: Device Qualifier Descriptor Reserved USB Field Index for LessEquals Operator
--		LESS_EQUALS_DEVICE_QUALIFIER_BRESERVED_COUNT: Device Qualifier Descriptor Reserved USB Field Count for LessEquals Operator
--		LESS_EQUALS_CONFIGURATION_BLENGTH_INDEX: Configuration Descriptor Length USB Field Index for LessEquals Operator
--		LESS_EQUALS_CONFIGURATION_BLENGTH_COUNT: Configuration Descriptor Length USB Field Count for LessEquals Operator
--		LESS_EQUALS_CONFIGURATION_WTOTALLENGTH_INDEX: Configuration Descriptor Total Length USB Field Index for LessEquals Operator
--		LESS_EQUALS_CONFIGURATION_WTOTALLENGTH_COUNT: Configuration Descriptor Total Length USB Field Count for LessEquals Operator
--		LESS_EQUALS_CONFIGURATION_BNUMINTERFACES_INDEX: Configuration Descriptor Num Interfaces USB Field Index for LessEquals Operator
--		LESS_EQUALS_CONFIGURATION_BNUMINTERFACES_COUNT: Configuration Descriptor Num Interfaces USB Field Count for LessEquals Operator
--		LESS_EQUALS_CONFIGURATION_BCONFIGURATIONVALUE_INDEX: Configuration Descriptor Configuration Value USB Field Index for LessEquals Operator
--		LESS_EQUALS_CONFIGURATION_BCONFIGURATIONVALUE_COUNT: Configuration Descriptor Configuration Value USB Field Count for LessEquals Operator
--		LESS_EQUALS_CONFIGURATION_BMATTRIBUTES_INDEX: Configuration Descriptor Attributes USB Field Index for LessEquals Operator
--		LESS_EQUALS_CONFIGURATION_BMATTRIBUTES_COUNT: Configuration Descriptor Attributes USB Field Count for LessEquals Operator
--		LESS_EQUALS_CONFIGURATION_BMAXPOWER_INDEX: Configuration Descriptor Max Power USB Field Index for LessEquals Operator
--		LESS_EQUALS_CONFIGURATION_BMAXPOWER_COUNT: Configuration Descriptor Max Power USB Field Count for LessEquals Operator
--		LESS_EQUALS_OTHER_SPEED_BLENGTH_INDEX: Other Speed Descriptor Length USB Field Index for LessEquals Operator
--		LESS_EQUALS_OTHER_SPEED_BLENGTH_COUNT: Other Speed Descriptor Length USB Field Count for LessEquals Operator
--		LESS_EQUALS_OTHER_SPEED_WTOTALLENGTH_INDEX: Other Speed Descriptor Total Length USB Field Index for LessEquals Operator
--		LESS_EQUALS_OTHER_SPEED_WTOTALLENGTH_COUNT: Other Speed Descriptor Total Length USB Field Count for LessEquals Operator
--		LESS_EQUALS_OTHER_SPEED_BNUMINTERFACES_INDEX: Other Speed Descriptor Num Interfaces USB Field Index for LessEquals Operator
--		LESS_EQUALS_OTHER_SPEED_BNUMINTERFACES_COUNT: Other Speed Descriptor Num Interfaces USB Field Count for LessEquals Operator
--		LESS_EQUALS_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX: Other Speed Descriptor Configuration Value USB Field Index for LessEquals Operator
--		LESS_EQUALS_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT: Other Speed Descriptor Configuration Value USB Field Count for LessEquals Operator
--		LESS_EQUALS_OTHER_SPEED_BMATTRIBUTES_INDEX: Other Speed Descriptor Attributes USB Field Index for LessEquals Operator
--		LESS_EQUALS_OTHER_SPEED_BMATTRIBUTES_COUNT: Other Speed Descriptor Attributes USB Field Count for LessEquals Operator
--		LESS_EQUALS_OTHER_SPEED_BMAXPOWER_INDEX: Other Speed Descriptor Max Power USB Field Index for LessEquals Operator
--		LESS_EQUALS_OTHER_SPEED_BMAXPOWER_COUNT: Other Speed Descriptor Max Power USB Field Count for LessEquals Operator
--		LESS_EQUALS_INTERFACE_BLENGTH_INDEX: Interface Descriptor Length USB Field Index for LessEquals Operator
--		LESS_EQUALS_INTERFACE_BLENGTH_COUNT: Interface Descriptor Length USB Field Count for LessEquals Operator
--		LESS_EQUALS_INTERFACE_BINTERFACENUMBER_INDEX: Interface Descriptor Interface Number USB Field Index for LessEquals Operator
--		LESS_EQUALS_INTERFACE_BINTERFACENUMBER_COUNT: Interface Descriptor Interface Number USB Field Count for LessEquals Operator
--		LESS_EQUALS_INTERFACE_BALTERNATESETTING_INDEX: Interface Descriptor Alternate Setting USB Field Index for LessEquals Operator
--		LESS_EQUALS_INTERFACE_BALTERNATESETTING_COUNT: Interface Descriptor Alternate Setting USB Field Count for LessEquals Operator
--		LESS_EQUALS_INTERFACE_BNUMENDPOINTS_INDEX: Interface Descriptor Num Endpoints USB Field Index for LessEquals Operator
--		LESS_EQUALS_INTERFACE_BNUMENDPOINTS_COUNT: Interface Descriptor Num Endpoints USB Field Count for LessEquals Operator
--		LESS_EQUALS_INTERFACE_BINTERFACECLASS_INDEX: Interface Descriptor Interface Class USB Field Index for LessEquals Operator
--		LESS_EQUALS_INTERFACE_BINTERFACECLASS_COUNT: Interface Descriptor Interface Class USB Field Count for LessEquals Operator
--		LESS_EQUALS_INTERFACE_BINTERFACESUBCLASS_INDEX: Interface Descriptor Interface Sub Class USB Field Index for LessEquals Operator
--		LESS_EQUALS_INTERFACE_BINTERFACESUBCLASS_COUNT: Interface Descriptor Interface Sub Class USB Field Count for LessEquals Operator
--		LESS_EQUALS_INTERFACE_BINTERFACEPROTOCOL_INDEX: Interface Descriptor Interface Protocol USB Field Index for LessEquals Operator
--		LESS_EQUALS_INTERFACE_BINTERFACEPROTOCOL_COUNT: Interface Descriptor Interface Protocol USB Field Count for LessEquals Operator
--		LESS_EQUALS_ENDPOINT_BLENGTH_INDEX: Endpoint Descriptor Length USB Field Index for LessEquals Operator
--		LESS_EQUALS_ENDPOINT_BLENGTH_COUNT: Endpoint Descriptor Length USB Field Count for LessEquals Operator
--		LESS_EQUALS_ENDPOINT_BENDPOINTADDRESS_INDEX: Endpoint Descriptor Endpoint Address USB Field Index for LessEquals Operator
--		LESS_EQUALS_ENDPOINT_BENDPOINTADDRESS_COUNT: Endpoint Descriptor Endpoint Address USB Field Count for LessEquals Operator
--		LESS_EQUALS_ENDPOINT_BMATTRIBUTES_INDEX: Endpoint Descriptor Attributes USB Field Index for LessEquals Operator
--		LESS_EQUALS_ENDPOINT_BMATTRIBUTES_COUNT: Endpoint Descriptor Attributes USB Field Count for LessEquals Operator
--		LESS_EQUALS_ENDPOINT_WMAXPACKETSIZE_INDEX: Endpoint Descriptor Max Packet Size USB Field Index for LessEquals Operator
--		LESS_EQUALS_ENDPOINT_WMAXPACKETSIZE_COUNT: Endpoint Descriptor Max Packet Size USB Field Count for LessEquals Operator
--		LESS_EQUALS_ENDPOINT_BINTERVAL_INDEX: Endpoint Descriptor Interval USB Field Index for LessEquals Operator
--		LESS_EQUALS_ENDPOINT_BINTERVAL_COUNT: Endpoint Descriptor Interval USB Field Count for LessEquals Operator
--		LESS_EQUALS_HID_BLENGTH_INDEX: HID Descriptor Length USB Field Index for LessEquals Operator
--		LESS_EQUALS_HID_BLENGTH_COUNT: HID Descriptor Length USB Field Count for LessEquals Operator
--		LESS_EQUALS_HID_BCDHID_INDEX: HID Descriptor HID USB Field Index for LessEquals Operator
--		LESS_EQUALS_HID_BCDHID_COUNT: HID Descriptor HID USB Field Count for LessEquals Operator
--		LESS_EQUALS_HID_BCOUNTRYCODE_INDEX: HID Descriptor Country Code USB Field Index for LessEquals Operator
--		LESS_EQUALS_HID_BCOUNTRYCODE_COUNT: HID Descriptor Country Code USB Field Count for LessEquals Operator
--		LESS_EQUALS_HID_BNUMDESCRIPTORS_INDEX: HID Descriptor Num Descriptors USB Field Index for LessEquals Operator
--		LESS_EQUALS_HID_BNUMDESCRIPTORS_COUNT: HID Descriptor Num Descriptors USB Field Count for LessEquals Operator
--		LESS_EQUALS_HID_BDESCRIPTORTYPE_INDEX: HID Descriptor Descriptor Type USB Field Index for LessEquals Operator
--		LESS_EQUALS_HID_BDESCRIPTORTYPE_COUNT: HID Descriptor Descriptor Type USB Field Count for LessEquals Operator
--		LESS_EQUALS_HID_WDESCRIPTORLENGTH_INDEX: HID Descriptor Descriptor Length USB Field Index for LessEquals Operator
--		LESS_EQUALS_HID_WDESCRIPTORLENGTH_COUNT: HID Descriptor Descriptor Length USB Field Count for LessEquals Operator
--		LESS_EQUALS_STRING_BLENGTH_INDEX: String Descriptor Length USB Field Index for LessEquals Operator
--		LESS_EQUALS_STRING_BLENGTH_COUNT: String Descriptor Length USB Field Count for LessEquals Operator
--		LESS_EQUALS_STRING_IMANUFACTURER_INDEX: String Descriptor Manufacturer USB Field Index for LessEquals Operator
--		LESS_EQUALS_STRING_IMANUFACTURER_COUNT: String Descriptor Manufacturer USB Field Count for LessEquals Operator
--		LESS_EQUALS_STRING_IPRODUCT_INDEX: String Descriptor Product USB Field Index for LessEquals Operator
--		LESS_EQUALS_STRING_IPRODUCT_COUNT: String Descriptor Product USB Field Count for LessEquals Operator
--		LESS_EQUALS_STRING_ISERIALNUMBER_INDEX: String Descriptor Serial Number USB Field Index for LessEquals Operator
--		LESS_EQUALS_STRING_ISERIALNUMBER_COUNT: String Descriptor Serial Number USB Field Count for LessEquals Operator
--		LESS_EQUALS_STRING_ICONFIGURATION_INDEX: String Descriptor Configuration USB Field Index for LessEquals Operator
--		LESS_EQUALS_STRING_ICONFIGURATION_COUNT: String Descriptor Configuration USB Field Count for LessEquals Operator
--		LESS_EQUALS_STRING_IINTERFACE_INDEX: String Descriptor Interface USB Field Index for LessEquals Operator
--		LESS_EQUALS_STRING_IINTERFACE_COUNT: String Descriptor Interface USB Field Count for LessEquals Operator
--
--		STARTS_WITH_MEMORY_ADDR_LENGTH: Define the Memory Address Bus Length for StartsWith Operator (in line with the maximum index value)
--		STARTS_WITH_MEMORY_ADDR_MAX_INDEX: Define the Memory Maximum Address for StartsWith Operator (in line with the maximum index value)
--		STARTS_WITH_MEMORY_ADDR_MAX_COUNT: Define the Memory Maximum Address Count for StartsWith Operator (in line with the maximum count value)
--		STARTS_WITH_DEVICE_BLENGTH_INDEX: Device Descriptor Length USB Field Index for StartsWith Operator
--		STARTS_WITH_DEVICE_BLENGTH_COUNT: Device Descriptor Length USB Field Count for StartsWith Operator
--		STARTS_WITH_DEVICE_BCDUSB_INDEX: Device Descriptor USB Release Number Field Index for StartsWith Operator
--		STARTS_WITH_DEVICE_BCDUSB_COUNT: Device Descriptor USB Release Number Field Count for StartsWith Operator
--		STARTS_WITH_DEVICE_BDEVICECLASS_INDEX: Device Descriptor Device Class USB Field Index for StartsWith Operator
--		STARTS_WITH_DEVICE_BDEVICECLASS_COUNT: Device Descriptor Device Class USB Field Count for StartsWith Operator
--		STARTS_WITH_DEVICE_BDEVICESUBCLASS_INDEX: Device Descriptor Device Sub Class USB Field Index for StartsWith Operator
--		STARTS_WITH_DEVICE_BDEVICESUBCLASS_COUNT: Device Descriptor Device Sub Class USB Field Count for StartsWith Operator
--		STARTS_WITH_DEVICE_BDEVICEPROTOCOL_INDEX: Device Descriptor Device Protocol USB Field Index for StartsWith Operator
--		STARTS_WITH_DEVICE_BDEVICEPROTOCOL_COUNT: Device Descriptor Device Protocol USB Field Count for StartsWith Operator
--		STARTS_WITH_DEVICE_BMAXPACKETSIZE0_INDEX: Device Descriptor Max Packet Size0 USB Field Index for StartsWith Operator
--		STARTS_WITH_DEVICE_BMAXPACKETSIZE0_COUNT: Device Descriptor Max Packet Size0 USB Field Count for StartsWith Operator
--		STARTS_WITH_DEVICE_IDVENDOR_INDEX: Device Descriptor Vendor USB Field Index for StartsWith Operator
--		STARTS_WITH_DEVICE_IDVENDOR_COUNT: Device Descriptor Vendor USB Field Count for StartsWith Operator
--		STARTS_WITH_DEVICE_IDPRODUCT_INDEX: Device Descriptor Product USB Field Index for StartsWith Operator
--		STARTS_WITH_DEVICE_IDPRODUCT_COUNT: Device Descriptor Product USB Field Count for StartsWith Operator
--		STARTS_WITH_DEVICE_BCDDEVICE_INDEX: Device Descriptor Device Release Number USB Field Index for StartsWith Operator
--		STARTS_WITH_DEVICE_BCDDEVICE_COUNT: Device Descriptor Device Release Number USB Field Count for StartsWith Operator
--		STARTS_WITH_DEVICE_BNUMCONFIGURATIONS_INDEX: Device Descriptor Num Configuration USB Field Index for StartsWith Operator
--		STARTS_WITH_DEVICE_BNUMCONFIGURATIONS_COUNT: Device Descriptor Num Configuration USB Field Count for StartsWith Operator
--		STARTS_WITH_DEVICE_QUALIFIER_BLENGTH_INDEX: Device Qualifier Descriptor Length USB Field Index for StartsWith Operator
--		STARTS_WITH_DEVICE_QUALIFIER_BLENGTH_COUNT: Device Qualifier Descriptor Length USB Field Count for StartsWith Operator
--		STARTS_WITH_DEVICE_QUALIFIER_BCDUSB_INDEX: Device Qualifier Descriptor USB Release Number Field Index for StartsWith Operator
--		STARTS_WITH_DEVICE_QUALIFIER_BCDUSB_COUNT: Device Qualifier Descriptor USB Release Number Field Count for StartsWith Operator
--		STARTS_WITH_DEVICE_QUALIFIER_BDEVICECLASS_INDEX: Device Qualifier Descriptor Device Class USB Field Index for StartsWith Operator
--		STARTS_WITH_DEVICE_QUALIFIER_BDEVICECLASS_COUNT: Device Qualifier Descriptor Device Class USB Field Count for StartsWith Operator
--		STARTS_WITH_DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX: Device Qualifier Descriptor Device Sub Class USB Field Index for StartsWith Operator
--		STARTS_WITH_DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT: Device Qualifier Descriptor Device Sub Class USB Field Count for StartsWith Operator
--		STARTS_WITH_DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX: Device Qualifier Descriptor Device Protocol USB Field Index for StartsWith Operator
--		STARTS_WITH_DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT: Device Qualifier Descriptor Device Protocol USB Field Count for StartsWith Operator
--		STARTS_WITH_DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX: Device Qualifier Descriptor Max Packet Size0 USB Field Index for StartsWith Operator
--		STARTS_WITH_DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT: Device Qualifier Descriptor Max Packet Size0 USB Field Count for StartsWith Operator
--		STARTS_WITH_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX: Device Qualifier Descriptor Num Configuration USB Field Index for StartsWith Operator
--		STARTS_WITH_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT: Device Qualifier Descriptor Num Configuration USB Field Count for StartsWith Operator
--		STARTS_WITH_DEVICE_QUALIFIER_BRESERVED_INDEX: Device Qualifier Descriptor Reserved USB Field Index for StartsWith Operator
--		STARTS_WITH_DEVICE_QUALIFIER_BRESERVED_COUNT: Device Qualifier Descriptor Reserved USB Field Count for StartsWith Operator
--		STARTS_WITH_CONFIGURATION_BLENGTH_INDEX: Configuration Descriptor Length USB Field Index for StartsWith Operator
--		STARTS_WITH_CONFIGURATION_BLENGTH_COUNT: Configuration Descriptor Length USB Field Count for StartsWith Operator
--		STARTS_WITH_CONFIGURATION_WTOTALLENGTH_INDEX: Configuration Descriptor Total Length USB Field Index for StartsWith Operator
--		STARTS_WITH_CONFIGURATION_WTOTALLENGTH_COUNT: Configuration Descriptor Total Length USB Field Count for StartsWith Operator
--		STARTS_WITH_CONFIGURATION_BNUMINTERFACES_INDEX: Configuration Descriptor Num Interfaces USB Field Index for StartsWith Operator
--		STARTS_WITH_CONFIGURATION_BNUMINTERFACES_COUNT: Configuration Descriptor Num Interfaces USB Field Count for StartsWith Operator
--		STARTS_WITH_CONFIGURATION_BCONFIGURATIONVALUE_INDEX: Configuration Descriptor Configuration Value USB Field Index for StartsWith Operator
--		STARTS_WITH_CONFIGURATION_BCONFIGURATIONVALUE_COUNT: Configuration Descriptor Configuration Value USB Field Count for StartsWith Operator
--		STARTS_WITH_CONFIGURATION_BMATTRIBUTES_INDEX: Configuration Descriptor Attributes USB Field Index for StartsWith Operator
--		STARTS_WITH_CONFIGURATION_BMATTRIBUTES_COUNT: Configuration Descriptor Attributes USB Field Count for StartsWith Operator
--		STARTS_WITH_CONFIGURATION_BMAXPOWER_INDEX: Configuration Descriptor Max Power USB Field Index for StartsWith Operator
--		STARTS_WITH_CONFIGURATION_BMAXPOWER_COUNT: Configuration Descriptor Max Power USB Field Count for StartsWith Operator
--		STARTS_WITH_OTHER_SPEED_BLENGTH_INDEX: Other Speed Descriptor Length USB Field Index for StartsWith Operator
--		STARTS_WITH_OTHER_SPEED_BLENGTH_COUNT: Other Speed Descriptor Length USB Field Count for StartsWith Operator
--		STARTS_WITH_OTHER_SPEED_WTOTALLENGTH_INDEX: Other Speed Descriptor Total Length USB Field Index for StartsWith Operator
--		STARTS_WITH_OTHER_SPEED_WTOTALLENGTH_COUNT: Other Speed Descriptor Total Length USB Field Count for StartsWith Operator
--		STARTS_WITH_OTHER_SPEED_BNUMINTERFACES_INDEX: Other Speed Descriptor Num Interfaces USB Field Index for StartsWith Operator
--		STARTS_WITH_OTHER_SPEED_BNUMINTERFACES_COUNT: Other Speed Descriptor Num Interfaces USB Field Count for StartsWith Operator
--		STARTS_WITH_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX: Other Speed Descriptor Configuration Value USB Field Index for StartsWith Operator
--		STARTS_WITH_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT: Other Speed Descriptor Configuration Value USB Field Count for StartsWith Operator
--		STARTS_WITH_OTHER_SPEED_BMATTRIBUTES_INDEX: Other Speed Descriptor Attributes USB Field Index for StartsWith Operator
--		STARTS_WITH_OTHER_SPEED_BMATTRIBUTES_COUNT: Other Speed Descriptor Attributes USB Field Count for StartsWith Operator
--		STARTS_WITH_OTHER_SPEED_BMAXPOWER_INDEX: Other Speed Descriptor Max Power USB Field Index for StartsWith Operator
--		STARTS_WITH_OTHER_SPEED_BMAXPOWER_COUNT: Other Speed Descriptor Max Power USB Field Count for StartsWith Operator
--		STARTS_WITH_INTERFACE_BLENGTH_INDEX: Interface Descriptor Length USB Field Index for StartsWith Operator
--		STARTS_WITH_INTERFACE_BLENGTH_COUNT: Interface Descriptor Length USB Field Count for StartsWith Operator
--		STARTS_WITH_INTERFACE_BINTERFACENUMBER_INDEX: Interface Descriptor Interface Number USB Field Index for StartsWith Operator
--		STARTS_WITH_INTERFACE_BINTERFACENUMBER_COUNT: Interface Descriptor Interface Number USB Field Count for StartsWith Operator
--		STARTS_WITH_INTERFACE_BALTERNATESETTING_INDEX: Interface Descriptor Alternate Setting USB Field Index for StartsWith Operator
--		STARTS_WITH_INTERFACE_BALTERNATESETTING_COUNT: Interface Descriptor Alternate Setting USB Field Count for StartsWith Operator
--		STARTS_WITH_INTERFACE_BNUMENDPOINTS_INDEX: Interface Descriptor Num Endpoints USB Field Index for StartsWith Operator
--		STARTS_WITH_INTERFACE_BNUMENDPOINTS_COUNT: Interface Descriptor Num Endpoints USB Field Count for StartsWith Operator
--		STARTS_WITH_INTERFACE_BINTERFACECLASS_INDEX: Interface Descriptor Interface Class USB Field Index for StartsWith Operator
--		STARTS_WITH_INTERFACE_BINTERFACECLASS_COUNT: Interface Descriptor Interface Class USB Field Count for StartsWith Operator
--		STARTS_WITH_INTERFACE_BINTERFACESUBCLASS_INDEX: Interface Descriptor Interface Sub Class USB Field Index for StartsWith Operator
--		STARTS_WITH_INTERFACE_BINTERFACESUBCLASS_COUNT: Interface Descriptor Interface Sub Class USB Field Count for StartsWith Operator
--		STARTS_WITH_INTERFACE_BINTERFACEPROTOCOL_INDEX: Interface Descriptor Interface Protocol USB Field Index for StartsWith Operator
--		STARTS_WITH_INTERFACE_BINTERFACEPROTOCOL_COUNT: Interface Descriptor Interface Protocol USB Field Count for StartsWith Operator
--		STARTS_WITH_ENDPOINT_BLENGTH_INDEX: Endpoint Descriptor Length USB Field Index for StartsWith Operator
--		STARTS_WITH_ENDPOINT_BLENGTH_COUNT: Endpoint Descriptor Length USB Field Count for StartsWith Operator
--		STARTS_WITH_ENDPOINT_BENDPOINTADDRESS_INDEX: Endpoint Descriptor Endpoint Address USB Field Index for StartsWith Operator
--		STARTS_WITH_ENDPOINT_BENDPOINTADDRESS_COUNT: Endpoint Descriptor Endpoint Address USB Field Count for StartsWith Operator
--		STARTS_WITH_ENDPOINT_BMATTRIBUTES_INDEX: Endpoint Descriptor Attributes USB Field Index for StartsWith Operator
--		STARTS_WITH_ENDPOINT_BMATTRIBUTES_COUNT: Endpoint Descriptor Attributes USB Field Count for StartsWith Operator
--		STARTS_WITH_ENDPOINT_WMAXPACKETSIZE_INDEX: Endpoint Descriptor Max Packet Size USB Field Index for StartsWith Operator
--		STARTS_WITH_ENDPOINT_WMAXPACKETSIZE_COUNT: Endpoint Descriptor Max Packet Size USB Field Count for StartsWith Operator
--		STARTS_WITH_ENDPOINT_BINTERVAL_INDEX: Endpoint Descriptor Interval USB Field Index for StartsWith Operator
--		STARTS_WITH_ENDPOINT_BINTERVAL_COUNT: Endpoint Descriptor Interval USB Field Count for StartsWith Operator
--		STARTS_WITH_HID_BLENGTH_INDEX: HID Descriptor Length USB Field Index for StartsWith Operator
--		STARTS_WITH_HID_BLENGTH_COUNT: HID Descriptor Length USB Field Count for StartsWith Operator
--		STARTS_WITH_HID_BCDHID_INDEX: HID Descriptor HID USB Field Index for StartsWith Operator
--		STARTS_WITH_HID_BCDHID_COUNT: HID Descriptor HID USB Field Count for StartsWith Operator
--		STARTS_WITH_HID_BCOUNTRYCODE_INDEX: HID Descriptor Country Code USB Field Index for StartsWith Operator
--		STARTS_WITH_HID_BCOUNTRYCODE_COUNT: HID Descriptor Country Code USB Field Count for StartsWith Operator
--		STARTS_WITH_HID_BNUMDESCRIPTORS_INDEX: HID Descriptor Num Descriptors USB Field Index for StartsWith Operator
--		STARTS_WITH_HID_BNUMDESCRIPTORS_COUNT: HID Descriptor Num Descriptors USB Field Count for StartsWith Operator
--		STARTS_WITH_HID_BDESCRIPTORTYPE_INDEX: HID Descriptor Descriptor Type USB Field Index for StartsWith Operator
--		STARTS_WITH_HID_BDESCRIPTORTYPE_COUNT: HID Descriptor Descriptor Type USB Field Count for StartsWith Operator
--		STARTS_WITH_HID_WDESCRIPTORLENGTH_INDEX: HID Descriptor Descriptor Length USB Field Index for StartsWith Operator
--		STARTS_WITH_HID_WDESCRIPTORLENGTH_COUNT: HID Descriptor Descriptor Length USB Field Count for StartsWith Operator
--		STARTS_WITH_STRING_BLENGTH_INDEX: String Descriptor Length USB Field Index for StartsWith Operator
--		STARTS_WITH_STRING_BLENGTH_COUNT: String Descriptor Length USB Field Count for StartsWith Operator
--		STARTS_WITH_STRING_IMANUFACTURER_INDEX: String Descriptor Manufacturer USB Field Index for StartsWith Operator
--		STARTS_WITH_STRING_IMANUFACTURER_COUNT: String Descriptor Manufacturer USB Field Count for StartsWith Operator
--		STARTS_WITH_STRING_IPRODUCT_INDEX: String Descriptor Product USB Field Index for StartsWith Operator
--		STARTS_WITH_STRING_IPRODUCT_COUNT: String Descriptor Product USB Field Count for StartsWith Operator
--		STARTS_WITH_STRING_ISERIALNUMBER_INDEX: String Descriptor Serial Number USB Field Index for StartsWith Operator
--		STARTS_WITH_STRING_ISERIALNUMBER_COUNT: String Descriptor Serial Number USB Field Count for StartsWith Operator
--		STARTS_WITH_STRING_ICONFIGURATION_INDEX: String Descriptor Configuration USB Field Index for StartsWith Operator
--		STARTS_WITH_STRING_ICONFIGURATION_COUNT: String Descriptor Configuration USB Field Count for StartsWith Operator
--		STARTS_WITH_STRING_IINTERFACE_INDEX: String Descriptor Interface USB Field Index for StartsWith Operator
--		STARTS_WITH_STRING_IINTERFACE_COUNT: String Descriptor Interface USB Field Count for StartsWith Operator
--
--		ENDS_WITH_MEMORY_ADDR_LENGTH: Define the Memory Address Bus Length for EndsWith Operator (in line with the maximum index value)
--		ENDS_WITH_MEMORY_ADDR_MAX_INDEX: Define the Memory Maximum Address for EndsWith Operator (in line with the maximum index value)
--		ENDS_WITH_MEMORY_ADDR_MAX_COUNT: Define the Memory Maximum Address Count for EndsWith Operator (in line with the maximum count value)
--		ENDS_WITH_DEVICE_BLENGTH_INDEX: Device Descriptor Length USB Field Index for EndsWith Operator
--		ENDS_WITH_DEVICE_BLENGTH_COUNT: Device Descriptor Length USB Field Count for EndsWith Operator
--		ENDS_WITH_DEVICE_BCDUSB_INDEX: Device Descriptor USB Release Number Field Index for EndsWith Operator
--		ENDS_WITH_DEVICE_BCDUSB_COUNT: Device Descriptor USB Release Number Field Count for EndsWith Operator
--		ENDS_WITH_DEVICE_BDEVICECLASS_INDEX: Device Descriptor Device Class USB Field Index for EndsWith Operator
--		ENDS_WITH_DEVICE_BDEVICECLASS_COUNT: Device Descriptor Device Class USB Field Count for EndsWith Operator
--		ENDS_WITH_DEVICE_BDEVICESUBCLASS_INDEX: Device Descriptor Device Sub Class USB Field Index for EndsWith Operator
--		ENDS_WITH_DEVICE_BDEVICESUBCLASS_COUNT: Device Descriptor Device Sub Class USB Field Count for EndsWith Operator
--		ENDS_WITH_DEVICE_BDEVICEPROTOCOL_INDEX: Device Descriptor Device Protocol USB Field Index for EndsWith Operator
--		ENDS_WITH_DEVICE_BDEVICEPROTOCOL_COUNT: Device Descriptor Device Protocol USB Field Count for EndsWith Operator
--		ENDS_WITH_DEVICE_BMAXPACKETSIZE0_INDEX: Device Descriptor Max Packet Size0 USB Field Index for EndsWith Operator
--		ENDS_WITH_DEVICE_BMAXPACKETSIZE0_COUNT: Device Descriptor Max Packet Size0 USB Field Count for EndsWith Operator
--		ENDS_WITH_DEVICE_IDVENDOR_INDEX: Device Descriptor Vendor USB Field Index for EndsWith Operator
--		ENDS_WITH_DEVICE_IDVENDOR_COUNT: Device Descriptor Vendor USB Field Count for EndsWith Operator
--		ENDS_WITH_DEVICE_IDPRODUCT_INDEX: Device Descriptor Product USB Field Index for EndsWith Operator
--		ENDS_WITH_DEVICE_IDPRODUCT_COUNT: Device Descriptor Product USB Field Count for EndsWith Operator
--		ENDS_WITH_DEVICE_BCDDEVICE_INDEX: Device Descriptor Device Release Number USB Field Index for EndsWith Operator
--		ENDS_WITH_DEVICE_BCDDEVICE_COUNT: Device Descriptor Device Release Number USB Field Count for EndsWith Operator
--		ENDS_WITH_DEVICE_BNUMCONFIGURATIONS_INDEX: Device Descriptor Num Configuration USB Field Index for EndsWith Operator
--		ENDS_WITH_DEVICE_BNUMCONFIGURATIONS_COUNT: Device Descriptor Num Configuration USB Field Count for EndsWith Operator
--		ENDS_WITH_DEVICE_QUALIFIER_BLENGTH_INDEX: Device Qualifier Descriptor Length USB Field Index for EndsWith Operator
--		ENDS_WITH_DEVICE_QUALIFIER_BLENGTH_COUNT: Device Qualifier Descriptor Length USB Field Count for EndsWith Operator
--		ENDS_WITH_DEVICE_QUALIFIER_BCDUSB_INDEX: Device Qualifier Descriptor USB Release Number Field Index for EndsWith Operator
--		ENDS_WITH_DEVICE_QUALIFIER_BCDUSB_COUNT: Device Qualifier Descriptor USB Release Number Field Count for EndsWith Operator
--		ENDS_WITH_DEVICE_QUALIFIER_BDEVICECLASS_INDEX: Device Qualifier Descriptor Device Class USB Field Index for EndsWith Operator
--		ENDS_WITH_DEVICE_QUALIFIER_BDEVICECLASS_COUNT: Device Qualifier Descriptor Device Class USB Field Count for EndsWith Operator
--		ENDS_WITH_DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX: Device Qualifier Descriptor Device Sub Class USB Field Index for EndsWith Operator
--		ENDS_WITH_DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT: Device Qualifier Descriptor Device Sub Class USB Field Count for EndsWith Operator
--		ENDS_WITH_DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX: Device Qualifier Descriptor Device Protocol USB Field Index for EndsWith Operator
--		ENDS_WITH_DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT: Device Qualifier Descriptor Device Protocol USB Field Count for EndsWith Operator
--		ENDS_WITH_DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX: Device Qualifier Descriptor Max Packet Size0 USB Field Index for EndsWith Operator
--		ENDS_WITH_DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT: Device Qualifier Descriptor Max Packet Size0 USB Field Count for EndsWith Operator
--		ENDS_WITH_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX: Device Qualifier Descriptor Num Configuration USB Field Index for EndsWith Operator
--		ENDS_WITH_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT: Device Qualifier Descriptor Num Configuration USB Field Count for EndsWith Operator
--		ENDS_WITH_DEVICE_QUALIFIER_BRESERVED_INDEX: Device Qualifier Descriptor Reserved USB Field Index for EndsWith Operator
--		ENDS_WITH_DEVICE_QUALIFIER_BRESERVED_COUNT: Device Qualifier Descriptor Reserved USB Field Count for EndsWith Operator
--		ENDS_WITH_CONFIGURATION_BLENGTH_INDEX: Configuration Descriptor Length USB Field Index for EndsWith Operator
--		ENDS_WITH_CONFIGURATION_BLENGTH_COUNT: Configuration Descriptor Length USB Field Count for EndsWith Operator
--		ENDS_WITH_CONFIGURATION_WTOTALLENGTH_INDEX: Configuration Descriptor Total Length USB Field Index for EndsWith Operator
--		ENDS_WITH_CONFIGURATION_WTOTALLENGTH_COUNT: Configuration Descriptor Total Length USB Field Count for EndsWith Operator
--		ENDS_WITH_CONFIGURATION_BNUMINTERFACES_INDEX: Configuration Descriptor Num Interfaces USB Field Index for EndsWith Operator
--		ENDS_WITH_CONFIGURATION_BNUMINTERFACES_COUNT: Configuration Descriptor Num Interfaces USB Field Count for EndsWith Operator
--		ENDS_WITH_CONFIGURATION_BCONFIGURATIONVALUE_INDEX: Configuration Descriptor Configuration Value USB Field Index for EndsWith Operator
--		ENDS_WITH_CONFIGURATION_BCONFIGURATIONVALUE_COUNT: Configuration Descriptor Configuration Value USB Field Count for EndsWith Operator
--		ENDS_WITH_CONFIGURATION_BMATTRIBUTES_INDEX: Configuration Descriptor Attributes USB Field Index for EndsWith Operator
--		ENDS_WITH_CONFIGURATION_BMATTRIBUTES_COUNT: Configuration Descriptor Attributes USB Field Count for EndsWith Operator
--		ENDS_WITH_CONFIGURATION_BMAXPOWER_INDEX: Configuration Descriptor Max Power USB Field Index for EndsWith Operator
--		ENDS_WITH_CONFIGURATION_BMAXPOWER_COUNT: Configuration Descriptor Max Power USB Field Count for EndsWith Operator
--		ENDS_WITH_OTHER_SPEED_BLENGTH_INDEX: Other Speed Descriptor Length USB Field Index for EndsWith Operator
--		ENDS_WITH_OTHER_SPEED_BLENGTH_COUNT: Other Speed Descriptor Length USB Field Count for EndsWith Operator
--		ENDS_WITH_OTHER_SPEED_WTOTALLENGTH_INDEX: Other Speed Descriptor Total Length USB Field Index for EndsWith Operator
--		ENDS_WITH_OTHER_SPEED_WTOTALLENGTH_COUNT: Other Speed Descriptor Total Length USB Field Count for EndsWith Operator
--		ENDS_WITH_OTHER_SPEED_BNUMINTERFACES_INDEX: Other Speed Descriptor Num Interfaces USB Field Index for EndsWith Operator
--		ENDS_WITH_OTHER_SPEED_BNUMINTERFACES_COUNT: Other Speed Descriptor Num Interfaces USB Field Count for EndsWith Operator
--		ENDS_WITH_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX: Other Speed Descriptor Configuration Value USB Field Index for EndsWith Operator
--		ENDS_WITH_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT: Other Speed Descriptor Configuration Value USB Field Count for EndsWith Operator
--		ENDS_WITH_OTHER_SPEED_BMATTRIBUTES_INDEX: Other Speed Descriptor Attributes USB Field Index for EndsWith Operator
--		ENDS_WITH_OTHER_SPEED_BMATTRIBUTES_COUNT: Other Speed Descriptor Attributes USB Field Count for EndsWith Operator
--		ENDS_WITH_OTHER_SPEED_BMAXPOWER_INDEX: Other Speed Descriptor Max Power USB Field Index for EndsWith Operator
--		ENDS_WITH_OTHER_SPEED_BMAXPOWER_COUNT: Other Speed Descriptor Max Power USB Field Count for EndsWith Operator
--		ENDS_WITH_INTERFACE_BLENGTH_INDEX: Interface Descriptor Length USB Field Index for EndsWith Operator
--		ENDS_WITH_INTERFACE_BLENGTH_COUNT: Interface Descriptor Length USB Field Count for EndsWith Operator
--		ENDS_WITH_INTERFACE_BINTERFACENUMBER_INDEX: Interface Descriptor Interface Number USB Field Index for EndsWith Operator
--		ENDS_WITH_INTERFACE_BINTERFACENUMBER_COUNT: Interface Descriptor Interface Number USB Field Count for EndsWith Operator
--		ENDS_WITH_INTERFACE_BALTERNATESETTING_INDEX: Interface Descriptor Alternate Setting USB Field Index for EndsWith Operator
--		ENDS_WITH_INTERFACE_BALTERNATESETTING_COUNT: Interface Descriptor Alternate Setting USB Field Count for EndsWith Operator
--		ENDS_WITH_INTERFACE_BNUMENDPOINTS_INDEX: Interface Descriptor Num Endpoints USB Field Index for EndsWith Operator
--		ENDS_WITH_INTERFACE_BNUMENDPOINTS_COUNT: Interface Descriptor Num Endpoints USB Field Count for EndsWith Operator
--		ENDS_WITH_INTERFACE_BINTERFACECLASS_INDEX: Interface Descriptor Interface Class USB Field Index for EndsWith Operator
--		ENDS_WITH_INTERFACE_BINTERFACECLASS_COUNT: Interface Descriptor Interface Class USB Field Count for EndsWith Operator
--		ENDS_WITH_INTERFACE_BINTERFACESUBCLASS_INDEX: Interface Descriptor Interface Sub Class USB Field Index for EndsWith Operator
--		ENDS_WITH_INTERFACE_BINTERFACESUBCLASS_COUNT: Interface Descriptor Interface Sub Class USB Field Count for EndsWith Operator
--		ENDS_WITH_INTERFACE_BINTERFACEPROTOCOL_INDEX: Interface Descriptor Interface Protocol USB Field Index for EndsWith Operator
--		ENDS_WITH_INTERFACE_BINTERFACEPROTOCOL_COUNT: Interface Descriptor Interface Protocol USB Field Count for EndsWith Operator
--		ENDS_WITH_ENDPOINT_BLENGTH_INDEX: Endpoint Descriptor Length USB Field Index for EndsWith Operator
--		ENDS_WITH_ENDPOINT_BLENGTH_COUNT: Endpoint Descriptor Length USB Field Count for EndsWith Operator
--		ENDS_WITH_ENDPOINT_BENDPOINTADDRESS_INDEX: Endpoint Descriptor Endpoint Address USB Field Index for EndsWith Operator
--		ENDS_WITH_ENDPOINT_BENDPOINTADDRESS_COUNT: Endpoint Descriptor Endpoint Address USB Field Count for EndsWith Operator
--		ENDS_WITH_ENDPOINT_BMATTRIBUTES_INDEX: Endpoint Descriptor Attributes USB Field Index for EndsWith Operator
--		ENDS_WITH_ENDPOINT_BMATTRIBUTES_COUNT: Endpoint Descriptor Attributes USB Field Count for EndsWith Operator
--		ENDS_WITH_ENDPOINT_WMAXPACKETSIZE_INDEX: Endpoint Descriptor Max Packet Size USB Field Index for EndsWith Operator
--		ENDS_WITH_ENDPOINT_WMAXPACKETSIZE_COUNT: Endpoint Descriptor Max Packet Size USB Field Count for EndsWith Operator
--		ENDS_WITH_ENDPOINT_BINTERVAL_INDEX: Endpoint Descriptor Interval USB Field Index for EndsWith Operator
--		ENDS_WITH_ENDPOINT_BINTERVAL_COUNT: Endpoint Descriptor Interval USB Field Count for EndsWith Operator
--		ENDS_WITH_HID_BLENGTH_INDEX: HID Descriptor Length USB Field Index for EndsWith Operator
--		ENDS_WITH_HID_BLENGTH_COUNT: HID Descriptor Length USB Field Count for EndsWith Operator
--		ENDS_WITH_HID_BCDHID_INDEX: HID Descriptor HID USB Field Index for EndsWith Operator
--		ENDS_WITH_HID_BCDHID_COUNT: HID Descriptor HID USB Field Count for EndsWith Operator
--		ENDS_WITH_HID_BCOUNTRYCODE_INDEX: HID Descriptor Country Code USB Field Index for EndsWith Operator
--		ENDS_WITH_HID_BCOUNTRYCODE_COUNT: HID Descriptor Country Code USB Field Count for EndsWith Operator
--		ENDS_WITH_HID_BNUMDESCRIPTORS_INDEX: HID Descriptor Num Descriptors USB Field Index for EndsWith Operator
--		ENDS_WITH_HID_BNUMDESCRIPTORS_COUNT: HID Descriptor Num Descriptors USB Field Count for EndsWith Operator
--		ENDS_WITH_HID_BDESCRIPTORTYPE_INDEX: HID Descriptor Descriptor Type USB Field Index for EndsWith Operator
--		ENDS_WITH_HID_BDESCRIPTORTYPE_COUNT: HID Descriptor Descriptor Type USB Field Count for EndsWith Operator
--		ENDS_WITH_HID_WDESCRIPTORLENGTH_INDEX: HID Descriptor Descriptor Length USB Field Index for EndsWith Operator
--		ENDS_WITH_HID_WDESCRIPTORLENGTH_COUNT: HID Descriptor Descriptor Length USB Field Count for EndsWith Operator
--		ENDS_WITH_STRING_BLENGTH_INDEX: String Descriptor Length USB Field Index for EndsWith Operator
--		ENDS_WITH_STRING_BLENGTH_COUNT: String Descriptor Length USB Field Count for EndsWith Operator
--		ENDS_WITH_STRING_IMANUFACTURER_INDEX: String Descriptor Manufacturer USB Field Index for EndsWith Operator
--		ENDS_WITH_STRING_IMANUFACTURER_COUNT: String Descriptor Manufacturer USB Field Count for EndsWith Operator
--		ENDS_WITH_STRING_IPRODUCT_INDEX: String Descriptor Product USB Field Index for EndsWith Operator
--		ENDS_WITH_STRING_IPRODUCT_COUNT: String Descriptor Product USB Field Count for EndsWith Operator
--		ENDS_WITH_STRING_ISERIALNUMBER_INDEX: String Descriptor Serial Number USB Field Index for EndsWith Operator
--		ENDS_WITH_STRING_ISERIALNUMBER_COUNT: String Descriptor Serial Number USB Field Count for EndsWith Operator
--		ENDS_WITH_STRING_ICONFIGURATION_INDEX: String Descriptor Configuration USB Field Index for EndsWith Operator
--		ENDS_WITH_STRING_ICONFIGURATION_COUNT: String Descriptor Configuration USB Field Count for EndsWith Operator
--		ENDS_WITH_STRING_IINTERFACE_INDEX: String Descriptor Interface USB Field Index for EndsWith Operator
--		ENDS_WITH_STRING_IINTERFACE_COUNT: String Descriptor Interface USB Field Count for EndsWith Operator
--
--		CONTAINS_MEMORY_ADDR_LENGTH: Define the Memory Address Bus Length for Contains Operator (in line with the maximum index value)
--		CONTAINS_MEMORY_ADDR_MAX_INDEX: Define the Memory Maximum Address for Contains Operator (in line with the maximum index value)
--		CONTAINS_MEMORY_ADDR_MAX_COUNT: Define the Memory Maximum Address Count for Contains Operator (in line with the maximum count value)
--		CONTAINS_DEVICE_BLENGTH_INDEX: Device Descriptor Length USB Field Index for Contains Operator
--		CONTAINS_DEVICE_BLENGTH_COUNT: Device Descriptor Length USB Field Count for Contains Operator
--		CONTAINS_DEVICE_BCDUSB_INDEX: Device Descriptor USB Release Number Field Index for Contains Operator
--		CONTAINS_DEVICE_BCDUSB_COUNT: Device Descriptor USB Release Number Field Count for Contains Operator
--		CONTAINS_DEVICE_BDEVICECLASS_INDEX: Device Descriptor Device Class USB Field Index for Contains Operator
--		CONTAINS_DEVICE_BDEVICECLASS_COUNT: Device Descriptor Device Class USB Field Count for Contains Operator
--		CONTAINS_DEVICE_BDEVICESUBCLASS_INDEX: Device Descriptor Device Sub Class USB Field Index for Contains Operator
--		CONTAINS_DEVICE_BDEVICESUBCLASS_COUNT: Device Descriptor Device Sub Class USB Field Count for Contains Operator
--		CONTAINS_DEVICE_BDEVICEPROTOCOL_INDEX: Device Descriptor Device Protocol USB Field Index for Contains Operator
--		CONTAINS_DEVICE_BDEVICEPROTOCOL_COUNT: Device Descriptor Device Protocol USB Field Count for Contains Operator
--		CONTAINS_DEVICE_BMAXPACKETSIZE0_INDEX: Device Descriptor Max Packet Size0 USB Field Index for Contains Operator
--		CONTAINS_DEVICE_BMAXPACKETSIZE0_COUNT: Device Descriptor Max Packet Size0 USB Field Count for Contains Operator
--		CONTAINS_DEVICE_IDVENDOR_INDEX: Device Descriptor Vendor USB Field Index for Contains Operator
--		CONTAINS_DEVICE_IDVENDOR_COUNT: Device Descriptor Vendor USB Field Count for Contains Operator
--		CONTAINS_DEVICE_IDPRODUCT_INDEX: Device Descriptor Product USB Field Index for Contains Operator
--		CONTAINS_DEVICE_IDPRODUCT_COUNT: Device Descriptor Product USB Field Count for Contains Operator
--		CONTAINS_DEVICE_BCDDEVICE_INDEX: Device Descriptor Device Release Number USB Field Index for Contains Operator
--		CONTAINS_DEVICE_BCDDEVICE_COUNT: Device Descriptor Device Release Number USB Field Count for Contains Operator
--		CONTAINS_DEVICE_BNUMCONFIGURATIONS_INDEX: Device Descriptor Num Configuration USB Field Index for Contains Operator
--		CONTAINS_DEVICE_BNUMCONFIGURATIONS_COUNT: Device Descriptor Num Configuration USB Field Count for Contains Operator
--		CONTAINS_DEVICE_QUALIFIER_BLENGTH_INDEX: Device Qualifier Descriptor Length USB Field Index for Contains Operator
--		CONTAINS_DEVICE_QUALIFIER_BLENGTH_COUNT: Device Qualifier Descriptor Length USB Field Count for Contains Operator
--		CONTAINS_DEVICE_QUALIFIER_BCDUSB_INDEX: Device Qualifier Descriptor USB Release Number Field Index for Contains Operator
--		CONTAINS_DEVICE_QUALIFIER_BCDUSB_COUNT: Device Qualifier Descriptor USB Release Number Field Count for Contains Operator
--		CONTAINS_DEVICE_QUALIFIER_BDEVICECLASS_INDEX: Device Qualifier Descriptor Device Class USB Field Index for Contains Operator
--		CONTAINS_DEVICE_QUALIFIER_BDEVICECLASS_COUNT: Device Qualifier Descriptor Device Class USB Field Count for Contains Operator
--		CONTAINS_DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX: Device Qualifier Descriptor Device Sub Class USB Field Index for Contains Operator
--		CONTAINS_DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT: Device Qualifier Descriptor Device Sub Class USB Field Count for Contains Operator
--		CONTAINS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX: Device Qualifier Descriptor Device Protocol USB Field Index for Contains Operator
--		CONTAINS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT: Device Qualifier Descriptor Device Protocol USB Field Count for Contains Operator
--		CONTAINS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX: Device Qualifier Descriptor Max Packet Size0 USB Field Index for Contains Operator
--		CONTAINS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT: Device Qualifier Descriptor Max Packet Size0 USB Field Count for Contains Operator
--		CONTAINS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX: Device Qualifier Descriptor Num Configuration USB Field Index for Contains Operator
--		CONTAINS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT: Device Qualifier Descriptor Num Configuration USB Field Count for Contains Operator
--		CONTAINS_DEVICE_QUALIFIER_BRESERVED_INDEX: Device Qualifier Descriptor Reserved USB Field Index for Contains Operator
--		CONTAINS_DEVICE_QUALIFIER_BRESERVED_COUNT: Device Qualifier Descriptor Reserved USB Field Count for Contains Operator
--		CONTAINS_CONFIGURATION_BLENGTH_INDEX: Configuration Descriptor Length USB Field Index for Contains Operator
--		CONTAINS_CONFIGURATION_BLENGTH_COUNT: Configuration Descriptor Length USB Field Count for Contains Operator
--		CONTAINS_CONFIGURATION_WTOTALLENGTH_INDEX: Configuration Descriptor Total Length USB Field Index for Contains Operator
--		CONTAINS_CONFIGURATION_WTOTALLENGTH_COUNT: Configuration Descriptor Total Length USB Field Count for Contains Operator
--		CONTAINS_CONFIGURATION_BNUMINTERFACES_INDEX: Configuration Descriptor Num Interfaces USB Field Index for Contains Operator
--		CONTAINS_CONFIGURATION_BNUMINTERFACES_COUNT: Configuration Descriptor Num Interfaces USB Field Count for Contains Operator
--		CONTAINS_CONFIGURATION_BCONFIGURATIONVALUE_INDEX: Configuration Descriptor Configuration Value USB Field Index for Contains Operator
--		CONTAINS_CONFIGURATION_BCONFIGURATIONVALUE_COUNT: Configuration Descriptor Configuration Value USB Field Count for Contains Operator
--		CONTAINS_CONFIGURATION_BMATTRIBUTES_INDEX: Configuration Descriptor Attributes USB Field Index for Contains Operator
--		CONTAINS_CONFIGURATION_BMATTRIBUTES_COUNT: Configuration Descriptor Attributes USB Field Count for Contains Operator
--		CONTAINS_CONFIGURATION_BMAXPOWER_INDEX: Configuration Descriptor Max Power USB Field Index for Contains Operator
--		CONTAINS_CONFIGURATION_BMAXPOWER_COUNT: Configuration Descriptor Max Power USB Field Count for Contains Operator
--		CONTAINS_OTHER_SPEED_BLENGTH_INDEX: Other Speed Descriptor Length USB Field Index for Contains Operator
--		CONTAINS_OTHER_SPEED_BLENGTH_COUNT: Other Speed Descriptor Length USB Field Count for Contains Operator
--		CONTAINS_OTHER_SPEED_WTOTALLENGTH_INDEX: Other Speed Descriptor Total Length USB Field Index for Contains Operator
--		CONTAINS_OTHER_SPEED_WTOTALLENGTH_COUNT: Other Speed Descriptor Total Length USB Field Count for Contains Operator
--		CONTAINS_OTHER_SPEED_BNUMINTERFACES_INDEX: Other Speed Descriptor Num Interfaces USB Field Index for Contains Operator
--		CONTAINS_OTHER_SPEED_BNUMINTERFACES_COUNT: Other Speed Descriptor Num Interfaces USB Field Count for Contains Operator
--		CONTAINS_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX: Other Speed Descriptor Configuration Value USB Field Index for Contains Operator
--		CONTAINS_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT: Other Speed Descriptor Configuration Value USB Field Count for Contains Operator
--		CONTAINS_OTHER_SPEED_BMATTRIBUTES_INDEX: Other Speed Descriptor Attributes USB Field Index for Contains Operator
--		CONTAINS_OTHER_SPEED_BMATTRIBUTES_COUNT: Other Speed Descriptor Attributes USB Field Count for Contains Operator
--		CONTAINS_OTHER_SPEED_BMAXPOWER_INDEX: Other Speed Descriptor Max Power USB Field Index for Contains Operator
--		CONTAINS_OTHER_SPEED_BMAXPOWER_COUNT: Other Speed Descriptor Max Power USB Field Count for Contains Operator
--		CONTAINS_INTERFACE_BLENGTH_INDEX: Interface Descriptor Length USB Field Index for Contains Operator
--		CONTAINS_INTERFACE_BLENGTH_COUNT: Interface Descriptor Length USB Field Count for Contains Operator
--		CONTAINS_INTERFACE_BINTERFACENUMBER_INDEX: Interface Descriptor Interface Number USB Field Index for Contains Operator
--		CONTAINS_INTERFACE_BINTERFACENUMBER_COUNT: Interface Descriptor Interface Number USB Field Count for Contains Operator
--		CONTAINS_INTERFACE_BALTERNATESETTING_INDEX: Interface Descriptor Alternate Setting USB Field Index for Contains Operator
--		CONTAINS_INTERFACE_BALTERNATESETTING_COUNT: Interface Descriptor Alternate Setting USB Field Count for Contains Operator
--		CONTAINS_INTERFACE_BNUMENDPOINTS_INDEX: Interface Descriptor Num Endpoints USB Field Index for Contains Operator
--		CONTAINS_INTERFACE_BNUMENDPOINTS_COUNT: Interface Descriptor Num Endpoints USB Field Count for Contains Operator
--		CONTAINS_INTERFACE_BINTERFACECLASS_INDEX: Interface Descriptor Interface Class USB Field Index for Contains Operator
--		CONTAINS_INTERFACE_BINTERFACECLASS_COUNT: Interface Descriptor Interface Class USB Field Count for Contains Operator
--		CONTAINS_INTERFACE_BINTERFACESUBCLASS_INDEX: Interface Descriptor Interface Sub Class USB Field Index for Contains Operator
--		CONTAINS_INTERFACE_BINTERFACESUBCLASS_COUNT: Interface Descriptor Interface Sub Class USB Field Count for Contains Operator
--		CONTAINS_INTERFACE_BINTERFACEPROTOCOL_INDEX: Interface Descriptor Interface Protocol USB Field Index for Contains Operator
--		CONTAINS_INTERFACE_BINTERFACEPROTOCOL_COUNT: Interface Descriptor Interface Protocol USB Field Count for Contains Operator
--		CONTAINS_ENDPOINT_BLENGTH_INDEX: Endpoint Descriptor Length USB Field Index for Contains Operator
--		CONTAINS_ENDPOINT_BLENGTH_COUNT: Endpoint Descriptor Length USB Field Count for Contains Operator
--		CONTAINS_ENDPOINT_BENDPOINTADDRESS_INDEX: Endpoint Descriptor Endpoint Address USB Field Index for Contains Operator
--		CONTAINS_ENDPOINT_BENDPOINTADDRESS_COUNT: Endpoint Descriptor Endpoint Address USB Field Count for Contains Operator
--		CONTAINS_ENDPOINT_BMATTRIBUTES_INDEX: Endpoint Descriptor Attributes USB Field Index for Contains Operator
--		CONTAINS_ENDPOINT_BMATTRIBUTES_COUNT: Endpoint Descriptor Attributes USB Field Count for Contains Operator
--		CONTAINS_ENDPOINT_WMAXPACKETSIZE_INDEX: Endpoint Descriptor Max Packet Size USB Field Index for Contains Operator
--		CONTAINS_ENDPOINT_WMAXPACKETSIZE_COUNT: Endpoint Descriptor Max Packet Size USB Field Count for Contains Operator
--		CONTAINS_ENDPOINT_BINTERVAL_INDEX: Endpoint Descriptor Interval USB Field Index for Contains Operator
--		CONTAINS_ENDPOINT_BINTERVAL_COUNT: Endpoint Descriptor Interval USB Field Count for Contains Operator
--		CONTAINS_HID_BLENGTH_INDEX: HID Descriptor Length USB Field Index for Contains Operator
--		CONTAINS_HID_BLENGTH_COUNT: HID Descriptor Length USB Field Count for Contains Operator
--		CONTAINS_HID_BCDHID_INDEX: HID Descriptor HID USB Field Index for Contains Operator
--		CONTAINS_HID_BCDHID_COUNT: HID Descriptor HID USB Field Count for Contains Operator
--		CONTAINS_HID_BCOUNTRYCODE_INDEX: HID Descriptor Country Code USB Field Index for Contains Operator
--		CONTAINS_HID_BCOUNTRYCODE_COUNT: HID Descriptor Country Code USB Field Count for Contains Operator
--		CONTAINS_HID_BNUMDESCRIPTORS_INDEX: HID Descriptor Num Descriptors USB Field Index for Contains Operator
--		CONTAINS_HID_BNUMDESCRIPTORS_COUNT: HID Descriptor Num Descriptors USB Field Count for Contains Operator
--		CONTAINS_HID_BDESCRIPTORTYPE_INDEX: HID Descriptor Descriptor Type USB Field Index for Contains Operator
--		CONTAINS_HID_BDESCRIPTORTYPE_COUNT: HID Descriptor Descriptor Type USB Field Count for Contains Operator
--		CONTAINS_HID_WDESCRIPTORLENGTH_INDEX: HID Descriptor Descriptor Length USB Field Index for Contains Operator
--		CONTAINS_HID_WDESCRIPTORLENGTH_COUNT: HID Descriptor Descriptor Length USB Field Count for Contains Operator
--		CONTAINS_STRING_BLENGTH_INDEX: String Descriptor Length USB Field Index for Contains Operator
--		CONTAINS_STRING_BLENGTH_COUNT: String Descriptor Length USB Field Count for Contains Operator
--		CONTAINS_STRING_IMANUFACTURER_INDEX: String Descriptor Manufacturer USB Field Index for Contains Operator
--		CONTAINS_STRING_IMANUFACTURER_COUNT: String Descriptor Manufacturer USB Field Count for Contains Operator
--		CONTAINS_STRING_IPRODUCT_INDEX: String Descriptor Product USB Field Index for Contains Operator
--		CONTAINS_STRING_IPRODUCT_COUNT: String Descriptor Product USB Field Count for Contains Operator
--		CONTAINS_STRING_ISERIALNUMBER_INDEX: String Descriptor Serial Number USB Field Index for Contains Operator
--		CONTAINS_STRING_ISERIALNUMBER_COUNT: String Descriptor Serial Number USB Field Count for Contains Operator
--		CONTAINS_STRING_ICONFIGURATION_INDEX: String Descriptor Configuration USB Field Index for Contains Operator
--		CONTAINS_STRING_ICONFIGURATION_COUNT: String Descriptor Configuration USB Field Count for Contains Operator
--		CONTAINS_STRING_IINTERFACE_INDEX: String Descriptor Interface USB Field Index for Contains Operator
--		CONTAINS_STRING_IINTERFACE_COUNT: String Descriptor Interface USB Field Count for Contains Operator
--
--		NOT_CONTAINS_MEMORY_ADDR_LENGTH: Define the Memory Address Bus Length for NotContains Operator (in line with the maximum index value)
--		NOT_CONTAINS_MEMORY_ADDR_MAX_INDEX: Define the Memory Maximum Address for NotContains Operator (in line with the maximum index value)
--		NOT_CONTAINS_MEMORY_ADDR_MAX_COUNT: Define the Memory Maximum Address Count for NotContains Operator (in line with the maximum count value)
--		NOT_CONTAINS_DEVICE_BLENGTH_INDEX: Device Descriptor Length USB Field Index for NotContains Operator
--		NOT_CONTAINS_DEVICE_BLENGTH_COUNT: Device Descriptor Length USB Field Count for NotContains Operator
--		NOT_CONTAINS_DEVICE_BCDUSB_INDEX: Device Descriptor USB Release Number Field Index for NotContains Operator
--		NOT_CONTAINS_DEVICE_BCDUSB_COUNT: Device Descriptor USB Release Number Field Count for NotContains Operator
--		NOT_CONTAINS_DEVICE_BDEVICECLASS_INDEX: Device Descriptor Device Class USB Field Index for NotContains Operator
--		NOT_CONTAINS_DEVICE_BDEVICECLASS_COUNT: Device Descriptor Device Class USB Field Count for NotContains Operator
--		NOT_CONTAINS_DEVICE_BDEVICESUBCLASS_INDEX: Device Descriptor Device Sub Class USB Field Index for NotContains Operator
--		NOT_CONTAINS_DEVICE_BDEVICESUBCLASS_COUNT: Device Descriptor Device Sub Class USB Field Count for NotContains Operator
--		NOT_CONTAINS_DEVICE_BDEVICEPROTOCOL_INDEX: Device Descriptor Device Protocol USB Field Index for NotContains Operator
--		NOT_CONTAINS_DEVICE_BDEVICEPROTOCOL_COUNT: Device Descriptor Device Protocol USB Field Count for NotContains Operator
--		NOT_CONTAINS_DEVICE_BMAXPACKETSIZE0_INDEX: Device Descriptor Max Packet Size0 USB Field Index for NotContains Operator
--		NOT_CONTAINS_DEVICE_BMAXPACKETSIZE0_COUNT: Device Descriptor Max Packet Size0 USB Field Count for NotContains Operator
--		NOT_CONTAINS_DEVICE_IDVENDOR_INDEX: Device Descriptor Vendor USB Field Index for NotContains Operator
--		NOT_CONTAINS_DEVICE_IDVENDOR_COUNT: Device Descriptor Vendor USB Field Count for NotContains Operator
--		NOT_CONTAINS_DEVICE_IDPRODUCT_INDEX: Device Descriptor Product USB Field Index for NotContains Operator
--		NOT_CONTAINS_DEVICE_IDPRODUCT_COUNT: Device Descriptor Product USB Field Count for NotContains Operator
--		NOT_CONTAINS_DEVICE_BCDDEVICE_INDEX: Device Descriptor Device Release Number USB Field Index for NotContains Operator
--		NOT_CONTAINS_DEVICE_BCDDEVICE_COUNT: Device Descriptor Device Release Number USB Field Count for NotContains Operator
--		NOT_CONTAINS_DEVICE_BNUMCONFIGURATIONS_INDEX: Device Descriptor Num Configuration USB Field Index for NotContains Operator
--		NOT_CONTAINS_DEVICE_BNUMCONFIGURATIONS_COUNT: Device Descriptor Num Configuration USB Field Count for NotContains Operator
--		NOT_CONTAINS_DEVICE_QUALIFIER_BLENGTH_INDEX: Device Qualifier Descriptor Length USB Field Index for NotContains Operator
--		NOT_CONTAINS_DEVICE_QUALIFIER_BLENGTH_COUNT: Device Qualifier Descriptor Length USB Field Count for NotContains Operator
--		NOT_CONTAINS_DEVICE_QUALIFIER_BCDUSB_INDEX: Device Qualifier Descriptor USB Release Number Field Index for NotContains Operator
--		NOT_CONTAINS_DEVICE_QUALIFIER_BCDUSB_COUNT: Device Qualifier Descriptor USB Release Number Field Count for NotContains Operator
--		NOT_CONTAINS_DEVICE_QUALIFIER_BDEVICECLASS_INDEX: Device Qualifier Descriptor Device Class USB Field Index for NotContains Operator
--		NOT_CONTAINS_DEVICE_QUALIFIER_BDEVICECLASS_COUNT: Device Qualifier Descriptor Device Class USB Field Count for NotContains Operator
--		NOT_CONTAINS_DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX: Device Qualifier Descriptor Device Sub Class USB Field Index for NotContains Operator
--		NOT_CONTAINS_DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT: Device Qualifier Descriptor Device Sub Class USB Field Count for NotContains Operator
--		NOT_CONTAINS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX: Device Qualifier Descriptor Device Protocol USB Field Index for NotContains Operator
--		NOT_CONTAINS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT: Device Qualifier Descriptor Device Protocol USB Field Count for NotContains Operator
--		NOT_CONTAINS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX: Device Qualifier Descriptor Max Packet Size0 USB Field Index for NotContains Operator
--		NOT_CONTAINS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT: Device Qualifier Descriptor Max Packet Size0 USB Field Count for NotContains Operator
--		NOT_CONTAINS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX: Device Qualifier Descriptor Num Configuration USB Field Index for NotContains Operator
--		NOT_CONTAINS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT: Device Qualifier Descriptor Num Configuration USB Field Count for NotContains Operator
--		NOT_CONTAINS_DEVICE_QUALIFIER_BRESERVED_INDEX: Device Qualifier Descriptor Reserved USB Field Index for NotContains Operator
--		NOT_CONTAINS_DEVICE_QUALIFIER_BRESERVED_COUNT: Device Qualifier Descriptor Reserved USB Field Count for NotContains Operator
--		NOT_CONTAINS_CONFIGURATION_BLENGTH_INDEX: Configuration Descriptor Length USB Field Index for NotContains Operator
--		NOT_CONTAINS_CONFIGURATION_BLENGTH_COUNT: Configuration Descriptor Length USB Field Count for NotContains Operator
--		NOT_CONTAINS_CONFIGURATION_WTOTALLENGTH_INDEX: Configuration Descriptor Total Length USB Field Index for NotContains Operator
--		NOT_CONTAINS_CONFIGURATION_WTOTALLENGTH_COUNT: Configuration Descriptor Total Length USB Field Count for NotContains Operator
--		NOT_CONTAINS_CONFIGURATION_BNUMINTERFACES_INDEX: Configuration Descriptor Num Interfaces USB Field Index for NotContains Operator
--		NOT_CONTAINS_CONFIGURATION_BNUMINTERFACES_COUNT: Configuration Descriptor Num Interfaces USB Field Count for NotContains Operator
--		NOT_CONTAINS_CONFIGURATION_BCONFIGURATIONVALUE_INDEX: Configuration Descriptor Configuration Value USB Field Index for NotContains Operator
--		NOT_CONTAINS_CONFIGURATION_BCONFIGURATIONVALUE_COUNT: Configuration Descriptor Configuration Value USB Field Count for NotContains Operator
--		NOT_CONTAINS_CONFIGURATION_BMATTRIBUTES_INDEX: Configuration Descriptor Attributes USB Field Index for NotContains Operator
--		NOT_CONTAINS_CONFIGURATION_BMATTRIBUTES_COUNT: Configuration Descriptor Attributes USB Field Count for NotContains Operator
--		NOT_CONTAINS_CONFIGURATION_BMAXPOWER_INDEX: Configuration Descriptor Max Power USB Field Index for NotContains Operator
--		NOT_CONTAINS_CONFIGURATION_BMAXPOWER_COUNT: Configuration Descriptor Max Power USB Field Count for NotContains Operator
--		NOT_CONTAINS_OTHER_SPEED_BLENGTH_INDEX: Other Speed Descriptor Length USB Field Index for NotContains Operator
--		NOT_CONTAINS_OTHER_SPEED_BLENGTH_COUNT: Other Speed Descriptor Length USB Field Count for NotContains Operator
--		NOT_CONTAINS_OTHER_SPEED_WTOTALLENGTH_INDEX: Other Speed Descriptor Total Length USB Field Index for NotContains Operator
--		NOT_CONTAINS_OTHER_SPEED_WTOTALLENGTH_COUNT: Other Speed Descriptor Total Length USB Field Count for NotContains Operator
--		NOT_CONTAINS_OTHER_SPEED_BNUMINTERFACES_INDEX: Other Speed Descriptor Num Interfaces USB Field Index for NotContains Operator
--		NOT_CONTAINS_OTHER_SPEED_BNUMINTERFACES_COUNT: Other Speed Descriptor Num Interfaces USB Field Count for NotContains Operator
--		NOT_CONTAINS_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX: Other Speed Descriptor Configuration Value USB Field Index for NotContains Operator
--		NOT_CONTAINS_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT: Other Speed Descriptor Configuration Value USB Field Count for NotContains Operator
--		NOT_CONTAINS_OTHER_SPEED_BMATTRIBUTES_INDEX: Other Speed Descriptor Attributes USB Field Index for NotContains Operator
--		NOT_CONTAINS_OTHER_SPEED_BMATTRIBUTES_COUNT: Other Speed Descriptor Attributes USB Field Count for NotContains Operator
--		NOT_CONTAINS_OTHER_SPEED_BMAXPOWER_INDEX: Other Speed Descriptor Max Power USB Field Index for NotContains Operator
--		NOT_CONTAINS_OTHER_SPEED_BMAXPOWER_COUNT: Other Speed Descriptor Max Power USB Field Count for NotContains Operator
--		NOT_CONTAINS_INTERFACE_BLENGTH_INDEX: Interface Descriptor Length USB Field Index for NotContains Operator
--		NOT_CONTAINS_INTERFACE_BLENGTH_COUNT: Interface Descriptor Length USB Field Count for NotContains Operator
--		NOT_CONTAINS_INTERFACE_BINTERFACENUMBER_INDEX: Interface Descriptor Interface Number USB Field Index for NotContains Operator
--		NOT_CONTAINS_INTERFACE_BINTERFACENUMBER_COUNT: Interface Descriptor Interface Number USB Field Count for NotContains Operator
--		NOT_CONTAINS_INTERFACE_BALTERNATESETTING_INDEX: Interface Descriptor Alternate Setting USB Field Index for NotContains Operator
--		NOT_CONTAINS_INTERFACE_BALTERNATESETTING_COUNT: Interface Descriptor Alternate Setting USB Field Count for NotContains Operator
--		NOT_CONTAINS_INTERFACE_BNUMENDPOINTS_INDEX: Interface Descriptor Num Endpoints USB Field Index for NotContains Operator
--		NOT_CONTAINS_INTERFACE_BNUMENDPOINTS_COUNT: Interface Descriptor Num Endpoints USB Field Count for NotContains Operator
--		NOT_CONTAINS_INTERFACE_BINTERFACECLASS_INDEX: Interface Descriptor Interface Class USB Field Index for NotContains Operator
--		NOT_CONTAINS_INTERFACE_BINTERFACECLASS_COUNT: Interface Descriptor Interface Class USB Field Count for NotContains Operator
--		NOT_CONTAINS_INTERFACE_BINTERFACESUBCLASS_INDEX: Interface Descriptor Interface Sub Class USB Field Index for NotContains Operator
--		NOT_CONTAINS_INTERFACE_BINTERFACESUBCLASS_COUNT: Interface Descriptor Interface Sub Class USB Field Count for NotContains Operator
--		NOT_CONTAINS_INTERFACE_BINTERFACEPROTOCOL_INDEX: Interface Descriptor Interface Protocol USB Field Index for NotContains Operator
--		NOT_CONTAINS_INTERFACE_BINTERFACEPROTOCOL_COUNT: Interface Descriptor Interface Protocol USB Field Count for NotContains Operator
--		NOT_CONTAINS_ENDPOINT_BLENGTH_INDEX: Endpoint Descriptor Length USB Field Index for NotContains Operator
--		NOT_CONTAINS_ENDPOINT_BLENGTH_COUNT: Endpoint Descriptor Length USB Field Count for NotContains Operator
--		NOT_CONTAINS_ENDPOINT_BENDPOINTADDRESS_INDEX: Endpoint Descriptor Endpoint Address USB Field Index for NotContains Operator
--		NOT_CONTAINS_ENDPOINT_BENDPOINTADDRESS_COUNT: Endpoint Descriptor Endpoint Address USB Field Count for NotContains Operator
--		NOT_CONTAINS_ENDPOINT_BMATTRIBUTES_INDEX: Endpoint Descriptor Attributes USB Field Index for NotContains Operator
--		NOT_CONTAINS_ENDPOINT_BMATTRIBUTES_COUNT: Endpoint Descriptor Attributes USB Field Count for NotContains Operator
--		NOT_CONTAINS_ENDPOINT_WMAXPACKETSIZE_INDEX: Endpoint Descriptor Max Packet Size USB Field Index for NotContains Operator
--		NOT_CONTAINS_ENDPOINT_WMAXPACKETSIZE_COUNT: Endpoint Descriptor Max Packet Size USB Field Count for NotContains Operator
--		NOT_CONTAINS_ENDPOINT_BINTERVAL_INDEX: Endpoint Descriptor Interval USB Field Index for NotContains Operator
--		NOT_CONTAINS_ENDPOINT_BINTERVAL_COUNT: Endpoint Descriptor Interval USB Field Count for NotContains Operator
--		NOT_CONTAINS_HID_BLENGTH_INDEX: HID Descriptor Length USB Field Index for NotContains Operator
--		NOT_CONTAINS_HID_BLENGTH_COUNT: HID Descriptor Length USB Field Count for NotContains Operator
--		NOT_CONTAINS_HID_BCDHID_INDEX: HID Descriptor HID USB Field Index for NotContains Operator
--		NOT_CONTAINS_HID_BCDHID_COUNT: HID Descriptor HID USB Field Count for NotContains Operator
--		NOT_CONTAINS_HID_BCOUNTRYCODE_INDEX: HID Descriptor Country Code USB Field Index for NotContains Operator
--		NOT_CONTAINS_HID_BCOUNTRYCODE_COUNT: HID Descriptor Country Code USB Field Count for NotContains Operator
--		NOT_CONTAINS_HID_BNUMDESCRIPTORS_INDEX: HID Descriptor Num Descriptors USB Field Index for NotContains Operator
--		NOT_CONTAINS_HID_BNUMDESCRIPTORS_COUNT: HID Descriptor Num Descriptors USB Field Count for NotContains Operator
--		NOT_CONTAINS_HID_BDESCRIPTORTYPE_INDEX: HID Descriptor Descriptor Type USB Field Index for NotContains Operator
--		NOT_CONTAINS_HID_BDESCRIPTORTYPE_COUNT: HID Descriptor Descriptor Type USB Field Count for NotContains Operator
--		NOT_CONTAINS_HID_WDESCRIPTORLENGTH_INDEX: HID Descriptor Descriptor Length USB Field Index for NotContains Operator
--		NOT_CONTAINS_HID_WDESCRIPTORLENGTH_COUNT: HID Descriptor Descriptor Length USB Field Count for NotContains Operator
--		NOT_CONTAINS_STRING_BLENGTH_INDEX: String Descriptor Length USB Field Index for NotContains Operator
--		NOT_CONTAINS_STRING_BLENGTH_COUNT: String Descriptor Length USB Field Count for NotContains Operator
--		NOT_CONTAINS_STRING_IMANUFACTURER_INDEX: String Descriptor Manufacturer USB Field Index for NotContains Operator
--		NOT_CONTAINS_STRING_IMANUFACTURER_COUNT: String Descriptor Manufacturer USB Field Count for NotContains Operator
--		NOT_CONTAINS_STRING_IPRODUCT_INDEX: String Descriptor Product USB Field Index for NotContains Operator
--		NOT_CONTAINS_STRING_IPRODUCT_COUNT: String Descriptor Product USB Field Count for NotContains Operator
--		NOT_CONTAINS_STRING_ISERIALNUMBER_INDEX: String Descriptor Serial Number USB Field Index for NotContains Operator
--		NOT_CONTAINS_STRING_ISERIALNUMBER_COUNT: String Descriptor Serial Number USB Field Count for NotContains Operator
--		NOT_CONTAINS_STRING_ICONFIGURATION_INDEX: String Descriptor Configuration USB Field Index for NotContains Operator
--		NOT_CONTAINS_STRING_ICONFIGURATION_COUNT: String Descriptor Configuration USB Field Count for NotContains Operator
--		NOT_CONTAINS_STRING_IINTERFACE_INDEX: String Descriptor Interface USB Field Index for NotContains Operator
--		NOT_CONTAINS_STRING_IINTERFACE_COUNT: String Descriptor Interface USB Field Count for NotContains Operator
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

ENTITY Testbench_USBVerifier is
--  Port ( );
END Testbench_USBVerifier;

ARCHITECTURE Behavioral of Testbench_USBVerifier is

------------------------------------------------------------------------
-- Component Declarations
------------------------------------------------------------------------
COMPONENT USBVerifier is

GENERIC(
	EQUALS_OPERATOR_ENABLE: STD_LOGIC := '1';
	NOT_EQUALS_OPERATOR_ENABLE: STD_LOGIC := '1';
	GREATER_OPERATOR_ENABLE: STD_LOGIC := '1';
	GREATER_EQUALS_OPERATOR_ENABLE: STD_LOGIC := '1';
	LESS_OPERATOR_ENABLE: STD_LOGIC := '1';
	LESS_EQUALS_OPERATOR_ENABLE: STD_LOGIC := '1';
	STARTS_WITH_OPERATOR_ENABLE: STD_LOGIC := '1';
	ENDS_WITH_OPERATOR_ENABLE: STD_LOGIC := '1';
	CONTAINS_OPERATOR_ENABLE: STD_LOGIC := '1';
	NOT_CONTAINS_OPERATOR_ENABLE: STD_LOGIC := '1';
	WATCHDOG_LIMIT: INTEGER := 18;

	EQUALS_MEMORY_ADDR_LENGTH: INTEGER := 1;
	EQUALS_MEMORY_ADDR_MAX_INDEX: INTEGER := 0;
	EQUALS_MEMORY_ADDR_MAX_COUNT: INTEGER := 0; 
	EQUALS_DEVICE_BLENGTH_INDEX: INTEGER := 0;
	EQUALS_DEVICE_BLENGTH_COUNT: INTEGER := 0;
	EQUALS_DEVICE_BCDUSB_INDEX: INTEGER := 0;
	EQUALS_DEVICE_BCDUSB_COUNT: INTEGER := 0;
	EQUALS_DEVICE_BDEVICECLASS_INDEX: INTEGER := 0;
	EQUALS_DEVICE_BDEVICECLASS_COUNT: INTEGER := 0;
	EQUALS_DEVICE_BDEVICESUBCLASS_INDEX: INTEGER := 0;
	EQUALS_DEVICE_BDEVICESUBCLASS_COUNT: INTEGER := 0;
	EQUALS_DEVICE_BDEVICEPROTOCOL_INDEX: INTEGER := 0;
	EQUALS_DEVICE_BDEVICEPROTOCOL_COUNT: INTEGER := 0;
	EQUALS_DEVICE_BMAXPACKETSIZE0_INDEX: INTEGER := 0;
	EQUALS_DEVICE_BMAXPACKETSIZE0_COUNT: INTEGER := 0;
	EQUALS_DEVICE_IDVENDOR_INDEX: INTEGER := 0;
	EQUALS_DEVICE_IDVENDOR_COUNT: INTEGER := 0;
	EQUALS_DEVICE_IDPRODUCT_INDEX: INTEGER := 0;
	EQUALS_DEVICE_IDPRODUCT_COUNT: INTEGER := 0;
	EQUALS_DEVICE_BCDDEVICE_INDEX: INTEGER := 0;
	EQUALS_DEVICE_BCDDEVICE_COUNT: INTEGER := 0;
	EQUALS_DEVICE_BNUMCONFIGURATIONS_INDEX: INTEGER := 0;
	EQUALS_DEVICE_BNUMCONFIGURATIONS_COUNT: INTEGER := 0;
	EQUALS_DEVICE_QUALIFIER_BLENGTH_INDEX: INTEGER := 0;
	EQUALS_DEVICE_QUALIFIER_BLENGTH_COUNT: INTEGER := 0;
	EQUALS_DEVICE_QUALIFIER_BCDUSB_INDEX: INTEGER := 0;
	EQUALS_DEVICE_QUALIFIER_BCDUSB_COUNT: INTEGER := 0;
	EQUALS_DEVICE_QUALIFIER_BDEVICECLASS_INDEX: INTEGER := 0;
	EQUALS_DEVICE_QUALIFIER_BDEVICECLASS_COUNT: INTEGER := 0;
	EQUALS_DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX: INTEGER := 0;
	EQUALS_DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT: INTEGER := 0;
	EQUALS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX: INTEGER := 0;
	EQUALS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT: INTEGER := 0;
	EQUALS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX: INTEGER := 0;
	EQUALS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT: INTEGER := 0;
	EQUALS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX: INTEGER := 0;
	EQUALS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT: INTEGER := 0;
	EQUALS_DEVICE_QUALIFIER_BRESERVED_INDEX: INTEGER := 0;
	EQUALS_DEVICE_QUALIFIER_BRESERVED_COUNT: INTEGER := 0;
	EQUALS_CONFIGURATION_BLENGTH_INDEX: INTEGER := 0;
	EQUALS_CONFIGURATION_BLENGTH_COUNT: INTEGER := 0;
	EQUALS_CONFIGURATION_WTOTALLENGTH_INDEX: INTEGER := 0;
	EQUALS_CONFIGURATION_WTOTALLENGTH_COUNT: INTEGER := 0;
	EQUALS_CONFIGURATION_BNUMINTERFACES_INDEX: INTEGER := 0;
	EQUALS_CONFIGURATION_BNUMINTERFACES_COUNT: INTEGER := 0;
	EQUALS_CONFIGURATION_BCONFIGURATIONVALUE_INDEX: INTEGER := 0;
	EQUALS_CONFIGURATION_BCONFIGURATIONVALUE_COUNT: INTEGER := 0;
	EQUALS_CONFIGURATION_BMATTRIBUTES_INDEX: INTEGER := 0;
	EQUALS_CONFIGURATION_BMATTRIBUTES_COUNT: INTEGER := 0;
	EQUALS_CONFIGURATION_BMAXPOWER_INDEX: INTEGER := 0;
	EQUALS_CONFIGURATION_BMAXPOWER_COUNT: INTEGER := 0;
	EQUALS_OTHER_SPEED_BLENGTH_INDEX: INTEGER := 0;
	EQUALS_OTHER_SPEED_BLENGTH_COUNT: INTEGER := 0;
	EQUALS_OTHER_SPEED_WTOTALLENGTH_INDEX: INTEGER := 0;
	EQUALS_OTHER_SPEED_WTOTALLENGTH_COUNT: INTEGER := 0;
	EQUALS_OTHER_SPEED_BNUMINTERFACES_INDEX: INTEGER := 0;
	EQUALS_OTHER_SPEED_BNUMINTERFACES_COUNT: INTEGER := 0;
	EQUALS_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX: INTEGER := 0;
	EQUALS_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT: INTEGER := 0;
	EQUALS_OTHER_SPEED_BMATTRIBUTES_INDEX: INTEGER := 0;
	EQUALS_OTHER_SPEED_BMATTRIBUTES_COUNT: INTEGER := 0;
	EQUALS_OTHER_SPEED_BMAXPOWER_INDEX: INTEGER := 0;
	EQUALS_OTHER_SPEED_BMAXPOWER_COUNT: INTEGER := 0;
	EQUALS_INTERFACE_BLENGTH_INDEX: INTEGER := 0;
	EQUALS_INTERFACE_BLENGTH_COUNT: INTEGER := 0;
	EQUALS_INTERFACE_BINTERFACENUMBER_INDEX: INTEGER := 0;
	EQUALS_INTERFACE_BINTERFACENUMBER_COUNT: INTEGER := 0;
	EQUALS_INTERFACE_BALTERNATESETTING_INDEX: INTEGER := 0;
	EQUALS_INTERFACE_BALTERNATESETTING_COUNT: INTEGER := 0;
	EQUALS_INTERFACE_BNUMENDPOINTS_INDEX: INTEGER := 0;
	EQUALS_INTERFACE_BNUMENDPOINTS_COUNT: INTEGER := 0;
	EQUALS_INTERFACE_BINTERFACECLASS_INDEX: INTEGER := 0;
	EQUALS_INTERFACE_BINTERFACECLASS_COUNT: INTEGER := 0;
	EQUALS_INTERFACE_BINTERFACESUBCLASS_INDEX: INTEGER := 0;
	EQUALS_INTERFACE_BINTERFACESUBCLASS_COUNT: INTEGER := 0;
	EQUALS_INTERFACE_BINTERFACEPROTOCOL_INDEX: INTEGER := 0;
	EQUALS_INTERFACE_BINTERFACEPROTOCOL_COUNT: INTEGER := 0;
	EQUALS_ENDPOINT_BLENGTH_INDEX: INTEGER := 0;
	EQUALS_ENDPOINT_BLENGTH_COUNT: INTEGER := 0;
	EQUALS_ENDPOINT_BENDPOINTADDRESS_INDEX: INTEGER := 0;
	EQUALS_ENDPOINT_BENDPOINTADDRESS_COUNT: INTEGER := 0;
	EQUALS_ENDPOINT_BMATTRIBUTES_INDEX: INTEGER := 0;
	EQUALS_ENDPOINT_BMATTRIBUTES_COUNT: INTEGER := 0;
	EQUALS_ENDPOINT_WMAXPACKETSIZE_INDEX: INTEGER := 0;
	EQUALS_ENDPOINT_WMAXPACKETSIZE_COUNT: INTEGER := 0;
	EQUALS_ENDPOINT_BINTERVAL_INDEX: INTEGER := 0;
	EQUALS_ENDPOINT_BINTERVAL_COUNT: INTEGER := 0;
	EQUALS_HID_BLENGTH_INDEX: INTEGER := 0;
	EQUALS_HID_BLENGTH_COUNT: INTEGER := 0;
	EQUALS_HID_BCDHID_INDEX: INTEGER := 0;
	EQUALS_HID_BCDHID_COUNT: INTEGER := 0;
	EQUALS_HID_BCOUNTRYCODE_INDEX: INTEGER := 0;
	EQUALS_HID_BCOUNTRYCODE_COUNT: INTEGER := 0;
	EQUALS_HID_BNUMDESCRIPTORS_INDEX: INTEGER := 0;
	EQUALS_HID_BNUMDESCRIPTORS_COUNT: INTEGER := 0;
	EQUALS_HID_BDESCRIPTORTYPE_INDEX: INTEGER := 0;
	EQUALS_HID_BDESCRIPTORTYPE_COUNT: INTEGER := 0;
	EQUALS_HID_WDESCRIPTORLENGTH_INDEX: INTEGER := 0;
	EQUALS_HID_WDESCRIPTORLENGTH_COUNT: INTEGER := 0;
	EQUALS_STRING_BLENGTH_INDEX: INTEGER := 0;
	EQUALS_STRING_BLENGTH_COUNT: INTEGER := 0;
	EQUALS_STRING_IMANUFACTURER_INDEX: INTEGER := 0;
	EQUALS_STRING_IMANUFACTURER_COUNT: INTEGER := 0;
	EQUALS_STRING_IPRODUCT_INDEX: INTEGER := 0;
	EQUALS_STRING_IPRODUCT_COUNT: INTEGER := 0;
	EQUALS_STRING_ISERIALNUMBER_INDEX: INTEGER := 0;
	EQUALS_STRING_ISERIALNUMBER_COUNT: INTEGER := 0;
	EQUALS_STRING_ICONFIGURATION_INDEX: INTEGER := 0;
	EQUALS_STRING_ICONFIGURATION_COUNT: INTEGER := 0;
	EQUALS_STRING_IINTERFACE_INDEX: INTEGER := 0;
	EQUALS_STRING_IINTERFACE_COUNT: INTEGER := 0;

	NOT_EQUALS_MEMORY_ADDR_LENGTH: INTEGER := 1;
	NOT_EQUALS_MEMORY_ADDR_MAX_INDEX: INTEGER := 0;
	NOT_EQUALS_MEMORY_ADDR_MAX_COUNT: INTEGER := 0; 
	NOT_EQUALS_DEVICE_BLENGTH_INDEX: INTEGER := 0;
	NOT_EQUALS_DEVICE_BLENGTH_COUNT: INTEGER := 0;
	NOT_EQUALS_DEVICE_BCDUSB_INDEX: INTEGER := 0;
	NOT_EQUALS_DEVICE_BCDUSB_COUNT: INTEGER := 0;
	NOT_EQUALS_DEVICE_BDEVICECLASS_INDEX: INTEGER := 0;
	NOT_EQUALS_DEVICE_BDEVICECLASS_COUNT: INTEGER := 0;
	NOT_EQUALS_DEVICE_BDEVICESUBCLASS_INDEX: INTEGER := 0;
	NOT_EQUALS_DEVICE_BDEVICESUBCLASS_COUNT: INTEGER := 0;
	NOT_EQUALS_DEVICE_BDEVICEPROTOCOL_INDEX: INTEGER := 0;
	NOT_EQUALS_DEVICE_BDEVICEPROTOCOL_COUNT: INTEGER := 0;
	NOT_EQUALS_DEVICE_BMAXPACKETSIZE0_INDEX: INTEGER := 0;
	NOT_EQUALS_DEVICE_BMAXPACKETSIZE0_COUNT: INTEGER := 0;
	NOT_EQUALS_DEVICE_IDVENDOR_INDEX: INTEGER := 0;
	NOT_EQUALS_DEVICE_IDVENDOR_COUNT: INTEGER := 0;
	NOT_EQUALS_DEVICE_IDPRODUCT_INDEX: INTEGER := 0;
	NOT_EQUALS_DEVICE_IDPRODUCT_COUNT: INTEGER := 0;
	NOT_EQUALS_DEVICE_BCDDEVICE_INDEX: INTEGER := 0;
	NOT_EQUALS_DEVICE_BCDDEVICE_COUNT: INTEGER := 0;
	NOT_EQUALS_DEVICE_BNUMCONFIGURATIONS_INDEX: INTEGER := 0;
	NOT_EQUALS_DEVICE_BNUMCONFIGURATIONS_COUNT: INTEGER := 0;
	NOT_EQUALS_DEVICE_QUALIFIER_BLENGTH_INDEX: INTEGER := 0;
	NOT_EQUALS_DEVICE_QUALIFIER_BLENGTH_COUNT: INTEGER := 0;
	NOT_EQUALS_DEVICE_QUALIFIER_BCDUSB_INDEX: INTEGER := 0;
	NOT_EQUALS_DEVICE_QUALIFIER_BCDUSB_COUNT: INTEGER := 0;
	NOT_EQUALS_DEVICE_QUALIFIER_BDEVICECLASS_INDEX: INTEGER := 0;
	NOT_EQUALS_DEVICE_QUALIFIER_BDEVICECLASS_COUNT: INTEGER := 0;
	NOT_EQUALS_DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX: INTEGER := 0;
	NOT_EQUALS_DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT: INTEGER := 0;
	NOT_EQUALS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX: INTEGER := 0;
	NOT_EQUALS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT: INTEGER := 0;
	NOT_EQUALS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX: INTEGER := 0;
	NOT_EQUALS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT: INTEGER := 0;
	NOT_EQUALS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX: INTEGER := 0;
	NOT_EQUALS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT: INTEGER := 0;
	NOT_EQUALS_DEVICE_QUALIFIER_BRESERVED_INDEX: INTEGER := 0;
	NOT_EQUALS_DEVICE_QUALIFIER_BRESERVED_COUNT: INTEGER := 0;
	NOT_EQUALS_CONFIGURATION_BLENGTH_INDEX: INTEGER := 0;
	NOT_EQUALS_CONFIGURATION_BLENGTH_COUNT: INTEGER := 0;
	NOT_EQUALS_CONFIGURATION_WTOTALLENGTH_INDEX: INTEGER := 0;
	NOT_EQUALS_CONFIGURATION_WTOTALLENGTH_COUNT: INTEGER := 0;
	NOT_EQUALS_CONFIGURATION_BNUMINTERFACES_INDEX: INTEGER := 0;
	NOT_EQUALS_CONFIGURATION_BNUMINTERFACES_COUNT: INTEGER := 0;
	NOT_EQUALS_CONFIGURATION_BCONFIGURATIONVALUE_INDEX: INTEGER := 0;
	NOT_EQUALS_CONFIGURATION_BCONFIGURATIONVALUE_COUNT: INTEGER := 0;
	NOT_EQUALS_CONFIGURATION_BMATTRIBUTES_INDEX: INTEGER := 0;
	NOT_EQUALS_CONFIGURATION_BMATTRIBUTES_COUNT: INTEGER := 0;
	NOT_EQUALS_CONFIGURATION_BMAXPOWER_INDEX: INTEGER := 0;
	NOT_EQUALS_CONFIGURATION_BMAXPOWER_COUNT: INTEGER := 0;
	NOT_EQUALS_OTHER_SPEED_BLENGTH_INDEX: INTEGER := 0;
	NOT_EQUALS_OTHER_SPEED_BLENGTH_COUNT: INTEGER := 0;
	NOT_EQUALS_OTHER_SPEED_WTOTALLENGTH_INDEX: INTEGER := 0;
	NOT_EQUALS_OTHER_SPEED_WTOTALLENGTH_COUNT: INTEGER := 0;
	NOT_EQUALS_OTHER_SPEED_BNUMINTERFACES_INDEX: INTEGER := 0;
	NOT_EQUALS_OTHER_SPEED_BNUMINTERFACES_COUNT: INTEGER := 0;
	NOT_EQUALS_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX: INTEGER := 0;
	NOT_EQUALS_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT: INTEGER := 0;
	NOT_EQUALS_OTHER_SPEED_BMATTRIBUTES_INDEX: INTEGER := 0;
	NOT_EQUALS_OTHER_SPEED_BMATTRIBUTES_COUNT: INTEGER := 0;
	NOT_EQUALS_OTHER_SPEED_BMAXPOWER_INDEX: INTEGER := 0;
	NOT_EQUALS_OTHER_SPEED_BMAXPOWER_COUNT: INTEGER := 0;
	NOT_EQUALS_INTERFACE_BLENGTH_INDEX: INTEGER := 0;
	NOT_EQUALS_INTERFACE_BLENGTH_COUNT: INTEGER := 0;
	NOT_EQUALS_INTERFACE_BINTERFACENUMBER_INDEX: INTEGER := 0;
	NOT_EQUALS_INTERFACE_BINTERFACENUMBER_COUNT: INTEGER := 0;
	NOT_EQUALS_INTERFACE_BALTERNATESETTING_INDEX: INTEGER := 0;
	NOT_EQUALS_INTERFACE_BALTERNATESETTING_COUNT: INTEGER := 0;
	NOT_EQUALS_INTERFACE_BNUMENDPOINTS_INDEX: INTEGER := 0;
	NOT_EQUALS_INTERFACE_BNUMENDPOINTS_COUNT: INTEGER := 0;
	NOT_EQUALS_INTERFACE_BINTERFACECLASS_INDEX: INTEGER := 0;
	NOT_EQUALS_INTERFACE_BINTERFACECLASS_COUNT: INTEGER := 0;
	NOT_EQUALS_INTERFACE_BINTERFACESUBCLASS_INDEX: INTEGER := 0;
	NOT_EQUALS_INTERFACE_BINTERFACESUBCLASS_COUNT: INTEGER := 0;
	NOT_EQUALS_INTERFACE_BINTERFACEPROTOCOL_INDEX: INTEGER := 0;
	NOT_EQUALS_INTERFACE_BINTERFACEPROTOCOL_COUNT: INTEGER := 0;
	NOT_EQUALS_ENDPOINT_BLENGTH_INDEX: INTEGER := 0;
	NOT_EQUALS_ENDPOINT_BLENGTH_COUNT: INTEGER := 0;
	NOT_EQUALS_ENDPOINT_BENDPOINTADDRESS_INDEX: INTEGER := 0;
	NOT_EQUALS_ENDPOINT_BENDPOINTADDRESS_COUNT: INTEGER := 0;
	NOT_EQUALS_ENDPOINT_BMATTRIBUTES_INDEX: INTEGER := 0;
	NOT_EQUALS_ENDPOINT_BMATTRIBUTES_COUNT: INTEGER := 0;
	NOT_EQUALS_ENDPOINT_WMAXPACKETSIZE_INDEX: INTEGER := 0;
	NOT_EQUALS_ENDPOINT_WMAXPACKETSIZE_COUNT: INTEGER := 0;
	NOT_EQUALS_ENDPOINT_BINTERVAL_INDEX: INTEGER := 0;
	NOT_EQUALS_ENDPOINT_BINTERVAL_COUNT: INTEGER := 0;
	NOT_EQUALS_HID_BLENGTH_INDEX: INTEGER := 0;
	NOT_EQUALS_HID_BLENGTH_COUNT: INTEGER := 0;
	NOT_EQUALS_HID_BCDHID_INDEX: INTEGER := 0;
	NOT_EQUALS_HID_BCDHID_COUNT: INTEGER := 0;
	NOT_EQUALS_HID_BCOUNTRYCODE_INDEX: INTEGER := 0;
	NOT_EQUALS_HID_BCOUNTRYCODE_COUNT: INTEGER := 0;
	NOT_EQUALS_HID_BNUMDESCRIPTORS_INDEX: INTEGER := 0;
	NOT_EQUALS_HID_BNUMDESCRIPTORS_COUNT: INTEGER := 0;
	NOT_EQUALS_HID_BDESCRIPTORTYPE_INDEX: INTEGER := 0;
	NOT_EQUALS_HID_BDESCRIPTORTYPE_COUNT: INTEGER := 0;
	NOT_EQUALS_HID_WDESCRIPTORLENGTH_INDEX: INTEGER := 0;
	NOT_EQUALS_HID_WDESCRIPTORLENGTH_COUNT: INTEGER := 0;
	NOT_EQUALS_STRING_BLENGTH_INDEX: INTEGER := 0;
	NOT_EQUALS_STRING_BLENGTH_COUNT: INTEGER := 0;
	NOT_EQUALS_STRING_IMANUFACTURER_INDEX: INTEGER := 0;
	NOT_EQUALS_STRING_IMANUFACTURER_COUNT: INTEGER := 0;
	NOT_EQUALS_STRING_IPRODUCT_INDEX: INTEGER := 0;
	NOT_EQUALS_STRING_IPRODUCT_COUNT: INTEGER := 0;
	NOT_EQUALS_STRING_ISERIALNUMBER_INDEX: INTEGER := 0;
	NOT_EQUALS_STRING_ISERIALNUMBER_COUNT: INTEGER := 0;
	NOT_EQUALS_STRING_ICONFIGURATION_INDEX: INTEGER := 0;
	NOT_EQUALS_STRING_ICONFIGURATION_COUNT: INTEGER := 0;
	NOT_EQUALS_STRING_IINTERFACE_INDEX: INTEGER := 0;
	NOT_EQUALS_STRING_IINTERFACE_COUNT: INTEGER := 0;

	GREATER_MEMORY_ADDR_LENGTH: INTEGER := 1;
	GREATER_MEMORY_ADDR_MAX_INDEX: INTEGER := 0;
	GREATER_MEMORY_ADDR_MAX_COUNT: INTEGER := 0; 
	GREATER_DEVICE_BLENGTH_INDEX: INTEGER := 0;
	GREATER_DEVICE_BLENGTH_COUNT: INTEGER := 0;
	GREATER_DEVICE_BCDUSB_INDEX: INTEGER := 0;
	GREATER_DEVICE_BCDUSB_COUNT: INTEGER := 0;
	GREATER_DEVICE_BDEVICECLASS_INDEX: INTEGER := 0;
	GREATER_DEVICE_BDEVICECLASS_COUNT: INTEGER := 0;
	GREATER_DEVICE_BDEVICESUBCLASS_INDEX: INTEGER := 0;
	GREATER_DEVICE_BDEVICESUBCLASS_COUNT: INTEGER := 0;
	GREATER_DEVICE_BDEVICEPROTOCOL_INDEX: INTEGER := 0;
	GREATER_DEVICE_BDEVICEPROTOCOL_COUNT: INTEGER := 0;
	GREATER_DEVICE_BMAXPACKETSIZE0_INDEX: INTEGER := 0;
	GREATER_DEVICE_BMAXPACKETSIZE0_COUNT: INTEGER := 0;
	GREATER_DEVICE_IDVENDOR_INDEX: INTEGER := 0;
	GREATER_DEVICE_IDVENDOR_COUNT: INTEGER := 0;
	GREATER_DEVICE_IDPRODUCT_INDEX: INTEGER := 0;
	GREATER_DEVICE_IDPRODUCT_COUNT: INTEGER := 0;
	GREATER_DEVICE_BCDDEVICE_INDEX: INTEGER := 0;
	GREATER_DEVICE_BCDDEVICE_COUNT: INTEGER := 0;
	GREATER_DEVICE_BNUMCONFIGURATIONS_INDEX: INTEGER := 0;
	GREATER_DEVICE_BNUMCONFIGURATIONS_COUNT: INTEGER := 0;
	GREATER_DEVICE_QUALIFIER_BLENGTH_INDEX: INTEGER := 0;
	GREATER_DEVICE_QUALIFIER_BLENGTH_COUNT: INTEGER := 0;
	GREATER_DEVICE_QUALIFIER_BCDUSB_INDEX: INTEGER := 0;
	GREATER_DEVICE_QUALIFIER_BCDUSB_COUNT: INTEGER := 0;
	GREATER_DEVICE_QUALIFIER_BDEVICECLASS_INDEX: INTEGER := 0;
	GREATER_DEVICE_QUALIFIER_BDEVICECLASS_COUNT: INTEGER := 0;
	GREATER_DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX: INTEGER := 0;
	GREATER_DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT: INTEGER := 0;
	GREATER_DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX: INTEGER := 0;
	GREATER_DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT: INTEGER := 0;
	GREATER_DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX: INTEGER := 0;
	GREATER_DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT: INTEGER := 0;
	GREATER_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX: INTEGER := 0;
	GREATER_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT: INTEGER := 0;
	GREATER_DEVICE_QUALIFIER_BRESERVED_INDEX: INTEGER := 0;
	GREATER_DEVICE_QUALIFIER_BRESERVED_COUNT: INTEGER := 0;
	GREATER_CONFIGURATION_BLENGTH_INDEX: INTEGER := 0;
	GREATER_CONFIGURATION_BLENGTH_COUNT: INTEGER := 0;
	GREATER_CONFIGURATION_WTOTALLENGTH_INDEX: INTEGER := 0;
	GREATER_CONFIGURATION_WTOTALLENGTH_COUNT: INTEGER := 0;
	GREATER_CONFIGURATION_BNUMINTERFACES_INDEX: INTEGER := 0;
	GREATER_CONFIGURATION_BNUMINTERFACES_COUNT: INTEGER := 0;
	GREATER_CONFIGURATION_BCONFIGURATIONVALUE_INDEX: INTEGER := 0;
	GREATER_CONFIGURATION_BCONFIGURATIONVALUE_COUNT: INTEGER := 0;
	GREATER_CONFIGURATION_BMATTRIBUTES_INDEX: INTEGER := 0;
	GREATER_CONFIGURATION_BMATTRIBUTES_COUNT: INTEGER := 0;
	GREATER_CONFIGURATION_BMAXPOWER_INDEX: INTEGER := 0;
	GREATER_CONFIGURATION_BMAXPOWER_COUNT: INTEGER := 0;
	GREATER_OTHER_SPEED_BLENGTH_INDEX: INTEGER := 0;
	GREATER_OTHER_SPEED_BLENGTH_COUNT: INTEGER := 0;
	GREATER_OTHER_SPEED_WTOTALLENGTH_INDEX: INTEGER := 0;
	GREATER_OTHER_SPEED_WTOTALLENGTH_COUNT: INTEGER := 0;
	GREATER_OTHER_SPEED_BNUMINTERFACES_INDEX: INTEGER := 0;
	GREATER_OTHER_SPEED_BNUMINTERFACES_COUNT: INTEGER := 0;
	GREATER_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX: INTEGER := 0;
	GREATER_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT: INTEGER := 0;
	GREATER_OTHER_SPEED_BMATTRIBUTES_INDEX: INTEGER := 0;
	GREATER_OTHER_SPEED_BMATTRIBUTES_COUNT: INTEGER := 0;
	GREATER_OTHER_SPEED_BMAXPOWER_INDEX: INTEGER := 0;
	GREATER_OTHER_SPEED_BMAXPOWER_COUNT: INTEGER := 0;
	GREATER_INTERFACE_BLENGTH_INDEX: INTEGER := 0;
	GREATER_INTERFACE_BLENGTH_COUNT: INTEGER := 0;
	GREATER_INTERFACE_BINTERFACENUMBER_INDEX: INTEGER := 0;
	GREATER_INTERFACE_BINTERFACENUMBER_COUNT: INTEGER := 0;
	GREATER_INTERFACE_BALTERNATESETTING_INDEX: INTEGER := 0;
	GREATER_INTERFACE_BALTERNATESETTING_COUNT: INTEGER := 0;
	GREATER_INTERFACE_BNUMENDPOINTS_INDEX: INTEGER := 0;
	GREATER_INTERFACE_BNUMENDPOINTS_COUNT: INTEGER := 0;
	GREATER_INTERFACE_BINTERFACECLASS_INDEX: INTEGER := 0;
	GREATER_INTERFACE_BINTERFACECLASS_COUNT: INTEGER := 0;
	GREATER_INTERFACE_BINTERFACESUBCLASS_INDEX: INTEGER := 0;
	GREATER_INTERFACE_BINTERFACESUBCLASS_COUNT: INTEGER := 0;
	GREATER_INTERFACE_BINTERFACEPROTOCOL_INDEX: INTEGER := 0;
	GREATER_INTERFACE_BINTERFACEPROTOCOL_COUNT: INTEGER := 0;
	GREATER_ENDPOINT_BLENGTH_INDEX: INTEGER := 0;
	GREATER_ENDPOINT_BLENGTH_COUNT: INTEGER := 0;
	GREATER_ENDPOINT_BENDPOINTADDRESS_INDEX: INTEGER := 0;
	GREATER_ENDPOINT_BENDPOINTADDRESS_COUNT: INTEGER := 0;
	GREATER_ENDPOINT_BMATTRIBUTES_INDEX: INTEGER := 0;
	GREATER_ENDPOINT_BMATTRIBUTES_COUNT: INTEGER := 0;
	GREATER_ENDPOINT_WMAXPACKETSIZE_INDEX: INTEGER := 0;
	GREATER_ENDPOINT_WMAXPACKETSIZE_COUNT: INTEGER := 0;
	GREATER_ENDPOINT_BINTERVAL_INDEX: INTEGER := 0;
	GREATER_ENDPOINT_BINTERVAL_COUNT: INTEGER := 0;
	GREATER_HID_BLENGTH_INDEX: INTEGER := 0;
	GREATER_HID_BLENGTH_COUNT: INTEGER := 0;
	GREATER_HID_BCDHID_INDEX: INTEGER := 0;
	GREATER_HID_BCDHID_COUNT: INTEGER := 0;
	GREATER_HID_BCOUNTRYCODE_INDEX: INTEGER := 0;
	GREATER_HID_BCOUNTRYCODE_COUNT: INTEGER := 0;
	GREATER_HID_BNUMDESCRIPTORS_INDEX: INTEGER := 0;
	GREATER_HID_BNUMDESCRIPTORS_COUNT: INTEGER := 0;
	GREATER_HID_BDESCRIPTORTYPE_INDEX: INTEGER := 0;
	GREATER_HID_BDESCRIPTORTYPE_COUNT: INTEGER := 0;
	GREATER_HID_WDESCRIPTORLENGTH_INDEX: INTEGER := 0;
	GREATER_HID_WDESCRIPTORLENGTH_COUNT: INTEGER := 0;
	GREATER_STRING_BLENGTH_INDEX: INTEGER := 0;
	GREATER_STRING_BLENGTH_COUNT: INTEGER := 0;
	GREATER_STRING_IMANUFACTURER_INDEX: INTEGER := 0;
	GREATER_STRING_IMANUFACTURER_COUNT: INTEGER := 0;
	GREATER_STRING_IPRODUCT_INDEX: INTEGER := 0;
	GREATER_STRING_IPRODUCT_COUNT: INTEGER := 0;
	GREATER_STRING_ISERIALNUMBER_INDEX: INTEGER := 0;
	GREATER_STRING_ISERIALNUMBER_COUNT: INTEGER := 0;
	GREATER_STRING_ICONFIGURATION_INDEX: INTEGER := 0;
	GREATER_STRING_ICONFIGURATION_COUNT: INTEGER := 0;
	GREATER_STRING_IINTERFACE_INDEX: INTEGER := 0;
	GREATER_STRING_IINTERFACE_COUNT: INTEGER := 0;

	GREATER_EQUALS_MEMORY_ADDR_LENGTH: INTEGER := 1;
	GREATER_EQUALS_MEMORY_ADDR_MAX_INDEX: INTEGER := 0;
	GREATER_EQUALS_MEMORY_ADDR_MAX_COUNT: INTEGER := 0; 
	GREATER_EQUALS_DEVICE_BLENGTH_INDEX: INTEGER := 0;
	GREATER_EQUALS_DEVICE_BLENGTH_COUNT: INTEGER := 0;
	GREATER_EQUALS_DEVICE_BCDUSB_INDEX: INTEGER := 0;
	GREATER_EQUALS_DEVICE_BCDUSB_COUNT: INTEGER := 0;
	GREATER_EQUALS_DEVICE_BDEVICECLASS_INDEX: INTEGER := 0;
	GREATER_EQUALS_DEVICE_BDEVICECLASS_COUNT: INTEGER := 0;
	GREATER_EQUALS_DEVICE_BDEVICESUBCLASS_INDEX: INTEGER := 0;
	GREATER_EQUALS_DEVICE_BDEVICESUBCLASS_COUNT: INTEGER := 0;
	GREATER_EQUALS_DEVICE_BDEVICEPROTOCOL_INDEX: INTEGER := 0;
	GREATER_EQUALS_DEVICE_BDEVICEPROTOCOL_COUNT: INTEGER := 0;
	GREATER_EQUALS_DEVICE_BMAXPACKETSIZE0_INDEX: INTEGER := 0;
	GREATER_EQUALS_DEVICE_BMAXPACKETSIZE0_COUNT: INTEGER := 0;
	GREATER_EQUALS_DEVICE_IDVENDOR_INDEX: INTEGER := 0;
	GREATER_EQUALS_DEVICE_IDVENDOR_COUNT: INTEGER := 0;
	GREATER_EQUALS_DEVICE_IDPRODUCT_INDEX: INTEGER := 0;
	GREATER_EQUALS_DEVICE_IDPRODUCT_COUNT: INTEGER := 0;
	GREATER_EQUALS_DEVICE_BCDDEVICE_INDEX: INTEGER := 0;
	GREATER_EQUALS_DEVICE_BCDDEVICE_COUNT: INTEGER := 0;
	GREATER_EQUALS_DEVICE_BNUMCONFIGURATIONS_INDEX: INTEGER := 0;
	GREATER_EQUALS_DEVICE_BNUMCONFIGURATIONS_COUNT: INTEGER := 0;
	GREATER_EQUALS_DEVICE_QUALIFIER_BLENGTH_INDEX: INTEGER := 0;
	GREATER_EQUALS_DEVICE_QUALIFIER_BLENGTH_COUNT: INTEGER := 0;
	GREATER_EQUALS_DEVICE_QUALIFIER_BCDUSB_INDEX: INTEGER := 0;
	GREATER_EQUALS_DEVICE_QUALIFIER_BCDUSB_COUNT: INTEGER := 0;
	GREATER_EQUALS_DEVICE_QUALIFIER_BDEVICECLASS_INDEX: INTEGER := 0;
	GREATER_EQUALS_DEVICE_QUALIFIER_BDEVICECLASS_COUNT: INTEGER := 0;
	GREATER_EQUALS_DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX: INTEGER := 0;
	GREATER_EQUALS_DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT: INTEGER := 0;
	GREATER_EQUALS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX: INTEGER := 0;
	GREATER_EQUALS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT: INTEGER := 0;
	GREATER_EQUALS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX: INTEGER := 0;
	GREATER_EQUALS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT: INTEGER := 0;
	GREATER_EQUALS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX: INTEGER := 0;
	GREATER_EQUALS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT: INTEGER := 0;
	GREATER_EQUALS_DEVICE_QUALIFIER_BRESERVED_INDEX: INTEGER := 0;
	GREATER_EQUALS_DEVICE_QUALIFIER_BRESERVED_COUNT: INTEGER := 0;
	GREATER_EQUALS_CONFIGURATION_BLENGTH_INDEX: INTEGER := 0;
	GREATER_EQUALS_CONFIGURATION_BLENGTH_COUNT: INTEGER := 0;
	GREATER_EQUALS_CONFIGURATION_WTOTALLENGTH_INDEX: INTEGER := 0;
	GREATER_EQUALS_CONFIGURATION_WTOTALLENGTH_COUNT: INTEGER := 0;
	GREATER_EQUALS_CONFIGURATION_BNUMINTERFACES_INDEX: INTEGER := 0;
	GREATER_EQUALS_CONFIGURATION_BNUMINTERFACES_COUNT: INTEGER := 0;
	GREATER_EQUALS_CONFIGURATION_BCONFIGURATIONVALUE_INDEX: INTEGER := 0;
	GREATER_EQUALS_CONFIGURATION_BCONFIGURATIONVALUE_COUNT: INTEGER := 0;
	GREATER_EQUALS_CONFIGURATION_BMATTRIBUTES_INDEX: INTEGER := 0;
	GREATER_EQUALS_CONFIGURATION_BMATTRIBUTES_COUNT: INTEGER := 0;
	GREATER_EQUALS_CONFIGURATION_BMAXPOWER_INDEX: INTEGER := 0;
	GREATER_EQUALS_CONFIGURATION_BMAXPOWER_COUNT: INTEGER := 0;
	GREATER_EQUALS_OTHER_SPEED_BLENGTH_INDEX: INTEGER := 0;
	GREATER_EQUALS_OTHER_SPEED_BLENGTH_COUNT: INTEGER := 0;
	GREATER_EQUALS_OTHER_SPEED_WTOTALLENGTH_INDEX: INTEGER := 0;
	GREATER_EQUALS_OTHER_SPEED_WTOTALLENGTH_COUNT: INTEGER := 0;
	GREATER_EQUALS_OTHER_SPEED_BNUMINTERFACES_INDEX: INTEGER := 0;
	GREATER_EQUALS_OTHER_SPEED_BNUMINTERFACES_COUNT: INTEGER := 0;
	GREATER_EQUALS_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX: INTEGER := 0;
	GREATER_EQUALS_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT: INTEGER := 0;
	GREATER_EQUALS_OTHER_SPEED_BMATTRIBUTES_INDEX: INTEGER := 0;
	GREATER_EQUALS_OTHER_SPEED_BMATTRIBUTES_COUNT: INTEGER := 0;
	GREATER_EQUALS_OTHER_SPEED_BMAXPOWER_INDEX: INTEGER := 0;
	GREATER_EQUALS_OTHER_SPEED_BMAXPOWER_COUNT: INTEGER := 0;
	GREATER_EQUALS_INTERFACE_BLENGTH_INDEX: INTEGER := 0;
	GREATER_EQUALS_INTERFACE_BLENGTH_COUNT: INTEGER := 0;
	GREATER_EQUALS_INTERFACE_BINTERFACENUMBER_INDEX: INTEGER := 0;
	GREATER_EQUALS_INTERFACE_BINTERFACENUMBER_COUNT: INTEGER := 0;
	GREATER_EQUALS_INTERFACE_BALTERNATESETTING_INDEX: INTEGER := 0;
	GREATER_EQUALS_INTERFACE_BALTERNATESETTING_COUNT: INTEGER := 0;
	GREATER_EQUALS_INTERFACE_BNUMENDPOINTS_INDEX: INTEGER := 0;
	GREATER_EQUALS_INTERFACE_BNUMENDPOINTS_COUNT: INTEGER := 0;
	GREATER_EQUALS_INTERFACE_BINTERFACECLASS_INDEX: INTEGER := 0;
	GREATER_EQUALS_INTERFACE_BINTERFACECLASS_COUNT: INTEGER := 0;
	GREATER_EQUALS_INTERFACE_BINTERFACESUBCLASS_INDEX: INTEGER := 0;
	GREATER_EQUALS_INTERFACE_BINTERFACESUBCLASS_COUNT: INTEGER := 0;
	GREATER_EQUALS_INTERFACE_BINTERFACEPROTOCOL_INDEX: INTEGER := 0;
	GREATER_EQUALS_INTERFACE_BINTERFACEPROTOCOL_COUNT: INTEGER := 0;
	GREATER_EQUALS_ENDPOINT_BLENGTH_INDEX: INTEGER := 0;
	GREATER_EQUALS_ENDPOINT_BLENGTH_COUNT: INTEGER := 0;
	GREATER_EQUALS_ENDPOINT_BENDPOINTADDRESS_INDEX: INTEGER := 0;
	GREATER_EQUALS_ENDPOINT_BENDPOINTADDRESS_COUNT: INTEGER := 0;
	GREATER_EQUALS_ENDPOINT_BMATTRIBUTES_INDEX: INTEGER := 0;
	GREATER_EQUALS_ENDPOINT_BMATTRIBUTES_COUNT: INTEGER := 0;
	GREATER_EQUALS_ENDPOINT_WMAXPACKETSIZE_INDEX: INTEGER := 0;
	GREATER_EQUALS_ENDPOINT_WMAXPACKETSIZE_COUNT: INTEGER := 0;
	GREATER_EQUALS_ENDPOINT_BINTERVAL_INDEX: INTEGER := 0;
	GREATER_EQUALS_ENDPOINT_BINTERVAL_COUNT: INTEGER := 0;
	GREATER_EQUALS_HID_BLENGTH_INDEX: INTEGER := 0;
	GREATER_EQUALS_HID_BLENGTH_COUNT: INTEGER := 0;
	GREATER_EQUALS_HID_BCDHID_INDEX: INTEGER := 0;
	GREATER_EQUALS_HID_BCDHID_COUNT: INTEGER := 0;
	GREATER_EQUALS_HID_BCOUNTRYCODE_INDEX: INTEGER := 0;
	GREATER_EQUALS_HID_BCOUNTRYCODE_COUNT: INTEGER := 0;
	GREATER_EQUALS_HID_BNUMDESCRIPTORS_INDEX: INTEGER := 0;
	GREATER_EQUALS_HID_BNUMDESCRIPTORS_COUNT: INTEGER := 0;
	GREATER_EQUALS_HID_BDESCRIPTORTYPE_INDEX: INTEGER := 0;
	GREATER_EQUALS_HID_BDESCRIPTORTYPE_COUNT: INTEGER := 0;
	GREATER_EQUALS_HID_WDESCRIPTORLENGTH_INDEX: INTEGER := 0;
	GREATER_EQUALS_HID_WDESCRIPTORLENGTH_COUNT: INTEGER := 0;
	GREATER_EQUALS_STRING_BLENGTH_INDEX: INTEGER := 0;
	GREATER_EQUALS_STRING_BLENGTH_COUNT: INTEGER := 0;
	GREATER_EQUALS_STRING_IMANUFACTURER_INDEX: INTEGER := 0;
	GREATER_EQUALS_STRING_IMANUFACTURER_COUNT: INTEGER := 0;
	GREATER_EQUALS_STRING_IPRODUCT_INDEX: INTEGER := 0;
	GREATER_EQUALS_STRING_IPRODUCT_COUNT: INTEGER := 0;
	GREATER_EQUALS_STRING_ISERIALNUMBER_INDEX: INTEGER := 0;
	GREATER_EQUALS_STRING_ISERIALNUMBER_COUNT: INTEGER := 0;
	GREATER_EQUALS_STRING_ICONFIGURATION_INDEX: INTEGER := 0;
	GREATER_EQUALS_STRING_ICONFIGURATION_COUNT: INTEGER := 0;
	GREATER_EQUALS_STRING_IINTERFACE_INDEX: INTEGER := 0;
	GREATER_EQUALS_STRING_IINTERFACE_COUNT: INTEGER := 0;

	LESS_MEMORY_ADDR_LENGTH: INTEGER := 1;
	LESS_MEMORY_ADDR_MAX_INDEX: INTEGER := 0;
	LESS_MEMORY_ADDR_MAX_COUNT: INTEGER := 0; 
	LESS_DEVICE_BLENGTH_INDEX: INTEGER := 0;
	LESS_DEVICE_BLENGTH_COUNT: INTEGER := 0;
	LESS_DEVICE_BCDUSB_INDEX: INTEGER := 0;
	LESS_DEVICE_BCDUSB_COUNT: INTEGER := 0;
	LESS_DEVICE_BDEVICECLASS_INDEX: INTEGER := 0;
	LESS_DEVICE_BDEVICECLASS_COUNT: INTEGER := 0;
	LESS_DEVICE_BDEVICESUBCLASS_INDEX: INTEGER := 0;
	LESS_DEVICE_BDEVICESUBCLASS_COUNT: INTEGER := 0;
	LESS_DEVICE_BDEVICEPROTOCOL_INDEX: INTEGER := 0;
	LESS_DEVICE_BDEVICEPROTOCOL_COUNT: INTEGER := 0;
	LESS_DEVICE_BMAXPACKETSIZE0_INDEX: INTEGER := 0;
	LESS_DEVICE_BMAXPACKETSIZE0_COUNT: INTEGER := 0;
	LESS_DEVICE_IDVENDOR_INDEX: INTEGER := 0;
	LESS_DEVICE_IDVENDOR_COUNT: INTEGER := 0;
	LESS_DEVICE_IDPRODUCT_INDEX: INTEGER := 0;
	LESS_DEVICE_IDPRODUCT_COUNT: INTEGER := 0;
	LESS_DEVICE_BCDDEVICE_INDEX: INTEGER := 0;
	LESS_DEVICE_BCDDEVICE_COUNT: INTEGER := 0;
	LESS_DEVICE_BNUMCONFIGURATIONS_INDEX: INTEGER := 0;
	LESS_DEVICE_BNUMCONFIGURATIONS_COUNT: INTEGER := 0;
	LESS_DEVICE_QUALIFIER_BLENGTH_INDEX: INTEGER := 0;
	LESS_DEVICE_QUALIFIER_BLENGTH_COUNT: INTEGER := 0;
	LESS_DEVICE_QUALIFIER_BCDUSB_INDEX: INTEGER := 0;
	LESS_DEVICE_QUALIFIER_BCDUSB_COUNT: INTEGER := 0;
	LESS_DEVICE_QUALIFIER_BDEVICECLASS_INDEX: INTEGER := 0;
	LESS_DEVICE_QUALIFIER_BDEVICECLASS_COUNT: INTEGER := 0;
	LESS_DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX: INTEGER := 0;
	LESS_DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT: INTEGER := 0;
	LESS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX: INTEGER := 0;
	LESS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT: INTEGER := 0;
	LESS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX: INTEGER := 0;
	LESS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT: INTEGER := 0;
	LESS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX: INTEGER := 0;
	LESS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT: INTEGER := 0;
	LESS_DEVICE_QUALIFIER_BRESERVED_INDEX: INTEGER := 0;
	LESS_DEVICE_QUALIFIER_BRESERVED_COUNT: INTEGER := 0;
	LESS_CONFIGURATION_BLENGTH_INDEX: INTEGER := 0;
	LESS_CONFIGURATION_BLENGTH_COUNT: INTEGER := 0;
	LESS_CONFIGURATION_WTOTALLENGTH_INDEX: INTEGER := 0;
	LESS_CONFIGURATION_WTOTALLENGTH_COUNT: INTEGER := 0;
	LESS_CONFIGURATION_BNUMINTERFACES_INDEX: INTEGER := 0;
	LESS_CONFIGURATION_BNUMINTERFACES_COUNT: INTEGER := 0;
	LESS_CONFIGURATION_BCONFIGURATIONVALUE_INDEX: INTEGER := 0;
	LESS_CONFIGURATION_BCONFIGURATIONVALUE_COUNT: INTEGER := 0;
	LESS_CONFIGURATION_BMATTRIBUTES_INDEX: INTEGER := 0;
	LESS_CONFIGURATION_BMATTRIBUTES_COUNT: INTEGER := 0;
	LESS_CONFIGURATION_BMAXPOWER_INDEX: INTEGER := 0;
	LESS_CONFIGURATION_BMAXPOWER_COUNT: INTEGER := 0;
	LESS_OTHER_SPEED_BLENGTH_INDEX: INTEGER := 0;
	LESS_OTHER_SPEED_BLENGTH_COUNT: INTEGER := 0;
	LESS_OTHER_SPEED_WTOTALLENGTH_INDEX: INTEGER := 0;
	LESS_OTHER_SPEED_WTOTALLENGTH_COUNT: INTEGER := 0;
	LESS_OTHER_SPEED_BNUMINTERFACES_INDEX: INTEGER := 0;
	LESS_OTHER_SPEED_BNUMINTERFACES_COUNT: INTEGER := 0;
	LESS_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX: INTEGER := 0;
	LESS_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT: INTEGER := 0;
	LESS_OTHER_SPEED_BMATTRIBUTES_INDEX: INTEGER := 0;
	LESS_OTHER_SPEED_BMATTRIBUTES_COUNT: INTEGER := 0;
	LESS_OTHER_SPEED_BMAXPOWER_INDEX: INTEGER := 0;
	LESS_OTHER_SPEED_BMAXPOWER_COUNT: INTEGER := 0;
	LESS_INTERFACE_BLENGTH_INDEX: INTEGER := 0;
	LESS_INTERFACE_BLENGTH_COUNT: INTEGER := 0;
	LESS_INTERFACE_BINTERFACENUMBER_INDEX: INTEGER := 0;
	LESS_INTERFACE_BINTERFACENUMBER_COUNT: INTEGER := 0;
	LESS_INTERFACE_BALTERNATESETTING_INDEX: INTEGER := 0;
	LESS_INTERFACE_BALTERNATESETTING_COUNT: INTEGER := 0;
	LESS_INTERFACE_BNUMENDPOINTS_INDEX: INTEGER := 0;
	LESS_INTERFACE_BNUMENDPOINTS_COUNT: INTEGER := 0;
	LESS_INTERFACE_BINTERFACECLASS_INDEX: INTEGER := 0;
	LESS_INTERFACE_BINTERFACECLASS_COUNT: INTEGER := 0;
	LESS_INTERFACE_BINTERFACESUBCLASS_INDEX: INTEGER := 0;
	LESS_INTERFACE_BINTERFACESUBCLASS_COUNT: INTEGER := 0;
	LESS_INTERFACE_BINTERFACEPROTOCOL_INDEX: INTEGER := 0;
	LESS_INTERFACE_BINTERFACEPROTOCOL_COUNT: INTEGER := 0;
	LESS_ENDPOINT_BLENGTH_INDEX: INTEGER := 0;
	LESS_ENDPOINT_BLENGTH_COUNT: INTEGER := 0;
	LESS_ENDPOINT_BENDPOINTADDRESS_INDEX: INTEGER := 0;
	LESS_ENDPOINT_BENDPOINTADDRESS_COUNT: INTEGER := 0;
	LESS_ENDPOINT_BMATTRIBUTES_INDEX: INTEGER := 0;
	LESS_ENDPOINT_BMATTRIBUTES_COUNT: INTEGER := 0;
	LESS_ENDPOINT_WMAXPACKETSIZE_INDEX: INTEGER := 0;
	LESS_ENDPOINT_WMAXPACKETSIZE_COUNT: INTEGER := 0;
	LESS_ENDPOINT_BINTERVAL_INDEX: INTEGER := 0;
	LESS_ENDPOINT_BINTERVAL_COUNT: INTEGER := 0;
	LESS_HID_BLENGTH_INDEX: INTEGER := 0;
	LESS_HID_BLENGTH_COUNT: INTEGER := 0;
	LESS_HID_BCDHID_INDEX: INTEGER := 0;
	LESS_HID_BCDHID_COUNT: INTEGER := 0;
	LESS_HID_BCOUNTRYCODE_INDEX: INTEGER := 0;
	LESS_HID_BCOUNTRYCODE_COUNT: INTEGER := 0;
	LESS_HID_BNUMDESCRIPTORS_INDEX: INTEGER := 0;
	LESS_HID_BNUMDESCRIPTORS_COUNT: INTEGER := 0;
	LESS_HID_BDESCRIPTORTYPE_INDEX: INTEGER := 0;
	LESS_HID_BDESCRIPTORTYPE_COUNT: INTEGER := 0;
	LESS_HID_WDESCRIPTORLENGTH_INDEX: INTEGER := 0;
	LESS_HID_WDESCRIPTORLENGTH_COUNT: INTEGER := 0;
	LESS_STRING_BLENGTH_INDEX: INTEGER := 0;
	LESS_STRING_BLENGTH_COUNT: INTEGER := 0;
	LESS_STRING_IMANUFACTURER_INDEX: INTEGER := 0;
	LESS_STRING_IMANUFACTURER_COUNT: INTEGER := 0;
	LESS_STRING_IPRODUCT_INDEX: INTEGER := 0;
	LESS_STRING_IPRODUCT_COUNT: INTEGER := 0;
	LESS_STRING_ISERIALNUMBER_INDEX: INTEGER := 0;
	LESS_STRING_ISERIALNUMBER_COUNT: INTEGER := 0;
	LESS_STRING_ICONFIGURATION_INDEX: INTEGER := 0;
	LESS_STRING_ICONFIGURATION_COUNT: INTEGER := 0;
	LESS_STRING_IINTERFACE_INDEX: INTEGER := 0;
	LESS_STRING_IINTERFACE_COUNT: INTEGER := 0;

	LESS_EQUALS_MEMORY_ADDR_LENGTH: INTEGER := 1;
	LESS_EQUALS_MEMORY_ADDR_MAX_INDEX: INTEGER := 0;
	LESS_EQUALS_MEMORY_ADDR_MAX_COUNT: INTEGER := 0; 
	LESS_EQUALS_DEVICE_BLENGTH_INDEX: INTEGER := 0;
	LESS_EQUALS_DEVICE_BLENGTH_COUNT: INTEGER := 0;
	LESS_EQUALS_DEVICE_BCDUSB_INDEX: INTEGER := 0;
	LESS_EQUALS_DEVICE_BCDUSB_COUNT: INTEGER := 0;
	LESS_EQUALS_DEVICE_BDEVICECLASS_INDEX: INTEGER := 0;
	LESS_EQUALS_DEVICE_BDEVICECLASS_COUNT: INTEGER := 0;
	LESS_EQUALS_DEVICE_BDEVICESUBCLASS_INDEX: INTEGER := 0;
	LESS_EQUALS_DEVICE_BDEVICESUBCLASS_COUNT: INTEGER := 0;
	LESS_EQUALS_DEVICE_BDEVICEPROTOCOL_INDEX: INTEGER := 0;
	LESS_EQUALS_DEVICE_BDEVICEPROTOCOL_COUNT: INTEGER := 0;
	LESS_EQUALS_DEVICE_BMAXPACKETSIZE0_INDEX: INTEGER := 0;
	LESS_EQUALS_DEVICE_BMAXPACKETSIZE0_COUNT: INTEGER := 0;
	LESS_EQUALS_DEVICE_IDVENDOR_INDEX: INTEGER := 0;
	LESS_EQUALS_DEVICE_IDVENDOR_COUNT: INTEGER := 0;
	LESS_EQUALS_DEVICE_IDPRODUCT_INDEX: INTEGER := 0;
	LESS_EQUALS_DEVICE_IDPRODUCT_COUNT: INTEGER := 0;
	LESS_EQUALS_DEVICE_BCDDEVICE_INDEX: INTEGER := 0;
	LESS_EQUALS_DEVICE_BCDDEVICE_COUNT: INTEGER := 0;
	LESS_EQUALS_DEVICE_BNUMCONFIGURATIONS_INDEX: INTEGER := 0;
	LESS_EQUALS_DEVICE_BNUMCONFIGURATIONS_COUNT: INTEGER := 0;
	LESS_EQUALS_DEVICE_QUALIFIER_BLENGTH_INDEX: INTEGER := 0;
	LESS_EQUALS_DEVICE_QUALIFIER_BLENGTH_COUNT: INTEGER := 0;
	LESS_EQUALS_DEVICE_QUALIFIER_BCDUSB_INDEX: INTEGER := 0;
	LESS_EQUALS_DEVICE_QUALIFIER_BCDUSB_COUNT: INTEGER := 0;
	LESS_EQUALS_DEVICE_QUALIFIER_BDEVICECLASS_INDEX: INTEGER := 0;
	LESS_EQUALS_DEVICE_QUALIFIER_BDEVICECLASS_COUNT: INTEGER := 0;
	LESS_EQUALS_DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX: INTEGER := 0;
	LESS_EQUALS_DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT: INTEGER := 0;
	LESS_EQUALS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX: INTEGER := 0;
	LESS_EQUALS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT: INTEGER := 0;
	LESS_EQUALS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX: INTEGER := 0;
	LESS_EQUALS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT: INTEGER := 0;
	LESS_EQUALS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX: INTEGER := 0;
	LESS_EQUALS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT: INTEGER := 0;
	LESS_EQUALS_DEVICE_QUALIFIER_BRESERVED_INDEX: INTEGER := 0;
	LESS_EQUALS_DEVICE_QUALIFIER_BRESERVED_COUNT: INTEGER := 0;
	LESS_EQUALS_CONFIGURATION_BLENGTH_INDEX: INTEGER := 0;
	LESS_EQUALS_CONFIGURATION_BLENGTH_COUNT: INTEGER := 0;
	LESS_EQUALS_CONFIGURATION_WTOTALLENGTH_INDEX: INTEGER := 0;
	LESS_EQUALS_CONFIGURATION_WTOTALLENGTH_COUNT: INTEGER := 0;
	LESS_EQUALS_CONFIGURATION_BNUMINTERFACES_INDEX: INTEGER := 0;
	LESS_EQUALS_CONFIGURATION_BNUMINTERFACES_COUNT: INTEGER := 0;
	LESS_EQUALS_CONFIGURATION_BCONFIGURATIONVALUE_INDEX: INTEGER := 0;
	LESS_EQUALS_CONFIGURATION_BCONFIGURATIONVALUE_COUNT: INTEGER := 0;
	LESS_EQUALS_CONFIGURATION_BMATTRIBUTES_INDEX: INTEGER := 0;
	LESS_EQUALS_CONFIGURATION_BMATTRIBUTES_COUNT: INTEGER := 0;
	LESS_EQUALS_CONFIGURATION_BMAXPOWER_INDEX: INTEGER := 0;
	LESS_EQUALS_CONFIGURATION_BMAXPOWER_COUNT: INTEGER := 0;
	LESS_EQUALS_OTHER_SPEED_BLENGTH_INDEX: INTEGER := 0;
	LESS_EQUALS_OTHER_SPEED_BLENGTH_COUNT: INTEGER := 0;
	LESS_EQUALS_OTHER_SPEED_WTOTALLENGTH_INDEX: INTEGER := 0;
	LESS_EQUALS_OTHER_SPEED_WTOTALLENGTH_COUNT: INTEGER := 0;
	LESS_EQUALS_OTHER_SPEED_BNUMINTERFACES_INDEX: INTEGER := 0;
	LESS_EQUALS_OTHER_SPEED_BNUMINTERFACES_COUNT: INTEGER := 0;
	LESS_EQUALS_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX: INTEGER := 0;
	LESS_EQUALS_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT: INTEGER := 0;
	LESS_EQUALS_OTHER_SPEED_BMATTRIBUTES_INDEX: INTEGER := 0;
	LESS_EQUALS_OTHER_SPEED_BMATTRIBUTES_COUNT: INTEGER := 0;
	LESS_EQUALS_OTHER_SPEED_BMAXPOWER_INDEX: INTEGER := 0;
	LESS_EQUALS_OTHER_SPEED_BMAXPOWER_COUNT: INTEGER := 0;
	LESS_EQUALS_INTERFACE_BLENGTH_INDEX: INTEGER := 0;
	LESS_EQUALS_INTERFACE_BLENGTH_COUNT: INTEGER := 0;
	LESS_EQUALS_INTERFACE_BINTERFACENUMBER_INDEX: INTEGER := 0;
	LESS_EQUALS_INTERFACE_BINTERFACENUMBER_COUNT: INTEGER := 0;
	LESS_EQUALS_INTERFACE_BALTERNATESETTING_INDEX: INTEGER := 0;
	LESS_EQUALS_INTERFACE_BALTERNATESETTING_COUNT: INTEGER := 0;
	LESS_EQUALS_INTERFACE_BNUMENDPOINTS_INDEX: INTEGER := 0;
	LESS_EQUALS_INTERFACE_BNUMENDPOINTS_COUNT: INTEGER := 0;
	LESS_EQUALS_INTERFACE_BINTERFACECLASS_INDEX: INTEGER := 0;
	LESS_EQUALS_INTERFACE_BINTERFACECLASS_COUNT: INTEGER := 0;
	LESS_EQUALS_INTERFACE_BINTERFACESUBCLASS_INDEX: INTEGER := 0;
	LESS_EQUALS_INTERFACE_BINTERFACESUBCLASS_COUNT: INTEGER := 0;
	LESS_EQUALS_INTERFACE_BINTERFACEPROTOCOL_INDEX: INTEGER := 0;
	LESS_EQUALS_INTERFACE_BINTERFACEPROTOCOL_COUNT: INTEGER := 0;
	LESS_EQUALS_ENDPOINT_BLENGTH_INDEX: INTEGER := 0;
	LESS_EQUALS_ENDPOINT_BLENGTH_COUNT: INTEGER := 0;
	LESS_EQUALS_ENDPOINT_BENDPOINTADDRESS_INDEX: INTEGER := 0;
	LESS_EQUALS_ENDPOINT_BENDPOINTADDRESS_COUNT: INTEGER := 0;
	LESS_EQUALS_ENDPOINT_BMATTRIBUTES_INDEX: INTEGER := 0;
	LESS_EQUALS_ENDPOINT_BMATTRIBUTES_COUNT: INTEGER := 0;
	LESS_EQUALS_ENDPOINT_WMAXPACKETSIZE_INDEX: INTEGER := 0;
	LESS_EQUALS_ENDPOINT_WMAXPACKETSIZE_COUNT: INTEGER := 0;
	LESS_EQUALS_ENDPOINT_BINTERVAL_INDEX: INTEGER := 0;
	LESS_EQUALS_ENDPOINT_BINTERVAL_COUNT: INTEGER := 0;
	LESS_EQUALS_HID_BLENGTH_INDEX: INTEGER := 0;
	LESS_EQUALS_HID_BLENGTH_COUNT: INTEGER := 0;
	LESS_EQUALS_HID_BCDHID_INDEX: INTEGER := 0;
	LESS_EQUALS_HID_BCDHID_COUNT: INTEGER := 0;
	LESS_EQUALS_HID_BCOUNTRYCODE_INDEX: INTEGER := 0;
	LESS_EQUALS_HID_BCOUNTRYCODE_COUNT: INTEGER := 0;
	LESS_EQUALS_HID_BNUMDESCRIPTORS_INDEX: INTEGER := 0;
	LESS_EQUALS_HID_BNUMDESCRIPTORS_COUNT: INTEGER := 0;
	LESS_EQUALS_HID_BDESCRIPTORTYPE_INDEX: INTEGER := 0;
	LESS_EQUALS_HID_BDESCRIPTORTYPE_COUNT: INTEGER := 0;
	LESS_EQUALS_HID_WDESCRIPTORLENGTH_INDEX: INTEGER := 0;
	LESS_EQUALS_HID_WDESCRIPTORLENGTH_COUNT: INTEGER := 0;
	LESS_EQUALS_STRING_BLENGTH_INDEX: INTEGER := 0;
	LESS_EQUALS_STRING_BLENGTH_COUNT: INTEGER := 0;
	LESS_EQUALS_STRING_IMANUFACTURER_INDEX: INTEGER := 0;
	LESS_EQUALS_STRING_IMANUFACTURER_COUNT: INTEGER := 0;
	LESS_EQUALS_STRING_IPRODUCT_INDEX: INTEGER := 0;
	LESS_EQUALS_STRING_IPRODUCT_COUNT: INTEGER := 0;
	LESS_EQUALS_STRING_ISERIALNUMBER_INDEX: INTEGER := 0;
	LESS_EQUALS_STRING_ISERIALNUMBER_COUNT: INTEGER := 0;
	LESS_EQUALS_STRING_ICONFIGURATION_INDEX: INTEGER := 0;
	LESS_EQUALS_STRING_ICONFIGURATION_COUNT: INTEGER := 0;
	LESS_EQUALS_STRING_IINTERFACE_INDEX: INTEGER := 0;
	LESS_EQUALS_STRING_IINTERFACE_COUNT: INTEGER := 0;

	STARTS_WITH_MEMORY_ADDR_LENGTH: INTEGER := 1;
	STARTS_WITH_MEMORY_ADDR_MAX_INDEX: INTEGER := 0;
	STARTS_WITH_MEMORY_ADDR_MAX_COUNT: INTEGER := 0; 
	STARTS_WITH_DEVICE_BLENGTH_INDEX: INTEGER := 0;
	STARTS_WITH_DEVICE_BLENGTH_COUNT: INTEGER := 0;
	STARTS_WITH_DEVICE_BCDUSB_INDEX: INTEGER := 0;
	STARTS_WITH_DEVICE_BCDUSB_COUNT: INTEGER := 0;
	STARTS_WITH_DEVICE_BDEVICECLASS_INDEX: INTEGER := 0;
	STARTS_WITH_DEVICE_BDEVICECLASS_COUNT: INTEGER := 0;
	STARTS_WITH_DEVICE_BDEVICESUBCLASS_INDEX: INTEGER := 0;
	STARTS_WITH_DEVICE_BDEVICESUBCLASS_COUNT: INTEGER := 0;
	STARTS_WITH_DEVICE_BDEVICEPROTOCOL_INDEX: INTEGER := 0;
	STARTS_WITH_DEVICE_BDEVICEPROTOCOL_COUNT: INTEGER := 0;
	STARTS_WITH_DEVICE_BMAXPACKETSIZE0_INDEX: INTEGER := 0;
	STARTS_WITH_DEVICE_BMAXPACKETSIZE0_COUNT: INTEGER := 0;
	STARTS_WITH_DEVICE_IDVENDOR_INDEX: INTEGER := 0;
	STARTS_WITH_DEVICE_IDVENDOR_COUNT: INTEGER := 0;
	STARTS_WITH_DEVICE_IDPRODUCT_INDEX: INTEGER := 0;
	STARTS_WITH_DEVICE_IDPRODUCT_COUNT: INTEGER := 0;
	STARTS_WITH_DEVICE_BCDDEVICE_INDEX: INTEGER := 0;
	STARTS_WITH_DEVICE_BCDDEVICE_COUNT: INTEGER := 0;
	STARTS_WITH_DEVICE_BNUMCONFIGURATIONS_INDEX: INTEGER := 0;
	STARTS_WITH_DEVICE_BNUMCONFIGURATIONS_COUNT: INTEGER := 0;
	STARTS_WITH_DEVICE_QUALIFIER_BLENGTH_INDEX: INTEGER := 0;
	STARTS_WITH_DEVICE_QUALIFIER_BLENGTH_COUNT: INTEGER := 0;
	STARTS_WITH_DEVICE_QUALIFIER_BCDUSB_INDEX: INTEGER := 0;
	STARTS_WITH_DEVICE_QUALIFIER_BCDUSB_COUNT: INTEGER := 0;
	STARTS_WITH_DEVICE_QUALIFIER_BDEVICECLASS_INDEX: INTEGER := 0;
	STARTS_WITH_DEVICE_QUALIFIER_BDEVICECLASS_COUNT: INTEGER := 0;
	STARTS_WITH_DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX: INTEGER := 0;
	STARTS_WITH_DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT: INTEGER := 0;
	STARTS_WITH_DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX: INTEGER := 0;
	STARTS_WITH_DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT: INTEGER := 0;
	STARTS_WITH_DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX: INTEGER := 0;
	STARTS_WITH_DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT: INTEGER := 0;
	STARTS_WITH_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX: INTEGER := 0;
	STARTS_WITH_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT: INTEGER := 0;
	STARTS_WITH_DEVICE_QUALIFIER_BRESERVED_INDEX: INTEGER := 0;
	STARTS_WITH_DEVICE_QUALIFIER_BRESERVED_COUNT: INTEGER := 0;
	STARTS_WITH_CONFIGURATION_BLENGTH_INDEX: INTEGER := 0;
	STARTS_WITH_CONFIGURATION_BLENGTH_COUNT: INTEGER := 0;
	STARTS_WITH_CONFIGURATION_WTOTALLENGTH_INDEX: INTEGER := 0;
	STARTS_WITH_CONFIGURATION_WTOTALLENGTH_COUNT: INTEGER := 0;
	STARTS_WITH_CONFIGURATION_BNUMINTERFACES_INDEX: INTEGER := 0;
	STARTS_WITH_CONFIGURATION_BNUMINTERFACES_COUNT: INTEGER := 0;
	STARTS_WITH_CONFIGURATION_BCONFIGURATIONVALUE_INDEX: INTEGER := 0;
	STARTS_WITH_CONFIGURATION_BCONFIGURATIONVALUE_COUNT: INTEGER := 0;
	STARTS_WITH_CONFIGURATION_BMATTRIBUTES_INDEX: INTEGER := 0;
	STARTS_WITH_CONFIGURATION_BMATTRIBUTES_COUNT: INTEGER := 0;
	STARTS_WITH_CONFIGURATION_BMAXPOWER_INDEX: INTEGER := 0;
	STARTS_WITH_CONFIGURATION_BMAXPOWER_COUNT: INTEGER := 0;
	STARTS_WITH_OTHER_SPEED_BLENGTH_INDEX: INTEGER := 0;
	STARTS_WITH_OTHER_SPEED_BLENGTH_COUNT: INTEGER := 0;
	STARTS_WITH_OTHER_SPEED_WTOTALLENGTH_INDEX: INTEGER := 0;
	STARTS_WITH_OTHER_SPEED_WTOTALLENGTH_COUNT: INTEGER := 0;
	STARTS_WITH_OTHER_SPEED_BNUMINTERFACES_INDEX: INTEGER := 0;
	STARTS_WITH_OTHER_SPEED_BNUMINTERFACES_COUNT: INTEGER := 0;
	STARTS_WITH_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX: INTEGER := 0;
	STARTS_WITH_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT: INTEGER := 0;
	STARTS_WITH_OTHER_SPEED_BMATTRIBUTES_INDEX: INTEGER := 0;
	STARTS_WITH_OTHER_SPEED_BMATTRIBUTES_COUNT: INTEGER := 0;
	STARTS_WITH_OTHER_SPEED_BMAXPOWER_INDEX: INTEGER := 0;
	STARTS_WITH_OTHER_SPEED_BMAXPOWER_COUNT: INTEGER := 0;
	STARTS_WITH_INTERFACE_BLENGTH_INDEX: INTEGER := 0;
	STARTS_WITH_INTERFACE_BLENGTH_COUNT: INTEGER := 0;
	STARTS_WITH_INTERFACE_BINTERFACENUMBER_INDEX: INTEGER := 0;
	STARTS_WITH_INTERFACE_BINTERFACENUMBER_COUNT: INTEGER := 0;
	STARTS_WITH_INTERFACE_BALTERNATESETTING_INDEX: INTEGER := 0;
	STARTS_WITH_INTERFACE_BALTERNATESETTING_COUNT: INTEGER := 0;
	STARTS_WITH_INTERFACE_BNUMENDPOINTS_INDEX: INTEGER := 0;
	STARTS_WITH_INTERFACE_BNUMENDPOINTS_COUNT: INTEGER := 0;
	STARTS_WITH_INTERFACE_BINTERFACECLASS_INDEX: INTEGER := 0;
	STARTS_WITH_INTERFACE_BINTERFACECLASS_COUNT: INTEGER := 0;
	STARTS_WITH_INTERFACE_BINTERFACESUBCLASS_INDEX: INTEGER := 0;
	STARTS_WITH_INTERFACE_BINTERFACESUBCLASS_COUNT: INTEGER := 0;
	STARTS_WITH_INTERFACE_BINTERFACEPROTOCOL_INDEX: INTEGER := 0;
	STARTS_WITH_INTERFACE_BINTERFACEPROTOCOL_COUNT: INTEGER := 0;
	STARTS_WITH_ENDPOINT_BLENGTH_INDEX: INTEGER := 0;
	STARTS_WITH_ENDPOINT_BLENGTH_COUNT: INTEGER := 0;
	STARTS_WITH_ENDPOINT_BENDPOINTADDRESS_INDEX: INTEGER := 0;
	STARTS_WITH_ENDPOINT_BENDPOINTADDRESS_COUNT: INTEGER := 0;
	STARTS_WITH_ENDPOINT_BMATTRIBUTES_INDEX: INTEGER := 0;
	STARTS_WITH_ENDPOINT_BMATTRIBUTES_COUNT: INTEGER := 0;
	STARTS_WITH_ENDPOINT_WMAXPACKETSIZE_INDEX: INTEGER := 0;
	STARTS_WITH_ENDPOINT_WMAXPACKETSIZE_COUNT: INTEGER := 0;
	STARTS_WITH_ENDPOINT_BINTERVAL_INDEX: INTEGER := 0;
	STARTS_WITH_ENDPOINT_BINTERVAL_COUNT: INTEGER := 0;
	STARTS_WITH_HID_BLENGTH_INDEX: INTEGER := 0;
	STARTS_WITH_HID_BLENGTH_COUNT: INTEGER := 0;
	STARTS_WITH_HID_BCDHID_INDEX: INTEGER := 0;
	STARTS_WITH_HID_BCDHID_COUNT: INTEGER := 0;
	STARTS_WITH_HID_BCOUNTRYCODE_INDEX: INTEGER := 0;
	STARTS_WITH_HID_BCOUNTRYCODE_COUNT: INTEGER := 0;
	STARTS_WITH_HID_BNUMDESCRIPTORS_INDEX: INTEGER := 0;
	STARTS_WITH_HID_BNUMDESCRIPTORS_COUNT: INTEGER := 0;
	STARTS_WITH_HID_BDESCRIPTORTYPE_INDEX: INTEGER := 0;
	STARTS_WITH_HID_BDESCRIPTORTYPE_COUNT: INTEGER := 0;
	STARTS_WITH_HID_WDESCRIPTORLENGTH_INDEX: INTEGER := 0;
	STARTS_WITH_HID_WDESCRIPTORLENGTH_COUNT: INTEGER := 0;
	STARTS_WITH_STRING_BLENGTH_INDEX: INTEGER := 0;
	STARTS_WITH_STRING_BLENGTH_COUNT: INTEGER := 0;
	STARTS_WITH_STRING_IMANUFACTURER_INDEX: INTEGER := 0;
	STARTS_WITH_STRING_IMANUFACTURER_COUNT: INTEGER := 0;
	STARTS_WITH_STRING_IPRODUCT_INDEX: INTEGER := 0;
	STARTS_WITH_STRING_IPRODUCT_COUNT: INTEGER := 0;
	STARTS_WITH_STRING_ISERIALNUMBER_INDEX: INTEGER := 0;
	STARTS_WITH_STRING_ISERIALNUMBER_COUNT: INTEGER := 0;
	STARTS_WITH_STRING_ICONFIGURATION_INDEX: INTEGER := 0;
	STARTS_WITH_STRING_ICONFIGURATION_COUNT: INTEGER := 0;
	STARTS_WITH_STRING_IINTERFACE_INDEX: INTEGER := 0;
	STARTS_WITH_STRING_IINTERFACE_COUNT: INTEGER := 0;

	ENDS_WITH_MEMORY_ADDR_LENGTH: INTEGER := 1;
	ENDS_WITH_MEMORY_ADDR_MAX_INDEX: INTEGER := 0;
	ENDS_WITH_MEMORY_ADDR_MAX_COUNT: INTEGER := 0; 
	ENDS_WITH_DEVICE_BLENGTH_INDEX: INTEGER := 0;
	ENDS_WITH_DEVICE_BLENGTH_COUNT: INTEGER := 0;
	ENDS_WITH_DEVICE_BCDUSB_INDEX: INTEGER := 0;
	ENDS_WITH_DEVICE_BCDUSB_COUNT: INTEGER := 0;
	ENDS_WITH_DEVICE_BDEVICECLASS_INDEX: INTEGER := 0;
	ENDS_WITH_DEVICE_BDEVICECLASS_COUNT: INTEGER := 0;
	ENDS_WITH_DEVICE_BDEVICESUBCLASS_INDEX: INTEGER := 0;
	ENDS_WITH_DEVICE_BDEVICESUBCLASS_COUNT: INTEGER := 0;
	ENDS_WITH_DEVICE_BDEVICEPROTOCOL_INDEX: INTEGER := 0;
	ENDS_WITH_DEVICE_BDEVICEPROTOCOL_COUNT: INTEGER := 0;
	ENDS_WITH_DEVICE_BMAXPACKETSIZE0_INDEX: INTEGER := 0;
	ENDS_WITH_DEVICE_BMAXPACKETSIZE0_COUNT: INTEGER := 0;
	ENDS_WITH_DEVICE_IDVENDOR_INDEX: INTEGER := 0;
	ENDS_WITH_DEVICE_IDVENDOR_COUNT: INTEGER := 0;
	ENDS_WITH_DEVICE_IDPRODUCT_INDEX: INTEGER := 0;
	ENDS_WITH_DEVICE_IDPRODUCT_COUNT: INTEGER := 0;
	ENDS_WITH_DEVICE_BCDDEVICE_INDEX: INTEGER := 0;
	ENDS_WITH_DEVICE_BCDDEVICE_COUNT: INTEGER := 0;
	ENDS_WITH_DEVICE_BNUMCONFIGURATIONS_INDEX: INTEGER := 0;
	ENDS_WITH_DEVICE_BNUMCONFIGURATIONS_COUNT: INTEGER := 0;
	ENDS_WITH_DEVICE_QUALIFIER_BLENGTH_INDEX: INTEGER := 0;
	ENDS_WITH_DEVICE_QUALIFIER_BLENGTH_COUNT: INTEGER := 0;
	ENDS_WITH_DEVICE_QUALIFIER_BCDUSB_INDEX: INTEGER := 0;
	ENDS_WITH_DEVICE_QUALIFIER_BCDUSB_COUNT: INTEGER := 0;
	ENDS_WITH_DEVICE_QUALIFIER_BDEVICECLASS_INDEX: INTEGER := 0;
	ENDS_WITH_DEVICE_QUALIFIER_BDEVICECLASS_COUNT: INTEGER := 0;
	ENDS_WITH_DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX: INTEGER := 0;
	ENDS_WITH_DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT: INTEGER := 0;
	ENDS_WITH_DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX: INTEGER := 0;
	ENDS_WITH_DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT: INTEGER := 0;
	ENDS_WITH_DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX: INTEGER := 0;
	ENDS_WITH_DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT: INTEGER := 0;
	ENDS_WITH_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX: INTEGER := 0;
	ENDS_WITH_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT: INTEGER := 0;
	ENDS_WITH_DEVICE_QUALIFIER_BRESERVED_INDEX: INTEGER := 0;
	ENDS_WITH_DEVICE_QUALIFIER_BRESERVED_COUNT: INTEGER := 0;
	ENDS_WITH_CONFIGURATION_BLENGTH_INDEX: INTEGER := 0;
	ENDS_WITH_CONFIGURATION_BLENGTH_COUNT: INTEGER := 0;
	ENDS_WITH_CONFIGURATION_WTOTALLENGTH_INDEX: INTEGER := 0;
	ENDS_WITH_CONFIGURATION_WTOTALLENGTH_COUNT: INTEGER := 0;
	ENDS_WITH_CONFIGURATION_BNUMINTERFACES_INDEX: INTEGER := 0;
	ENDS_WITH_CONFIGURATION_BNUMINTERFACES_COUNT: INTEGER := 0;
	ENDS_WITH_CONFIGURATION_BCONFIGURATIONVALUE_INDEX: INTEGER := 0;
	ENDS_WITH_CONFIGURATION_BCONFIGURATIONVALUE_COUNT: INTEGER := 0;
	ENDS_WITH_CONFIGURATION_BMATTRIBUTES_INDEX: INTEGER := 0;
	ENDS_WITH_CONFIGURATION_BMATTRIBUTES_COUNT: INTEGER := 0;
	ENDS_WITH_CONFIGURATION_BMAXPOWER_INDEX: INTEGER := 0;
	ENDS_WITH_CONFIGURATION_BMAXPOWER_COUNT: INTEGER := 0;
	ENDS_WITH_OTHER_SPEED_BLENGTH_INDEX: INTEGER := 0;
	ENDS_WITH_OTHER_SPEED_BLENGTH_COUNT: INTEGER := 0;
	ENDS_WITH_OTHER_SPEED_WTOTALLENGTH_INDEX: INTEGER := 0;
	ENDS_WITH_OTHER_SPEED_WTOTALLENGTH_COUNT: INTEGER := 0;
	ENDS_WITH_OTHER_SPEED_BNUMINTERFACES_INDEX: INTEGER := 0;
	ENDS_WITH_OTHER_SPEED_BNUMINTERFACES_COUNT: INTEGER := 0;
	ENDS_WITH_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX: INTEGER := 0;
	ENDS_WITH_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT: INTEGER := 0;
	ENDS_WITH_OTHER_SPEED_BMATTRIBUTES_INDEX: INTEGER := 0;
	ENDS_WITH_OTHER_SPEED_BMATTRIBUTES_COUNT: INTEGER := 0;
	ENDS_WITH_OTHER_SPEED_BMAXPOWER_INDEX: INTEGER := 0;
	ENDS_WITH_OTHER_SPEED_BMAXPOWER_COUNT: INTEGER := 0;
	ENDS_WITH_INTERFACE_BLENGTH_INDEX: INTEGER := 0;
	ENDS_WITH_INTERFACE_BLENGTH_COUNT: INTEGER := 0;
	ENDS_WITH_INTERFACE_BINTERFACENUMBER_INDEX: INTEGER := 0;
	ENDS_WITH_INTERFACE_BINTERFACENUMBER_COUNT: INTEGER := 0;
	ENDS_WITH_INTERFACE_BALTERNATESETTING_INDEX: INTEGER := 0;
	ENDS_WITH_INTERFACE_BALTERNATESETTING_COUNT: INTEGER := 0;
	ENDS_WITH_INTERFACE_BNUMENDPOINTS_INDEX: INTEGER := 0;
	ENDS_WITH_INTERFACE_BNUMENDPOINTS_COUNT: INTEGER := 0;
	ENDS_WITH_INTERFACE_BINTERFACECLASS_INDEX: INTEGER := 0;
	ENDS_WITH_INTERFACE_BINTERFACECLASS_COUNT: INTEGER := 0;
	ENDS_WITH_INTERFACE_BINTERFACESUBCLASS_INDEX: INTEGER := 0;
	ENDS_WITH_INTERFACE_BINTERFACESUBCLASS_COUNT: INTEGER := 0;
	ENDS_WITH_INTERFACE_BINTERFACEPROTOCOL_INDEX: INTEGER := 0;
	ENDS_WITH_INTERFACE_BINTERFACEPROTOCOL_COUNT: INTEGER := 0;
	ENDS_WITH_ENDPOINT_BLENGTH_INDEX: INTEGER := 0;
	ENDS_WITH_ENDPOINT_BLENGTH_COUNT: INTEGER := 0;
	ENDS_WITH_ENDPOINT_BENDPOINTADDRESS_INDEX: INTEGER := 0;
	ENDS_WITH_ENDPOINT_BENDPOINTADDRESS_COUNT: INTEGER := 0;
	ENDS_WITH_ENDPOINT_BMATTRIBUTES_INDEX: INTEGER := 0;
	ENDS_WITH_ENDPOINT_BMATTRIBUTES_COUNT: INTEGER := 0;
	ENDS_WITH_ENDPOINT_WMAXPACKETSIZE_INDEX: INTEGER := 0;
	ENDS_WITH_ENDPOINT_WMAXPACKETSIZE_COUNT: INTEGER := 0;
	ENDS_WITH_ENDPOINT_BINTERVAL_INDEX: INTEGER := 0;
	ENDS_WITH_ENDPOINT_BINTERVAL_COUNT: INTEGER := 0;
	ENDS_WITH_HID_BLENGTH_INDEX: INTEGER := 0;
	ENDS_WITH_HID_BLENGTH_COUNT: INTEGER := 0;
	ENDS_WITH_HID_BCDHID_INDEX: INTEGER := 0;
	ENDS_WITH_HID_BCDHID_COUNT: INTEGER := 0;
	ENDS_WITH_HID_BCOUNTRYCODE_INDEX: INTEGER := 0;
	ENDS_WITH_HID_BCOUNTRYCODE_COUNT: INTEGER := 0;
	ENDS_WITH_HID_BNUMDESCRIPTORS_INDEX: INTEGER := 0;
	ENDS_WITH_HID_BNUMDESCRIPTORS_COUNT: INTEGER := 0;
	ENDS_WITH_HID_BDESCRIPTORTYPE_INDEX: INTEGER := 0;
	ENDS_WITH_HID_BDESCRIPTORTYPE_COUNT: INTEGER := 0;
	ENDS_WITH_HID_WDESCRIPTORLENGTH_INDEX: INTEGER := 0;
	ENDS_WITH_HID_WDESCRIPTORLENGTH_COUNT: INTEGER := 0;
	ENDS_WITH_STRING_BLENGTH_INDEX: INTEGER := 0;
	ENDS_WITH_STRING_BLENGTH_COUNT: INTEGER := 0;
	ENDS_WITH_STRING_IMANUFACTURER_INDEX: INTEGER := 0;
	ENDS_WITH_STRING_IMANUFACTURER_COUNT: INTEGER := 0;
	ENDS_WITH_STRING_IPRODUCT_INDEX: INTEGER := 0;
	ENDS_WITH_STRING_IPRODUCT_COUNT: INTEGER := 0;
	ENDS_WITH_STRING_ISERIALNUMBER_INDEX: INTEGER := 0;
	ENDS_WITH_STRING_ISERIALNUMBER_COUNT: INTEGER := 0;
	ENDS_WITH_STRING_ICONFIGURATION_INDEX: INTEGER := 0;
	ENDS_WITH_STRING_ICONFIGURATION_COUNT: INTEGER := 0;
	ENDS_WITH_STRING_IINTERFACE_INDEX: INTEGER := 0;
	ENDS_WITH_STRING_IINTERFACE_COUNT: INTEGER := 0;

	CONTAINS_MEMORY_ADDR_LENGTH: INTEGER := 1;
	CONTAINS_MEMORY_ADDR_MAX_INDEX: INTEGER := 0;
	CONTAINS_MEMORY_ADDR_MAX_COUNT: INTEGER := 0; 
	CONTAINS_DEVICE_BLENGTH_INDEX: INTEGER := 0;
	CONTAINS_DEVICE_BLENGTH_COUNT: INTEGER := 0;
	CONTAINS_DEVICE_BCDUSB_INDEX: INTEGER := 0;
	CONTAINS_DEVICE_BCDUSB_COUNT: INTEGER := 0;
	CONTAINS_DEVICE_BDEVICECLASS_INDEX: INTEGER := 0;
	CONTAINS_DEVICE_BDEVICECLASS_COUNT: INTEGER := 0;
	CONTAINS_DEVICE_BDEVICESUBCLASS_INDEX: INTEGER := 0;
	CONTAINS_DEVICE_BDEVICESUBCLASS_COUNT: INTEGER := 0;
	CONTAINS_DEVICE_BDEVICEPROTOCOL_INDEX: INTEGER := 0;
	CONTAINS_DEVICE_BDEVICEPROTOCOL_COUNT: INTEGER := 0;
	CONTAINS_DEVICE_BMAXPACKETSIZE0_INDEX: INTEGER := 0;
	CONTAINS_DEVICE_BMAXPACKETSIZE0_COUNT: INTEGER := 0;
	CONTAINS_DEVICE_IDVENDOR_INDEX: INTEGER := 0;
	CONTAINS_DEVICE_IDVENDOR_COUNT: INTEGER := 0;
	CONTAINS_DEVICE_IDPRODUCT_INDEX: INTEGER := 0;
	CONTAINS_DEVICE_IDPRODUCT_COUNT: INTEGER := 0;
	CONTAINS_DEVICE_BCDDEVICE_INDEX: INTEGER := 0;
	CONTAINS_DEVICE_BCDDEVICE_COUNT: INTEGER := 0;
	CONTAINS_DEVICE_BNUMCONFIGURATIONS_INDEX: INTEGER := 0;
	CONTAINS_DEVICE_BNUMCONFIGURATIONS_COUNT: INTEGER := 0;
	CONTAINS_DEVICE_QUALIFIER_BLENGTH_INDEX: INTEGER := 0;
	CONTAINS_DEVICE_QUALIFIER_BLENGTH_COUNT: INTEGER := 0;
	CONTAINS_DEVICE_QUALIFIER_BCDUSB_INDEX: INTEGER := 0;
	CONTAINS_DEVICE_QUALIFIER_BCDUSB_COUNT: INTEGER := 0;
	CONTAINS_DEVICE_QUALIFIER_BDEVICECLASS_INDEX: INTEGER := 0;
	CONTAINS_DEVICE_QUALIFIER_BDEVICECLASS_COUNT: INTEGER := 0;
	CONTAINS_DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX: INTEGER := 0;
	CONTAINS_DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT: INTEGER := 0;
	CONTAINS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX: INTEGER := 0;
	CONTAINS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT: INTEGER := 0;
	CONTAINS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX: INTEGER := 0;
	CONTAINS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT: INTEGER := 0;
	CONTAINS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX: INTEGER := 0;
	CONTAINS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT: INTEGER := 0;
	CONTAINS_DEVICE_QUALIFIER_BRESERVED_INDEX: INTEGER := 0;
	CONTAINS_DEVICE_QUALIFIER_BRESERVED_COUNT: INTEGER := 0;
	CONTAINS_CONFIGURATION_BLENGTH_INDEX: INTEGER := 0;
	CONTAINS_CONFIGURATION_BLENGTH_COUNT: INTEGER := 0;
	CONTAINS_CONFIGURATION_WTOTALLENGTH_INDEX: INTEGER := 0;
	CONTAINS_CONFIGURATION_WTOTALLENGTH_COUNT: INTEGER := 0;
	CONTAINS_CONFIGURATION_BNUMINTERFACES_INDEX: INTEGER := 0;
	CONTAINS_CONFIGURATION_BNUMINTERFACES_COUNT: INTEGER := 0;
	CONTAINS_CONFIGURATION_BCONFIGURATIONVALUE_INDEX: INTEGER := 0;
	CONTAINS_CONFIGURATION_BCONFIGURATIONVALUE_COUNT: INTEGER := 0;
	CONTAINS_CONFIGURATION_BMATTRIBUTES_INDEX: INTEGER := 0;
	CONTAINS_CONFIGURATION_BMATTRIBUTES_COUNT: INTEGER := 0;
	CONTAINS_CONFIGURATION_BMAXPOWER_INDEX: INTEGER := 0;
	CONTAINS_CONFIGURATION_BMAXPOWER_COUNT: INTEGER := 0;
	CONTAINS_OTHER_SPEED_BLENGTH_INDEX: INTEGER := 0;
	CONTAINS_OTHER_SPEED_BLENGTH_COUNT: INTEGER := 0;
	CONTAINS_OTHER_SPEED_WTOTALLENGTH_INDEX: INTEGER := 0;
	CONTAINS_OTHER_SPEED_WTOTALLENGTH_COUNT: INTEGER := 0;
	CONTAINS_OTHER_SPEED_BNUMINTERFACES_INDEX: INTEGER := 0;
	CONTAINS_OTHER_SPEED_BNUMINTERFACES_COUNT: INTEGER := 0;
	CONTAINS_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX: INTEGER := 0;
	CONTAINS_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT: INTEGER := 0;
	CONTAINS_OTHER_SPEED_BMATTRIBUTES_INDEX: INTEGER := 0;
	CONTAINS_OTHER_SPEED_BMATTRIBUTES_COUNT: INTEGER := 0;
	CONTAINS_OTHER_SPEED_BMAXPOWER_INDEX: INTEGER := 0;
	CONTAINS_OTHER_SPEED_BMAXPOWER_COUNT: INTEGER := 0;
	CONTAINS_INTERFACE_BLENGTH_INDEX: INTEGER := 0;
	CONTAINS_INTERFACE_BLENGTH_COUNT: INTEGER := 0;
	CONTAINS_INTERFACE_BINTERFACENUMBER_INDEX: INTEGER := 0;
	CONTAINS_INTERFACE_BINTERFACENUMBER_COUNT: INTEGER := 0;
	CONTAINS_INTERFACE_BALTERNATESETTING_INDEX: INTEGER := 0;
	CONTAINS_INTERFACE_BALTERNATESETTING_COUNT: INTEGER := 0;
	CONTAINS_INTERFACE_BNUMENDPOINTS_INDEX: INTEGER := 0;
	CONTAINS_INTERFACE_BNUMENDPOINTS_COUNT: INTEGER := 0;
	CONTAINS_INTERFACE_BINTERFACECLASS_INDEX: INTEGER := 0;
	CONTAINS_INTERFACE_BINTERFACECLASS_COUNT: INTEGER := 0;
	CONTAINS_INTERFACE_BINTERFACESUBCLASS_INDEX: INTEGER := 0;
	CONTAINS_INTERFACE_BINTERFACESUBCLASS_COUNT: INTEGER := 0;
	CONTAINS_INTERFACE_BINTERFACEPROTOCOL_INDEX: INTEGER := 0;
	CONTAINS_INTERFACE_BINTERFACEPROTOCOL_COUNT: INTEGER := 0;
	CONTAINS_ENDPOINT_BLENGTH_INDEX: INTEGER := 0;
	CONTAINS_ENDPOINT_BLENGTH_COUNT: INTEGER := 0;
	CONTAINS_ENDPOINT_BENDPOINTADDRESS_INDEX: INTEGER := 0;
	CONTAINS_ENDPOINT_BENDPOINTADDRESS_COUNT: INTEGER := 0;
	CONTAINS_ENDPOINT_BMATTRIBUTES_INDEX: INTEGER := 0;
	CONTAINS_ENDPOINT_BMATTRIBUTES_COUNT: INTEGER := 0;
	CONTAINS_ENDPOINT_WMAXPACKETSIZE_INDEX: INTEGER := 0;
	CONTAINS_ENDPOINT_WMAXPACKETSIZE_COUNT: INTEGER := 0;
	CONTAINS_ENDPOINT_BINTERVAL_INDEX: INTEGER := 0;
	CONTAINS_ENDPOINT_BINTERVAL_COUNT: INTEGER := 0;
	CONTAINS_HID_BLENGTH_INDEX: INTEGER := 0;
	CONTAINS_HID_BLENGTH_COUNT: INTEGER := 0;
	CONTAINS_HID_BCDHID_INDEX: INTEGER := 0;
	CONTAINS_HID_BCDHID_COUNT: INTEGER := 0;
	CONTAINS_HID_BCOUNTRYCODE_INDEX: INTEGER := 0;
	CONTAINS_HID_BCOUNTRYCODE_COUNT: INTEGER := 0;
	CONTAINS_HID_BNUMDESCRIPTORS_INDEX: INTEGER := 0;
	CONTAINS_HID_BNUMDESCRIPTORS_COUNT: INTEGER := 0;
	CONTAINS_HID_BDESCRIPTORTYPE_INDEX: INTEGER := 0;
	CONTAINS_HID_BDESCRIPTORTYPE_COUNT: INTEGER := 0;
	CONTAINS_HID_WDESCRIPTORLENGTH_INDEX: INTEGER := 0;
	CONTAINS_HID_WDESCRIPTORLENGTH_COUNT: INTEGER := 0;
	CONTAINS_STRING_BLENGTH_INDEX: INTEGER := 0;
	CONTAINS_STRING_BLENGTH_COUNT: INTEGER := 0;
	CONTAINS_STRING_IMANUFACTURER_INDEX: INTEGER := 0;
	CONTAINS_STRING_IMANUFACTURER_COUNT: INTEGER := 0;
	CONTAINS_STRING_IPRODUCT_INDEX: INTEGER := 0;
	CONTAINS_STRING_IPRODUCT_COUNT: INTEGER := 0;
	CONTAINS_STRING_ISERIALNUMBER_INDEX: INTEGER := 0;
	CONTAINS_STRING_ISERIALNUMBER_COUNT: INTEGER := 0;
	CONTAINS_STRING_ICONFIGURATION_INDEX: INTEGER := 0;
	CONTAINS_STRING_ICONFIGURATION_COUNT: INTEGER := 0;
	CONTAINS_STRING_IINTERFACE_INDEX: INTEGER := 0;
	CONTAINS_STRING_IINTERFACE_COUNT: INTEGER := 0;

	NOT_CONTAINS_MEMORY_ADDR_LENGTH: INTEGER := 1;
	NOT_CONTAINS_MEMORY_ADDR_MAX_INDEX: INTEGER := 0;
	NOT_CONTAINS_MEMORY_ADDR_MAX_COUNT: INTEGER := 0;
	NOT_CONTAINS_DEVICE_BLENGTH_INDEX: INTEGER := 0;
	NOT_CONTAINS_DEVICE_BLENGTH_COUNT: INTEGER := 0;
	NOT_CONTAINS_DEVICE_BCDUSB_INDEX: INTEGER := 0;
	NOT_CONTAINS_DEVICE_BCDUSB_COUNT: INTEGER := 0;
	NOT_CONTAINS_DEVICE_BDEVICECLASS_INDEX: INTEGER := 0;
	NOT_CONTAINS_DEVICE_BDEVICECLASS_COUNT: INTEGER := 0;
	NOT_CONTAINS_DEVICE_BDEVICESUBCLASS_INDEX: INTEGER := 0;
	NOT_CONTAINS_DEVICE_BDEVICESUBCLASS_COUNT: INTEGER := 0;
	NOT_CONTAINS_DEVICE_BDEVICEPROTOCOL_INDEX: INTEGER := 0;
	NOT_CONTAINS_DEVICE_BDEVICEPROTOCOL_COUNT: INTEGER := 0;
	NOT_CONTAINS_DEVICE_BMAXPACKETSIZE0_INDEX: INTEGER := 0;
	NOT_CONTAINS_DEVICE_BMAXPACKETSIZE0_COUNT: INTEGER := 0;
	NOT_CONTAINS_DEVICE_IDVENDOR_INDEX: INTEGER := 0;
	NOT_CONTAINS_DEVICE_IDVENDOR_COUNT: INTEGER := 0;
	NOT_CONTAINS_DEVICE_IDPRODUCT_INDEX: INTEGER := 0;
	NOT_CONTAINS_DEVICE_IDPRODUCT_COUNT: INTEGER := 0;
	NOT_CONTAINS_DEVICE_BCDDEVICE_INDEX: INTEGER := 0;
	NOT_CONTAINS_DEVICE_BCDDEVICE_COUNT: INTEGER := 0;
	NOT_CONTAINS_DEVICE_BNUMCONFIGURATIONS_INDEX: INTEGER := 0;
	NOT_CONTAINS_DEVICE_BNUMCONFIGURATIONS_COUNT: INTEGER := 0;
	NOT_CONTAINS_DEVICE_QUALIFIER_BLENGTH_INDEX: INTEGER := 0;
	NOT_CONTAINS_DEVICE_QUALIFIER_BLENGTH_COUNT: INTEGER := 0;
	NOT_CONTAINS_DEVICE_QUALIFIER_BCDUSB_INDEX: INTEGER := 0;
	NOT_CONTAINS_DEVICE_QUALIFIER_BCDUSB_COUNT: INTEGER := 0;
	NOT_CONTAINS_DEVICE_QUALIFIER_BDEVICECLASS_INDEX: INTEGER := 0;
	NOT_CONTAINS_DEVICE_QUALIFIER_BDEVICECLASS_COUNT: INTEGER := 0;
	NOT_CONTAINS_DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX: INTEGER := 0;
	NOT_CONTAINS_DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT: INTEGER := 0;
	NOT_CONTAINS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX: INTEGER := 0;
	NOT_CONTAINS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT: INTEGER := 0;
	NOT_CONTAINS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX: INTEGER := 0;
	NOT_CONTAINS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT: INTEGER := 0;
	NOT_CONTAINS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX: INTEGER := 0;
	NOT_CONTAINS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT: INTEGER := 0;
	NOT_CONTAINS_DEVICE_QUALIFIER_BRESERVED_INDEX: INTEGER := 0;
	NOT_CONTAINS_DEVICE_QUALIFIER_BRESERVED_COUNT: INTEGER := 0;
	NOT_CONTAINS_CONFIGURATION_BLENGTH_INDEX: INTEGER := 0;
	NOT_CONTAINS_CONFIGURATION_BLENGTH_COUNT: INTEGER := 0;
	NOT_CONTAINS_CONFIGURATION_WTOTALLENGTH_INDEX: INTEGER := 0;
	NOT_CONTAINS_CONFIGURATION_WTOTALLENGTH_COUNT: INTEGER := 0;
	NOT_CONTAINS_CONFIGURATION_BNUMINTERFACES_INDEX: INTEGER := 0;
	NOT_CONTAINS_CONFIGURATION_BNUMINTERFACES_COUNT: INTEGER := 0;
	NOT_CONTAINS_CONFIGURATION_BCONFIGURATIONVALUE_INDEX: INTEGER := 0;
	NOT_CONTAINS_CONFIGURATION_BCONFIGURATIONVALUE_COUNT: INTEGER := 0;
	NOT_CONTAINS_CONFIGURATION_BMATTRIBUTES_INDEX: INTEGER := 0;
	NOT_CONTAINS_CONFIGURATION_BMATTRIBUTES_COUNT: INTEGER := 0;
	NOT_CONTAINS_CONFIGURATION_BMAXPOWER_INDEX: INTEGER := 0;
	NOT_CONTAINS_CONFIGURATION_BMAXPOWER_COUNT: INTEGER := 0;
	NOT_CONTAINS_OTHER_SPEED_BLENGTH_INDEX: INTEGER := 0;
	NOT_CONTAINS_OTHER_SPEED_BLENGTH_COUNT: INTEGER := 0;
	NOT_CONTAINS_OTHER_SPEED_WTOTALLENGTH_INDEX: INTEGER := 0;
	NOT_CONTAINS_OTHER_SPEED_WTOTALLENGTH_COUNT: INTEGER := 0;
	NOT_CONTAINS_OTHER_SPEED_BNUMINTERFACES_INDEX: INTEGER := 0;
	NOT_CONTAINS_OTHER_SPEED_BNUMINTERFACES_COUNT: INTEGER := 0;
	NOT_CONTAINS_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX: INTEGER := 0;
	NOT_CONTAINS_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT: INTEGER := 0;
	NOT_CONTAINS_OTHER_SPEED_BMATTRIBUTES_INDEX: INTEGER := 0;
	NOT_CONTAINS_OTHER_SPEED_BMATTRIBUTES_COUNT: INTEGER := 0;
	NOT_CONTAINS_OTHER_SPEED_BMAXPOWER_INDEX: INTEGER := 0;
	NOT_CONTAINS_OTHER_SPEED_BMAXPOWER_COUNT: INTEGER := 0;
	NOT_CONTAINS_INTERFACE_BLENGTH_INDEX: INTEGER := 0;
	NOT_CONTAINS_INTERFACE_BLENGTH_COUNT: INTEGER := 0;
	NOT_CONTAINS_INTERFACE_BINTERFACENUMBER_INDEX: INTEGER := 0;
	NOT_CONTAINS_INTERFACE_BINTERFACENUMBER_COUNT: INTEGER := 0;
	NOT_CONTAINS_INTERFACE_BALTERNATESETTING_INDEX: INTEGER := 0;
	NOT_CONTAINS_INTERFACE_BALTERNATESETTING_COUNT: INTEGER := 0;
	NOT_CONTAINS_INTERFACE_BNUMENDPOINTS_INDEX: INTEGER := 0;
	NOT_CONTAINS_INTERFACE_BNUMENDPOINTS_COUNT: INTEGER := 0;
	NOT_CONTAINS_INTERFACE_BINTERFACECLASS_INDEX: INTEGER := 0;
	NOT_CONTAINS_INTERFACE_BINTERFACECLASS_COUNT: INTEGER := 0;
	NOT_CONTAINS_INTERFACE_BINTERFACESUBCLASS_INDEX: INTEGER := 0;
	NOT_CONTAINS_INTERFACE_BINTERFACESUBCLASS_COUNT: INTEGER := 0;
	NOT_CONTAINS_INTERFACE_BINTERFACEPROTOCOL_INDEX: INTEGER := 0;
	NOT_CONTAINS_INTERFACE_BINTERFACEPROTOCOL_COUNT: INTEGER := 0;
	NOT_CONTAINS_ENDPOINT_BLENGTH_INDEX: INTEGER := 0;
	NOT_CONTAINS_ENDPOINT_BLENGTH_COUNT: INTEGER := 0;
	NOT_CONTAINS_ENDPOINT_BENDPOINTADDRESS_INDEX: INTEGER := 0;
	NOT_CONTAINS_ENDPOINT_BENDPOINTADDRESS_COUNT: INTEGER := 0;
	NOT_CONTAINS_ENDPOINT_BMATTRIBUTES_INDEX: INTEGER := 0;
	NOT_CONTAINS_ENDPOINT_BMATTRIBUTES_COUNT: INTEGER := 0;
	NOT_CONTAINS_ENDPOINT_WMAXPACKETSIZE_INDEX: INTEGER := 0;
	NOT_CONTAINS_ENDPOINT_WMAXPACKETSIZE_COUNT: INTEGER := 0;
	NOT_CONTAINS_ENDPOINT_BINTERVAL_INDEX: INTEGER := 0;
	NOT_CONTAINS_ENDPOINT_BINTERVAL_COUNT: INTEGER := 0;
	NOT_CONTAINS_HID_BLENGTH_INDEX: INTEGER := 0;
	NOT_CONTAINS_HID_BLENGTH_COUNT: INTEGER := 0;
	NOT_CONTAINS_HID_BCDHID_INDEX: INTEGER := 0;
	NOT_CONTAINS_HID_BCDHID_COUNT: INTEGER := 0;
	NOT_CONTAINS_HID_BCOUNTRYCODE_INDEX: INTEGER := 0;
	NOT_CONTAINS_HID_BCOUNTRYCODE_COUNT: INTEGER := 0;
	NOT_CONTAINS_HID_BNUMDESCRIPTORS_INDEX: INTEGER := 0;
	NOT_CONTAINS_HID_BNUMDESCRIPTORS_COUNT: INTEGER := 0;
	NOT_CONTAINS_HID_BDESCRIPTORTYPE_INDEX: INTEGER := 0;
	NOT_CONTAINS_HID_BDESCRIPTORTYPE_COUNT: INTEGER := 0;
	NOT_CONTAINS_HID_WDESCRIPTORLENGTH_INDEX: INTEGER := 0;
	NOT_CONTAINS_HID_WDESCRIPTORLENGTH_COUNT: INTEGER := 0;
	NOT_CONTAINS_STRING_BLENGTH_INDEX: INTEGER := 0;
	NOT_CONTAINS_STRING_BLENGTH_COUNT: INTEGER := 0;
	NOT_CONTAINS_STRING_IMANUFACTURER_INDEX: INTEGER := 0;
	NOT_CONTAINS_STRING_IMANUFACTURER_COUNT: INTEGER := 0;
	NOT_CONTAINS_STRING_IPRODUCT_INDEX: INTEGER := 0;
	NOT_CONTAINS_STRING_IPRODUCT_COUNT: INTEGER := 0;
	NOT_CONTAINS_STRING_ISERIALNUMBER_INDEX: INTEGER := 0;
	NOT_CONTAINS_STRING_ISERIALNUMBER_COUNT: INTEGER := 0;
	NOT_CONTAINS_STRING_ICONFIGURATION_INDEX: INTEGER := 0;
	NOT_CONTAINS_STRING_ICONFIGURATION_COUNT: INTEGER := 0;
	NOT_CONTAINS_STRING_IINTERFACE_INDEX: INTEGER := 0;
	NOT_CONTAINS_STRING_IINTERFACE_COUNT: INTEGER := 0
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

uut: USBVerifier
	GENERIC MAP (
		EQUALS_OPERATOR_ENABLE => '1',
		NOT_EQUALS_OPERATOR_ENABLE => '1',
		GREATER_OPERATOR_ENABLE => '1',
		GREATER_EQUALS_OPERATOR_ENABLE => '1',
		LESS_OPERATOR_ENABLE => '1',
		LESS_EQUALS_OPERATOR_ENABLE => '1',
		STARTS_WITH_OPERATOR_ENABLE => '1',
		ENDS_WITH_OPERATOR_ENABLE => '1',
		CONTAINS_OPERATOR_ENABLE => '1',
		NOT_CONTAINS_OPERATOR_ENABLE => '1',
		WATCHDOG_LIMIT => 18,

		EQUALS_MEMORY_ADDR_LENGTH => 1,
		EQUALS_MEMORY_ADDR_MAX_INDEX => 0,
		EQUALS_MEMORY_ADDR_MAX_COUNT => 0, 
		EQUALS_DEVICE_BLENGTH_INDEX => 0,
		EQUALS_DEVICE_BLENGTH_COUNT => 0,
		EQUALS_DEVICE_BCDUSB_INDEX => 0,
		EQUALS_DEVICE_BCDUSB_COUNT => 0,
		EQUALS_DEVICE_BDEVICECLASS_INDEX => 0,
		EQUALS_DEVICE_BDEVICECLASS_COUNT => 0,
		EQUALS_DEVICE_BDEVICESUBCLASS_INDEX => 0,
		EQUALS_DEVICE_BDEVICESUBCLASS_COUNT => 0,
		EQUALS_DEVICE_BDEVICEPROTOCOL_INDEX => 0,
		EQUALS_DEVICE_BDEVICEPROTOCOL_COUNT => 0,
		EQUALS_DEVICE_BMAXPACKETSIZE0_INDEX => 0,
		EQUALS_DEVICE_BMAXPACKETSIZE0_COUNT => 0,
		EQUALS_DEVICE_IDVENDOR_INDEX => 0,
		EQUALS_DEVICE_IDVENDOR_COUNT => 0,
		EQUALS_DEVICE_IDPRODUCT_INDEX => 0,
		EQUALS_DEVICE_IDPRODUCT_COUNT => 0,
		EQUALS_DEVICE_BCDDEVICE_INDEX => 0,
		EQUALS_DEVICE_BCDDEVICE_COUNT => 0,
		EQUALS_DEVICE_BNUMCONFIGURATIONS_INDEX => 0,
		EQUALS_DEVICE_BNUMCONFIGURATIONS_COUNT => 0,
		EQUALS_DEVICE_QUALIFIER_BLENGTH_INDEX => 0,
		EQUALS_DEVICE_QUALIFIER_BLENGTH_COUNT => 0,
		EQUALS_DEVICE_QUALIFIER_BCDUSB_INDEX => 0,
		EQUALS_DEVICE_QUALIFIER_BCDUSB_COUNT => 0,
		EQUALS_DEVICE_QUALIFIER_BDEVICECLASS_INDEX => 0,
		EQUALS_DEVICE_QUALIFIER_BDEVICECLASS_COUNT => 0,
		EQUALS_DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX => 0,
		EQUALS_DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT => 0,
		EQUALS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX => 0,
		EQUALS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT => 0,
		EQUALS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX => 0,
		EQUALS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT => 0,
		EQUALS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX => 0,
		EQUALS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT => 0,
		EQUALS_DEVICE_QUALIFIER_BRESERVED_INDEX => 0,
		EQUALS_DEVICE_QUALIFIER_BRESERVED_COUNT => 0,
		EQUALS_CONFIGURATION_BLENGTH_INDEX => 0,
		EQUALS_CONFIGURATION_BLENGTH_COUNT => 0,
		EQUALS_CONFIGURATION_WTOTALLENGTH_INDEX => 0,
		EQUALS_CONFIGURATION_WTOTALLENGTH_COUNT => 0,
		EQUALS_CONFIGURATION_BNUMINTERFACES_INDEX => 0,
		EQUALS_CONFIGURATION_BNUMINTERFACES_COUNT => 0,
		EQUALS_CONFIGURATION_BCONFIGURATIONVALUE_INDEX => 0,
		EQUALS_CONFIGURATION_BCONFIGURATIONVALUE_COUNT => 0,
		EQUALS_CONFIGURATION_BMATTRIBUTES_INDEX => 0,
		EQUALS_CONFIGURATION_BMATTRIBUTES_COUNT => 0,
		EQUALS_CONFIGURATION_BMAXPOWER_INDEX => 0,
		EQUALS_CONFIGURATION_BMAXPOWER_COUNT => 0,
		EQUALS_OTHER_SPEED_BLENGTH_INDEX => 0,
		EQUALS_OTHER_SPEED_BLENGTH_COUNT => 0,
		EQUALS_OTHER_SPEED_WTOTALLENGTH_INDEX => 0,
		EQUALS_OTHER_SPEED_WTOTALLENGTH_COUNT => 0,
		EQUALS_OTHER_SPEED_BNUMINTERFACES_INDEX => 0,
		EQUALS_OTHER_SPEED_BNUMINTERFACES_COUNT => 0,
		EQUALS_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX => 0,
		EQUALS_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT => 0,
		EQUALS_OTHER_SPEED_BMATTRIBUTES_INDEX => 0,
		EQUALS_OTHER_SPEED_BMATTRIBUTES_COUNT => 0,
		EQUALS_OTHER_SPEED_BMAXPOWER_INDEX => 0,
		EQUALS_OTHER_SPEED_BMAXPOWER_COUNT => 0,
		EQUALS_INTERFACE_BLENGTH_INDEX => 0,
		EQUALS_INTERFACE_BLENGTH_COUNT => 0,
		EQUALS_INTERFACE_BINTERFACENUMBER_INDEX => 0,
		EQUALS_INTERFACE_BINTERFACENUMBER_COUNT => 0,
		EQUALS_INTERFACE_BALTERNATESETTING_INDEX => 0,
		EQUALS_INTERFACE_BALTERNATESETTING_COUNT => 0,
		EQUALS_INTERFACE_BNUMENDPOINTS_INDEX => 0,
		EQUALS_INTERFACE_BNUMENDPOINTS_COUNT => 0,
		EQUALS_INTERFACE_BINTERFACECLASS_INDEX => 0,
		EQUALS_INTERFACE_BINTERFACECLASS_COUNT => 0,
		EQUALS_INTERFACE_BINTERFACESUBCLASS_INDEX => 0,
		EQUALS_INTERFACE_BINTERFACESUBCLASS_COUNT => 0,
		EQUALS_INTERFACE_BINTERFACEPROTOCOL_INDEX => 0,
		EQUALS_INTERFACE_BINTERFACEPROTOCOL_COUNT => 0,
		EQUALS_ENDPOINT_BLENGTH_INDEX => 0,
		EQUALS_ENDPOINT_BLENGTH_COUNT => 0,
		EQUALS_ENDPOINT_BENDPOINTADDRESS_INDEX => 0,
		EQUALS_ENDPOINT_BENDPOINTADDRESS_COUNT => 0,
		EQUALS_ENDPOINT_BMATTRIBUTES_INDEX => 0,
		EQUALS_ENDPOINT_BMATTRIBUTES_COUNT => 0,
		EQUALS_ENDPOINT_WMAXPACKETSIZE_INDEX => 0,
		EQUALS_ENDPOINT_WMAXPACKETSIZE_COUNT => 0,
		EQUALS_ENDPOINT_BINTERVAL_INDEX => 0,
		EQUALS_ENDPOINT_BINTERVAL_COUNT => 0,
		EQUALS_HID_BLENGTH_INDEX => 0,
		EQUALS_HID_BLENGTH_COUNT => 0,
		EQUALS_HID_BCDHID_INDEX => 0,
		EQUALS_HID_BCDHID_COUNT => 0,
		EQUALS_HID_BCOUNTRYCODE_INDEX => 0,
		EQUALS_HID_BCOUNTRYCODE_COUNT => 0,
		EQUALS_HID_BNUMDESCRIPTORS_INDEX => 0,
		EQUALS_HID_BNUMDESCRIPTORS_COUNT => 0,
		EQUALS_HID_BDESCRIPTORTYPE_INDEX => 0,
		EQUALS_HID_BDESCRIPTORTYPE_COUNT => 0,
		EQUALS_HID_WDESCRIPTORLENGTH_INDEX => 0,
		EQUALS_HID_WDESCRIPTORLENGTH_COUNT => 0,
		EQUALS_STRING_BLENGTH_INDEX => 0,
		EQUALS_STRING_BLENGTH_COUNT => 0,
		EQUALS_STRING_IMANUFACTURER_INDEX => 0,
		EQUALS_STRING_IMANUFACTURER_COUNT => 0,
		EQUALS_STRING_IPRODUCT_INDEX => 0,
		EQUALS_STRING_IPRODUCT_COUNT => 0,
		EQUALS_STRING_ISERIALNUMBER_INDEX => 0,
		EQUALS_STRING_ISERIALNUMBER_COUNT => 0,
		EQUALS_STRING_ICONFIGURATION_INDEX => 0,
		EQUALS_STRING_ICONFIGURATION_COUNT => 0,
		EQUALS_STRING_IINTERFACE_INDEX => 0,
		EQUALS_STRING_IINTERFACE_COUNT => 0,

		NOT_EQUALS_MEMORY_ADDR_LENGTH => 1,
		NOT_EQUALS_MEMORY_ADDR_MAX_INDEX => 0,
		NOT_EQUALS_MEMORY_ADDR_MAX_COUNT => 0, 
		NOT_EQUALS_DEVICE_BLENGTH_INDEX => 0,
		NOT_EQUALS_DEVICE_BLENGTH_COUNT => 0,
		NOT_EQUALS_DEVICE_BCDUSB_INDEX => 0,
		NOT_EQUALS_DEVICE_BCDUSB_COUNT => 0,
		NOT_EQUALS_DEVICE_BDEVICECLASS_INDEX => 0,
		NOT_EQUALS_DEVICE_BDEVICECLASS_COUNT => 0,
		NOT_EQUALS_DEVICE_BDEVICESUBCLASS_INDEX => 0,
		NOT_EQUALS_DEVICE_BDEVICESUBCLASS_COUNT => 0,
		NOT_EQUALS_DEVICE_BDEVICEPROTOCOL_INDEX => 0,
		NOT_EQUALS_DEVICE_BDEVICEPROTOCOL_COUNT => 0,
		NOT_EQUALS_DEVICE_BMAXPACKETSIZE0_INDEX => 0,
		NOT_EQUALS_DEVICE_BMAXPACKETSIZE0_COUNT => 0,
		NOT_EQUALS_DEVICE_IDVENDOR_INDEX => 0,
		NOT_EQUALS_DEVICE_IDVENDOR_COUNT => 0,
		NOT_EQUALS_DEVICE_IDPRODUCT_INDEX => 0,
		NOT_EQUALS_DEVICE_IDPRODUCT_COUNT => 0,
		NOT_EQUALS_DEVICE_BCDDEVICE_INDEX => 0,
		NOT_EQUALS_DEVICE_BCDDEVICE_COUNT => 0,
		NOT_EQUALS_DEVICE_BNUMCONFIGURATIONS_INDEX => 0,
		NOT_EQUALS_DEVICE_BNUMCONFIGURATIONS_COUNT => 0,
		NOT_EQUALS_DEVICE_QUALIFIER_BLENGTH_INDEX => 0,
		NOT_EQUALS_DEVICE_QUALIFIER_BLENGTH_COUNT => 0,
		NOT_EQUALS_DEVICE_QUALIFIER_BCDUSB_INDEX => 0,
		NOT_EQUALS_DEVICE_QUALIFIER_BCDUSB_COUNT => 0,
		NOT_EQUALS_DEVICE_QUALIFIER_BDEVICECLASS_INDEX => 0,
		NOT_EQUALS_DEVICE_QUALIFIER_BDEVICECLASS_COUNT => 0,
		NOT_EQUALS_DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX => 0,
		NOT_EQUALS_DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT => 0,
		NOT_EQUALS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX => 0,
		NOT_EQUALS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT => 0,
		NOT_EQUALS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX => 0,
		NOT_EQUALS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT => 0,
		NOT_EQUALS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX => 0,
		NOT_EQUALS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT => 0,
		NOT_EQUALS_DEVICE_QUALIFIER_BRESERVED_INDEX => 0,
		NOT_EQUALS_DEVICE_QUALIFIER_BRESERVED_COUNT => 0,
		NOT_EQUALS_CONFIGURATION_BLENGTH_INDEX => 0,
		NOT_EQUALS_CONFIGURATION_BLENGTH_COUNT => 0,
		NOT_EQUALS_CONFIGURATION_WTOTALLENGTH_INDEX => 0,
		NOT_EQUALS_CONFIGURATION_WTOTALLENGTH_COUNT => 0,
		NOT_EQUALS_CONFIGURATION_BNUMINTERFACES_INDEX => 0,
		NOT_EQUALS_CONFIGURATION_BNUMINTERFACES_COUNT => 0,
		NOT_EQUALS_CONFIGURATION_BCONFIGURATIONVALUE_INDEX => 0,
		NOT_EQUALS_CONFIGURATION_BCONFIGURATIONVALUE_COUNT => 0,
		NOT_EQUALS_CONFIGURATION_BMATTRIBUTES_INDEX => 0,
		NOT_EQUALS_CONFIGURATION_BMATTRIBUTES_COUNT => 0,
		NOT_EQUALS_CONFIGURATION_BMAXPOWER_INDEX => 0,
		NOT_EQUALS_CONFIGURATION_BMAXPOWER_COUNT => 0,
		NOT_EQUALS_OTHER_SPEED_BLENGTH_INDEX => 0,
		NOT_EQUALS_OTHER_SPEED_BLENGTH_COUNT => 0,
		NOT_EQUALS_OTHER_SPEED_WTOTALLENGTH_INDEX => 0,
		NOT_EQUALS_OTHER_SPEED_WTOTALLENGTH_COUNT => 0,
		NOT_EQUALS_OTHER_SPEED_BNUMINTERFACES_INDEX => 0,
		NOT_EQUALS_OTHER_SPEED_BNUMINTERFACES_COUNT => 0,
		NOT_EQUALS_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX => 0,
		NOT_EQUALS_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT => 0,
		NOT_EQUALS_OTHER_SPEED_BMATTRIBUTES_INDEX => 0,
		NOT_EQUALS_OTHER_SPEED_BMATTRIBUTES_COUNT => 0,
		NOT_EQUALS_OTHER_SPEED_BMAXPOWER_INDEX => 0,
		NOT_EQUALS_OTHER_SPEED_BMAXPOWER_COUNT => 0,
		NOT_EQUALS_INTERFACE_BLENGTH_INDEX => 0,
		NOT_EQUALS_INTERFACE_BLENGTH_COUNT => 0,
		NOT_EQUALS_INTERFACE_BINTERFACENUMBER_INDEX => 0,
		NOT_EQUALS_INTERFACE_BINTERFACENUMBER_COUNT => 0,
		NOT_EQUALS_INTERFACE_BALTERNATESETTING_INDEX => 0,
		NOT_EQUALS_INTERFACE_BALTERNATESETTING_COUNT => 0,
		NOT_EQUALS_INTERFACE_BNUMENDPOINTS_INDEX => 0,
		NOT_EQUALS_INTERFACE_BNUMENDPOINTS_COUNT => 0,
		NOT_EQUALS_INTERFACE_BINTERFACECLASS_INDEX => 0,
		NOT_EQUALS_INTERFACE_BINTERFACECLASS_COUNT => 0,
		NOT_EQUALS_INTERFACE_BINTERFACESUBCLASS_INDEX => 0,
		NOT_EQUALS_INTERFACE_BINTERFACESUBCLASS_COUNT => 0,
		NOT_EQUALS_INTERFACE_BINTERFACEPROTOCOL_INDEX => 0,
		NOT_EQUALS_INTERFACE_BINTERFACEPROTOCOL_COUNT => 0,
		NOT_EQUALS_ENDPOINT_BLENGTH_INDEX => 0,
		NOT_EQUALS_ENDPOINT_BLENGTH_COUNT => 0,
		NOT_EQUALS_ENDPOINT_BENDPOINTADDRESS_INDEX => 0,
		NOT_EQUALS_ENDPOINT_BENDPOINTADDRESS_COUNT => 0,
		NOT_EQUALS_ENDPOINT_BMATTRIBUTES_INDEX => 0,
		NOT_EQUALS_ENDPOINT_BMATTRIBUTES_COUNT => 0,
		NOT_EQUALS_ENDPOINT_WMAXPACKETSIZE_INDEX => 0,
		NOT_EQUALS_ENDPOINT_WMAXPACKETSIZE_COUNT => 0,
		NOT_EQUALS_ENDPOINT_BINTERVAL_INDEX => 0,
		NOT_EQUALS_ENDPOINT_BINTERVAL_COUNT => 0,
		NOT_EQUALS_HID_BLENGTH_INDEX => 0,
		NOT_EQUALS_HID_BLENGTH_COUNT => 0,
		NOT_EQUALS_HID_BCDHID_INDEX => 0,
		NOT_EQUALS_HID_BCDHID_COUNT => 0,
		NOT_EQUALS_HID_BCOUNTRYCODE_INDEX => 0,
		NOT_EQUALS_HID_BCOUNTRYCODE_COUNT => 0,
		NOT_EQUALS_HID_BNUMDESCRIPTORS_INDEX => 0,
		NOT_EQUALS_HID_BNUMDESCRIPTORS_COUNT => 0,
		NOT_EQUALS_HID_BDESCRIPTORTYPE_INDEX => 0,
		NOT_EQUALS_HID_BDESCRIPTORTYPE_COUNT => 0,
		NOT_EQUALS_HID_WDESCRIPTORLENGTH_INDEX => 0,
		NOT_EQUALS_HID_WDESCRIPTORLENGTH_COUNT => 0,
		NOT_EQUALS_STRING_BLENGTH_INDEX => 0,
		NOT_EQUALS_STRING_BLENGTH_COUNT => 0,
		NOT_EQUALS_STRING_IMANUFACTURER_INDEX => 0,
		NOT_EQUALS_STRING_IMANUFACTURER_COUNT => 0,
		NOT_EQUALS_STRING_IPRODUCT_INDEX => 0,
		NOT_EQUALS_STRING_IPRODUCT_COUNT => 0,
		NOT_EQUALS_STRING_ISERIALNUMBER_INDEX => 0,
		NOT_EQUALS_STRING_ISERIALNUMBER_COUNT => 0,
		NOT_EQUALS_STRING_ICONFIGURATION_INDEX => 0,
		NOT_EQUALS_STRING_ICONFIGURATION_COUNT => 0,
		NOT_EQUALS_STRING_IINTERFACE_INDEX => 0,
		NOT_EQUALS_STRING_IINTERFACE_COUNT => 0,

		GREATER_MEMORY_ADDR_LENGTH => 1,
		GREATER_MEMORY_ADDR_MAX_INDEX => 0,
		GREATER_MEMORY_ADDR_MAX_COUNT => 0, 
		GREATER_DEVICE_BLENGTH_INDEX => 0,
		GREATER_DEVICE_BLENGTH_COUNT => 0,
		GREATER_DEVICE_BCDUSB_INDEX => 0,
		GREATER_DEVICE_BCDUSB_COUNT => 0,
		GREATER_DEVICE_BDEVICECLASS_INDEX => 0,
		GREATER_DEVICE_BDEVICECLASS_COUNT => 0,
		GREATER_DEVICE_BDEVICESUBCLASS_INDEX => 0,
		GREATER_DEVICE_BDEVICESUBCLASS_COUNT => 0,
		GREATER_DEVICE_BDEVICEPROTOCOL_INDEX => 0,
		GREATER_DEVICE_BDEVICEPROTOCOL_COUNT => 0,
		GREATER_DEVICE_BMAXPACKETSIZE0_INDEX => 0,
		GREATER_DEVICE_BMAXPACKETSIZE0_COUNT => 0,
		GREATER_DEVICE_IDVENDOR_INDEX => 0,
		GREATER_DEVICE_IDVENDOR_COUNT => 0,
		GREATER_DEVICE_IDPRODUCT_INDEX => 0,
		GREATER_DEVICE_IDPRODUCT_COUNT => 0,
		GREATER_DEVICE_BCDDEVICE_INDEX => 0,
		GREATER_DEVICE_BCDDEVICE_COUNT => 0,
		GREATER_DEVICE_BNUMCONFIGURATIONS_INDEX => 0,
		GREATER_DEVICE_BNUMCONFIGURATIONS_COUNT => 0,
		GREATER_DEVICE_QUALIFIER_BLENGTH_INDEX => 0,
		GREATER_DEVICE_QUALIFIER_BLENGTH_COUNT => 0,
		GREATER_DEVICE_QUALIFIER_BCDUSB_INDEX => 0,
		GREATER_DEVICE_QUALIFIER_BCDUSB_COUNT => 0,
		GREATER_DEVICE_QUALIFIER_BDEVICECLASS_INDEX => 0,
		GREATER_DEVICE_QUALIFIER_BDEVICECLASS_COUNT => 0,
		GREATER_DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX => 0,
		GREATER_DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT => 0,
		GREATER_DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX => 0,
		GREATER_DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT => 0,
		GREATER_DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX => 0,
		GREATER_DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT => 0,
		GREATER_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX => 0,
		GREATER_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT => 0,
		GREATER_DEVICE_QUALIFIER_BRESERVED_INDEX => 0,
		GREATER_DEVICE_QUALIFIER_BRESERVED_COUNT => 0,
		GREATER_CONFIGURATION_BLENGTH_INDEX => 0,
		GREATER_CONFIGURATION_BLENGTH_COUNT => 0,
		GREATER_CONFIGURATION_WTOTALLENGTH_INDEX => 0,
		GREATER_CONFIGURATION_WTOTALLENGTH_COUNT => 0,
		GREATER_CONFIGURATION_BNUMINTERFACES_INDEX => 0,
		GREATER_CONFIGURATION_BNUMINTERFACES_COUNT => 0,
		GREATER_CONFIGURATION_BCONFIGURATIONVALUE_INDEX => 0,
		GREATER_CONFIGURATION_BCONFIGURATIONVALUE_COUNT => 0,
		GREATER_CONFIGURATION_BMATTRIBUTES_INDEX => 0,
		GREATER_CONFIGURATION_BMATTRIBUTES_COUNT => 0,
		GREATER_CONFIGURATION_BMAXPOWER_INDEX => 0,
		GREATER_CONFIGURATION_BMAXPOWER_COUNT => 0,
		GREATER_OTHER_SPEED_BLENGTH_INDEX => 0,
		GREATER_OTHER_SPEED_BLENGTH_COUNT => 0,
		GREATER_OTHER_SPEED_WTOTALLENGTH_INDEX => 0,
		GREATER_OTHER_SPEED_WTOTALLENGTH_COUNT => 0,
		GREATER_OTHER_SPEED_BNUMINTERFACES_INDEX => 0,
		GREATER_OTHER_SPEED_BNUMINTERFACES_COUNT => 0,
		GREATER_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX => 0,
		GREATER_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT => 0,
		GREATER_OTHER_SPEED_BMATTRIBUTES_INDEX => 0,
		GREATER_OTHER_SPEED_BMATTRIBUTES_COUNT => 0,
		GREATER_OTHER_SPEED_BMAXPOWER_INDEX => 0,
		GREATER_OTHER_SPEED_BMAXPOWER_COUNT => 0,
		GREATER_INTERFACE_BLENGTH_INDEX => 0,
		GREATER_INTERFACE_BLENGTH_COUNT => 0,
		GREATER_INTERFACE_BINTERFACENUMBER_INDEX => 0,
		GREATER_INTERFACE_BINTERFACENUMBER_COUNT => 0,
		GREATER_INTERFACE_BALTERNATESETTING_INDEX => 0,
		GREATER_INTERFACE_BALTERNATESETTING_COUNT => 0,
		GREATER_INTERFACE_BNUMENDPOINTS_INDEX => 0,
		GREATER_INTERFACE_BNUMENDPOINTS_COUNT => 0,
		GREATER_INTERFACE_BINTERFACECLASS_INDEX => 0,
		GREATER_INTERFACE_BINTERFACECLASS_COUNT => 0,
		GREATER_INTERFACE_BINTERFACESUBCLASS_INDEX => 0,
		GREATER_INTERFACE_BINTERFACESUBCLASS_COUNT => 0,
		GREATER_INTERFACE_BINTERFACEPROTOCOL_INDEX => 0,
		GREATER_INTERFACE_BINTERFACEPROTOCOL_COUNT => 0,
		GREATER_ENDPOINT_BLENGTH_INDEX => 0,
		GREATER_ENDPOINT_BLENGTH_COUNT => 0,
		GREATER_ENDPOINT_BENDPOINTADDRESS_INDEX => 0,
		GREATER_ENDPOINT_BENDPOINTADDRESS_COUNT => 0,
		GREATER_ENDPOINT_BMATTRIBUTES_INDEX => 0,
		GREATER_ENDPOINT_BMATTRIBUTES_COUNT => 0,
		GREATER_ENDPOINT_WMAXPACKETSIZE_INDEX => 0,
		GREATER_ENDPOINT_WMAXPACKETSIZE_COUNT => 0,
		GREATER_ENDPOINT_BINTERVAL_INDEX => 0,
		GREATER_ENDPOINT_BINTERVAL_COUNT => 0,
		GREATER_HID_BLENGTH_INDEX => 0,
		GREATER_HID_BLENGTH_COUNT => 0,
		GREATER_HID_BCDHID_INDEX => 0,
		GREATER_HID_BCDHID_COUNT => 0,
		GREATER_HID_BCOUNTRYCODE_INDEX => 0,
		GREATER_HID_BCOUNTRYCODE_COUNT => 0,
		GREATER_HID_BNUMDESCRIPTORS_INDEX => 0,
		GREATER_HID_BNUMDESCRIPTORS_COUNT => 0,
		GREATER_HID_BDESCRIPTORTYPE_INDEX => 0,
		GREATER_HID_BDESCRIPTORTYPE_COUNT => 0,
		GREATER_HID_WDESCRIPTORLENGTH_INDEX => 0,
		GREATER_HID_WDESCRIPTORLENGTH_COUNT => 0,
		GREATER_STRING_BLENGTH_INDEX => 0,
		GREATER_STRING_BLENGTH_COUNT => 0,
		GREATER_STRING_IMANUFACTURER_INDEX => 0,
		GREATER_STRING_IMANUFACTURER_COUNT => 0,
		GREATER_STRING_IPRODUCT_INDEX => 0,
		GREATER_STRING_IPRODUCT_COUNT => 0,
		GREATER_STRING_ISERIALNUMBER_INDEX => 0,
		GREATER_STRING_ISERIALNUMBER_COUNT => 0,
		GREATER_STRING_ICONFIGURATION_INDEX => 0,
		GREATER_STRING_ICONFIGURATION_COUNT => 0,
		GREATER_STRING_IINTERFACE_INDEX => 0,
		GREATER_STRING_IINTERFACE_COUNT => 0,

		GREATER_EQUALS_MEMORY_ADDR_LENGTH => 1,
		GREATER_EQUALS_MEMORY_ADDR_MAX_INDEX => 0,
		GREATER_EQUALS_MEMORY_ADDR_MAX_COUNT => 0, 
		GREATER_EQUALS_DEVICE_BLENGTH_INDEX => 0,
		GREATER_EQUALS_DEVICE_BLENGTH_COUNT => 0,
		GREATER_EQUALS_DEVICE_BCDUSB_INDEX => 0,
		GREATER_EQUALS_DEVICE_BCDUSB_COUNT => 0,
		GREATER_EQUALS_DEVICE_BDEVICECLASS_INDEX => 0,
		GREATER_EQUALS_DEVICE_BDEVICECLASS_COUNT => 0,
		GREATER_EQUALS_DEVICE_BDEVICESUBCLASS_INDEX => 0,
		GREATER_EQUALS_DEVICE_BDEVICESUBCLASS_COUNT => 0,
		GREATER_EQUALS_DEVICE_BDEVICEPROTOCOL_INDEX => 0,
		GREATER_EQUALS_DEVICE_BDEVICEPROTOCOL_COUNT => 0,
		GREATER_EQUALS_DEVICE_BMAXPACKETSIZE0_INDEX => 0,
		GREATER_EQUALS_DEVICE_BMAXPACKETSIZE0_COUNT => 0,
		GREATER_EQUALS_DEVICE_IDVENDOR_INDEX => 0,
		GREATER_EQUALS_DEVICE_IDVENDOR_COUNT => 0,
		GREATER_EQUALS_DEVICE_IDPRODUCT_INDEX => 0,
		GREATER_EQUALS_DEVICE_IDPRODUCT_COUNT => 0,
		GREATER_EQUALS_DEVICE_BCDDEVICE_INDEX => 0,
		GREATER_EQUALS_DEVICE_BCDDEVICE_COUNT => 0,
		GREATER_EQUALS_DEVICE_BNUMCONFIGURATIONS_INDEX => 0,
		GREATER_EQUALS_DEVICE_BNUMCONFIGURATIONS_COUNT => 0,
		GREATER_EQUALS_DEVICE_QUALIFIER_BLENGTH_INDEX => 0,
		GREATER_EQUALS_DEVICE_QUALIFIER_BLENGTH_COUNT => 0,
		GREATER_EQUALS_DEVICE_QUALIFIER_BCDUSB_INDEX => 0,
		GREATER_EQUALS_DEVICE_QUALIFIER_BCDUSB_COUNT => 0,
		GREATER_EQUALS_DEVICE_QUALIFIER_BDEVICECLASS_INDEX => 0,
		GREATER_EQUALS_DEVICE_QUALIFIER_BDEVICECLASS_COUNT => 0,
		GREATER_EQUALS_DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX => 0,
		GREATER_EQUALS_DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT => 0,
		GREATER_EQUALS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX => 0,
		GREATER_EQUALS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT => 0,
		GREATER_EQUALS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX => 0,
		GREATER_EQUALS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT => 0,
		GREATER_EQUALS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX => 0,
		GREATER_EQUALS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT => 0,
		GREATER_EQUALS_DEVICE_QUALIFIER_BRESERVED_INDEX => 0,
		GREATER_EQUALS_DEVICE_QUALIFIER_BRESERVED_COUNT => 0,
		GREATER_EQUALS_CONFIGURATION_BLENGTH_INDEX => 0,
		GREATER_EQUALS_CONFIGURATION_BLENGTH_COUNT => 0,
		GREATER_EQUALS_CONFIGURATION_WTOTALLENGTH_INDEX => 0,
		GREATER_EQUALS_CONFIGURATION_WTOTALLENGTH_COUNT => 0,
		GREATER_EQUALS_CONFIGURATION_BNUMINTERFACES_INDEX => 0,
		GREATER_EQUALS_CONFIGURATION_BNUMINTERFACES_COUNT => 0,
		GREATER_EQUALS_CONFIGURATION_BCONFIGURATIONVALUE_INDEX => 0,
		GREATER_EQUALS_CONFIGURATION_BCONFIGURATIONVALUE_COUNT => 0,
		GREATER_EQUALS_CONFIGURATION_BMATTRIBUTES_INDEX => 0,
		GREATER_EQUALS_CONFIGURATION_BMATTRIBUTES_COUNT => 0,
		GREATER_EQUALS_CONFIGURATION_BMAXPOWER_INDEX => 0,
		GREATER_EQUALS_CONFIGURATION_BMAXPOWER_COUNT => 0,
		GREATER_EQUALS_OTHER_SPEED_BLENGTH_INDEX => 0,
		GREATER_EQUALS_OTHER_SPEED_BLENGTH_COUNT => 0,
		GREATER_EQUALS_OTHER_SPEED_WTOTALLENGTH_INDEX => 0,
		GREATER_EQUALS_OTHER_SPEED_WTOTALLENGTH_COUNT => 0,
		GREATER_EQUALS_OTHER_SPEED_BNUMINTERFACES_INDEX => 0,
		GREATER_EQUALS_OTHER_SPEED_BNUMINTERFACES_COUNT => 0,
		GREATER_EQUALS_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX => 0,
		GREATER_EQUALS_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT => 0,
		GREATER_EQUALS_OTHER_SPEED_BMATTRIBUTES_INDEX => 0,
		GREATER_EQUALS_OTHER_SPEED_BMATTRIBUTES_COUNT => 0,
		GREATER_EQUALS_OTHER_SPEED_BMAXPOWER_INDEX => 0,
		GREATER_EQUALS_OTHER_SPEED_BMAXPOWER_COUNT => 0,
		GREATER_EQUALS_INTERFACE_BLENGTH_INDEX => 0,
		GREATER_EQUALS_INTERFACE_BLENGTH_COUNT => 0,
		GREATER_EQUALS_INTERFACE_BINTERFACENUMBER_INDEX => 0,
		GREATER_EQUALS_INTERFACE_BINTERFACENUMBER_COUNT => 0,
		GREATER_EQUALS_INTERFACE_BALTERNATESETTING_INDEX => 0,
		GREATER_EQUALS_INTERFACE_BALTERNATESETTING_COUNT => 0,
		GREATER_EQUALS_INTERFACE_BNUMENDPOINTS_INDEX => 0,
		GREATER_EQUALS_INTERFACE_BNUMENDPOINTS_COUNT => 0,
		GREATER_EQUALS_INTERFACE_BINTERFACECLASS_INDEX => 0,
		GREATER_EQUALS_INTERFACE_BINTERFACECLASS_COUNT => 0,
		GREATER_EQUALS_INTERFACE_BINTERFACESUBCLASS_INDEX => 0,
		GREATER_EQUALS_INTERFACE_BINTERFACESUBCLASS_COUNT => 0,
		GREATER_EQUALS_INTERFACE_BINTERFACEPROTOCOL_INDEX => 0,
		GREATER_EQUALS_INTERFACE_BINTERFACEPROTOCOL_COUNT => 0,
		GREATER_EQUALS_ENDPOINT_BLENGTH_INDEX => 0,
		GREATER_EQUALS_ENDPOINT_BLENGTH_COUNT => 0,
		GREATER_EQUALS_ENDPOINT_BENDPOINTADDRESS_INDEX => 0,
		GREATER_EQUALS_ENDPOINT_BENDPOINTADDRESS_COUNT => 0,
		GREATER_EQUALS_ENDPOINT_BMATTRIBUTES_INDEX => 0,
		GREATER_EQUALS_ENDPOINT_BMATTRIBUTES_COUNT => 0,
		GREATER_EQUALS_ENDPOINT_WMAXPACKETSIZE_INDEX => 0,
		GREATER_EQUALS_ENDPOINT_WMAXPACKETSIZE_COUNT => 0,
		GREATER_EQUALS_ENDPOINT_BINTERVAL_INDEX => 0,
		GREATER_EQUALS_ENDPOINT_BINTERVAL_COUNT => 0,
		GREATER_EQUALS_HID_BLENGTH_INDEX => 0,
		GREATER_EQUALS_HID_BLENGTH_COUNT => 0,
		GREATER_EQUALS_HID_BCDHID_INDEX => 0,
		GREATER_EQUALS_HID_BCDHID_COUNT => 0,
		GREATER_EQUALS_HID_BCOUNTRYCODE_INDEX => 0,
		GREATER_EQUALS_HID_BCOUNTRYCODE_COUNT => 0,
		GREATER_EQUALS_HID_BNUMDESCRIPTORS_INDEX => 0,
		GREATER_EQUALS_HID_BNUMDESCRIPTORS_COUNT => 0,
		GREATER_EQUALS_HID_BDESCRIPTORTYPE_INDEX => 0,
		GREATER_EQUALS_HID_BDESCRIPTORTYPE_COUNT => 0,
		GREATER_EQUALS_HID_WDESCRIPTORLENGTH_INDEX => 0,
		GREATER_EQUALS_HID_WDESCRIPTORLENGTH_COUNT => 0,
		GREATER_EQUALS_STRING_BLENGTH_INDEX => 0,
		GREATER_EQUALS_STRING_BLENGTH_COUNT => 0,
		GREATER_EQUALS_STRING_IMANUFACTURER_INDEX => 0,
		GREATER_EQUALS_STRING_IMANUFACTURER_COUNT => 0,
		GREATER_EQUALS_STRING_IPRODUCT_INDEX => 0,
		GREATER_EQUALS_STRING_IPRODUCT_COUNT => 0,
		GREATER_EQUALS_STRING_ISERIALNUMBER_INDEX => 0,
		GREATER_EQUALS_STRING_ISERIALNUMBER_COUNT => 0,
		GREATER_EQUALS_STRING_ICONFIGURATION_INDEX => 0,
		GREATER_EQUALS_STRING_ICONFIGURATION_COUNT => 0,
		GREATER_EQUALS_STRING_IINTERFACE_INDEX => 0,
		GREATER_EQUALS_STRING_IINTERFACE_COUNT => 0,

		LESS_MEMORY_ADDR_LENGTH => 1,
		LESS_MEMORY_ADDR_MAX_INDEX => 0,
		LESS_MEMORY_ADDR_MAX_COUNT => 0, 
		LESS_DEVICE_BLENGTH_INDEX => 0,
		LESS_DEVICE_BLENGTH_COUNT => 0,
		LESS_DEVICE_BCDUSB_INDEX => 0,
		LESS_DEVICE_BCDUSB_COUNT => 0,
		LESS_DEVICE_BDEVICECLASS_INDEX => 0,
		LESS_DEVICE_BDEVICECLASS_COUNT => 0,
		LESS_DEVICE_BDEVICESUBCLASS_INDEX => 0,
		LESS_DEVICE_BDEVICESUBCLASS_COUNT => 0,
		LESS_DEVICE_BDEVICEPROTOCOL_INDEX => 0,
		LESS_DEVICE_BDEVICEPROTOCOL_COUNT => 0,
		LESS_DEVICE_BMAXPACKETSIZE0_INDEX => 0,
		LESS_DEVICE_BMAXPACKETSIZE0_COUNT => 0,
		LESS_DEVICE_IDVENDOR_INDEX => 0,
		LESS_DEVICE_IDVENDOR_COUNT => 0,
		LESS_DEVICE_IDPRODUCT_INDEX => 0,
		LESS_DEVICE_IDPRODUCT_COUNT => 0,
		LESS_DEVICE_BCDDEVICE_INDEX => 0,
		LESS_DEVICE_BCDDEVICE_COUNT => 0,
		LESS_DEVICE_BNUMCONFIGURATIONS_INDEX => 0,
		LESS_DEVICE_BNUMCONFIGURATIONS_COUNT => 0,
		LESS_DEVICE_QUALIFIER_BLENGTH_INDEX => 0,
		LESS_DEVICE_QUALIFIER_BLENGTH_COUNT => 0,
		LESS_DEVICE_QUALIFIER_BCDUSB_INDEX => 0,
		LESS_DEVICE_QUALIFIER_BCDUSB_COUNT => 0,
		LESS_DEVICE_QUALIFIER_BDEVICECLASS_INDEX => 0,
		LESS_DEVICE_QUALIFIER_BDEVICECLASS_COUNT => 0,
		LESS_DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX => 0,
		LESS_DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT => 0,
		LESS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX => 0,
		LESS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT => 0,
		LESS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX => 0,
		LESS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT => 0,
		LESS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX => 0,
		LESS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT => 0,
		LESS_DEVICE_QUALIFIER_BRESERVED_INDEX => 0,
		LESS_DEVICE_QUALIFIER_BRESERVED_COUNT => 0,
		LESS_CONFIGURATION_BLENGTH_INDEX => 0,
		LESS_CONFIGURATION_BLENGTH_COUNT => 0,
		LESS_CONFIGURATION_WTOTALLENGTH_INDEX => 0,
		LESS_CONFIGURATION_WTOTALLENGTH_COUNT => 0,
		LESS_CONFIGURATION_BNUMINTERFACES_INDEX => 0,
		LESS_CONFIGURATION_BNUMINTERFACES_COUNT => 0,
		LESS_CONFIGURATION_BCONFIGURATIONVALUE_INDEX => 0,
		LESS_CONFIGURATION_BCONFIGURATIONVALUE_COUNT => 0,
		LESS_CONFIGURATION_BMATTRIBUTES_INDEX => 0,
		LESS_CONFIGURATION_BMATTRIBUTES_COUNT => 0,
		LESS_CONFIGURATION_BMAXPOWER_INDEX => 0,
		LESS_CONFIGURATION_BMAXPOWER_COUNT => 0,
		LESS_OTHER_SPEED_BLENGTH_INDEX => 0,
		LESS_OTHER_SPEED_BLENGTH_COUNT => 0,
		LESS_OTHER_SPEED_WTOTALLENGTH_INDEX => 0,
		LESS_OTHER_SPEED_WTOTALLENGTH_COUNT => 0,
		LESS_OTHER_SPEED_BNUMINTERFACES_INDEX => 0,
		LESS_OTHER_SPEED_BNUMINTERFACES_COUNT => 0,
		LESS_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX => 0,
		LESS_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT => 0,
		LESS_OTHER_SPEED_BMATTRIBUTES_INDEX => 0,
		LESS_OTHER_SPEED_BMATTRIBUTES_COUNT => 0,
		LESS_OTHER_SPEED_BMAXPOWER_INDEX => 0,
		LESS_OTHER_SPEED_BMAXPOWER_COUNT => 0,
		LESS_INTERFACE_BLENGTH_INDEX => 0,
		LESS_INTERFACE_BLENGTH_COUNT => 0,
		LESS_INTERFACE_BINTERFACENUMBER_INDEX => 0,
		LESS_INTERFACE_BINTERFACENUMBER_COUNT => 0,
		LESS_INTERFACE_BALTERNATESETTING_INDEX => 0,
		LESS_INTERFACE_BALTERNATESETTING_COUNT => 0,
		LESS_INTERFACE_BNUMENDPOINTS_INDEX => 0,
		LESS_INTERFACE_BNUMENDPOINTS_COUNT => 0,
		LESS_INTERFACE_BINTERFACECLASS_INDEX => 0,
		LESS_INTERFACE_BINTERFACECLASS_COUNT => 0,
		LESS_INTERFACE_BINTERFACESUBCLASS_INDEX => 0,
		LESS_INTERFACE_BINTERFACESUBCLASS_COUNT => 0,
		LESS_INTERFACE_BINTERFACEPROTOCOL_INDEX => 0,
		LESS_INTERFACE_BINTERFACEPROTOCOL_COUNT => 0,
		LESS_ENDPOINT_BLENGTH_INDEX => 0,
		LESS_ENDPOINT_BLENGTH_COUNT => 0,
		LESS_ENDPOINT_BENDPOINTADDRESS_INDEX => 0,
		LESS_ENDPOINT_BENDPOINTADDRESS_COUNT => 0,
		LESS_ENDPOINT_BMATTRIBUTES_INDEX => 0,
		LESS_ENDPOINT_BMATTRIBUTES_COUNT => 0,
		LESS_ENDPOINT_WMAXPACKETSIZE_INDEX => 0,
		LESS_ENDPOINT_WMAXPACKETSIZE_COUNT => 0,
		LESS_ENDPOINT_BINTERVAL_INDEX => 0,
		LESS_ENDPOINT_BINTERVAL_COUNT => 0,
		LESS_HID_BLENGTH_INDEX => 0,
		LESS_HID_BLENGTH_COUNT => 0,
		LESS_HID_BCDHID_INDEX => 0,
		LESS_HID_BCDHID_COUNT => 0,
		LESS_HID_BCOUNTRYCODE_INDEX => 0,
		LESS_HID_BCOUNTRYCODE_COUNT => 0,
		LESS_HID_BNUMDESCRIPTORS_INDEX => 0,
		LESS_HID_BNUMDESCRIPTORS_COUNT => 0,
		LESS_HID_BDESCRIPTORTYPE_INDEX => 0,
		LESS_HID_BDESCRIPTORTYPE_COUNT => 0,
		LESS_HID_WDESCRIPTORLENGTH_INDEX => 0,
		LESS_HID_WDESCRIPTORLENGTH_COUNT => 0,
		LESS_STRING_BLENGTH_INDEX => 0,
		LESS_STRING_BLENGTH_COUNT => 0,
		LESS_STRING_IMANUFACTURER_INDEX => 0,
		LESS_STRING_IMANUFACTURER_COUNT => 0,
		LESS_STRING_IPRODUCT_INDEX => 0,
		LESS_STRING_IPRODUCT_COUNT => 0,
		LESS_STRING_ISERIALNUMBER_INDEX => 0,
		LESS_STRING_ISERIALNUMBER_COUNT => 0,
		LESS_STRING_ICONFIGURATION_INDEX => 0,
		LESS_STRING_ICONFIGURATION_COUNT => 0,
		LESS_STRING_IINTERFACE_INDEX => 0,
		LESS_STRING_IINTERFACE_COUNT => 0,

		LESS_EQUALS_MEMORY_ADDR_LENGTH => 1,
		LESS_EQUALS_MEMORY_ADDR_MAX_INDEX => 0,
		LESS_EQUALS_MEMORY_ADDR_MAX_COUNT => 0, 
		LESS_EQUALS_DEVICE_BLENGTH_INDEX => 0,
		LESS_EQUALS_DEVICE_BLENGTH_COUNT => 0,
		LESS_EQUALS_DEVICE_BCDUSB_INDEX => 0,
		LESS_EQUALS_DEVICE_BCDUSB_COUNT => 0,
		LESS_EQUALS_DEVICE_BDEVICECLASS_INDEX => 0,
		LESS_EQUALS_DEVICE_BDEVICECLASS_COUNT => 0,
		LESS_EQUALS_DEVICE_BDEVICESUBCLASS_INDEX => 0,
		LESS_EQUALS_DEVICE_BDEVICESUBCLASS_COUNT => 0,
		LESS_EQUALS_DEVICE_BDEVICEPROTOCOL_INDEX => 0,
		LESS_EQUALS_DEVICE_BDEVICEPROTOCOL_COUNT => 0,
		LESS_EQUALS_DEVICE_BMAXPACKETSIZE0_INDEX => 0,
		LESS_EQUALS_DEVICE_BMAXPACKETSIZE0_COUNT => 0,
		LESS_EQUALS_DEVICE_IDVENDOR_INDEX => 0,
		LESS_EQUALS_DEVICE_IDVENDOR_COUNT => 0,
		LESS_EQUALS_DEVICE_IDPRODUCT_INDEX => 0,
		LESS_EQUALS_DEVICE_IDPRODUCT_COUNT => 0,
		LESS_EQUALS_DEVICE_BCDDEVICE_INDEX => 0,
		LESS_EQUALS_DEVICE_BCDDEVICE_COUNT => 0,
		LESS_EQUALS_DEVICE_BNUMCONFIGURATIONS_INDEX => 0,
		LESS_EQUALS_DEVICE_BNUMCONFIGURATIONS_COUNT => 0,
		LESS_EQUALS_DEVICE_QUALIFIER_BLENGTH_INDEX => 0,
		LESS_EQUALS_DEVICE_QUALIFIER_BLENGTH_COUNT => 0,
		LESS_EQUALS_DEVICE_QUALIFIER_BCDUSB_INDEX => 0,
		LESS_EQUALS_DEVICE_QUALIFIER_BCDUSB_COUNT => 0,
		LESS_EQUALS_DEVICE_QUALIFIER_BDEVICECLASS_INDEX => 0,
		LESS_EQUALS_DEVICE_QUALIFIER_BDEVICECLASS_COUNT => 0,
		LESS_EQUALS_DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX => 0,
		LESS_EQUALS_DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT => 0,
		LESS_EQUALS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX => 0,
		LESS_EQUALS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT => 0,
		LESS_EQUALS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX => 0,
		LESS_EQUALS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT => 0,
		LESS_EQUALS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX => 0,
		LESS_EQUALS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT => 0,
		LESS_EQUALS_DEVICE_QUALIFIER_BRESERVED_INDEX => 0,
		LESS_EQUALS_DEVICE_QUALIFIER_BRESERVED_COUNT => 0,
		LESS_EQUALS_CONFIGURATION_BLENGTH_INDEX => 0,
		LESS_EQUALS_CONFIGURATION_BLENGTH_COUNT => 0,
		LESS_EQUALS_CONFIGURATION_WTOTALLENGTH_INDEX => 0,
		LESS_EQUALS_CONFIGURATION_WTOTALLENGTH_COUNT => 0,
		LESS_EQUALS_CONFIGURATION_BNUMINTERFACES_INDEX => 0,
		LESS_EQUALS_CONFIGURATION_BNUMINTERFACES_COUNT => 0,
		LESS_EQUALS_CONFIGURATION_BCONFIGURATIONVALUE_INDEX => 0,
		LESS_EQUALS_CONFIGURATION_BCONFIGURATIONVALUE_COUNT => 0,
		LESS_EQUALS_CONFIGURATION_BMATTRIBUTES_INDEX => 0,
		LESS_EQUALS_CONFIGURATION_BMATTRIBUTES_COUNT => 0,
		LESS_EQUALS_CONFIGURATION_BMAXPOWER_INDEX => 0,
		LESS_EQUALS_CONFIGURATION_BMAXPOWER_COUNT => 0,
		LESS_EQUALS_OTHER_SPEED_BLENGTH_INDEX => 0,
		LESS_EQUALS_OTHER_SPEED_BLENGTH_COUNT => 0,
		LESS_EQUALS_OTHER_SPEED_WTOTALLENGTH_INDEX => 0,
		LESS_EQUALS_OTHER_SPEED_WTOTALLENGTH_COUNT => 0,
		LESS_EQUALS_OTHER_SPEED_BNUMINTERFACES_INDEX => 0,
		LESS_EQUALS_OTHER_SPEED_BNUMINTERFACES_COUNT => 0,
		LESS_EQUALS_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX => 0,
		LESS_EQUALS_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT => 0,
		LESS_EQUALS_OTHER_SPEED_BMATTRIBUTES_INDEX => 0,
		LESS_EQUALS_OTHER_SPEED_BMATTRIBUTES_COUNT => 0,
		LESS_EQUALS_OTHER_SPEED_BMAXPOWER_INDEX => 0,
		LESS_EQUALS_OTHER_SPEED_BMAXPOWER_COUNT => 0,
		LESS_EQUALS_INTERFACE_BLENGTH_INDEX => 0,
		LESS_EQUALS_INTERFACE_BLENGTH_COUNT => 0,
		LESS_EQUALS_INTERFACE_BINTERFACENUMBER_INDEX => 0,
		LESS_EQUALS_INTERFACE_BINTERFACENUMBER_COUNT => 0,
		LESS_EQUALS_INTERFACE_BALTERNATESETTING_INDEX => 0,
		LESS_EQUALS_INTERFACE_BALTERNATESETTING_COUNT => 0,
		LESS_EQUALS_INTERFACE_BNUMENDPOINTS_INDEX => 0,
		LESS_EQUALS_INTERFACE_BNUMENDPOINTS_COUNT => 0,
		LESS_EQUALS_INTERFACE_BINTERFACECLASS_INDEX => 0,
		LESS_EQUALS_INTERFACE_BINTERFACECLASS_COUNT => 0,
		LESS_EQUALS_INTERFACE_BINTERFACESUBCLASS_INDEX => 0,
		LESS_EQUALS_INTERFACE_BINTERFACESUBCLASS_COUNT => 0,
		LESS_EQUALS_INTERFACE_BINTERFACEPROTOCOL_INDEX => 0,
		LESS_EQUALS_INTERFACE_BINTERFACEPROTOCOL_COUNT => 0,
		LESS_EQUALS_ENDPOINT_BLENGTH_INDEX => 0,
		LESS_EQUALS_ENDPOINT_BLENGTH_COUNT => 0,
		LESS_EQUALS_ENDPOINT_BENDPOINTADDRESS_INDEX => 0,
		LESS_EQUALS_ENDPOINT_BENDPOINTADDRESS_COUNT => 0,
		LESS_EQUALS_ENDPOINT_BMATTRIBUTES_INDEX => 0,
		LESS_EQUALS_ENDPOINT_BMATTRIBUTES_COUNT => 0,
		LESS_EQUALS_ENDPOINT_WMAXPACKETSIZE_INDEX => 0,
		LESS_EQUALS_ENDPOINT_WMAXPACKETSIZE_COUNT => 0,
		LESS_EQUALS_ENDPOINT_BINTERVAL_INDEX => 0,
		LESS_EQUALS_ENDPOINT_BINTERVAL_COUNT => 0,
		LESS_EQUALS_HID_BLENGTH_INDEX => 0,
		LESS_EQUALS_HID_BLENGTH_COUNT => 0,
		LESS_EQUALS_HID_BCDHID_INDEX => 0,
		LESS_EQUALS_HID_BCDHID_COUNT => 0,
		LESS_EQUALS_HID_BCOUNTRYCODE_INDEX => 0,
		LESS_EQUALS_HID_BCOUNTRYCODE_COUNT => 0,
		LESS_EQUALS_HID_BNUMDESCRIPTORS_INDEX => 0,
		LESS_EQUALS_HID_BNUMDESCRIPTORS_COUNT => 0,
		LESS_EQUALS_HID_BDESCRIPTORTYPE_INDEX => 0,
		LESS_EQUALS_HID_BDESCRIPTORTYPE_COUNT => 0,
		LESS_EQUALS_HID_WDESCRIPTORLENGTH_INDEX => 0,
		LESS_EQUALS_HID_WDESCRIPTORLENGTH_COUNT => 0,
		LESS_EQUALS_STRING_BLENGTH_INDEX => 0,
		LESS_EQUALS_STRING_BLENGTH_COUNT => 0,
		LESS_EQUALS_STRING_IMANUFACTURER_INDEX => 0,
		LESS_EQUALS_STRING_IMANUFACTURER_COUNT => 0,
		LESS_EQUALS_STRING_IPRODUCT_INDEX => 0,
		LESS_EQUALS_STRING_IPRODUCT_COUNT => 0,
		LESS_EQUALS_STRING_ISERIALNUMBER_INDEX => 0,
		LESS_EQUALS_STRING_ISERIALNUMBER_COUNT => 0,
		LESS_EQUALS_STRING_ICONFIGURATION_INDEX => 0,
		LESS_EQUALS_STRING_ICONFIGURATION_COUNT => 0,
		LESS_EQUALS_STRING_IINTERFACE_INDEX => 0,
		LESS_EQUALS_STRING_IINTERFACE_COUNT => 0,

		STARTS_WITH_MEMORY_ADDR_LENGTH => 1,
		STARTS_WITH_MEMORY_ADDR_MAX_INDEX => 0,
		STARTS_WITH_MEMORY_ADDR_MAX_COUNT => 0, 
		STARTS_WITH_DEVICE_BLENGTH_INDEX => 0,
		STARTS_WITH_DEVICE_BLENGTH_COUNT => 0,
		STARTS_WITH_DEVICE_BCDUSB_INDEX => 0,
		STARTS_WITH_DEVICE_BCDUSB_COUNT => 0,
		STARTS_WITH_DEVICE_BDEVICECLASS_INDEX => 0,
		STARTS_WITH_DEVICE_BDEVICECLASS_COUNT => 0,
		STARTS_WITH_DEVICE_BDEVICESUBCLASS_INDEX => 0,
		STARTS_WITH_DEVICE_BDEVICESUBCLASS_COUNT => 0,
		STARTS_WITH_DEVICE_BDEVICEPROTOCOL_INDEX => 0,
		STARTS_WITH_DEVICE_BDEVICEPROTOCOL_COUNT => 0,
		STARTS_WITH_DEVICE_BMAXPACKETSIZE0_INDEX => 0,
		STARTS_WITH_DEVICE_BMAXPACKETSIZE0_COUNT => 0,
		STARTS_WITH_DEVICE_IDVENDOR_INDEX => 0,
		STARTS_WITH_DEVICE_IDVENDOR_COUNT => 0,
		STARTS_WITH_DEVICE_IDPRODUCT_INDEX => 0,
		STARTS_WITH_DEVICE_IDPRODUCT_COUNT => 0,
		STARTS_WITH_DEVICE_BCDDEVICE_INDEX => 0,
		STARTS_WITH_DEVICE_BCDDEVICE_COUNT => 0,
		STARTS_WITH_DEVICE_BNUMCONFIGURATIONS_INDEX => 0,
		STARTS_WITH_DEVICE_BNUMCONFIGURATIONS_COUNT => 0,
		STARTS_WITH_DEVICE_QUALIFIER_BLENGTH_INDEX => 0,
		STARTS_WITH_DEVICE_QUALIFIER_BLENGTH_COUNT => 0,
		STARTS_WITH_DEVICE_QUALIFIER_BCDUSB_INDEX => 0,
		STARTS_WITH_DEVICE_QUALIFIER_BCDUSB_COUNT => 0,
		STARTS_WITH_DEVICE_QUALIFIER_BDEVICECLASS_INDEX => 0,
		STARTS_WITH_DEVICE_QUALIFIER_BDEVICECLASS_COUNT => 0,
		STARTS_WITH_DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX => 0,
		STARTS_WITH_DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT => 0,
		STARTS_WITH_DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX => 0,
		STARTS_WITH_DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT => 0,
		STARTS_WITH_DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX => 0,
		STARTS_WITH_DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT => 0,
		STARTS_WITH_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX => 0,
		STARTS_WITH_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT => 0,
		STARTS_WITH_DEVICE_QUALIFIER_BRESERVED_INDEX => 0,
		STARTS_WITH_DEVICE_QUALIFIER_BRESERVED_COUNT => 0,
		STARTS_WITH_CONFIGURATION_BLENGTH_INDEX => 0,
		STARTS_WITH_CONFIGURATION_BLENGTH_COUNT => 0,
		STARTS_WITH_CONFIGURATION_WTOTALLENGTH_INDEX => 0,
		STARTS_WITH_CONFIGURATION_WTOTALLENGTH_COUNT => 0,
		STARTS_WITH_CONFIGURATION_BNUMINTERFACES_INDEX => 0,
		STARTS_WITH_CONFIGURATION_BNUMINTERFACES_COUNT => 0,
		STARTS_WITH_CONFIGURATION_BCONFIGURATIONVALUE_INDEX => 0,
		STARTS_WITH_CONFIGURATION_BCONFIGURATIONVALUE_COUNT => 0,
		STARTS_WITH_CONFIGURATION_BMATTRIBUTES_INDEX => 0,
		STARTS_WITH_CONFIGURATION_BMATTRIBUTES_COUNT => 0,
		STARTS_WITH_CONFIGURATION_BMAXPOWER_INDEX => 0,
		STARTS_WITH_CONFIGURATION_BMAXPOWER_COUNT => 0,
		STARTS_WITH_OTHER_SPEED_BLENGTH_INDEX => 0,
		STARTS_WITH_OTHER_SPEED_BLENGTH_COUNT => 0,
		STARTS_WITH_OTHER_SPEED_WTOTALLENGTH_INDEX => 0,
		STARTS_WITH_OTHER_SPEED_WTOTALLENGTH_COUNT => 0,
		STARTS_WITH_OTHER_SPEED_BNUMINTERFACES_INDEX => 0,
		STARTS_WITH_OTHER_SPEED_BNUMINTERFACES_COUNT => 0,
		STARTS_WITH_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX => 0,
		STARTS_WITH_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT => 0,
		STARTS_WITH_OTHER_SPEED_BMATTRIBUTES_INDEX => 0,
		STARTS_WITH_OTHER_SPEED_BMATTRIBUTES_COUNT => 0,
		STARTS_WITH_OTHER_SPEED_BMAXPOWER_INDEX => 0,
		STARTS_WITH_OTHER_SPEED_BMAXPOWER_COUNT => 0,
		STARTS_WITH_INTERFACE_BLENGTH_INDEX => 0,
		STARTS_WITH_INTERFACE_BLENGTH_COUNT => 0,
		STARTS_WITH_INTERFACE_BINTERFACENUMBER_INDEX => 0,
		STARTS_WITH_INTERFACE_BINTERFACENUMBER_COUNT => 0,
		STARTS_WITH_INTERFACE_BALTERNATESETTING_INDEX => 0,
		STARTS_WITH_INTERFACE_BALTERNATESETTING_COUNT => 0,
		STARTS_WITH_INTERFACE_BNUMENDPOINTS_INDEX => 0,
		STARTS_WITH_INTERFACE_BNUMENDPOINTS_COUNT => 0,
		STARTS_WITH_INTERFACE_BINTERFACECLASS_INDEX => 0,
		STARTS_WITH_INTERFACE_BINTERFACECLASS_COUNT => 0,
		STARTS_WITH_INTERFACE_BINTERFACESUBCLASS_INDEX => 0,
		STARTS_WITH_INTERFACE_BINTERFACESUBCLASS_COUNT => 0,
		STARTS_WITH_INTERFACE_BINTERFACEPROTOCOL_INDEX => 0,
		STARTS_WITH_INTERFACE_BINTERFACEPROTOCOL_COUNT => 0,
		STARTS_WITH_ENDPOINT_BLENGTH_INDEX => 0,
		STARTS_WITH_ENDPOINT_BLENGTH_COUNT => 0,
		STARTS_WITH_ENDPOINT_BENDPOINTADDRESS_INDEX => 0,
		STARTS_WITH_ENDPOINT_BENDPOINTADDRESS_COUNT => 0,
		STARTS_WITH_ENDPOINT_BMATTRIBUTES_INDEX => 0,
		STARTS_WITH_ENDPOINT_BMATTRIBUTES_COUNT => 0,
		STARTS_WITH_ENDPOINT_WMAXPACKETSIZE_INDEX => 0,
		STARTS_WITH_ENDPOINT_WMAXPACKETSIZE_COUNT => 0,
		STARTS_WITH_ENDPOINT_BINTERVAL_INDEX => 0,
		STARTS_WITH_ENDPOINT_BINTERVAL_COUNT => 0,
		STARTS_WITH_HID_BLENGTH_INDEX => 0,
		STARTS_WITH_HID_BLENGTH_COUNT => 0,
		STARTS_WITH_HID_BCDHID_INDEX => 0,
		STARTS_WITH_HID_BCDHID_COUNT => 0,
		STARTS_WITH_HID_BCOUNTRYCODE_INDEX => 0,
		STARTS_WITH_HID_BCOUNTRYCODE_COUNT => 0,
		STARTS_WITH_HID_BNUMDESCRIPTORS_INDEX => 0,
		STARTS_WITH_HID_BNUMDESCRIPTORS_COUNT => 0,
		STARTS_WITH_HID_BDESCRIPTORTYPE_INDEX => 0,
		STARTS_WITH_HID_BDESCRIPTORTYPE_COUNT => 0,
		STARTS_WITH_HID_WDESCRIPTORLENGTH_INDEX => 0,
		STARTS_WITH_HID_WDESCRIPTORLENGTH_COUNT => 0,
		STARTS_WITH_STRING_BLENGTH_INDEX => 0,
		STARTS_WITH_STRING_BLENGTH_COUNT => 0,
		STARTS_WITH_STRING_IMANUFACTURER_INDEX => 0,
		STARTS_WITH_STRING_IMANUFACTURER_COUNT => 0,
		STARTS_WITH_STRING_IPRODUCT_INDEX => 0,
		STARTS_WITH_STRING_IPRODUCT_COUNT => 0,
		STARTS_WITH_STRING_ISERIALNUMBER_INDEX => 0,
		STARTS_WITH_STRING_ISERIALNUMBER_COUNT => 0,
		STARTS_WITH_STRING_ICONFIGURATION_INDEX => 0,
		STARTS_WITH_STRING_ICONFIGURATION_COUNT => 0,
		STARTS_WITH_STRING_IINTERFACE_INDEX => 0,
		STARTS_WITH_STRING_IINTERFACE_COUNT => 0,

		ENDS_WITH_MEMORY_ADDR_LENGTH => 1,
		ENDS_WITH_MEMORY_ADDR_MAX_INDEX => 0,
		ENDS_WITH_MEMORY_ADDR_MAX_COUNT => 0, 
		ENDS_WITH_DEVICE_BLENGTH_INDEX => 0,
		ENDS_WITH_DEVICE_BLENGTH_COUNT => 0,
		ENDS_WITH_DEVICE_BCDUSB_INDEX => 0,
		ENDS_WITH_DEVICE_BCDUSB_COUNT => 0,
		ENDS_WITH_DEVICE_BDEVICECLASS_INDEX => 0,
		ENDS_WITH_DEVICE_BDEVICECLASS_COUNT => 0,
		ENDS_WITH_DEVICE_BDEVICESUBCLASS_INDEX => 0,
		ENDS_WITH_DEVICE_BDEVICESUBCLASS_COUNT => 0,
		ENDS_WITH_DEVICE_BDEVICEPROTOCOL_INDEX => 0,
		ENDS_WITH_DEVICE_BDEVICEPROTOCOL_COUNT => 0,
		ENDS_WITH_DEVICE_BMAXPACKETSIZE0_INDEX => 0,
		ENDS_WITH_DEVICE_BMAXPACKETSIZE0_COUNT => 0,
		ENDS_WITH_DEVICE_IDVENDOR_INDEX => 0,
		ENDS_WITH_DEVICE_IDVENDOR_COUNT => 0,
		ENDS_WITH_DEVICE_IDPRODUCT_INDEX => 0,
		ENDS_WITH_DEVICE_IDPRODUCT_COUNT => 0,
		ENDS_WITH_DEVICE_BCDDEVICE_INDEX => 0,
		ENDS_WITH_DEVICE_BCDDEVICE_COUNT => 0,
		ENDS_WITH_DEVICE_BNUMCONFIGURATIONS_INDEX => 0,
		ENDS_WITH_DEVICE_BNUMCONFIGURATIONS_COUNT => 0,
		ENDS_WITH_DEVICE_QUALIFIER_BLENGTH_INDEX => 0,
		ENDS_WITH_DEVICE_QUALIFIER_BLENGTH_COUNT => 0,
		ENDS_WITH_DEVICE_QUALIFIER_BCDUSB_INDEX => 0,
		ENDS_WITH_DEVICE_QUALIFIER_BCDUSB_COUNT => 0,
		ENDS_WITH_DEVICE_QUALIFIER_BDEVICECLASS_INDEX => 0,
		ENDS_WITH_DEVICE_QUALIFIER_BDEVICECLASS_COUNT => 0,
		ENDS_WITH_DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX => 0,
		ENDS_WITH_DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT => 0,
		ENDS_WITH_DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX => 0,
		ENDS_WITH_DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT => 0,
		ENDS_WITH_DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX => 0,
		ENDS_WITH_DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT => 0,
		ENDS_WITH_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX => 0,
		ENDS_WITH_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT => 0,
		ENDS_WITH_DEVICE_QUALIFIER_BRESERVED_INDEX => 0,
		ENDS_WITH_DEVICE_QUALIFIER_BRESERVED_COUNT => 0,
		ENDS_WITH_CONFIGURATION_BLENGTH_INDEX => 0,
		ENDS_WITH_CONFIGURATION_BLENGTH_COUNT => 0,
		ENDS_WITH_CONFIGURATION_WTOTALLENGTH_INDEX => 0,
		ENDS_WITH_CONFIGURATION_WTOTALLENGTH_COUNT => 0,
		ENDS_WITH_CONFIGURATION_BNUMINTERFACES_INDEX => 0,
		ENDS_WITH_CONFIGURATION_BNUMINTERFACES_COUNT => 0,
		ENDS_WITH_CONFIGURATION_BCONFIGURATIONVALUE_INDEX => 0,
		ENDS_WITH_CONFIGURATION_BCONFIGURATIONVALUE_COUNT => 0,
		ENDS_WITH_CONFIGURATION_BMATTRIBUTES_INDEX => 0,
		ENDS_WITH_CONFIGURATION_BMATTRIBUTES_COUNT => 0,
		ENDS_WITH_CONFIGURATION_BMAXPOWER_INDEX => 0,
		ENDS_WITH_CONFIGURATION_BMAXPOWER_COUNT => 0,
		ENDS_WITH_OTHER_SPEED_BLENGTH_INDEX => 0,
		ENDS_WITH_OTHER_SPEED_BLENGTH_COUNT => 0,
		ENDS_WITH_OTHER_SPEED_WTOTALLENGTH_INDEX => 0,
		ENDS_WITH_OTHER_SPEED_WTOTALLENGTH_COUNT => 0,
		ENDS_WITH_OTHER_SPEED_BNUMINTERFACES_INDEX => 0,
		ENDS_WITH_OTHER_SPEED_BNUMINTERFACES_COUNT => 0,
		ENDS_WITH_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX => 0,
		ENDS_WITH_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT => 0,
		ENDS_WITH_OTHER_SPEED_BMATTRIBUTES_INDEX => 0,
		ENDS_WITH_OTHER_SPEED_BMATTRIBUTES_COUNT => 0,
		ENDS_WITH_OTHER_SPEED_BMAXPOWER_INDEX => 0,
		ENDS_WITH_OTHER_SPEED_BMAXPOWER_COUNT => 0,
		ENDS_WITH_INTERFACE_BLENGTH_INDEX => 0,
		ENDS_WITH_INTERFACE_BLENGTH_COUNT => 0,
		ENDS_WITH_INTERFACE_BINTERFACENUMBER_INDEX => 0,
		ENDS_WITH_INTERFACE_BINTERFACENUMBER_COUNT => 0,
		ENDS_WITH_INTERFACE_BALTERNATESETTING_INDEX => 0,
		ENDS_WITH_INTERFACE_BALTERNATESETTING_COUNT => 0,
		ENDS_WITH_INTERFACE_BNUMENDPOINTS_INDEX => 0,
		ENDS_WITH_INTERFACE_BNUMENDPOINTS_COUNT => 0,
		ENDS_WITH_INTERFACE_BINTERFACECLASS_INDEX => 0,
		ENDS_WITH_INTERFACE_BINTERFACECLASS_COUNT => 0,
		ENDS_WITH_INTERFACE_BINTERFACESUBCLASS_INDEX => 0,
		ENDS_WITH_INTERFACE_BINTERFACESUBCLASS_COUNT => 0,
		ENDS_WITH_INTERFACE_BINTERFACEPROTOCOL_INDEX => 0,
		ENDS_WITH_INTERFACE_BINTERFACEPROTOCOL_COUNT => 0,
		ENDS_WITH_ENDPOINT_BLENGTH_INDEX => 0,
		ENDS_WITH_ENDPOINT_BLENGTH_COUNT => 0,
		ENDS_WITH_ENDPOINT_BENDPOINTADDRESS_INDEX => 0,
		ENDS_WITH_ENDPOINT_BENDPOINTADDRESS_COUNT => 0,
		ENDS_WITH_ENDPOINT_BMATTRIBUTES_INDEX => 0,
		ENDS_WITH_ENDPOINT_BMATTRIBUTES_COUNT => 0,
		ENDS_WITH_ENDPOINT_WMAXPACKETSIZE_INDEX => 0,
		ENDS_WITH_ENDPOINT_WMAXPACKETSIZE_COUNT => 0,
		ENDS_WITH_ENDPOINT_BINTERVAL_INDEX => 0,
		ENDS_WITH_ENDPOINT_BINTERVAL_COUNT => 0,
		ENDS_WITH_HID_BLENGTH_INDEX => 0,
		ENDS_WITH_HID_BLENGTH_COUNT => 0,
		ENDS_WITH_HID_BCDHID_INDEX => 0,
		ENDS_WITH_HID_BCDHID_COUNT => 0,
		ENDS_WITH_HID_BCOUNTRYCODE_INDEX => 0,
		ENDS_WITH_HID_BCOUNTRYCODE_COUNT => 0,
		ENDS_WITH_HID_BNUMDESCRIPTORS_INDEX => 0,
		ENDS_WITH_HID_BNUMDESCRIPTORS_COUNT => 0,
		ENDS_WITH_HID_BDESCRIPTORTYPE_INDEX => 0,
		ENDS_WITH_HID_BDESCRIPTORTYPE_COUNT => 0,
		ENDS_WITH_HID_WDESCRIPTORLENGTH_INDEX => 0,
		ENDS_WITH_HID_WDESCRIPTORLENGTH_COUNT => 0,
		ENDS_WITH_STRING_BLENGTH_INDEX => 0,
		ENDS_WITH_STRING_BLENGTH_COUNT => 0,
		ENDS_WITH_STRING_IMANUFACTURER_INDEX => 0,
		ENDS_WITH_STRING_IMANUFACTURER_COUNT => 0,
		ENDS_WITH_STRING_IPRODUCT_INDEX => 0,
		ENDS_WITH_STRING_IPRODUCT_COUNT => 0,
		ENDS_WITH_STRING_ISERIALNUMBER_INDEX => 0,
		ENDS_WITH_STRING_ISERIALNUMBER_COUNT => 0,
		ENDS_WITH_STRING_ICONFIGURATION_INDEX => 0,
		ENDS_WITH_STRING_ICONFIGURATION_COUNT => 0,
		ENDS_WITH_STRING_IINTERFACE_INDEX => 0,
		ENDS_WITH_STRING_IINTERFACE_COUNT => 0,

		CONTAINS_MEMORY_ADDR_LENGTH => 1,
		CONTAINS_MEMORY_ADDR_MAX_INDEX => 0,
		CONTAINS_MEMORY_ADDR_MAX_COUNT => 0, 
		CONTAINS_DEVICE_BLENGTH_INDEX => 0,
		CONTAINS_DEVICE_BLENGTH_COUNT => 0,
		CONTAINS_DEVICE_BCDUSB_INDEX => 0,
		CONTAINS_DEVICE_BCDUSB_COUNT => 0,
		CONTAINS_DEVICE_BDEVICECLASS_INDEX => 0,
		CONTAINS_DEVICE_BDEVICECLASS_COUNT => 0,
		CONTAINS_DEVICE_BDEVICESUBCLASS_INDEX => 0,
		CONTAINS_DEVICE_BDEVICESUBCLASS_COUNT => 0,
		CONTAINS_DEVICE_BDEVICEPROTOCOL_INDEX => 0,
		CONTAINS_DEVICE_BDEVICEPROTOCOL_COUNT => 0,
		CONTAINS_DEVICE_BMAXPACKETSIZE0_INDEX => 0,
		CONTAINS_DEVICE_BMAXPACKETSIZE0_COUNT => 0,
		CONTAINS_DEVICE_IDVENDOR_INDEX => 0,
		CONTAINS_DEVICE_IDVENDOR_COUNT => 0,
		CONTAINS_DEVICE_IDPRODUCT_INDEX => 0,
		CONTAINS_DEVICE_IDPRODUCT_COUNT => 0,
		CONTAINS_DEVICE_BCDDEVICE_INDEX => 0,
		CONTAINS_DEVICE_BCDDEVICE_COUNT => 0,
		CONTAINS_DEVICE_BNUMCONFIGURATIONS_INDEX => 0,
		CONTAINS_DEVICE_BNUMCONFIGURATIONS_COUNT => 0,
		CONTAINS_DEVICE_QUALIFIER_BLENGTH_INDEX => 0,
		CONTAINS_DEVICE_QUALIFIER_BLENGTH_COUNT => 0,
		CONTAINS_DEVICE_QUALIFIER_BCDUSB_INDEX => 0,
		CONTAINS_DEVICE_QUALIFIER_BCDUSB_COUNT => 0,
		CONTAINS_DEVICE_QUALIFIER_BDEVICECLASS_INDEX => 0,
		CONTAINS_DEVICE_QUALIFIER_BDEVICECLASS_COUNT => 0,
		CONTAINS_DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX => 0,
		CONTAINS_DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT => 0,
		CONTAINS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX => 0,
		CONTAINS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT => 0,
		CONTAINS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX => 0,
		CONTAINS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT => 0,
		CONTAINS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX => 0,
		CONTAINS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT => 0,
		CONTAINS_DEVICE_QUALIFIER_BRESERVED_INDEX => 0,
		CONTAINS_DEVICE_QUALIFIER_BRESERVED_COUNT => 0,
		CONTAINS_CONFIGURATION_BLENGTH_INDEX => 0,
		CONTAINS_CONFIGURATION_BLENGTH_COUNT => 0,
		CONTAINS_CONFIGURATION_WTOTALLENGTH_INDEX => 0,
		CONTAINS_CONFIGURATION_WTOTALLENGTH_COUNT => 0,
		CONTAINS_CONFIGURATION_BNUMINTERFACES_INDEX => 0,
		CONTAINS_CONFIGURATION_BNUMINTERFACES_COUNT => 0,
		CONTAINS_CONFIGURATION_BCONFIGURATIONVALUE_INDEX => 0,
		CONTAINS_CONFIGURATION_BCONFIGURATIONVALUE_COUNT => 0,
		CONTAINS_CONFIGURATION_BMATTRIBUTES_INDEX => 0,
		CONTAINS_CONFIGURATION_BMATTRIBUTES_COUNT => 0,
		CONTAINS_CONFIGURATION_BMAXPOWER_INDEX => 0,
		CONTAINS_CONFIGURATION_BMAXPOWER_COUNT => 0,
		CONTAINS_OTHER_SPEED_BLENGTH_INDEX => 0,
		CONTAINS_OTHER_SPEED_BLENGTH_COUNT => 0,
		CONTAINS_OTHER_SPEED_WTOTALLENGTH_INDEX => 0,
		CONTAINS_OTHER_SPEED_WTOTALLENGTH_COUNT => 0,
		CONTAINS_OTHER_SPEED_BNUMINTERFACES_INDEX => 0,
		CONTAINS_OTHER_SPEED_BNUMINTERFACES_COUNT => 0,
		CONTAINS_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX => 0,
		CONTAINS_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT => 0,
		CONTAINS_OTHER_SPEED_BMATTRIBUTES_INDEX => 0,
		CONTAINS_OTHER_SPEED_BMATTRIBUTES_COUNT => 0,
		CONTAINS_OTHER_SPEED_BMAXPOWER_INDEX => 0,
		CONTAINS_OTHER_SPEED_BMAXPOWER_COUNT => 0,
		CONTAINS_INTERFACE_BLENGTH_INDEX => 0,
		CONTAINS_INTERFACE_BLENGTH_COUNT => 0,
		CONTAINS_INTERFACE_BINTERFACENUMBER_INDEX => 0,
		CONTAINS_INTERFACE_BINTERFACENUMBER_COUNT => 0,
		CONTAINS_INTERFACE_BALTERNATESETTING_INDEX => 0,
		CONTAINS_INTERFACE_BALTERNATESETTING_COUNT => 0,
		CONTAINS_INTERFACE_BNUMENDPOINTS_INDEX => 0,
		CONTAINS_INTERFACE_BNUMENDPOINTS_COUNT => 0,
		CONTAINS_INTERFACE_BINTERFACECLASS_INDEX => 0,
		CONTAINS_INTERFACE_BINTERFACECLASS_COUNT => 0,
		CONTAINS_INTERFACE_BINTERFACESUBCLASS_INDEX => 0,
		CONTAINS_INTERFACE_BINTERFACESUBCLASS_COUNT => 0,
		CONTAINS_INTERFACE_BINTERFACEPROTOCOL_INDEX => 0,
		CONTAINS_INTERFACE_BINTERFACEPROTOCOL_COUNT => 0,
		CONTAINS_ENDPOINT_BLENGTH_INDEX => 0,
		CONTAINS_ENDPOINT_BLENGTH_COUNT => 0,
		CONTAINS_ENDPOINT_BENDPOINTADDRESS_INDEX => 0,
		CONTAINS_ENDPOINT_BENDPOINTADDRESS_COUNT => 0,
		CONTAINS_ENDPOINT_BMATTRIBUTES_INDEX => 0,
		CONTAINS_ENDPOINT_BMATTRIBUTES_COUNT => 0,
		CONTAINS_ENDPOINT_WMAXPACKETSIZE_INDEX => 0,
		CONTAINS_ENDPOINT_WMAXPACKETSIZE_COUNT => 0,
		CONTAINS_ENDPOINT_BINTERVAL_INDEX => 0,
		CONTAINS_ENDPOINT_BINTERVAL_COUNT => 0,
		CONTAINS_HID_BLENGTH_INDEX => 0,
		CONTAINS_HID_BLENGTH_COUNT => 0,
		CONTAINS_HID_BCDHID_INDEX => 0,
		CONTAINS_HID_BCDHID_COUNT => 0,
		CONTAINS_HID_BCOUNTRYCODE_INDEX => 0,
		CONTAINS_HID_BCOUNTRYCODE_COUNT => 0,
		CONTAINS_HID_BNUMDESCRIPTORS_INDEX => 0,
		CONTAINS_HID_BNUMDESCRIPTORS_COUNT => 0,
		CONTAINS_HID_BDESCRIPTORTYPE_INDEX => 0,
		CONTAINS_HID_BDESCRIPTORTYPE_COUNT => 0,
		CONTAINS_HID_WDESCRIPTORLENGTH_INDEX => 0,
		CONTAINS_HID_WDESCRIPTORLENGTH_COUNT => 0,
		CONTAINS_STRING_BLENGTH_INDEX => 0,
		CONTAINS_STRING_BLENGTH_COUNT => 0,
		CONTAINS_STRING_IMANUFACTURER_INDEX => 0,
		CONTAINS_STRING_IMANUFACTURER_COUNT => 0,
		CONTAINS_STRING_IPRODUCT_INDEX => 0,
		CONTAINS_STRING_IPRODUCT_COUNT => 0,
		CONTAINS_STRING_ISERIALNUMBER_INDEX => 0,
		CONTAINS_STRING_ISERIALNUMBER_COUNT => 0,
		CONTAINS_STRING_ICONFIGURATION_INDEX => 0,
		CONTAINS_STRING_ICONFIGURATION_COUNT => 0,
		CONTAINS_STRING_IINTERFACE_INDEX => 0,
		CONTAINS_STRING_IINTERFACE_COUNT => 0,

		NOT_CONTAINS_MEMORY_ADDR_LENGTH => 1,
		NOT_CONTAINS_MEMORY_ADDR_MAX_INDEX => 0,
		NOT_CONTAINS_MEMORY_ADDR_MAX_COUNT => 0,
		NOT_CONTAINS_DEVICE_BLENGTH_INDEX => 0,
		NOT_CONTAINS_DEVICE_BLENGTH_COUNT => 0,
		NOT_CONTAINS_DEVICE_BCDUSB_INDEX => 0,
		NOT_CONTAINS_DEVICE_BCDUSB_COUNT => 0,
		NOT_CONTAINS_DEVICE_BDEVICECLASS_INDEX => 0,
		NOT_CONTAINS_DEVICE_BDEVICECLASS_COUNT => 0,
		NOT_CONTAINS_DEVICE_BDEVICESUBCLASS_INDEX => 0,
		NOT_CONTAINS_DEVICE_BDEVICESUBCLASS_COUNT => 0,
		NOT_CONTAINS_DEVICE_BDEVICEPROTOCOL_INDEX => 0,
		NOT_CONTAINS_DEVICE_BDEVICEPROTOCOL_COUNT => 0,
		NOT_CONTAINS_DEVICE_BMAXPACKETSIZE0_INDEX => 0,
		NOT_CONTAINS_DEVICE_BMAXPACKETSIZE0_COUNT => 0,
		NOT_CONTAINS_DEVICE_IDVENDOR_INDEX => 0,
		NOT_CONTAINS_DEVICE_IDVENDOR_COUNT => 0,
		NOT_CONTAINS_DEVICE_IDPRODUCT_INDEX => 0,
		NOT_CONTAINS_DEVICE_IDPRODUCT_COUNT => 0,
		NOT_CONTAINS_DEVICE_BCDDEVICE_INDEX => 0,
		NOT_CONTAINS_DEVICE_BCDDEVICE_COUNT => 0,
		NOT_CONTAINS_DEVICE_BNUMCONFIGURATIONS_INDEX => 0,
		NOT_CONTAINS_DEVICE_BNUMCONFIGURATIONS_COUNT => 0,
		NOT_CONTAINS_DEVICE_QUALIFIER_BLENGTH_INDEX => 0,
		NOT_CONTAINS_DEVICE_QUALIFIER_BLENGTH_COUNT => 0,
		NOT_CONTAINS_DEVICE_QUALIFIER_BCDUSB_INDEX => 0,
		NOT_CONTAINS_DEVICE_QUALIFIER_BCDUSB_COUNT => 0,
		NOT_CONTAINS_DEVICE_QUALIFIER_BDEVICECLASS_INDEX => 0,
		NOT_CONTAINS_DEVICE_QUALIFIER_BDEVICECLASS_COUNT => 0,
		NOT_CONTAINS_DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX => 0,
		NOT_CONTAINS_DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT => 0,
		NOT_CONTAINS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX => 0,
		NOT_CONTAINS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT => 0,
		NOT_CONTAINS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX => 0,
		NOT_CONTAINS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT => 0,
		NOT_CONTAINS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX => 0,
		NOT_CONTAINS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT => 0,
		NOT_CONTAINS_DEVICE_QUALIFIER_BRESERVED_INDEX => 0,
		NOT_CONTAINS_DEVICE_QUALIFIER_BRESERVED_COUNT => 0,
		NOT_CONTAINS_CONFIGURATION_BLENGTH_INDEX => 0,
		NOT_CONTAINS_CONFIGURATION_BLENGTH_COUNT => 0,
		NOT_CONTAINS_CONFIGURATION_WTOTALLENGTH_INDEX => 0,
		NOT_CONTAINS_CONFIGURATION_WTOTALLENGTH_COUNT => 0,
		NOT_CONTAINS_CONFIGURATION_BNUMINTERFACES_INDEX => 0,
		NOT_CONTAINS_CONFIGURATION_BNUMINTERFACES_COUNT => 0,
		NOT_CONTAINS_CONFIGURATION_BCONFIGURATIONVALUE_INDEX => 0,
		NOT_CONTAINS_CONFIGURATION_BCONFIGURATIONVALUE_COUNT => 0,
		NOT_CONTAINS_CONFIGURATION_BMATTRIBUTES_INDEX => 0,
		NOT_CONTAINS_CONFIGURATION_BMATTRIBUTES_COUNT => 0,
		NOT_CONTAINS_CONFIGURATION_BMAXPOWER_INDEX => 0,
		NOT_CONTAINS_CONFIGURATION_BMAXPOWER_COUNT => 0,
		NOT_CONTAINS_OTHER_SPEED_BLENGTH_INDEX => 0,
		NOT_CONTAINS_OTHER_SPEED_BLENGTH_COUNT => 0,
		NOT_CONTAINS_OTHER_SPEED_WTOTALLENGTH_INDEX => 0,
		NOT_CONTAINS_OTHER_SPEED_WTOTALLENGTH_COUNT => 0,
		NOT_CONTAINS_OTHER_SPEED_BNUMINTERFACES_INDEX => 0,
		NOT_CONTAINS_OTHER_SPEED_BNUMINTERFACES_COUNT => 0,
		NOT_CONTAINS_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX => 0,
		NOT_CONTAINS_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT => 0,
		NOT_CONTAINS_OTHER_SPEED_BMATTRIBUTES_INDEX => 0,
		NOT_CONTAINS_OTHER_SPEED_BMATTRIBUTES_COUNT => 0,
		NOT_CONTAINS_OTHER_SPEED_BMAXPOWER_INDEX => 0,
		NOT_CONTAINS_OTHER_SPEED_BMAXPOWER_COUNT => 0,
		NOT_CONTAINS_INTERFACE_BLENGTH_INDEX => 0,
		NOT_CONTAINS_INTERFACE_BLENGTH_COUNT => 0,
		NOT_CONTAINS_INTERFACE_BINTERFACENUMBER_INDEX => 0,
		NOT_CONTAINS_INTERFACE_BINTERFACENUMBER_COUNT => 0,
		NOT_CONTAINS_INTERFACE_BALTERNATESETTING_INDEX => 0,
		NOT_CONTAINS_INTERFACE_BALTERNATESETTING_COUNT => 0,
		NOT_CONTAINS_INTERFACE_BNUMENDPOINTS_INDEX => 0,
		NOT_CONTAINS_INTERFACE_BNUMENDPOINTS_COUNT => 0,
		NOT_CONTAINS_INTERFACE_BINTERFACECLASS_INDEX => 0,
		NOT_CONTAINS_INTERFACE_BINTERFACECLASS_COUNT => 0,
		NOT_CONTAINS_INTERFACE_BINTERFACESUBCLASS_INDEX => 0,
		NOT_CONTAINS_INTERFACE_BINTERFACESUBCLASS_COUNT => 0,
		NOT_CONTAINS_INTERFACE_BINTERFACEPROTOCOL_INDEX => 0,
		NOT_CONTAINS_INTERFACE_BINTERFACEPROTOCOL_COUNT => 0,
		NOT_CONTAINS_ENDPOINT_BLENGTH_INDEX => 0,
		NOT_CONTAINS_ENDPOINT_BLENGTH_COUNT => 0,
		NOT_CONTAINS_ENDPOINT_BENDPOINTADDRESS_INDEX => 0,
		NOT_CONTAINS_ENDPOINT_BENDPOINTADDRESS_COUNT => 0,
		NOT_CONTAINS_ENDPOINT_BMATTRIBUTES_INDEX => 0,
		NOT_CONTAINS_ENDPOINT_BMATTRIBUTES_COUNT => 0,
		NOT_CONTAINS_ENDPOINT_WMAXPACKETSIZE_INDEX => 0,
		NOT_CONTAINS_ENDPOINT_WMAXPACKETSIZE_COUNT => 0,
		NOT_CONTAINS_ENDPOINT_BINTERVAL_INDEX => 0,
		NOT_CONTAINS_ENDPOINT_BINTERVAL_COUNT => 0,
		NOT_CONTAINS_HID_BLENGTH_INDEX => 0,
		NOT_CONTAINS_HID_BLENGTH_COUNT => 0,
		NOT_CONTAINS_HID_BCDHID_INDEX => 0,
		NOT_CONTAINS_HID_BCDHID_COUNT => 0,
		NOT_CONTAINS_HID_BCOUNTRYCODE_INDEX => 0,
		NOT_CONTAINS_HID_BCOUNTRYCODE_COUNT => 0,
		NOT_CONTAINS_HID_BNUMDESCRIPTORS_INDEX => 0,
		NOT_CONTAINS_HID_BNUMDESCRIPTORS_COUNT => 0,
		NOT_CONTAINS_HID_BDESCRIPTORTYPE_INDEX => 0,
		NOT_CONTAINS_HID_BDESCRIPTORTYPE_COUNT => 0,
		NOT_CONTAINS_HID_WDESCRIPTORLENGTH_INDEX => 0,
		NOT_CONTAINS_HID_WDESCRIPTORLENGTH_COUNT => 0,
		NOT_CONTAINS_STRING_BLENGTH_INDEX => 0,
		NOT_CONTAINS_STRING_BLENGTH_COUNT => 0,
		NOT_CONTAINS_STRING_IMANUFACTURER_INDEX => 0,
		NOT_CONTAINS_STRING_IMANUFACTURER_COUNT => 0,
		NOT_CONTAINS_STRING_IPRODUCT_INDEX => 0,
		NOT_CONTAINS_STRING_IPRODUCT_COUNT => 0,
		NOT_CONTAINS_STRING_ISERIALNUMBER_INDEX => 0,
		NOT_CONTAINS_STRING_ISERIALNUMBER_COUNT => 0,
		NOT_CONTAINS_STRING_ICONFIGURATION_INDEX => 0,
		NOT_CONTAINS_STRING_ICONFIGURATION_COUNT => 0,
		NOT_CONTAINS_STRING_IINTERFACE_INDEX => 0,
		NOT_CONTAINS_STRING_IINTERFACE_COUNT => 0
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