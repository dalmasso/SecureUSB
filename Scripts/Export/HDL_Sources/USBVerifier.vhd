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
--
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
--		EQUALS_DEVICE_IMANUFACTURER_BLENGTH_INDEX: Device Descriptor String Manufacturer Length USB Field Index for Equals Operator
--		EQUALS_DEVICE_IMANUFACTURER_BLENGTH_COUNT: Device Descriptor String Manufacturer Length USB Field Count for Equals Operator
--		EQUALS_DEVICE_IMANUFACTURER_INDEX: Device Descriptor String Manufacturer USB Field Index for Equals Operator
--		EQUALS_DEVICE_IMANUFACTURER_COUNT: Device Descriptor String Manufacturer USB Field Count for Equals Operator
--		EQUALS_DEVICE_IPRODUCT_BLENGTH_INDEX: Device Descriptor String Product Length USB Field Index for Equals Operator
--		EQUALS_DEVICE_IPRODUCT_BLENGTH_COUNT: Device Descriptor String Product Length USB Field Count for Equals Operator
--		EQUALS_DEVICE_IPRODUCT_INDEX: Device Descriptor String Product USB Field Index for Equals Operator
--		EQUALS_DEVICE_IPRODUCT_COUNT: Device Descriptor String Product USB Field Count for Equals Operator
--		EQUALS_DEVICE_ISERIALNUMBER_BLENGTH_INDEX: Device Descriptor String Serial Number Length USB Field Index for Equals Operator
--		EQUALS_DEVICE_ISERIALNUMBER_BLENGTH_COUNT: Device Descriptor String Serial Number Length USB Field Count for Equals Operator
--		EQUALS_DEVICE_ISERIALNUMBER_INDEX: Device Descriptor String Serial Number USB Field Index for Equals Operator
--		EQUALS_DEVICE_ISERIALNUMBER_COUNT: Device Descriptor String Serial Number USB Field Count for Equals Operator
--		EQUALS_DEVICE_BNUMCONFIGURATIONS_INDEX: Device Descriptor Num Configuration USB Field Index for Equals Operator
--		EQUALS_DEVICE_BNUMCONFIGURATIONS_COUNT: Device Descriptor Num Configuration USB Field Count for Equals Operator
--		EQUALS_CONFIGURATION_BLENGTH_INDEX: Configuration Descriptor Length USB Field Index for Equals Operator
--		EQUALS_CONFIGURATION_BLENGTH_COUNT: Configuration Descriptor Length USB Field Count for Equals Operator
--		EQUALS_CONFIGURATION_WTOTALLENGTH_INDEX: Configuration Descriptor Total Length USB Field Index for Equals Operator
--		EQUALS_CONFIGURATION_WTOTALLENGTH_COUNT: Configuration Descriptor Total Length USB Field Count for Equals Operator
--		EQUALS_CONFIGURATION_BNUMINTERFACES_INDEX: Configuration Descriptor Num Interfaces USB Field Index for Equals Operator
--		EQUALS_CONFIGURATION_BNUMINTERFACES_COUNT: Configuration Descriptor Num Interfaces USB Field Count for Equals Operator
--		EQUALS_CONFIGURATION_BCONFIGURATIONVALUE_INDEX: Configuration Descriptor Configuration Value USB Field Index for Equals Operator
--		EQUALS_CONFIGURATION_BCONFIGURATIONVALUE_COUNT: Configuration Descriptor Configuration Value USB Field Count for Equals Operator
--		EQUALS_CONFIGURATION_ICONFIGURATION_BLENGTH_INDEX: Configuration Descriptor String Configuration Length USB Field Index for Equals Operator
--		EQUALS_CONFIGURATION_ICONFIGURATION_BLENGTH_COUNT: Configuration Descriptor String Configuration Length USB Field Count for Equals Operator
--		EQUALS_CONFIGURATION_ICONFIGURATION_INDEX: Configuration Descriptor String Configuration USB Field Index for Equals Operator
--		EQUALS_CONFIGURATION_ICONFIGURATION_COUNT: Configuration Descriptor String Configuration USB Field Coubt for Equals Operator
--		EQUALS_CONFIGURATION_BMATTRIBUTES_INDEX: Configuration Descriptor Attributes USB Field Index for Equals Operator
--		EQUALS_CONFIGURATION_BMATTRIBUTES_COUNT: Configuration Descriptor Attributes USB Field Count for Equals Operator
--		EQUALS_CONFIGURATION_BMAXPOWER_INDEX: Configuration Descriptor Max Power USB Field Index for Equals Operator
--		EQUALS_CONFIGURATION_BMAXPOWER_COUNT: Configuration Descriptor Max Power USB Field Count for Equals Operator
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
--		EQUALS_INTERFACE_IINTERFACE_BLENGTH_INDEX: Interface Descriptor String Interface Length USB Field Index for Equals Operator
--		EQUALS_INTERFACE_IINTERFACE_BLENGTH_COUNT: Interface Descriptor String Interface Length USB Field Count for Equals Operator
--		EQUALS_INTERFACE_IINTERFACE_INDEX: Interface Descriptor String Interface USB Field Index for Equals Operator
--		EQUALS_INTERFACE_IINTERFACE_COUNT: Interface Descriptor String Interface USB Field Count for Equals Operator
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
--		EQUALS_OTHER_SPEED_BLENGTH_INDEX: Other Speed Descriptor Length USB Field Index for Equals Operator
--		EQUALS_OTHER_SPEED_BLENGTH_COUNT: Other Speed Descriptor Length USB Field Count for Equals Operator
--		EQUALS_OTHER_SPEED_WTOTALLENGTH_INDEX: Other Speed Descriptor Total Length USB Field Index for Equals Operator
--		EQUALS_OTHER_SPEED_WTOTALLENGTH_COUNT: Other Speed Descriptor Total Length USB Field Count for Equals Operator
--		EQUALS_OTHER_SPEED_BNUMINTERFACES_INDEX: Other Speed Descriptor Num Interfaces USB Field Index for Equals Operator
--		EQUALS_OTHER_SPEED_BNUMINTERFACES_COUNT: Other Speed Descriptor Num Interfaces USB Field Count for Equals Operator
--		EQUALS_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX: Other Speed Descriptor Configuration Value USB Field Index for Equals Operator
--		EQUALS_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT: Other Speed Descriptor Configuration Value USB Field Count for Equals Operator
--		EQUALS_OTHER_SPEED_ICONFIGURATION_BLENGTH_INDEX: Other Speed Descriptor String Configuration Length USB Field Index for Equals Operator
--		EQUALS_OTHER_SPEED_ICONFIGURATION_BLENGTH_COUNT: Other Speed Descriptor String Configuration Length USB Field Count for Equals Operator
--		EQUALS_OTHER_SPEED_ICONFIGURATION_INDEX: Other Speed Descriptor String Configuration USB Field Index for Equals Operator
--		EQUALS_OTHER_SPEED_ICONFIGURATION_COUNT: Other Speed Descriptor String Configuration USB Field Count for Equals Operator
--		EQUALS_OTHER_SPEED_BMATTRIBUTES_INDEX: Other Speed Descriptor Attributes USB Field Index for Equals Operator
--		EQUALS_OTHER_SPEED_BMATTRIBUTES_COUNT: Other Speed Descriptor Attributes USB Field Count for Equals Operator
--		EQUALS_OTHER_SPEED_BMAXPOWER_INDEX: Other Speed Descriptor Max Power USB Field Index for Equals Operator
--		EQUALS_OTHER_SPEED_BMAXPOWER_COUNT: Other Speed Descriptor Max Power USB Field Count for Equals Operator
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
--		NOT_EQUALS_DEVICE_IMANUFACTURER_BLENGTH_INDEX: Device Descriptor String Manufacturer Length USB Field Index for NotEquals Operator
--		NOT_EQUALS_DEVICE_IMANUFACTURER_BLENGTH_COUNT: Device Descriptor String Manufacturer Length USB Field Count for NotEquals Operator
--		NOT_EQUALS_DEVICE_IMANUFACTURER_INDEX: Device Descriptor String Manufacturer USB Field Index for NotEquals Operator
--		NOT_EQUALS_DEVICE_IMANUFACTURER_COUNT: Device Descriptor String Manufacturer USB Field Count for NotEquals Operator
--		NOT_EQUALS_DEVICE_IPRODUCT_BLENGTH_INDEX: Device Descriptor String Product Length USB Field Index for NotEquals Operator
--		NOT_EQUALS_DEVICE_IPRODUCT_BLENGTH_COUNT: Device Descriptor String Product Length USB Field Count for NotEquals Operator
--		NOT_EQUALS_DEVICE_IPRODUCT_INDEX: Device Descriptor String Product USB Field Index for NotEquals Operator
--		NOT_EQUALS_DEVICE_IPRODUCT_COUNT: Device Descriptor String Product USB Field Count for NotEquals Operator
--		NOT_EQUALS_DEVICE_ISERIALNUMBER_BLENGTH_INDEX: Device Descriptor String Serial Number Length USB Field Index for NotEquals Operator
--		NOT_EQUALS_DEVICE_ISERIALNUMBER_BLENGTH_COUNT: Device Descriptor String Serial Number Length USB Field Count for NotEquals Operator
--		NOT_EQUALS_DEVICE_ISERIALNUMBER_INDEX: Device Descriptor String Serial Number USB Field Index for NotEquals Operator
--		NOT_EQUALS_DEVICE_ISERIALNUMBER_COUNT: Device Descriptor String Serial Number USB Field Count for NotEquals Operator
--		NOT_EQUALS_DEVICE_BNUMCONFIGURATIONS_INDEX: Device Descriptor Num Configuration USB Field Index for NotEquals Operator
--		NOT_EQUALS_DEVICE_BNUMCONFIGURATIONS_COUNT: Device Descriptor Num Configuration USB Field Count for NotEquals Operator
--		NOT_EQUALS_CONFIGURATION_BLENGTH_INDEX: Configuration Descriptor Length USB Field Index for NotEquals Operator
--		NOT_EQUALS_CONFIGURATION_BLENGTH_COUNT: Configuration Descriptor Length USB Field Count for NotEquals Operator
--		NOT_EQUALS_CONFIGURATION_WTOTALLENGTH_INDEX: Configuration Descriptor Total Length USB Field Index for NotEquals Operator
--		NOT_EQUALS_CONFIGURATION_WTOTALLENGTH_COUNT: Configuration Descriptor Total Length USB Field Count for NotEquals Operator
--		NOT_EQUALS_CONFIGURATION_BNUMINTERFACES_INDEX: Configuration Descriptor Num Interfaces USB Field Index for NotEquals Operator
--		NOT_EQUALS_CONFIGURATION_BNUMINTERFACES_COUNT: Configuration Descriptor Num Interfaces USB Field Count for NotEquals Operator
--		NOT_EQUALS_CONFIGURATION_BCONFIGURATIONVALUE_INDEX: Configuration Descriptor Configuration Value USB Field Index for NotEquals Operator
--		NOT_EQUALS_CONFIGURATION_BCONFIGURATIONVALUE_COUNT: Configuration Descriptor Configuration Value USB Field Count for NotEquals Operator
--		NOT_EQUALS_CONFIGURATION_ICONFIGURATION_BLENGTH_INDEX: Configuration Descriptor String Configuration Length USB Field Index for NotEquals Operator
--		NOT_EQUALS_CONFIGURATION_ICONFIGURATION_BLENGTH_COUNT: Configuration Descriptor String Configuration Length USB Field Count for NotEquals Operator
--		NOT_EQUALS_CONFIGURATION_ICONFIGURATION_INDEX: Configuration Descriptor String Configuration USB Field Index for NotEquals Operator
--		NOT_EQUALS_CONFIGURATION_ICONFIGURATION_COUNT: Configuration Descriptor String Configuration USB Field Coubt for NotEquals Operator
--		NOT_EQUALS_CONFIGURATION_BMATTRIBUTES_INDEX: Configuration Descriptor Attributes USB Field Index for NotEquals Operator
--		NOT_EQUALS_CONFIGURATION_BMATTRIBUTES_COUNT: Configuration Descriptor Attributes USB Field Count for NotEquals Operator
--		NOT_EQUALS_CONFIGURATION_BMAXPOWER_INDEX: Configuration Descriptor Max Power USB Field Index for NotEquals Operator
--		NOT_EQUALS_CONFIGURATION_BMAXPOWER_COUNT: Configuration Descriptor Max Power USB Field Count for NotEquals Operator
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
--		NOT_EQUALS_INTERFACE_IINTERFACE_BLENGTH_INDEX: Interface Descriptor String Interface Length USB Field Index for NotEquals Operator
--		NOT_EQUALS_INTERFACE_IINTERFACE_BLENGTH_COUNT: Interface Descriptor String Interface Length USB Field Count for NotEquals Operator
--		NOT_EQUALS_INTERFACE_IINTERFACE_INDEX: Interface Descriptor String Interface USB Field Index for NotEquals Operator
--		NOT_EQUALS_INTERFACE_IINTERFACE_COUNT: Interface Descriptor String Interface USB Field Count for NotEquals Operator
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
--		NOT_EQUALS_OTHER_SPEED_BLENGTH_INDEX: Other Speed Descriptor Length USB Field Index for NotEquals Operator
--		NOT_EQUALS_OTHER_SPEED_BLENGTH_COUNT: Other Speed Descriptor Length USB Field Count for NotEquals Operator
--		NOT_EQUALS_OTHER_SPEED_WTOTALLENGTH_INDEX: Other Speed Descriptor Total Length USB Field Index for NotEquals Operator
--		NOT_EQUALS_OTHER_SPEED_WTOTALLENGTH_COUNT: Other Speed Descriptor Total Length USB Field Count for NotEquals Operator
--		NOT_EQUALS_OTHER_SPEED_BNUMINTERFACES_INDEX: Other Speed Descriptor Num Interfaces USB Field Index for NotEquals Operator
--		NOT_EQUALS_OTHER_SPEED_BNUMINTERFACES_COUNT: Other Speed Descriptor Num Interfaces USB Field Count for NotEquals Operator
--		NOT_EQUALS_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX: Other Speed Descriptor Configuration Value USB Field Index for NotEquals Operator
--		NOT_EQUALS_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT: Other Speed Descriptor Configuration Value USB Field Count for NotEquals Operator
--		NOT_EQUALS_OTHER_SPEED_ICONFIGURATION_BLENGTH_INDEX: Other Speed Descriptor String Configuration Length USB Field Index for NotEquals Operator
--		NOT_EQUALS_OTHER_SPEED_ICONFIGURATION_BLENGTH_COUNT: Other Speed Descriptor String Configuration Length USB Field Count for NotEquals Operator
--		NOT_EQUALS_OTHER_SPEED_ICONFIGURATION_INDEX: Other Speed Descriptor String Configuration USB Field Index for NotEquals Operator
--		NOT_EQUALS_OTHER_SPEED_ICONFIGURATION_COUNT: Other Speed Descriptor String Configuration USB Field Count for NotEquals Operator
--		NOT_EQUALS_OTHER_SPEED_BMATTRIBUTES_INDEX: Other Speed Descriptor Attributes USB Field Index for NotEquals Operator
--		NOT_EQUALS_OTHER_SPEED_BMATTRIBUTES_COUNT: Other Speed Descriptor Attributes USB Field Count for NotEquals Operator
--		NOT_EQUALS_OTHER_SPEED_BMAXPOWER_INDEX: Other Speed Descriptor Max Power USB Field Index for NotEquals Operator
--		NOT_EQUALS_OTHER_SPEED_BMAXPOWER_COUNT: Other Speed Descriptor Max Power USB Field Count for NotEquals Operator
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
--		GREATER_DEVICE_IMANUFACTURER_BLENGTH_INDEX: Device Descriptor String Manufacturer Length USB Field Index for Greater Operator
--		GREATER_DEVICE_IMANUFACTURER_BLENGTH_COUNT: Device Descriptor String Manufacturer Length USB Field Count for Greater Operator
--		GREATER_DEVICE_IMANUFACTURER_INDEX: Device Descriptor String Manufacturer USB Field Index for Greater Operator
--		GREATER_DEVICE_IMANUFACTURER_COUNT: Device Descriptor String Manufacturer USB Field Count for Greater Operator
--		GREATER_DEVICE_IPRODUCT_BLENGTH_INDEX: Device Descriptor String Product Length USB Field Index for Greater Operator
--		GREATER_DEVICE_IPRODUCT_BLENGTH_COUNT: Device Descriptor String Product Length USB Field Count for Greater Operator
--		GREATER_DEVICE_IPRODUCT_INDEX: Device Descriptor String Product USB Field Index for Greater Operator
--		GREATER_DEVICE_IPRODUCT_COUNT: Device Descriptor String Product USB Field Count for Greater Operator
--		GREATER_DEVICE_ISERIALNUMBER_BLENGTH_INDEX: Device Descriptor String Serial Number Length USB Field Index for Greater Operator
--		GREATER_DEVICE_ISERIALNUMBER_BLENGTH_COUNT: Device Descriptor String Serial Number Length USB Field Count for Greater Operator
--		GREATER_DEVICE_ISERIALNUMBER_INDEX: Device Descriptor String Serial Number USB Field Index for Greater Operator
--		GREATER_DEVICE_ISERIALNUMBER_COUNT: Device Descriptor String Serial Number USB Field Count for Greater Operator
--		GREATER_DEVICE_BNUMCONFIGURATIONS_INDEX: Device Descriptor Num Configuration USB Field Index for Greater Operator
--		GREATER_DEVICE_BNUMCONFIGURATIONS_COUNT: Device Descriptor Num Configuration USB Field Count for Greater Operator
--		GREATER_CONFIGURATION_BLENGTH_INDEX: Configuration Descriptor Length USB Field Index for Greater Operator
--		GREATER_CONFIGURATION_BLENGTH_COUNT: Configuration Descriptor Length USB Field Count for Greater Operator
--		GREATER_CONFIGURATION_WTOTALLENGTH_INDEX: Configuration Descriptor Total Length USB Field Index for Greater Operator
--		GREATER_CONFIGURATION_WTOTALLENGTH_COUNT: Configuration Descriptor Total Length USB Field Count for Greater Operator
--		GREATER_CONFIGURATION_BNUMINTERFACES_INDEX: Configuration Descriptor Num Interfaces USB Field Index for Greater Operator
--		GREATER_CONFIGURATION_BNUMINTERFACES_COUNT: Configuration Descriptor Num Interfaces USB Field Count for Greater Operator
--		GREATER_CONFIGURATION_BCONFIGURATIONVALUE_INDEX: Configuration Descriptor Configuration Value USB Field Index for Greater Operator
--		GREATER_CONFIGURATION_BCONFIGURATIONVALUE_COUNT: Configuration Descriptor Configuration Value USB Field Count for Greater Operator
--		GREATER_CONFIGURATION_ICONFIGURATION_BLENGTH_INDEX: Configuration Descriptor String Configuration Length USB Field Index for Greater Operator
--		GREATER_CONFIGURATION_ICONFIGURATION_BLENGTH_COUNT: Configuration Descriptor String Configuration Length USB Field Count for Greater Operator
--		GREATER_CONFIGURATION_ICONFIGURATION_INDEX: Configuration Descriptor String Configuration USB Field Index for Greater Operator
--		GREATER_CONFIGURATION_ICONFIGURATION_COUNT: Configuration Descriptor String Configuration USB Field Coubt for Greater Operator
--		GREATER_CONFIGURATION_BMATTRIBUTES_INDEX: Configuration Descriptor Attributes USB Field Index for Greater Operator
--		GREATER_CONFIGURATION_BMATTRIBUTES_COUNT: Configuration Descriptor Attributes USB Field Count for Greater Operator
--		GREATER_CONFIGURATION_BMAXPOWER_INDEX: Configuration Descriptor Max Power USB Field Index for Greater Operator
--		GREATER_CONFIGURATION_BMAXPOWER_COUNT: Configuration Descriptor Max Power USB Field Count for Greater Operator
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
--		GREATER_INTERFACE_IINTERFACE_BLENGTH_INDEX: Interface Descriptor String Interface Length USB Field Index for Greater Operator
--		GREATER_INTERFACE_IINTERFACE_BLENGTH_COUNT: Interface Descriptor String Interface Length USB Field Count for Greater Operator
--		GREATER_INTERFACE_IINTERFACE_INDEX: Interface Descriptor String Interface USB Field Index for Greater Operator
--		GREATER_INTERFACE_IINTERFACE_COUNT: Interface Descriptor String Interface USB Field Count for Greater Operator
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
--		GREATER_OTHER_SPEED_BLENGTH_INDEX: Other Speed Descriptor Length USB Field Index for Greater Operator
--		GREATER_OTHER_SPEED_BLENGTH_COUNT: Other Speed Descriptor Length USB Field Count for Greater Operator
--		GREATER_OTHER_SPEED_WTOTALLENGTH_INDEX: Other Speed Descriptor Total Length USB Field Index for Greater Operator
--		GREATER_OTHER_SPEED_WTOTALLENGTH_COUNT: Other Speed Descriptor Total Length USB Field Count for Greater Operator
--		GREATER_OTHER_SPEED_BNUMINTERFACES_INDEX: Other Speed Descriptor Num Interfaces USB Field Index for Greater Operator
--		GREATER_OTHER_SPEED_BNUMINTERFACES_COUNT: Other Speed Descriptor Num Interfaces USB Field Count for Greater Operator
--		GREATER_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX: Other Speed Descriptor Configuration Value USB Field Index for Greater Operator
--		GREATER_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT: Other Speed Descriptor Configuration Value USB Field Count for Greater Operator
--		GREATER_OTHER_SPEED_ICONFIGURATION_BLENGTH_INDEX: Other Speed Descriptor String Configuration Length USB Field Index for Greater Operator
--		GREATER_OTHER_SPEED_ICONFIGURATION_BLENGTH_COUNT: Other Speed Descriptor String Configuration Length USB Field Count for Greater Operator
--		GREATER_OTHER_SPEED_ICONFIGURATION_INDEX: Other Speed Descriptor String Configuration USB Field Index for Greater Operator
--		GREATER_OTHER_SPEED_ICONFIGURATION_COUNT: Other Speed Descriptor String Configuration USB Field Count for Greater Operator
--		GREATER_OTHER_SPEED_BMATTRIBUTES_INDEX: Other Speed Descriptor Attributes USB Field Index for Greater Operator
--		GREATER_OTHER_SPEED_BMATTRIBUTES_COUNT: Other Speed Descriptor Attributes USB Field Count for Greater Operator
--		GREATER_OTHER_SPEED_BMAXPOWER_INDEX: Other Speed Descriptor Max Power USB Field Index for Greater Operator
--		GREATER_OTHER_SPEED_BMAXPOWER_COUNT: Other Speed Descriptor Max Power USB Field Count for Greater Operator
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
--		GREATER_EQUALS_DEVICE_IMANUFACTURER_BLENGTH_INDEX: Device Descriptor String Manufacturer Length USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_DEVICE_IMANUFACTURER_BLENGTH_COUNT: Device Descriptor String Manufacturer Length USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_DEVICE_IMANUFACTURER_INDEX: Device Descriptor String Manufacturer USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_DEVICE_IMANUFACTURER_COUNT: Device Descriptor String Manufacturer USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_DEVICE_IPRODUCT_BLENGTH_INDEX: Device Descriptor String Product Length USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_DEVICE_IPRODUCT_BLENGTH_COUNT: Device Descriptor String Product Length USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_DEVICE_IPRODUCT_INDEX: Device Descriptor String Product USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_DEVICE_IPRODUCT_COUNT: Device Descriptor String Product USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_DEVICE_ISERIALNUMBER_BLENGTH_INDEX: Device Descriptor String Serial Number Length USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_DEVICE_ISERIALNUMBER_BLENGTH_COUNT: Device Descriptor String Serial Number Length USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_DEVICE_ISERIALNUMBER_INDEX: Device Descriptor String Serial Number USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_DEVICE_ISERIALNUMBER_COUNT: Device Descriptor String Serial Number USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_DEVICE_BNUMCONFIGURATIONS_INDEX: Device Descriptor Num Configuration USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_DEVICE_BNUMCONFIGURATIONS_COUNT: Device Descriptor Num Configuration USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_CONFIGURATION_BLENGTH_INDEX: Configuration Descriptor Length USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_CONFIGURATION_BLENGTH_COUNT: Configuration Descriptor Length USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_CONFIGURATION_WTOTALLENGTH_INDEX: Configuration Descriptor Total Length USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_CONFIGURATION_WTOTALLENGTH_COUNT: Configuration Descriptor Total Length USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_CONFIGURATION_BNUMINTERFACES_INDEX: Configuration Descriptor Num Interfaces USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_CONFIGURATION_BNUMINTERFACES_COUNT: Configuration Descriptor Num Interfaces USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_CONFIGURATION_BCONFIGURATIONVALUE_INDEX: Configuration Descriptor Configuration Value USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_CONFIGURATION_BCONFIGURATIONVALUE_COUNT: Configuration Descriptor Configuration Value USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_CONFIGURATION_ICONFIGURATION_BLENGTH_INDEX: Configuration Descriptor String Configuration Length USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_CONFIGURATION_ICONFIGURATION_BLENGTH_COUNT: Configuration Descriptor String Configuration Length USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_CONFIGURATION_ICONFIGURATION_INDEX: Configuration Descriptor String Configuration USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_CONFIGURATION_ICONFIGURATION_COUNT: Configuration Descriptor String Configuration USB Field Coubt for GreaterEquals Operator
--		GREATER_EQUALS_CONFIGURATION_BMATTRIBUTES_INDEX: Configuration Descriptor Attributes USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_CONFIGURATION_BMATTRIBUTES_COUNT: Configuration Descriptor Attributes USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_CONFIGURATION_BMAXPOWER_INDEX: Configuration Descriptor Max Power USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_CONFIGURATION_BMAXPOWER_COUNT: Configuration Descriptor Max Power USB Field Count for GreaterEquals Operator
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
--		GREATER_EQUALS_INTERFACE_IINTERFACE_BLENGTH_INDEX: Interface Descriptor String Interface Length USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_INTERFACE_IINTERFACE_BLENGTH_COUNT: Interface Descriptor String Interface Length USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_INTERFACE_IINTERFACE_INDEX: Interface Descriptor String Interface USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_INTERFACE_IINTERFACE_COUNT: Interface Descriptor String Interface USB Field Count for GreaterEquals Operator
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
--		GREATER_EQUALS_OTHER_SPEED_BLENGTH_INDEX: Other Speed Descriptor Length USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_OTHER_SPEED_BLENGTH_COUNT: Other Speed Descriptor Length USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_OTHER_SPEED_WTOTALLENGTH_INDEX: Other Speed Descriptor Total Length USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_OTHER_SPEED_WTOTALLENGTH_COUNT: Other Speed Descriptor Total Length USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_OTHER_SPEED_BNUMINTERFACES_INDEX: Other Speed Descriptor Num Interfaces USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_OTHER_SPEED_BNUMINTERFACES_COUNT: Other Speed Descriptor Num Interfaces USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX: Other Speed Descriptor Configuration Value USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT: Other Speed Descriptor Configuration Value USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_OTHER_SPEED_ICONFIGURATION_BLENGTH_INDEX: Other Speed Descriptor String Configuration Length USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_OTHER_SPEED_ICONFIGURATION_BLENGTH_COUNT: Other Speed Descriptor String Configuration Length USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_OTHER_SPEED_ICONFIGURATION_INDEX: Other Speed Descriptor String Configuration USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_OTHER_SPEED_ICONFIGURATION_COUNT: Other Speed Descriptor String Configuration USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_OTHER_SPEED_BMATTRIBUTES_INDEX: Other Speed Descriptor Attributes USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_OTHER_SPEED_BMATTRIBUTES_COUNT: Other Speed Descriptor Attributes USB Field Count for GreaterEquals Operator
--		GREATER_EQUALS_OTHER_SPEED_BMAXPOWER_INDEX: Other Speed Descriptor Max Power USB Field Index for GreaterEquals Operator
--		GREATER_EQUALS_OTHER_SPEED_BMAXPOWER_COUNT: Other Speed Descriptor Max Power USB Field Count for GreaterEquals Operator
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
--		LESS_DEVICE_IMANUFACTURER_BLENGTH_INDEX: Device Descriptor String Manufacturer Length USB Field Index for Less Operator
--		LESS_DEVICE_IMANUFACTURER_BLENGTH_COUNT: Device Descriptor String Manufacturer Length USB Field Count for Less Operator
--		LESS_DEVICE_IMANUFACTURER_INDEX: Device Descriptor String Manufacturer USB Field Index for Less Operator
--		LESS_DEVICE_IMANUFACTURER_COUNT: Device Descriptor String Manufacturer USB Field Count for Less Operator
--		LESS_DEVICE_IPRODUCT_BLENGTH_INDEX: Device Descriptor String Product Length USB Field Index for Less Operator
--		LESS_DEVICE_IPRODUCT_BLENGTH_COUNT: Device Descriptor String Product Length USB Field Count for Less Operator
--		LESS_DEVICE_IPRODUCT_INDEX: Device Descriptor String Product USB Field Index for Less Operator
--		LESS_DEVICE_IPRODUCT_COUNT: Device Descriptor String Product USB Field Count for Less Operator
--		LESS_DEVICE_ISERIALNUMBER_BLENGTH_INDEX: Device Descriptor String Serial Number Length USB Field Index for Less Operator
--		LESS_DEVICE_ISERIALNUMBER_BLENGTH_COUNT: Device Descriptor String Serial Number Length USB Field Count for Less Operator
--		LESS_DEVICE_ISERIALNUMBER_INDEX: Device Descriptor String Serial Number USB Field Index for Less Operator
--		LESS_DEVICE_ISERIALNUMBER_COUNT: Device Descriptor String Serial Number USB Field Count for Less Operator
--		LESS_DEVICE_BNUMCONFIGURATIONS_INDEX: Device Descriptor Num Configuration USB Field Index for Less Operator
--		LESS_DEVICE_BNUMCONFIGURATIONS_COUNT: Device Descriptor Num Configuration USB Field Count for Less Operator
--		LESS_CONFIGURATION_BLENGTH_INDEX: Configuration Descriptor Length USB Field Index for Less Operator
--		LESS_CONFIGURATION_BLENGTH_COUNT: Configuration Descriptor Length USB Field Count for Less Operator
--		LESS_CONFIGURATION_WTOTALLENGTH_INDEX: Configuration Descriptor Total Length USB Field Index for Less Operator
--		LESS_CONFIGURATION_WTOTALLENGTH_COUNT: Configuration Descriptor Total Length USB Field Count for Less Operator
--		LESS_CONFIGURATION_BNUMINTERFACES_INDEX: Configuration Descriptor Num Interfaces USB Field Index for Less Operator
--		LESS_CONFIGURATION_BNUMINTERFACES_COUNT: Configuration Descriptor Num Interfaces USB Field Count for Less Operator
--		LESS_CONFIGURATION_BCONFIGURATIONVALUE_INDEX: Configuration Descriptor Configuration Value USB Field Index for Less Operator
--		LESS_CONFIGURATION_BCONFIGURATIONVALUE_COUNT: Configuration Descriptor Configuration Value USB Field Count for Less Operator
--		LESS_CONFIGURATION_ICONFIGURATION_BLENGTH_INDEX: Configuration Descriptor String Configuration Length USB Field Index for Less Operator
--		LESS_CONFIGURATION_ICONFIGURATION_BLENGTH_COUNT: Configuration Descriptor String Configuration Length USB Field Count for Less Operator
--		LESS_CONFIGURATION_ICONFIGURATION_INDEX: Configuration Descriptor String Configuration USB Field Index for Less Operator
--		LESS_CONFIGURATION_ICONFIGURATION_COUNT: Configuration Descriptor String Configuration USB Field Coubt for Less Operator
--		LESS_CONFIGURATION_BMATTRIBUTES_INDEX: Configuration Descriptor Attributes USB Field Index for Less Operator
--		LESS_CONFIGURATION_BMATTRIBUTES_COUNT: Configuration Descriptor Attributes USB Field Count for Less Operator
--		LESS_CONFIGURATION_BMAXPOWER_INDEX: Configuration Descriptor Max Power USB Field Index for Less Operator
--		LESS_CONFIGURATION_BMAXPOWER_COUNT: Configuration Descriptor Max Power USB Field Count for Less Operator
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
--		LESS_INTERFACE_IINTERFACE_BLENGTH_INDEX: Interface Descriptor String Interface Length USB Field Index for Less Operator
--		LESS_INTERFACE_IINTERFACE_BLENGTH_COUNT: Interface Descriptor String Interface Length USB Field Count for Less Operator
--		LESS_INTERFACE_IINTERFACE_INDEX: Interface Descriptor String Interface USB Field Index for Less Operator
--		LESS_INTERFACE_IINTERFACE_COUNT: Interface Descriptor String Interface USB Field Count for Less Operator
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
--		LESS_OTHER_SPEED_BLENGTH_INDEX: Other Speed Descriptor Length USB Field Index for Less Operator
--		LESS_OTHER_SPEED_BLENGTH_COUNT: Other Speed Descriptor Length USB Field Count for Less Operator
--		LESS_OTHER_SPEED_WTOTALLENGTH_INDEX: Other Speed Descriptor Total Length USB Field Index for Less Operator
--		LESS_OTHER_SPEED_WTOTALLENGTH_COUNT: Other Speed Descriptor Total Length USB Field Count for Less Operator
--		LESS_OTHER_SPEED_BNUMINTERFACES_INDEX: Other Speed Descriptor Num Interfaces USB Field Index for Less Operator
--		LESS_OTHER_SPEED_BNUMINTERFACES_COUNT: Other Speed Descriptor Num Interfaces USB Field Count for Less Operator
--		LESS_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX: Other Speed Descriptor Configuration Value USB Field Index for Less Operator
--		LESS_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT: Other Speed Descriptor Configuration Value USB Field Count for Less Operator
--		LESS_OTHER_SPEED_ICONFIGURATION_BLENGTH_INDEX: Other Speed Descriptor String Configuration Length USB Field Index for Less Operator
--		LESS_OTHER_SPEED_ICONFIGURATION_BLENGTH_COUNT: Other Speed Descriptor String Configuration Length USB Field Count for Less Operator
--		LESS_OTHER_SPEED_ICONFIGURATION_INDEX: Other Speed Descriptor String Configuration USB Field Index for Less Operator
--		LESS_OTHER_SPEED_ICONFIGURATION_COUNT: Other Speed Descriptor String Configuration USB Field Count for Less Operator
--		LESS_OTHER_SPEED_BMATTRIBUTES_INDEX: Other Speed Descriptor Attributes USB Field Index for Less Operator
--		LESS_OTHER_SPEED_BMATTRIBUTES_COUNT: Other Speed Descriptor Attributes USB Field Count for Less Operator
--		LESS_OTHER_SPEED_BMAXPOWER_INDEX: Other Speed Descriptor Max Power USB Field Index for Less Operator
--		LESS_OTHER_SPEED_BMAXPOWER_COUNT: Other Speed Descriptor Max Power USB Field Count for Less Operator
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
--		LESS_EQUALS_DEVICE_IMANUFACTURER_BLENGTH_INDEX: Device Descriptor String Manufacturer Length USB Field Index for LessEquals Operator
--		LESS_EQUALS_DEVICE_IMANUFACTURER_BLENGTH_COUNT: Device Descriptor String Manufacturer Length USB Field Count for LessEquals Operator
--		LESS_EQUALS_DEVICE_IMANUFACTURER_INDEX: Device Descriptor String Manufacturer USB Field Index for LessEquals Operator
--		LESS_EQUALS_DEVICE_IMANUFACTURER_COUNT: Device Descriptor String Manufacturer USB Field Count for LessEquals Operator
--		LESS_EQUALS_DEVICE_IPRODUCT_BLENGTH_INDEX: Device Descriptor String Product Length USB Field Index for LessEquals Operator
--		LESS_EQUALS_DEVICE_IPRODUCT_BLENGTH_COUNT: Device Descriptor String Product Length USB Field Count for LessEquals Operator
--		LESS_EQUALS_DEVICE_IPRODUCT_INDEX: Device Descriptor String Product USB Field Index for LessEquals Operator
--		LESS_EQUALS_DEVICE_IPRODUCT_COUNT: Device Descriptor String Product USB Field Count for LessEquals Operator
--		LESS_EQUALS_DEVICE_ISERIALNUMBER_BLENGTH_INDEX: Device Descriptor String Serial Number Length USB Field Index for LessEquals Operator
--		LESS_EQUALS_DEVICE_ISERIALNUMBER_BLENGTH_COUNT: Device Descriptor String Serial Number Length USB Field Count for LessEquals Operator
--		LESS_EQUALS_DEVICE_ISERIALNUMBER_INDEX: Device Descriptor String Serial Number USB Field Index for LessEquals Operator
--		LESS_EQUALS_DEVICE_ISERIALNUMBER_COUNT: Device Descriptor String Serial Number USB Field Count for LessEquals Operator
--		LESS_EQUALS_DEVICE_BNUMCONFIGURATIONS_INDEX: Device Descriptor Num Configuration USB Field Index for LessEquals Operator
--		LESS_EQUALS_DEVICE_BNUMCONFIGURATIONS_COUNT: Device Descriptor Num Configuration USB Field Count for LessEquals Operator
--		LESS_EQUALS_CONFIGURATION_BLENGTH_INDEX: Configuration Descriptor Length USB Field Index for LessEquals Operator
--		LESS_EQUALS_CONFIGURATION_BLENGTH_COUNT: Configuration Descriptor Length USB Field Count for LessEquals Operator
--		LESS_EQUALS_CONFIGURATION_WTOTALLENGTH_INDEX: Configuration Descriptor Total Length USB Field Index for LessEquals Operator
--		LESS_EQUALS_CONFIGURATION_WTOTALLENGTH_COUNT: Configuration Descriptor Total Length USB Field Count for LessEquals Operator
--		LESS_EQUALS_CONFIGURATION_BNUMINTERFACES_INDEX: Configuration Descriptor Num Interfaces USB Field Index for LessEquals Operator
--		LESS_EQUALS_CONFIGURATION_BNUMINTERFACES_COUNT: Configuration Descriptor Num Interfaces USB Field Count for LessEquals Operator
--		LESS_EQUALS_CONFIGURATION_BCONFIGURATIONVALUE_INDEX: Configuration Descriptor Configuration Value USB Field Index for LessEquals Operator
--		LESS_EQUALS_CONFIGURATION_BCONFIGURATIONVALUE_COUNT: Configuration Descriptor Configuration Value USB Field Count for LessEquals Operator
--		LESS_EQUALS_CONFIGURATION_ICONFIGURATION_BLENGTH_INDEX: Configuration Descriptor String Configuration Length USB Field Index for LessEquals Operator
--		LESS_EQUALS_CONFIGURATION_ICONFIGURATION_BLENGTH_COUNT: Configuration Descriptor String Configuration Length USB Field Count for LessEquals Operator
--		LESS_EQUALS_CONFIGURATION_ICONFIGURATION_INDEX: Configuration Descriptor String Configuration USB Field Index for LessEquals Operator
--		LESS_EQUALS_CONFIGURATION_ICONFIGURATION_COUNT: Configuration Descriptor String Configuration USB Field Coubt for LessEquals Operator
--		LESS_EQUALS_CONFIGURATION_BMATTRIBUTES_INDEX: Configuration Descriptor Attributes USB Field Index for LessEquals Operator
--		LESS_EQUALS_CONFIGURATION_BMATTRIBUTES_COUNT: Configuration Descriptor Attributes USB Field Count for LessEquals Operator
--		LESS_EQUALS_CONFIGURATION_BMAXPOWER_INDEX: Configuration Descriptor Max Power USB Field Index for LessEquals Operator
--		LESS_EQUALS_CONFIGURATION_BMAXPOWER_COUNT: Configuration Descriptor Max Power USB Field Count for LessEquals Operator
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
--		LESS_EQUALS_INTERFACE_IINTERFACE_BLENGTH_INDEX: Interface Descriptor String Interface Length USB Field Index for LessEquals Operator
--		LESS_EQUALS_INTERFACE_IINTERFACE_BLENGTH_COUNT: Interface Descriptor String Interface Length USB Field Count for LessEquals Operator
--		LESS_EQUALS_INTERFACE_IINTERFACE_INDEX: Interface Descriptor String Interface USB Field Index for LessEquals Operator
--		LESS_EQUALS_INTERFACE_IINTERFACE_COUNT: Interface Descriptor String Interface USB Field Count for LessEquals Operator
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
--		LESS_EQUALS_OTHER_SPEED_BLENGTH_INDEX: Other Speed Descriptor Length USB Field Index for LessEquals Operator
--		LESS_EQUALS_OTHER_SPEED_BLENGTH_COUNT: Other Speed Descriptor Length USB Field Count for LessEquals Operator
--		LESS_EQUALS_OTHER_SPEED_WTOTALLENGTH_INDEX: Other Speed Descriptor Total Length USB Field Index for LessEquals Operator
--		LESS_EQUALS_OTHER_SPEED_WTOTALLENGTH_COUNT: Other Speed Descriptor Total Length USB Field Count for LessEquals Operator
--		LESS_EQUALS_OTHER_SPEED_BNUMINTERFACES_INDEX: Other Speed Descriptor Num Interfaces USB Field Index for LessEquals Operator
--		LESS_EQUALS_OTHER_SPEED_BNUMINTERFACES_COUNT: Other Speed Descriptor Num Interfaces USB Field Count for LessEquals Operator
--		LESS_EQUALS_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX: Other Speed Descriptor Configuration Value USB Field Index for LessEquals Operator
--		LESS_EQUALS_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT: Other Speed Descriptor Configuration Value USB Field Count for LessEquals Operator
--		LESS_EQUALS_OTHER_SPEED_ICONFIGURATION_BLENGTH_INDEX: Other Speed Descriptor String Configuration Length USB Field Index for LessEquals Operator
--		LESS_EQUALS_OTHER_SPEED_ICONFIGURATION_BLENGTH_COUNT: Other Speed Descriptor String Configuration Length USB Field Count for LessEquals Operator
--		LESS_EQUALS_OTHER_SPEED_ICONFIGURATION_INDEX: Other Speed Descriptor String Configuration USB Field Index for LessEquals Operator
--		LESS_EQUALS_OTHER_SPEED_ICONFIGURATION_COUNT: Other Speed Descriptor String Configuration USB Field Count for LessEquals Operator
--		LESS_EQUALS_OTHER_SPEED_BMATTRIBUTES_INDEX: Other Speed Descriptor Attributes USB Field Index for LessEquals Operator
--		LESS_EQUALS_OTHER_SPEED_BMATTRIBUTES_COUNT: Other Speed Descriptor Attributes USB Field Count for LessEquals Operator
--		LESS_EQUALS_OTHER_SPEED_BMAXPOWER_INDEX: Other Speed Descriptor Max Power USB Field Index for LessEquals Operator
--		LESS_EQUALS_OTHER_SPEED_BMAXPOWER_COUNT: Other Speed Descriptor Max Power USB Field Count for LessEquals Operator
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
--		STARTS_WITH_DEVICE_IMANUFACTURER_BLENGTH_INDEX: Device Descriptor String Manufacturer Length USB Field Index for StartsWith Operator
--		STARTS_WITH_DEVICE_IMANUFACTURER_BLENGTH_COUNT: Device Descriptor String Manufacturer Length USB Field Count for StartsWith Operator
--		STARTS_WITH_DEVICE_IMANUFACTURER_INDEX: Device Descriptor String Manufacturer USB Field Index for StartsWith Operator
--		STARTS_WITH_DEVICE_IMANUFACTURER_COUNT: Device Descriptor String Manufacturer USB Field Count for StartsWith Operator
--		STARTS_WITH_DEVICE_IPRODUCT_BLENGTH_INDEX: Device Descriptor String Product Length USB Field Index for StartsWith Operator
--		STARTS_WITH_DEVICE_IPRODUCT_BLENGTH_COUNT: Device Descriptor String Product Length USB Field Count for StartsWith Operator
--		STARTS_WITH_DEVICE_IPRODUCT_INDEX: Device Descriptor String Product USB Field Index for StartsWith Operator
--		STARTS_WITH_DEVICE_IPRODUCT_COUNT: Device Descriptor String Product USB Field Count for StartsWith Operator
--		STARTS_WITH_DEVICE_ISERIALNUMBER_BLENGTH_INDEX: Device Descriptor String Serial Number Length USB Field Index for StartsWith Operator
--		STARTS_WITH_DEVICE_ISERIALNUMBER_BLENGTH_COUNT: Device Descriptor String Serial Number Length USB Field Count for StartsWith Operator
--		STARTS_WITH_DEVICE_ISERIALNUMBER_INDEX: Device Descriptor String Serial Number USB Field Index for StartsWith Operator
--		STARTS_WITH_DEVICE_ISERIALNUMBER_COUNT: Device Descriptor String Serial Number USB Field Count for StartsWith Operator
--		STARTS_WITH_DEVICE_BNUMCONFIGURATIONS_INDEX: Device Descriptor Num Configuration USB Field Index for StartsWith Operator
--		STARTS_WITH_DEVICE_BNUMCONFIGURATIONS_COUNT: Device Descriptor Num Configuration USB Field Count for StartsWith Operator
--		STARTS_WITH_CONFIGURATION_BLENGTH_INDEX: Configuration Descriptor Length USB Field Index for StartsWith Operator
--		STARTS_WITH_CONFIGURATION_BLENGTH_COUNT: Configuration Descriptor Length USB Field Count for StartsWith Operator
--		STARTS_WITH_CONFIGURATION_WTOTALLENGTH_INDEX: Configuration Descriptor Total Length USB Field Index for StartsWith Operator
--		STARTS_WITH_CONFIGURATION_WTOTALLENGTH_COUNT: Configuration Descriptor Total Length USB Field Count for StartsWith Operator
--		STARTS_WITH_CONFIGURATION_BNUMINTERFACES_INDEX: Configuration Descriptor Num Interfaces USB Field Index for StartsWith Operator
--		STARTS_WITH_CONFIGURATION_BNUMINTERFACES_COUNT: Configuration Descriptor Num Interfaces USB Field Count for StartsWith Operator
--		STARTS_WITH_CONFIGURATION_BCONFIGURATIONVALUE_INDEX: Configuration Descriptor Configuration Value USB Field Index for StartsWith Operator
--		STARTS_WITH_CONFIGURATION_BCONFIGURATIONVALUE_COUNT: Configuration Descriptor Configuration Value USB Field Count for StartsWith Operator
--		STARTS_WITH_CONFIGURATION_ICONFIGURATION_BLENGTH_INDEX: Configuration Descriptor String Configuration Length USB Field Index for StartsWith Operator
--		STARTS_WITH_CONFIGURATION_ICONFIGURATION_BLENGTH_COUNT: Configuration Descriptor String Configuration Length USB Field Count for StartsWith Operator
--		STARTS_WITH_CONFIGURATION_ICONFIGURATION_INDEX: Configuration Descriptor String Configuration USB Field Index for StartsWith Operator
--		STARTS_WITH_CONFIGURATION_ICONFIGURATION_COUNT: Configuration Descriptor String Configuration USB Field Coubt for StartsWith Operator
--		STARTS_WITH_CONFIGURATION_BMATTRIBUTES_INDEX: Configuration Descriptor Attributes USB Field Index for StartsWith Operator
--		STARTS_WITH_CONFIGURATION_BMATTRIBUTES_COUNT: Configuration Descriptor Attributes USB Field Count for StartsWith Operator
--		STARTS_WITH_CONFIGURATION_BMAXPOWER_INDEX: Configuration Descriptor Max Power USB Field Index for StartsWith Operator
--		STARTS_WITH_CONFIGURATION_BMAXPOWER_COUNT: Configuration Descriptor Max Power USB Field Count for StartsWith Operator
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
--		STARTS_WITH_INTERFACE_IINTERFACE_BLENGTH_INDEX: Interface Descriptor String Interface Length USB Field Index for StartsWith Operator
--		STARTS_WITH_INTERFACE_IINTERFACE_BLENGTH_COUNT: Interface Descriptor String Interface Length USB Field Count for StartsWith Operator
--		STARTS_WITH_INTERFACE_IINTERFACE_INDEX: Interface Descriptor String Interface USB Field Index for StartsWith Operator
--		STARTS_WITH_INTERFACE_IINTERFACE_COUNT: Interface Descriptor String Interface USB Field Count for StartsWith Operator
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
--		STARTS_WITH_OTHER_SPEED_BLENGTH_INDEX: Other Speed Descriptor Length USB Field Index for StartsWith Operator
--		STARTS_WITH_OTHER_SPEED_BLENGTH_COUNT: Other Speed Descriptor Length USB Field Count for StartsWith Operator
--		STARTS_WITH_OTHER_SPEED_WTOTALLENGTH_INDEX: Other Speed Descriptor Total Length USB Field Index for StartsWith Operator
--		STARTS_WITH_OTHER_SPEED_WTOTALLENGTH_COUNT: Other Speed Descriptor Total Length USB Field Count for StartsWith Operator
--		STARTS_WITH_OTHER_SPEED_BNUMINTERFACES_INDEX: Other Speed Descriptor Num Interfaces USB Field Index for StartsWith Operator
--		STARTS_WITH_OTHER_SPEED_BNUMINTERFACES_COUNT: Other Speed Descriptor Num Interfaces USB Field Count for StartsWith Operator
--		STARTS_WITH_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX: Other Speed Descriptor Configuration Value USB Field Index for StartsWith Operator
--		STARTS_WITH_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT: Other Speed Descriptor Configuration Value USB Field Count for StartsWith Operator
--		STARTS_WITH_OTHER_SPEED_ICONFIGURATION_BLENGTH_INDEX: Other Speed Descriptor String Configuration Length USB Field Index for StartsWith Operator
--		STARTS_WITH_OTHER_SPEED_ICONFIGURATION_BLENGTH_COUNT: Other Speed Descriptor String Configuration Length USB Field Count for StartsWith Operator
--		STARTS_WITH_OTHER_SPEED_ICONFIGURATION_INDEX: Other Speed Descriptor String Configuration USB Field Index for StartsWith Operator
--		STARTS_WITH_OTHER_SPEED_ICONFIGURATION_COUNT: Other Speed Descriptor String Configuration USB Field Count for StartsWith Operator
--		STARTS_WITH_OTHER_SPEED_BMATTRIBUTES_INDEX: Other Speed Descriptor Attributes USB Field Index for StartsWith Operator
--		STARTS_WITH_OTHER_SPEED_BMATTRIBUTES_COUNT: Other Speed Descriptor Attributes USB Field Count for StartsWith Operator
--		STARTS_WITH_OTHER_SPEED_BMAXPOWER_INDEX: Other Speed Descriptor Max Power USB Field Index for StartsWith Operator
--		STARTS_WITH_OTHER_SPEED_BMAXPOWER_COUNT: Other Speed Descriptor Max Power USB Field Count for StartsWith Operator
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
--		ENDS_WITH_DEVICE_IMANUFACTURER_BLENGTH_INDEX: Device Descriptor String Manufacturer Length USB Field Index for EndsWith Operator
--		ENDS_WITH_DEVICE_IMANUFACTURER_BLENGTH_COUNT: Device Descriptor String Manufacturer Length USB Field Count for EndsWith Operator
--		ENDS_WITH_DEVICE_IMANUFACTURER_INDEX: Device Descriptor String Manufacturer USB Field Index for EndsWith Operator
--		ENDS_WITH_DEVICE_IMANUFACTURER_COUNT: Device Descriptor String Manufacturer USB Field Count for EndsWith Operator
--		ENDS_WITH_DEVICE_IPRODUCT_BLENGTH_INDEX: Device Descriptor String Product Length USB Field Index for EndsWith Operator
--		ENDS_WITH_DEVICE_IPRODUCT_BLENGTH_COUNT: Device Descriptor String Product Length USB Field Count for EndsWith Operator
--		ENDS_WITH_DEVICE_IPRODUCT_INDEX: Device Descriptor String Product USB Field Index for EndsWith Operator
--		ENDS_WITH_DEVICE_IPRODUCT_COUNT: Device Descriptor String Product USB Field Count for EndsWith Operator
--		ENDS_WITH_DEVICE_ISERIALNUMBER_BLENGTH_INDEX: Device Descriptor String Serial Number Length USB Field Index for EndsWith Operator
--		ENDS_WITH_DEVICE_ISERIALNUMBER_BLENGTH_COUNT: Device Descriptor String Serial Number Length USB Field Count for EndsWith Operator
--		ENDS_WITH_DEVICE_ISERIALNUMBER_INDEX: Device Descriptor String Serial Number USB Field Index for EndsWith Operator
--		ENDS_WITH_DEVICE_ISERIALNUMBER_COUNT: Device Descriptor String Serial Number USB Field Count for EndsWith Operator
--		ENDS_WITH_DEVICE_BNUMCONFIGURATIONS_INDEX: Device Descriptor Num Configuration USB Field Index for EndsWith Operator
--		ENDS_WITH_DEVICE_BNUMCONFIGURATIONS_COUNT: Device Descriptor Num Configuration USB Field Count for EndsWith Operator
--		ENDS_WITH_CONFIGURATION_BLENGTH_INDEX: Configuration Descriptor Length USB Field Index for EndsWith Operator
--		ENDS_WITH_CONFIGURATION_BLENGTH_COUNT: Configuration Descriptor Length USB Field Count for EndsWith Operator
--		ENDS_WITH_CONFIGURATION_WTOTALLENGTH_INDEX: Configuration Descriptor Total Length USB Field Index for EndsWith Operator
--		ENDS_WITH_CONFIGURATION_WTOTALLENGTH_COUNT: Configuration Descriptor Total Length USB Field Count for EndsWith Operator
--		ENDS_WITH_CONFIGURATION_BNUMINTERFACES_INDEX: Configuration Descriptor Num Interfaces USB Field Index for EndsWith Operator
--		ENDS_WITH_CONFIGURATION_BNUMINTERFACES_COUNT: Configuration Descriptor Num Interfaces USB Field Count for EndsWith Operator
--		ENDS_WITH_CONFIGURATION_BCONFIGURATIONVALUE_INDEX: Configuration Descriptor Configuration Value USB Field Index for EndsWith Operator
--		ENDS_WITH_CONFIGURATION_BCONFIGURATIONVALUE_COUNT: Configuration Descriptor Configuration Value USB Field Count for EndsWith Operator
--		ENDS_WITH_CONFIGURATION_ICONFIGURATION_BLENGTH_INDEX: Configuration Descriptor String Configuration Length USB Field Index for EndsWith Operator
--		ENDS_WITH_CONFIGURATION_ICONFIGURATION_BLENGTH_COUNT: Configuration Descriptor String Configuration Length USB Field Count for EndsWith Operator
--		ENDS_WITH_CONFIGURATION_ICONFIGURATION_INDEX: Configuration Descriptor String Configuration USB Field Index for EndsWith Operator
--		ENDS_WITH_CONFIGURATION_ICONFIGURATION_COUNT: Configuration Descriptor String Configuration USB Field Coubt for EndsWith Operator
--		ENDS_WITH_CONFIGURATION_BMATTRIBUTES_INDEX: Configuration Descriptor Attributes USB Field Index for EndsWith Operator
--		ENDS_WITH_CONFIGURATION_BMATTRIBUTES_COUNT: Configuration Descriptor Attributes USB Field Count for EndsWith Operator
--		ENDS_WITH_CONFIGURATION_BMAXPOWER_INDEX: Configuration Descriptor Max Power USB Field Index for EndsWith Operator
--		ENDS_WITH_CONFIGURATION_BMAXPOWER_COUNT: Configuration Descriptor Max Power USB Field Count for EndsWith Operator
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
--		ENDS_WITH_INTERFACE_IINTERFACE_BLENGTH_INDEX: Interface Descriptor String Interface Length USB Field Index for EndsWith Operator
--		ENDS_WITH_INTERFACE_IINTERFACE_BLENGTH_COUNT: Interface Descriptor String Interface Length USB Field Count for EndsWith Operator
--		ENDS_WITH_INTERFACE_IINTERFACE_INDEX: Interface Descriptor String Interface USB Field Index for EndsWith Operator
--		ENDS_WITH_INTERFACE_IINTERFACE_COUNT: Interface Descriptor String Interface USB Field Count for EndsWith Operator
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
--		ENDS_WITH_OTHER_SPEED_BLENGTH_INDEX: Other Speed Descriptor Length USB Field Index for EndsWith Operator
--		ENDS_WITH_OTHER_SPEED_BLENGTH_COUNT: Other Speed Descriptor Length USB Field Count for EndsWith Operator
--		ENDS_WITH_OTHER_SPEED_WTOTALLENGTH_INDEX: Other Speed Descriptor Total Length USB Field Index for EndsWith Operator
--		ENDS_WITH_OTHER_SPEED_WTOTALLENGTH_COUNT: Other Speed Descriptor Total Length USB Field Count for EndsWith Operator
--		ENDS_WITH_OTHER_SPEED_BNUMINTERFACES_INDEX: Other Speed Descriptor Num Interfaces USB Field Index for EndsWith Operator
--		ENDS_WITH_OTHER_SPEED_BNUMINTERFACES_COUNT: Other Speed Descriptor Num Interfaces USB Field Count for EndsWith Operator
--		ENDS_WITH_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX: Other Speed Descriptor Configuration Value USB Field Index for EndsWith Operator
--		ENDS_WITH_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT: Other Speed Descriptor Configuration Value USB Field Count for EndsWith Operator
--		ENDS_WITH_OTHER_SPEED_ICONFIGURATION_BLENGTH_INDEX: Other Speed Descriptor String Configuration Length USB Field Index for EndsWith Operator
--		ENDS_WITH_OTHER_SPEED_ICONFIGURATION_BLENGTH_COUNT: Other Speed Descriptor String Configuration Length USB Field Count for EndsWith Operator
--		ENDS_WITH_OTHER_SPEED_ICONFIGURATION_INDEX: Other Speed Descriptor String Configuration USB Field Index for EndsWith Operator
--		ENDS_WITH_OTHER_SPEED_ICONFIGURATION_COUNT: Other Speed Descriptor String Configuration USB Field Count for EndsWith Operator
--		ENDS_WITH_OTHER_SPEED_BMATTRIBUTES_INDEX: Other Speed Descriptor Attributes USB Field Index for EndsWith Operator
--		ENDS_WITH_OTHER_SPEED_BMATTRIBUTES_COUNT: Other Speed Descriptor Attributes USB Field Count for EndsWith Operator
--		ENDS_WITH_OTHER_SPEED_BMAXPOWER_INDEX: Other Speed Descriptor Max Power USB Field Index for EndsWith Operator
--		ENDS_WITH_OTHER_SPEED_BMAXPOWER_COUNT: Other Speed Descriptor Max Power USB Field Count for EndsWith Operator
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
--		CONTAINS_DEVICE_IMANUFACTURER_BLENGTH_INDEX: Device Descriptor String Manufacturer Length USB Field Index for Contains Operator
--		CONTAINS_DEVICE_IMANUFACTURER_BLENGTH_COUNT: Device Descriptor String Manufacturer Length USB Field Count for Contains Operator
--		CONTAINS_DEVICE_IMANUFACTURER_INDEX: Device Descriptor String Manufacturer USB Field Index for Contains Operator
--		CONTAINS_DEVICE_IMANUFACTURER_COUNT: Device Descriptor String Manufacturer USB Field Count for Contains Operator
--		CONTAINS_DEVICE_IPRODUCT_BLENGTH_INDEX: Device Descriptor String Product Length USB Field Index for Contains Operator
--		CONTAINS_DEVICE_IPRODUCT_BLENGTH_COUNT: Device Descriptor String Product Length USB Field Count for Contains Operator
--		CONTAINS_DEVICE_IPRODUCT_INDEX: Device Descriptor String Product USB Field Index for Contains Operator
--		CONTAINS_DEVICE_IPRODUCT_COUNT: Device Descriptor String Product USB Field Count for Contains Operator
--		CONTAINS_DEVICE_ISERIALNUMBER_BLENGTH_INDEX: Device Descriptor String Serial Number Length USB Field Index for Contains Operator
--		CONTAINS_DEVICE_ISERIALNUMBER_BLENGTH_COUNT: Device Descriptor String Serial Number Length USB Field Count for Contains Operator
--		CONTAINS_DEVICE_ISERIALNUMBER_INDEX: Device Descriptor String Serial Number USB Field Index for Contains Operator
--		CONTAINS_DEVICE_ISERIALNUMBER_COUNT: Device Descriptor String Serial Number USB Field Count for Contains Operator
--		CONTAINS_DEVICE_BNUMCONFIGURATIONS_INDEX: Device Descriptor Num Configuration USB Field Index for Contains Operator
--		CONTAINS_DEVICE_BNUMCONFIGURATIONS_COUNT: Device Descriptor Num Configuration USB Field Count for Contains Operator
--		CONTAINS_CONFIGURATION_BLENGTH_INDEX: Configuration Descriptor Length USB Field Index for Contains Operator
--		CONTAINS_CONFIGURATION_BLENGTH_COUNT: Configuration Descriptor Length USB Field Count for Contains Operator
--		CONTAINS_CONFIGURATION_WTOTALLENGTH_INDEX: Configuration Descriptor Total Length USB Field Index for Contains Operator
--		CONTAINS_CONFIGURATION_WTOTALLENGTH_COUNT: Configuration Descriptor Total Length USB Field Count for Contains Operator
--		CONTAINS_CONFIGURATION_BNUMINTERFACES_INDEX: Configuration Descriptor Num Interfaces USB Field Index for Contains Operator
--		CONTAINS_CONFIGURATION_BNUMINTERFACES_COUNT: Configuration Descriptor Num Interfaces USB Field Count for Contains Operator
--		CONTAINS_CONFIGURATION_BCONFIGURATIONVALUE_INDEX: Configuration Descriptor Configuration Value USB Field Index for Contains Operator
--		CONTAINS_CONFIGURATION_BCONFIGURATIONVALUE_COUNT: Configuration Descriptor Configuration Value USB Field Count for Contains Operator
--		CONTAINS_CONFIGURATION_ICONFIGURATION_BLENGTH_INDEX: Configuration Descriptor String Configuration Length USB Field Index for Contains Operator
--		CONTAINS_CONFIGURATION_ICONFIGURATION_BLENGTH_COUNT: Configuration Descriptor String Configuration Length USB Field Count for Contains Operator
--		CONTAINS_CONFIGURATION_ICONFIGURATION_INDEX: Configuration Descriptor String Configuration USB Field Index for Contains Operator
--		CONTAINS_CONFIGURATION_ICONFIGURATION_COUNT: Configuration Descriptor String Configuration USB Field Coubt for Contains Operator
--		CONTAINS_CONFIGURATION_BMATTRIBUTES_INDEX: Configuration Descriptor Attributes USB Field Index for Contains Operator
--		CONTAINS_CONFIGURATION_BMATTRIBUTES_COUNT: Configuration Descriptor Attributes USB Field Count for Contains Operator
--		CONTAINS_CONFIGURATION_BMAXPOWER_INDEX: Configuration Descriptor Max Power USB Field Index for Contains Operator
--		CONTAINS_CONFIGURATION_BMAXPOWER_COUNT: Configuration Descriptor Max Power USB Field Count for Contains Operator
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
--		CONTAINS_INTERFACE_IINTERFACE_BLENGTH_INDEX: Interface Descriptor String Interface Length USB Field Index for Contains Operator
--		CONTAINS_INTERFACE_IINTERFACE_BLENGTH_COUNT: Interface Descriptor String Interface Length USB Field Count for Contains Operator
--		CONTAINS_INTERFACE_IINTERFACE_INDEX: Interface Descriptor String Interface USB Field Index for Contains Operator
--		CONTAINS_INTERFACE_IINTERFACE_COUNT: Interface Descriptor String Interface USB Field Count for Contains Operator
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
--		CONTAINS_OTHER_SPEED_BLENGTH_INDEX: Other Speed Descriptor Length USB Field Index for Contains Operator
--		CONTAINS_OTHER_SPEED_BLENGTH_COUNT: Other Speed Descriptor Length USB Field Count for Contains Operator
--		CONTAINS_OTHER_SPEED_WTOTALLENGTH_INDEX: Other Speed Descriptor Total Length USB Field Index for Contains Operator
--		CONTAINS_OTHER_SPEED_WTOTALLENGTH_COUNT: Other Speed Descriptor Total Length USB Field Count for Contains Operator
--		CONTAINS_OTHER_SPEED_BNUMINTERFACES_INDEX: Other Speed Descriptor Num Interfaces USB Field Index for Contains Operator
--		CONTAINS_OTHER_SPEED_BNUMINTERFACES_COUNT: Other Speed Descriptor Num Interfaces USB Field Count for Contains Operator
--		CONTAINS_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX: Other Speed Descriptor Configuration Value USB Field Index for Contains Operator
--		CONTAINS_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT: Other Speed Descriptor Configuration Value USB Field Count for Contains Operator
--		CONTAINS_OTHER_SPEED_ICONFIGURATION_BLENGTH_INDEX: Other Speed Descriptor String Configuration Length USB Field Index for Contains Operator
--		CONTAINS_OTHER_SPEED_ICONFIGURATION_BLENGTH_COUNT: Other Speed Descriptor String Configuration Length USB Field Count for Contains Operator
--		CONTAINS_OTHER_SPEED_ICONFIGURATION_INDEX: Other Speed Descriptor String Configuration USB Field Index for Contains Operator
--		CONTAINS_OTHER_SPEED_ICONFIGURATION_COUNT: Other Speed Descriptor String Configuration USB Field Count for Contains Operator
--		CONTAINS_OTHER_SPEED_BMATTRIBUTES_INDEX: Other Speed Descriptor Attributes USB Field Index for Contains Operator
--		CONTAINS_OTHER_SPEED_BMATTRIBUTES_COUNT: Other Speed Descriptor Attributes USB Field Count for Contains Operator
--		CONTAINS_OTHER_SPEED_BMAXPOWER_INDEX: Other Speed Descriptor Max Power USB Field Index for Contains Operator
--		CONTAINS_OTHER_SPEED_BMAXPOWER_COUNT: Other Speed Descriptor Max Power USB Field Count for Contains Operator
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
--		NOT_CONTAINS_DEVICE_IMANUFACTURER_BLENGTH_INDEX: Device Descriptor String Manufacturer Length USB Field Index for NotContains Operator
--		NOT_CONTAINS_DEVICE_IMANUFACTURER_BLENGTH_COUNT: Device Descriptor String Manufacturer Length USB Field Count for NotContains Operator
--		NOT_CONTAINS_DEVICE_IMANUFACTURER_INDEX: Device Descriptor String Manufacturer USB Field Index for NotContains Operator
--		NOT_CONTAINS_DEVICE_IMANUFACTURER_COUNT: Device Descriptor String Manufacturer USB Field Count for NotContains Operator
--		NOT_CONTAINS_DEVICE_IPRODUCT_BLENGTH_INDEX: Device Descriptor String Product Length USB Field Index for NotContains Operator
--		NOT_CONTAINS_DEVICE_IPRODUCT_BLENGTH_COUNT: Device Descriptor String Product Length USB Field Count for NotContains Operator
--		NOT_CONTAINS_DEVICE_IPRODUCT_INDEX: Device Descriptor String Product USB Field Index for NotContains Operator
--		NOT_CONTAINS_DEVICE_IPRODUCT_COUNT: Device Descriptor String Product USB Field Count for NotContains Operator
--		NOT_CONTAINS_DEVICE_ISERIALNUMBER_BLENGTH_INDEX: Device Descriptor String Serial Number Length USB Field Index for NotContains Operator
--		NOT_CONTAINS_DEVICE_ISERIALNUMBER_BLENGTH_COUNT: Device Descriptor String Serial Number Length USB Field Count for NotContains Operator
--		NOT_CONTAINS_DEVICE_ISERIALNUMBER_INDEX: Device Descriptor String Serial Number USB Field Index for NotContains Operator
--		NOT_CONTAINS_DEVICE_ISERIALNUMBER_COUNT: Device Descriptor String Serial Number USB Field Count for NotContains Operator
--		NOT_CONTAINS_DEVICE_BNUMCONFIGURATIONS_INDEX: Device Descriptor Num Configuration USB Field Index for NotContains Operator
--		NOT_CONTAINS_DEVICE_BNUMCONFIGURATIONS_COUNT: Device Descriptor Num Configuration USB Field Count for NotContains Operator
--		NOT_CONTAINS_CONFIGURATION_BLENGTH_INDEX: Configuration Descriptor Length USB Field Index for NotContains Operator
--		NOT_CONTAINS_CONFIGURATION_BLENGTH_COUNT: Configuration Descriptor Length USB Field Count for NotContains Operator
--		NOT_CONTAINS_CONFIGURATION_WTOTALLENGTH_INDEX: Configuration Descriptor Total Length USB Field Index for NotContains Operator
--		NOT_CONTAINS_CONFIGURATION_WTOTALLENGTH_COUNT: Configuration Descriptor Total Length USB Field Count for NotContains Operator
--		NOT_CONTAINS_CONFIGURATION_BNUMINTERFACES_INDEX: Configuration Descriptor Num Interfaces USB Field Index for NotContains Operator
--		NOT_CONTAINS_CONFIGURATION_BNUMINTERFACES_COUNT: Configuration Descriptor Num Interfaces USB Field Count for NotContains Operator
--		NOT_CONTAINS_CONFIGURATION_BCONFIGURATIONVALUE_INDEX: Configuration Descriptor Configuration Value USB Field Index for NotContains Operator
--		NOT_CONTAINS_CONFIGURATION_BCONFIGURATIONVALUE_COUNT: Configuration Descriptor Configuration Value USB Field Count for NotContains Operator
--		NOT_CONTAINS_CONFIGURATION_ICONFIGURATION_BLENGTH_INDEX: Configuration Descriptor String Configuration Length USB Field Index for NotContains Operator
--		NOT_CONTAINS_CONFIGURATION_ICONFIGURATION_BLENGTH_COUNT: Configuration Descriptor String Configuration Length USB Field Count for NotContains Operator
--		NOT_CONTAINS_CONFIGURATION_ICONFIGURATION_INDEX: Configuration Descriptor String Configuration USB Field Index for NotContains Operator
--		NOT_CONTAINS_CONFIGURATION_ICONFIGURATION_COUNT: Configuration Descriptor String Configuration USB Field Coubt for NotContains Operator
--		NOT_CONTAINS_CONFIGURATION_BMATTRIBUTES_INDEX: Configuration Descriptor Attributes USB Field Index for NotContains Operator
--		NOT_CONTAINS_CONFIGURATION_BMATTRIBUTES_COUNT: Configuration Descriptor Attributes USB Field Count for NotContains Operator
--		NOT_CONTAINS_CONFIGURATION_BMAXPOWER_INDEX: Configuration Descriptor Max Power USB Field Index for NotContains Operator
--		NOT_CONTAINS_CONFIGURATION_BMAXPOWER_COUNT: Configuration Descriptor Max Power USB Field Count for NotContains Operator
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
--		NOT_CONTAINS_INTERFACE_IINTERFACE_BLENGTH_INDEX: Interface Descriptor String Interface Length USB Field Index for NotContains Operator
--		NOT_CONTAINS_INTERFACE_IINTERFACE_BLENGTH_COUNT: Interface Descriptor String Interface Length USB Field Count for NotContains Operator
--		NOT_CONTAINS_INTERFACE_IINTERFACE_INDEX: Interface Descriptor String Interface USB Field Index for NotContains Operator
--		NOT_CONTAINS_INTERFACE_IINTERFACE_COUNT: Interface Descriptor String Interface USB Field Count for NotContains Operator
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
--		NOT_CONTAINS_OTHER_SPEED_BLENGTH_INDEX: Other Speed Descriptor Length USB Field Index for NotContains Operator
--		NOT_CONTAINS_OTHER_SPEED_BLENGTH_COUNT: Other Speed Descriptor Length USB Field Count for NotContains Operator
--		NOT_CONTAINS_OTHER_SPEED_WTOTALLENGTH_INDEX: Other Speed Descriptor Total Length USB Field Index for NotContains Operator
--		NOT_CONTAINS_OTHER_SPEED_WTOTALLENGTH_COUNT: Other Speed Descriptor Total Length USB Field Count for NotContains Operator
--		NOT_CONTAINS_OTHER_SPEED_BNUMINTERFACES_INDEX: Other Speed Descriptor Num Interfaces USB Field Index for NotContains Operator
--		NOT_CONTAINS_OTHER_SPEED_BNUMINTERFACES_COUNT: Other Speed Descriptor Num Interfaces USB Field Count for NotContains Operator
--		NOT_CONTAINS_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX: Other Speed Descriptor Configuration Value USB Field Index for NotContains Operator
--		NOT_CONTAINS_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT: Other Speed Descriptor Configuration Value USB Field Count for NotContains Operator
--		NOT_CONTAINS_OTHER_SPEED_ICONFIGURATION_BLENGTH_INDEX: Other Speed Descriptor String Configuration Length USB Field Index for NotContains Operator
--		NOT_CONTAINS_OTHER_SPEED_ICONFIGURATION_BLENGTH_COUNT: Other Speed Descriptor String Configuration Length USB Field Count for NotContains Operator
--		NOT_CONTAINS_OTHER_SPEED_ICONFIGURATION_INDEX: Other Speed Descriptor String Configuration USB Field Index for NotContains Operator
--		NOT_CONTAINS_OTHER_SPEED_ICONFIGURATION_COUNT: Other Speed Descriptor String Configuration USB Field Count for NotContains Operator
--		NOT_CONTAINS_OTHER_SPEED_BMATTRIBUTES_INDEX: Other Speed Descriptor Attributes USB Field Index for NotContains Operator
--		NOT_CONTAINS_OTHER_SPEED_BMATTRIBUTES_COUNT: Other Speed Descriptor Attributes USB Field Count for NotContains Operator
--		NOT_CONTAINS_OTHER_SPEED_BMAXPOWER_INDEX: Other Speed Descriptor Max Power USB Field Index for NotContains Operator
--		NOT_CONTAINS_OTHER_SPEED_BMAXPOWER_COUNT: Other Speed Descriptor Max Power USB Field Count for NotContains Operator
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

ENTITY USBVerifier is

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
	EQUALS_DEVICE_IMANUFACTURER_BLENGTH_INDEX: INTEGER := 0;
	EQUALS_DEVICE_IMANUFACTURER_BLENGTH_COUNT: INTEGER := 0;
	EQUALS_DEVICE_IMANUFACTURER_INDEX: INTEGER := 0;
	EQUALS_DEVICE_IMANUFACTURER_COUNT: INTEGER := 0;
	EQUALS_DEVICE_IPRODUCT_BLENGTH_INDEX: INTEGER := 0;
	EQUALS_DEVICE_IPRODUCT_BLENGTH_COUNT: INTEGER := 0;
	EQUALS_DEVICE_IPRODUCT_INDEX: INTEGER := 0;
	EQUALS_DEVICE_IPRODUCT_COUNT: INTEGER := 0;
	EQUALS_DEVICE_ISERIALNUMBER_BLENGTH_INDEX: INTEGER := 0;
	EQUALS_DEVICE_ISERIALNUMBER_BLENGTH_COUNT: INTEGER := 0;
	EQUALS_DEVICE_ISERIALNUMBER_INDEX: INTEGER := 0;
	EQUALS_DEVICE_ISERIALNUMBER_COUNT: INTEGER := 0;
	EQUALS_DEVICE_BNUMCONFIGURATIONS_INDEX: INTEGER := 0;
	EQUALS_DEVICE_BNUMCONFIGURATIONS_COUNT: INTEGER := 0;
	EQUALS_CONFIGURATION_BLENGTH_INDEX: INTEGER := 0;
	EQUALS_CONFIGURATION_BLENGTH_COUNT: INTEGER := 0;
	EQUALS_CONFIGURATION_WTOTALLENGTH_INDEX: INTEGER := 0;
	EQUALS_CONFIGURATION_WTOTALLENGTH_COUNT: INTEGER := 0;
	EQUALS_CONFIGURATION_BNUMINTERFACES_INDEX: INTEGER := 0;
	EQUALS_CONFIGURATION_BNUMINTERFACES_COUNT: INTEGER := 0;
	EQUALS_CONFIGURATION_BCONFIGURATIONVALUE_INDEX: INTEGER := 0;
	EQUALS_CONFIGURATION_BCONFIGURATIONVALUE_COUNT: INTEGER := 0;
	EQUALS_CONFIGURATION_ICONFIGURATION_BLENGTH_INDEX: INTEGER := 0;
	EQUALS_CONFIGURATION_ICONFIGURATION_BLENGTH_COUNT: INTEGER := 0;
	EQUALS_CONFIGURATION_ICONFIGURATION_INDEX: INTEGER := 0;
	EQUALS_CONFIGURATION_ICONFIGURATION_COUNT: INTEGER := 0;
	EQUALS_CONFIGURATION_BMATTRIBUTES_INDEX: INTEGER := 0;
	EQUALS_CONFIGURATION_BMATTRIBUTES_COUNT: INTEGER := 0;
	EQUALS_CONFIGURATION_BMAXPOWER_INDEX: INTEGER := 0;
	EQUALS_CONFIGURATION_BMAXPOWER_COUNT: INTEGER := 0;
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
	EQUALS_INTERFACE_IINTERFACE_BLENGTH_INDEX: INTEGER := 0;
	EQUALS_INTERFACE_IINTERFACE_BLENGTH_COUNT: INTEGER := 0;
	EQUALS_INTERFACE_IINTERFACE_INDEX: INTEGER := 0;
	EQUALS_INTERFACE_IINTERFACE_COUNT: INTEGER := 0;
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
	EQUALS_OTHER_SPEED_BLENGTH_INDEX: INTEGER := 0;
	EQUALS_OTHER_SPEED_BLENGTH_COUNT: INTEGER := 0;
	EQUALS_OTHER_SPEED_WTOTALLENGTH_INDEX: INTEGER := 0;
	EQUALS_OTHER_SPEED_WTOTALLENGTH_COUNT: INTEGER := 0;
	EQUALS_OTHER_SPEED_BNUMINTERFACES_INDEX: INTEGER := 0;
	EQUALS_OTHER_SPEED_BNUMINTERFACES_COUNT: INTEGER := 0;
	EQUALS_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX: INTEGER := 0;
	EQUALS_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT: INTEGER := 0;
	EQUALS_OTHER_SPEED_ICONFIGURATION_BLENGTH_INDEX: INTEGER := 0;
	EQUALS_OTHER_SPEED_ICONFIGURATION_BLENGTH_COUNT: INTEGER := 0;
	EQUALS_OTHER_SPEED_ICONFIGURATION_INDEX: INTEGER := 0;
	EQUALS_OTHER_SPEED_ICONFIGURATION_COUNT: INTEGER := 0;
	EQUALS_OTHER_SPEED_BMATTRIBUTES_INDEX: INTEGER := 0;
	EQUALS_OTHER_SPEED_BMATTRIBUTES_COUNT: INTEGER := 0;
	EQUALS_OTHER_SPEED_BMAXPOWER_INDEX: INTEGER := 0;
	EQUALS_OTHER_SPEED_BMAXPOWER_COUNT: INTEGER := 0;

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
	NOT_EQUALS_DEVICE_IMANUFACTURER_BLENGTH_INDEX: INTEGER := 0;
	NOT_EQUALS_DEVICE_IMANUFACTURER_BLENGTH_COUNT: INTEGER := 0;
	NOT_EQUALS_DEVICE_IMANUFACTURER_INDEX: INTEGER := 0;
	NOT_EQUALS_DEVICE_IMANUFACTURER_COUNT: INTEGER := 0;
	NOT_EQUALS_DEVICE_IPRODUCT_BLENGTH_INDEX: INTEGER := 0;
	NOT_EQUALS_DEVICE_IPRODUCT_BLENGTH_COUNT: INTEGER := 0;
	NOT_EQUALS_DEVICE_IPRODUCT_INDEX: INTEGER := 0;
	NOT_EQUALS_DEVICE_IPRODUCT_COUNT: INTEGER := 0;
	NOT_EQUALS_DEVICE_ISERIALNUMBER_BLENGTH_INDEX: INTEGER := 0;
	NOT_EQUALS_DEVICE_ISERIALNUMBER_BLENGTH_COUNT: INTEGER := 0;
	NOT_EQUALS_DEVICE_ISERIALNUMBER_INDEX: INTEGER := 0;
	NOT_EQUALS_DEVICE_ISERIALNUMBER_COUNT: INTEGER := 0;
	NOT_EQUALS_DEVICE_BNUMCONFIGURATIONS_INDEX: INTEGER := 0;
	NOT_EQUALS_DEVICE_BNUMCONFIGURATIONS_COUNT: INTEGER := 0;
	NOT_EQUALS_CONFIGURATION_BLENGTH_INDEX: INTEGER := 0;
	NOT_EQUALS_CONFIGURATION_BLENGTH_COUNT: INTEGER := 0;
	NOT_EQUALS_CONFIGURATION_WTOTALLENGTH_INDEX: INTEGER := 0;
	NOT_EQUALS_CONFIGURATION_WTOTALLENGTH_COUNT: INTEGER := 0;
	NOT_EQUALS_CONFIGURATION_BNUMINTERFACES_INDEX: INTEGER := 0;
	NOT_EQUALS_CONFIGURATION_BNUMINTERFACES_COUNT: INTEGER := 0;
	NOT_EQUALS_CONFIGURATION_BCONFIGURATIONVALUE_INDEX: INTEGER := 0;
	NOT_EQUALS_CONFIGURATION_BCONFIGURATIONVALUE_COUNT: INTEGER := 0;
	NOT_EQUALS_CONFIGURATION_ICONFIGURATION_BLENGTH_INDEX: INTEGER := 0;
	NOT_EQUALS_CONFIGURATION_ICONFIGURATION_BLENGTH_COUNT: INTEGER := 0;
	NOT_EQUALS_CONFIGURATION_ICONFIGURATION_INDEX: INTEGER := 0;
	NOT_EQUALS_CONFIGURATION_ICONFIGURATION_COUNT: INTEGER := 0;
	NOT_EQUALS_CONFIGURATION_BMATTRIBUTES_INDEX: INTEGER := 0;
	NOT_EQUALS_CONFIGURATION_BMATTRIBUTES_COUNT: INTEGER := 0;
	NOT_EQUALS_CONFIGURATION_BMAXPOWER_INDEX: INTEGER := 0;
	NOT_EQUALS_CONFIGURATION_BMAXPOWER_COUNT: INTEGER := 0;
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
	NOT_EQUALS_INTERFACE_IINTERFACE_BLENGTH_INDEX: INTEGER := 0;
	NOT_EQUALS_INTERFACE_IINTERFACE_BLENGTH_COUNT: INTEGER := 0;
	NOT_EQUALS_INTERFACE_IINTERFACE_INDEX: INTEGER := 0;
	NOT_EQUALS_INTERFACE_IINTERFACE_COUNT: INTEGER := 0;
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
	NOT_EQUALS_OTHER_SPEED_BLENGTH_INDEX: INTEGER := 0;
	NOT_EQUALS_OTHER_SPEED_BLENGTH_COUNT: INTEGER := 0;
	NOT_EQUALS_OTHER_SPEED_WTOTALLENGTH_INDEX: INTEGER := 0;
	NOT_EQUALS_OTHER_SPEED_WTOTALLENGTH_COUNT: INTEGER := 0;
	NOT_EQUALS_OTHER_SPEED_BNUMINTERFACES_INDEX: INTEGER := 0;
	NOT_EQUALS_OTHER_SPEED_BNUMINTERFACES_COUNT: INTEGER := 0;
	NOT_EQUALS_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX: INTEGER := 0;
	NOT_EQUALS_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT: INTEGER := 0;
	NOT_EQUALS_OTHER_SPEED_ICONFIGURATION_BLENGTH_INDEX: INTEGER := 0;
	NOT_EQUALS_OTHER_SPEED_ICONFIGURATION_BLENGTH_COUNT: INTEGER := 0;
	NOT_EQUALS_OTHER_SPEED_ICONFIGURATION_INDEX: INTEGER := 0;
	NOT_EQUALS_OTHER_SPEED_ICONFIGURATION_COUNT: INTEGER := 0;
	NOT_EQUALS_OTHER_SPEED_BMATTRIBUTES_INDEX: INTEGER := 0;
	NOT_EQUALS_OTHER_SPEED_BMATTRIBUTES_COUNT: INTEGER := 0;
	NOT_EQUALS_OTHER_SPEED_BMAXPOWER_INDEX: INTEGER := 0;
	NOT_EQUALS_OTHER_SPEED_BMAXPOWER_COUNT: INTEGER := 0;

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
	GREATER_DEVICE_IMANUFACTURER_BLENGTH_INDEX: INTEGER := 0;
	GREATER_DEVICE_IMANUFACTURER_BLENGTH_COUNT: INTEGER := 0;
	GREATER_DEVICE_IMANUFACTURER_INDEX: INTEGER := 0;
	GREATER_DEVICE_IMANUFACTURER_COUNT: INTEGER := 0;
	GREATER_DEVICE_IPRODUCT_BLENGTH_INDEX: INTEGER := 0;
	GREATER_DEVICE_IPRODUCT_BLENGTH_COUNT: INTEGER := 0;
	GREATER_DEVICE_IPRODUCT_INDEX: INTEGER := 0;
	GREATER_DEVICE_IPRODUCT_COUNT: INTEGER := 0;
	GREATER_DEVICE_ISERIALNUMBER_BLENGTH_INDEX: INTEGER := 0;
	GREATER_DEVICE_ISERIALNUMBER_BLENGTH_COUNT: INTEGER := 0;
	GREATER_DEVICE_ISERIALNUMBER_INDEX: INTEGER := 0;
	GREATER_DEVICE_ISERIALNUMBER_COUNT: INTEGER := 0;
	GREATER_DEVICE_BNUMCONFIGURATIONS_INDEX: INTEGER := 0;
	GREATER_DEVICE_BNUMCONFIGURATIONS_COUNT: INTEGER := 0;
	GREATER_CONFIGURATION_BLENGTH_INDEX: INTEGER := 0;
	GREATER_CONFIGURATION_BLENGTH_COUNT: INTEGER := 0;
	GREATER_CONFIGURATION_WTOTALLENGTH_INDEX: INTEGER := 0;
	GREATER_CONFIGURATION_WTOTALLENGTH_COUNT: INTEGER := 0;
	GREATER_CONFIGURATION_BNUMINTERFACES_INDEX: INTEGER := 0;
	GREATER_CONFIGURATION_BNUMINTERFACES_COUNT: INTEGER := 0;
	GREATER_CONFIGURATION_BCONFIGURATIONVALUE_INDEX: INTEGER := 0;
	GREATER_CONFIGURATION_BCONFIGURATIONVALUE_COUNT: INTEGER := 0;
	GREATER_CONFIGURATION_ICONFIGURATION_BLENGTH_INDEX: INTEGER := 0;
	GREATER_CONFIGURATION_ICONFIGURATION_BLENGTH_COUNT: INTEGER := 0;
	GREATER_CONFIGURATION_ICONFIGURATION_INDEX: INTEGER := 0;
	GREATER_CONFIGURATION_ICONFIGURATION_COUNT: INTEGER := 0;
	GREATER_CONFIGURATION_BMATTRIBUTES_INDEX: INTEGER := 0;
	GREATER_CONFIGURATION_BMATTRIBUTES_COUNT: INTEGER := 0;
	GREATER_CONFIGURATION_BMAXPOWER_INDEX: INTEGER := 0;
	GREATER_CONFIGURATION_BMAXPOWER_COUNT: INTEGER := 0;
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
	GREATER_INTERFACE_IINTERFACE_BLENGTH_INDEX: INTEGER := 0;
	GREATER_INTERFACE_IINTERFACE_BLENGTH_COUNT: INTEGER := 0;
	GREATER_INTERFACE_IINTERFACE_INDEX: INTEGER := 0;
	GREATER_INTERFACE_IINTERFACE_COUNT: INTEGER := 0;
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
	GREATER_OTHER_SPEED_BLENGTH_INDEX: INTEGER := 0;
	GREATER_OTHER_SPEED_BLENGTH_COUNT: INTEGER := 0;
	GREATER_OTHER_SPEED_WTOTALLENGTH_INDEX: INTEGER := 0;
	GREATER_OTHER_SPEED_WTOTALLENGTH_COUNT: INTEGER := 0;
	GREATER_OTHER_SPEED_BNUMINTERFACES_INDEX: INTEGER := 0;
	GREATER_OTHER_SPEED_BNUMINTERFACES_COUNT: INTEGER := 0;
	GREATER_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX: INTEGER := 0;
	GREATER_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT: INTEGER := 0;
	GREATER_OTHER_SPEED_ICONFIGURATION_BLENGTH_INDEX: INTEGER := 0;
	GREATER_OTHER_SPEED_ICONFIGURATION_BLENGTH_COUNT: INTEGER := 0;
	GREATER_OTHER_SPEED_ICONFIGURATION_INDEX: INTEGER := 0;
	GREATER_OTHER_SPEED_ICONFIGURATION_COUNT: INTEGER := 0;
	GREATER_OTHER_SPEED_BMATTRIBUTES_INDEX: INTEGER := 0;
	GREATER_OTHER_SPEED_BMATTRIBUTES_COUNT: INTEGER := 0;
	GREATER_OTHER_SPEED_BMAXPOWER_INDEX: INTEGER := 0;
	GREATER_OTHER_SPEED_BMAXPOWER_COUNT: INTEGER := 0;

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
	GREATER_EQUALS_DEVICE_IMANUFACTURER_BLENGTH_INDEX: INTEGER := 0;
	GREATER_EQUALS_DEVICE_IMANUFACTURER_BLENGTH_COUNT: INTEGER := 0;
	GREATER_EQUALS_DEVICE_IMANUFACTURER_INDEX: INTEGER := 0;
	GREATER_EQUALS_DEVICE_IMANUFACTURER_COUNT: INTEGER := 0;
	GREATER_EQUALS_DEVICE_IPRODUCT_BLENGTH_INDEX: INTEGER := 0;
	GREATER_EQUALS_DEVICE_IPRODUCT_BLENGTH_COUNT: INTEGER := 0;
	GREATER_EQUALS_DEVICE_IPRODUCT_INDEX: INTEGER := 0;
	GREATER_EQUALS_DEVICE_IPRODUCT_COUNT: INTEGER := 0;
	GREATER_EQUALS_DEVICE_ISERIALNUMBER_BLENGTH_INDEX: INTEGER := 0;
	GREATER_EQUALS_DEVICE_ISERIALNUMBER_BLENGTH_COUNT: INTEGER := 0;
	GREATER_EQUALS_DEVICE_ISERIALNUMBER_INDEX: INTEGER := 0;
	GREATER_EQUALS_DEVICE_ISERIALNUMBER_COUNT: INTEGER := 0;
	GREATER_EQUALS_DEVICE_BNUMCONFIGURATIONS_INDEX: INTEGER := 0;
	GREATER_EQUALS_DEVICE_BNUMCONFIGURATIONS_COUNT: INTEGER := 0;
	GREATER_EQUALS_CONFIGURATION_BLENGTH_INDEX: INTEGER := 0;
	GREATER_EQUALS_CONFIGURATION_BLENGTH_COUNT: INTEGER := 0;
	GREATER_EQUALS_CONFIGURATION_WTOTALLENGTH_INDEX: INTEGER := 0;
	GREATER_EQUALS_CONFIGURATION_WTOTALLENGTH_COUNT: INTEGER := 0;
	GREATER_EQUALS_CONFIGURATION_BNUMINTERFACES_INDEX: INTEGER := 0;
	GREATER_EQUALS_CONFIGURATION_BNUMINTERFACES_COUNT: INTEGER := 0;
	GREATER_EQUALS_CONFIGURATION_BCONFIGURATIONVALUE_INDEX: INTEGER := 0;
	GREATER_EQUALS_CONFIGURATION_BCONFIGURATIONVALUE_COUNT: INTEGER := 0;
	GREATER_EQUALS_CONFIGURATION_ICONFIGURATION_BLENGTH_INDEX: INTEGER := 0;
	GREATER_EQUALS_CONFIGURATION_ICONFIGURATION_BLENGTH_COUNT: INTEGER := 0;
	GREATER_EQUALS_CONFIGURATION_ICONFIGURATION_INDEX: INTEGER := 0;
	GREATER_EQUALS_CONFIGURATION_ICONFIGURATION_COUNT: INTEGER := 0;
	GREATER_EQUALS_CONFIGURATION_BMATTRIBUTES_INDEX: INTEGER := 0;
	GREATER_EQUALS_CONFIGURATION_BMATTRIBUTES_COUNT: INTEGER := 0;
	GREATER_EQUALS_CONFIGURATION_BMAXPOWER_INDEX: INTEGER := 0;
	GREATER_EQUALS_CONFIGURATION_BMAXPOWER_COUNT: INTEGER := 0;
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
	GREATER_EQUALS_INTERFACE_IINTERFACE_BLENGTH_INDEX: INTEGER := 0;
	GREATER_EQUALS_INTERFACE_IINTERFACE_BLENGTH_COUNT: INTEGER := 0;
	GREATER_EQUALS_INTERFACE_IINTERFACE_INDEX: INTEGER := 0;
	GREATER_EQUALS_INTERFACE_IINTERFACE_COUNT: INTEGER := 0;
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
	GREATER_EQUALS_OTHER_SPEED_BLENGTH_INDEX: INTEGER := 0;
	GREATER_EQUALS_OTHER_SPEED_BLENGTH_COUNT: INTEGER := 0;
	GREATER_EQUALS_OTHER_SPEED_WTOTALLENGTH_INDEX: INTEGER := 0;
	GREATER_EQUALS_OTHER_SPEED_WTOTALLENGTH_COUNT: INTEGER := 0;
	GREATER_EQUALS_OTHER_SPEED_BNUMINTERFACES_INDEX: INTEGER := 0;
	GREATER_EQUALS_OTHER_SPEED_BNUMINTERFACES_COUNT: INTEGER := 0;
	GREATER_EQUALS_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX: INTEGER := 0;
	GREATER_EQUALS_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT: INTEGER := 0;
	GREATER_EQUALS_OTHER_SPEED_ICONFIGURATION_BLENGTH_INDEX: INTEGER := 0;
	GREATER_EQUALS_OTHER_SPEED_ICONFIGURATION_BLENGTH_COUNT: INTEGER := 0;
	GREATER_EQUALS_OTHER_SPEED_ICONFIGURATION_INDEX: INTEGER := 0;
	GREATER_EQUALS_OTHER_SPEED_ICONFIGURATION_COUNT: INTEGER := 0;
	GREATER_EQUALS_OTHER_SPEED_BMATTRIBUTES_INDEX: INTEGER := 0;
	GREATER_EQUALS_OTHER_SPEED_BMATTRIBUTES_COUNT: INTEGER := 0;
	GREATER_EQUALS_OTHER_SPEED_BMAXPOWER_INDEX: INTEGER := 0;
	GREATER_EQUALS_OTHER_SPEED_BMAXPOWER_COUNT: INTEGER := 0;

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
	LESS_DEVICE_IMANUFACTURER_BLENGTH_INDEX: INTEGER := 0;
	LESS_DEVICE_IMANUFACTURER_BLENGTH_COUNT: INTEGER := 0;
	LESS_DEVICE_IMANUFACTURER_INDEX: INTEGER := 0;
	LESS_DEVICE_IMANUFACTURER_COUNT: INTEGER := 0;
	LESS_DEVICE_IPRODUCT_BLENGTH_INDEX: INTEGER := 0;
	LESS_DEVICE_IPRODUCT_BLENGTH_COUNT: INTEGER := 0;
	LESS_DEVICE_IPRODUCT_INDEX: INTEGER := 0;
	LESS_DEVICE_IPRODUCT_COUNT: INTEGER := 0;
	LESS_DEVICE_ISERIALNUMBER_BLENGTH_INDEX: INTEGER := 0;
	LESS_DEVICE_ISERIALNUMBER_BLENGTH_COUNT: INTEGER := 0;
	LESS_DEVICE_ISERIALNUMBER_INDEX: INTEGER := 0;
	LESS_DEVICE_ISERIALNUMBER_COUNT: INTEGER := 0;
	LESS_DEVICE_BNUMCONFIGURATIONS_INDEX: INTEGER := 0;
	LESS_DEVICE_BNUMCONFIGURATIONS_COUNT: INTEGER := 0;
	LESS_CONFIGURATION_BLENGTH_INDEX: INTEGER := 0;
	LESS_CONFIGURATION_BLENGTH_COUNT: INTEGER := 0;
	LESS_CONFIGURATION_WTOTALLENGTH_INDEX: INTEGER := 0;
	LESS_CONFIGURATION_WTOTALLENGTH_COUNT: INTEGER := 0;
	LESS_CONFIGURATION_BNUMINTERFACES_INDEX: INTEGER := 0;
	LESS_CONFIGURATION_BNUMINTERFACES_COUNT: INTEGER := 0;
	LESS_CONFIGURATION_BCONFIGURATIONVALUE_INDEX: INTEGER := 0;
	LESS_CONFIGURATION_BCONFIGURATIONVALUE_COUNT: INTEGER := 0;
	LESS_CONFIGURATION_ICONFIGURATION_BLENGTH_INDEX: INTEGER := 0;
	LESS_CONFIGURATION_ICONFIGURATION_BLENGTH_COUNT: INTEGER := 0;
	LESS_CONFIGURATION_ICONFIGURATION_INDEX: INTEGER := 0;
	LESS_CONFIGURATION_ICONFIGURATION_COUNT: INTEGER := 0;
	LESS_CONFIGURATION_BMATTRIBUTES_INDEX: INTEGER := 0;
	LESS_CONFIGURATION_BMATTRIBUTES_COUNT: INTEGER := 0;
	LESS_CONFIGURATION_BMAXPOWER_INDEX: INTEGER := 0;
	LESS_CONFIGURATION_BMAXPOWER_COUNT: INTEGER := 0;
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
	LESS_INTERFACE_IINTERFACE_BLENGTH_INDEX: INTEGER := 0;
	LESS_INTERFACE_IINTERFACE_BLENGTH_COUNT: INTEGER := 0;
	LESS_INTERFACE_IINTERFACE_INDEX: INTEGER := 0;
	LESS_INTERFACE_IINTERFACE_COUNT: INTEGER := 0;
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
	LESS_OTHER_SPEED_BLENGTH_INDEX: INTEGER := 0;
	LESS_OTHER_SPEED_BLENGTH_COUNT: INTEGER := 0;
	LESS_OTHER_SPEED_WTOTALLENGTH_INDEX: INTEGER := 0;
	LESS_OTHER_SPEED_WTOTALLENGTH_COUNT: INTEGER := 0;
	LESS_OTHER_SPEED_BNUMINTERFACES_INDEX: INTEGER := 0;
	LESS_OTHER_SPEED_BNUMINTERFACES_COUNT: INTEGER := 0;
	LESS_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX: INTEGER := 0;
	LESS_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT: INTEGER := 0;
	LESS_OTHER_SPEED_ICONFIGURATION_BLENGTH_INDEX: INTEGER := 0;
	LESS_OTHER_SPEED_ICONFIGURATION_BLENGTH_COUNT: INTEGER := 0;
	LESS_OTHER_SPEED_ICONFIGURATION_INDEX: INTEGER := 0;
	LESS_OTHER_SPEED_ICONFIGURATION_COUNT: INTEGER := 0;
	LESS_OTHER_SPEED_BMATTRIBUTES_INDEX: INTEGER := 0;
	LESS_OTHER_SPEED_BMATTRIBUTES_COUNT: INTEGER := 0;
	LESS_OTHER_SPEED_BMAXPOWER_INDEX: INTEGER := 0;
	LESS_OTHER_SPEED_BMAXPOWER_COUNT: INTEGER := 0;

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
	LESS_EQUALS_DEVICE_IMANUFACTURER_BLENGTH_INDEX: INTEGER := 0;
	LESS_EQUALS_DEVICE_IMANUFACTURER_BLENGTH_COUNT: INTEGER := 0;
	LESS_EQUALS_DEVICE_IMANUFACTURER_INDEX: INTEGER := 0;
	LESS_EQUALS_DEVICE_IMANUFACTURER_COUNT: INTEGER := 0;
	LESS_EQUALS_DEVICE_IPRODUCT_BLENGTH_INDEX: INTEGER := 0;
	LESS_EQUALS_DEVICE_IPRODUCT_BLENGTH_COUNT: INTEGER := 0;
	LESS_EQUALS_DEVICE_IPRODUCT_INDEX: INTEGER := 0;
	LESS_EQUALS_DEVICE_IPRODUCT_COUNT: INTEGER := 0;
	LESS_EQUALS_DEVICE_ISERIALNUMBER_BLENGTH_INDEX: INTEGER := 0;
	LESS_EQUALS_DEVICE_ISERIALNUMBER_BLENGTH_COUNT: INTEGER := 0;
	LESS_EQUALS_DEVICE_ISERIALNUMBER_INDEX: INTEGER := 0;
	LESS_EQUALS_DEVICE_ISERIALNUMBER_COUNT: INTEGER := 0;
	LESS_EQUALS_DEVICE_BNUMCONFIGURATIONS_INDEX: INTEGER := 0;
	LESS_EQUALS_DEVICE_BNUMCONFIGURATIONS_COUNT: INTEGER := 0;
	LESS_EQUALS_CONFIGURATION_BLENGTH_INDEX: INTEGER := 0;
	LESS_EQUALS_CONFIGURATION_BLENGTH_COUNT: INTEGER := 0;
	LESS_EQUALS_CONFIGURATION_WTOTALLENGTH_INDEX: INTEGER := 0;
	LESS_EQUALS_CONFIGURATION_WTOTALLENGTH_COUNT: INTEGER := 0;
	LESS_EQUALS_CONFIGURATION_BNUMINTERFACES_INDEX: INTEGER := 0;
	LESS_EQUALS_CONFIGURATION_BNUMINTERFACES_COUNT: INTEGER := 0;
	LESS_EQUALS_CONFIGURATION_BCONFIGURATIONVALUE_INDEX: INTEGER := 0;
	LESS_EQUALS_CONFIGURATION_BCONFIGURATIONVALUE_COUNT: INTEGER := 0;
	LESS_EQUALS_CONFIGURATION_ICONFIGURATION_BLENGTH_INDEX: INTEGER := 0;
	LESS_EQUALS_CONFIGURATION_ICONFIGURATION_BLENGTH_COUNT: INTEGER := 0;
	LESS_EQUALS_CONFIGURATION_ICONFIGURATION_INDEX: INTEGER := 0;
	LESS_EQUALS_CONFIGURATION_ICONFIGURATION_COUNT: INTEGER := 0;
	LESS_EQUALS_CONFIGURATION_BMATTRIBUTES_INDEX: INTEGER := 0;
	LESS_EQUALS_CONFIGURATION_BMATTRIBUTES_COUNT: INTEGER := 0;
	LESS_EQUALS_CONFIGURATION_BMAXPOWER_INDEX: INTEGER := 0;
	LESS_EQUALS_CONFIGURATION_BMAXPOWER_COUNT: INTEGER := 0;
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
	LESS_EQUALS_INTERFACE_IINTERFACE_BLENGTH_INDEX: INTEGER := 0;
	LESS_EQUALS_INTERFACE_IINTERFACE_BLENGTH_COUNT: INTEGER := 0;
	LESS_EQUALS_INTERFACE_IINTERFACE_INDEX: INTEGER := 0;
	LESS_EQUALS_INTERFACE_IINTERFACE_COUNT: INTEGER := 0;
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
	LESS_EQUALS_OTHER_SPEED_BLENGTH_INDEX: INTEGER := 0;
	LESS_EQUALS_OTHER_SPEED_BLENGTH_COUNT: INTEGER := 0;
	LESS_EQUALS_OTHER_SPEED_WTOTALLENGTH_INDEX: INTEGER := 0;
	LESS_EQUALS_OTHER_SPEED_WTOTALLENGTH_COUNT: INTEGER := 0;
	LESS_EQUALS_OTHER_SPEED_BNUMINTERFACES_INDEX: INTEGER := 0;
	LESS_EQUALS_OTHER_SPEED_BNUMINTERFACES_COUNT: INTEGER := 0;
	LESS_EQUALS_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX: INTEGER := 0;
	LESS_EQUALS_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT: INTEGER := 0;
	LESS_EQUALS_OTHER_SPEED_ICONFIGURATION_BLENGTH_INDEX: INTEGER := 0;
	LESS_EQUALS_OTHER_SPEED_ICONFIGURATION_BLENGTH_COUNT: INTEGER := 0;
	LESS_EQUALS_OTHER_SPEED_ICONFIGURATION_INDEX: INTEGER := 0;
	LESS_EQUALS_OTHER_SPEED_ICONFIGURATION_COUNT: INTEGER := 0;
	LESS_EQUALS_OTHER_SPEED_BMATTRIBUTES_INDEX: INTEGER := 0;
	LESS_EQUALS_OTHER_SPEED_BMATTRIBUTES_COUNT: INTEGER := 0;
	LESS_EQUALS_OTHER_SPEED_BMAXPOWER_INDEX: INTEGER := 0;
	LESS_EQUALS_OTHER_SPEED_BMAXPOWER_COUNT: INTEGER := 0;

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
	STARTS_WITH_DEVICE_IMANUFACTURER_BLENGTH_INDEX: INTEGER := 0;
	STARTS_WITH_DEVICE_IMANUFACTURER_BLENGTH_COUNT: INTEGER := 0;
	STARTS_WITH_DEVICE_IMANUFACTURER_INDEX: INTEGER := 0;
	STARTS_WITH_DEVICE_IMANUFACTURER_COUNT: INTEGER := 0;
	STARTS_WITH_DEVICE_IPRODUCT_BLENGTH_INDEX: INTEGER := 0;
	STARTS_WITH_DEVICE_IPRODUCT_BLENGTH_COUNT: INTEGER := 0;
	STARTS_WITH_DEVICE_IPRODUCT_INDEX: INTEGER := 0;
	STARTS_WITH_DEVICE_IPRODUCT_COUNT: INTEGER := 0;
	STARTS_WITH_DEVICE_ISERIALNUMBER_BLENGTH_INDEX: INTEGER := 0;
	STARTS_WITH_DEVICE_ISERIALNUMBER_BLENGTH_COUNT: INTEGER := 0;
	STARTS_WITH_DEVICE_ISERIALNUMBER_INDEX: INTEGER := 0;
	STARTS_WITH_DEVICE_ISERIALNUMBER_COUNT: INTEGER := 0;
	STARTS_WITH_DEVICE_BNUMCONFIGURATIONS_INDEX: INTEGER := 0;
	STARTS_WITH_DEVICE_BNUMCONFIGURATIONS_COUNT: INTEGER := 0;
	STARTS_WITH_CONFIGURATION_BLENGTH_INDEX: INTEGER := 0;
	STARTS_WITH_CONFIGURATION_BLENGTH_COUNT: INTEGER := 0;
	STARTS_WITH_CONFIGURATION_WTOTALLENGTH_INDEX: INTEGER := 0;
	STARTS_WITH_CONFIGURATION_WTOTALLENGTH_COUNT: INTEGER := 0;
	STARTS_WITH_CONFIGURATION_BNUMINTERFACES_INDEX: INTEGER := 0;
	STARTS_WITH_CONFIGURATION_BNUMINTERFACES_COUNT: INTEGER := 0;
	STARTS_WITH_CONFIGURATION_BCONFIGURATIONVALUE_INDEX: INTEGER := 0;
	STARTS_WITH_CONFIGURATION_BCONFIGURATIONVALUE_COUNT: INTEGER := 0;
	STARTS_WITH_CONFIGURATION_ICONFIGURATION_BLENGTH_INDEX: INTEGER := 0;
	STARTS_WITH_CONFIGURATION_ICONFIGURATION_BLENGTH_COUNT: INTEGER := 0;
	STARTS_WITH_CONFIGURATION_ICONFIGURATION_INDEX: INTEGER := 0;
	STARTS_WITH_CONFIGURATION_ICONFIGURATION_COUNT: INTEGER := 0;
	STARTS_WITH_CONFIGURATION_BMATTRIBUTES_INDEX: INTEGER := 0;
	STARTS_WITH_CONFIGURATION_BMATTRIBUTES_COUNT: INTEGER := 0;
	STARTS_WITH_CONFIGURATION_BMAXPOWER_INDEX: INTEGER := 0;
	STARTS_WITH_CONFIGURATION_BMAXPOWER_COUNT: INTEGER := 0;
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
	STARTS_WITH_INTERFACE_IINTERFACE_BLENGTH_INDEX: INTEGER := 0;
	STARTS_WITH_INTERFACE_IINTERFACE_BLENGTH_COUNT: INTEGER := 0;
	STARTS_WITH_INTERFACE_IINTERFACE_INDEX: INTEGER := 0;
	STARTS_WITH_INTERFACE_IINTERFACE_COUNT: INTEGER := 0;
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
	STARTS_WITH_OTHER_SPEED_BLENGTH_INDEX: INTEGER := 0;
	STARTS_WITH_OTHER_SPEED_BLENGTH_COUNT: INTEGER := 0;
	STARTS_WITH_OTHER_SPEED_WTOTALLENGTH_INDEX: INTEGER := 0;
	STARTS_WITH_OTHER_SPEED_WTOTALLENGTH_COUNT: INTEGER := 0;
	STARTS_WITH_OTHER_SPEED_BNUMINTERFACES_INDEX: INTEGER := 0;
	STARTS_WITH_OTHER_SPEED_BNUMINTERFACES_COUNT: INTEGER := 0;
	STARTS_WITH_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX: INTEGER := 0;
	STARTS_WITH_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT: INTEGER := 0;
	STARTS_WITH_OTHER_SPEED_ICONFIGURATION_BLENGTH_INDEX: INTEGER := 0;
	STARTS_WITH_OTHER_SPEED_ICONFIGURATION_BLENGTH_COUNT: INTEGER := 0;
	STARTS_WITH_OTHER_SPEED_ICONFIGURATION_INDEX: INTEGER := 0;
	STARTS_WITH_OTHER_SPEED_ICONFIGURATION_COUNT: INTEGER := 0;
	STARTS_WITH_OTHER_SPEED_BMATTRIBUTES_INDEX: INTEGER := 0;
	STARTS_WITH_OTHER_SPEED_BMATTRIBUTES_COUNT: INTEGER := 0;
	STARTS_WITH_OTHER_SPEED_BMAXPOWER_INDEX: INTEGER := 0;
	STARTS_WITH_OTHER_SPEED_BMAXPOWER_COUNT: INTEGER := 0;

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
	ENDS_WITH_DEVICE_IMANUFACTURER_BLENGTH_INDEX: INTEGER := 0;
	ENDS_WITH_DEVICE_IMANUFACTURER_BLENGTH_COUNT: INTEGER := 0;
	ENDS_WITH_DEVICE_IMANUFACTURER_INDEX: INTEGER := 0;
	ENDS_WITH_DEVICE_IMANUFACTURER_COUNT: INTEGER := 0;
	ENDS_WITH_DEVICE_IPRODUCT_BLENGTH_INDEX: INTEGER := 0;
	ENDS_WITH_DEVICE_IPRODUCT_BLENGTH_COUNT: INTEGER := 0;
	ENDS_WITH_DEVICE_IPRODUCT_INDEX: INTEGER := 0;
	ENDS_WITH_DEVICE_IPRODUCT_COUNT: INTEGER := 0;
	ENDS_WITH_DEVICE_ISERIALNUMBER_BLENGTH_INDEX: INTEGER := 0;
	ENDS_WITH_DEVICE_ISERIALNUMBER_BLENGTH_COUNT: INTEGER := 0;
	ENDS_WITH_DEVICE_ISERIALNUMBER_INDEX: INTEGER := 0;
	ENDS_WITH_DEVICE_ISERIALNUMBER_COUNT: INTEGER := 0;
	ENDS_WITH_DEVICE_BNUMCONFIGURATIONS_INDEX: INTEGER := 0;
	ENDS_WITH_DEVICE_BNUMCONFIGURATIONS_COUNT: INTEGER := 0;
	ENDS_WITH_CONFIGURATION_BLENGTH_INDEX: INTEGER := 0;
	ENDS_WITH_CONFIGURATION_BLENGTH_COUNT: INTEGER := 0;
	ENDS_WITH_CONFIGURATION_WTOTALLENGTH_INDEX: INTEGER := 0;
	ENDS_WITH_CONFIGURATION_WTOTALLENGTH_COUNT: INTEGER := 0;
	ENDS_WITH_CONFIGURATION_BNUMINTERFACES_INDEX: INTEGER := 0;
	ENDS_WITH_CONFIGURATION_BNUMINTERFACES_COUNT: INTEGER := 0;
	ENDS_WITH_CONFIGURATION_BCONFIGURATIONVALUE_INDEX: INTEGER := 0;
	ENDS_WITH_CONFIGURATION_BCONFIGURATIONVALUE_COUNT: INTEGER := 0;
	ENDS_WITH_CONFIGURATION_ICONFIGURATION_BLENGTH_INDEX: INTEGER := 0;
	ENDS_WITH_CONFIGURATION_ICONFIGURATION_BLENGTH_COUNT: INTEGER := 0;
	ENDS_WITH_CONFIGURATION_ICONFIGURATION_INDEX: INTEGER := 0;
	ENDS_WITH_CONFIGURATION_ICONFIGURATION_COUNT: INTEGER := 0;
	ENDS_WITH_CONFIGURATION_BMATTRIBUTES_INDEX: INTEGER := 0;
	ENDS_WITH_CONFIGURATION_BMATTRIBUTES_COUNT: INTEGER := 0;
	ENDS_WITH_CONFIGURATION_BMAXPOWER_INDEX: INTEGER := 0;
	ENDS_WITH_CONFIGURATION_BMAXPOWER_COUNT: INTEGER := 0;
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
	ENDS_WITH_INTERFACE_IINTERFACE_BLENGTH_INDEX: INTEGER := 0;
	ENDS_WITH_INTERFACE_IINTERFACE_BLENGTH_COUNT: INTEGER := 0;
	ENDS_WITH_INTERFACE_IINTERFACE_INDEX: INTEGER := 0;
	ENDS_WITH_INTERFACE_IINTERFACE_COUNT: INTEGER := 0;
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
	ENDS_WITH_OTHER_SPEED_BLENGTH_INDEX: INTEGER := 0;
	ENDS_WITH_OTHER_SPEED_BLENGTH_COUNT: INTEGER := 0;
	ENDS_WITH_OTHER_SPEED_WTOTALLENGTH_INDEX: INTEGER := 0;
	ENDS_WITH_OTHER_SPEED_WTOTALLENGTH_COUNT: INTEGER := 0;
	ENDS_WITH_OTHER_SPEED_BNUMINTERFACES_INDEX: INTEGER := 0;
	ENDS_WITH_OTHER_SPEED_BNUMINTERFACES_COUNT: INTEGER := 0;
	ENDS_WITH_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX: INTEGER := 0;
	ENDS_WITH_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT: INTEGER := 0;
	ENDS_WITH_OTHER_SPEED_ICONFIGURATION_BLENGTH_INDEX: INTEGER := 0;
	ENDS_WITH_OTHER_SPEED_ICONFIGURATION_BLENGTH_COUNT: INTEGER := 0;
	ENDS_WITH_OTHER_SPEED_ICONFIGURATION_INDEX: INTEGER := 0;
	ENDS_WITH_OTHER_SPEED_ICONFIGURATION_COUNT: INTEGER := 0;
	ENDS_WITH_OTHER_SPEED_BMATTRIBUTES_INDEX: INTEGER := 0;
	ENDS_WITH_OTHER_SPEED_BMATTRIBUTES_COUNT: INTEGER := 0;
	ENDS_WITH_OTHER_SPEED_BMAXPOWER_INDEX: INTEGER := 0;
	ENDS_WITH_OTHER_SPEED_BMAXPOWER_COUNT: INTEGER := 0;

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
	CONTAINS_DEVICE_IMANUFACTURER_BLENGTH_INDEX: INTEGER := 0;
	CONTAINS_DEVICE_IMANUFACTURER_BLENGTH_COUNT: INTEGER := 0;
	CONTAINS_DEVICE_IMANUFACTURER_INDEX: INTEGER := 0;
	CONTAINS_DEVICE_IMANUFACTURER_COUNT: INTEGER := 0;
	CONTAINS_DEVICE_IPRODUCT_BLENGTH_INDEX: INTEGER := 0;
	CONTAINS_DEVICE_IPRODUCT_BLENGTH_COUNT: INTEGER := 0;
	CONTAINS_DEVICE_IPRODUCT_INDEX: INTEGER := 0;
	CONTAINS_DEVICE_IPRODUCT_COUNT: INTEGER := 0;
	CONTAINS_DEVICE_ISERIALNUMBER_BLENGTH_INDEX: INTEGER := 0;
	CONTAINS_DEVICE_ISERIALNUMBER_BLENGTH_COUNT: INTEGER := 0;
	CONTAINS_DEVICE_ISERIALNUMBER_INDEX: INTEGER := 0;
	CONTAINS_DEVICE_ISERIALNUMBER_COUNT: INTEGER := 0;
	CONTAINS_DEVICE_BNUMCONFIGURATIONS_INDEX: INTEGER := 0;
	CONTAINS_DEVICE_BNUMCONFIGURATIONS_COUNT: INTEGER := 0;
	CONTAINS_CONFIGURATION_BLENGTH_INDEX: INTEGER := 0;
	CONTAINS_CONFIGURATION_BLENGTH_COUNT: INTEGER := 0;
	CONTAINS_CONFIGURATION_WTOTALLENGTH_INDEX: INTEGER := 0;
	CONTAINS_CONFIGURATION_WTOTALLENGTH_COUNT: INTEGER := 0;
	CONTAINS_CONFIGURATION_BNUMINTERFACES_INDEX: INTEGER := 0;
	CONTAINS_CONFIGURATION_BNUMINTERFACES_COUNT: INTEGER := 0;
	CONTAINS_CONFIGURATION_BCONFIGURATIONVALUE_INDEX: INTEGER := 0;
	CONTAINS_CONFIGURATION_BCONFIGURATIONVALUE_COUNT: INTEGER := 0;
	CONTAINS_CONFIGURATION_ICONFIGURATION_BLENGTH_INDEX: INTEGER := 0;
	CONTAINS_CONFIGURATION_ICONFIGURATION_BLENGTH_COUNT: INTEGER := 0;
	CONTAINS_CONFIGURATION_ICONFIGURATION_INDEX: INTEGER := 0;
	CONTAINS_CONFIGURATION_ICONFIGURATION_COUNT: INTEGER := 0;
	CONTAINS_CONFIGURATION_BMATTRIBUTES_INDEX: INTEGER := 0;
	CONTAINS_CONFIGURATION_BMATTRIBUTES_COUNT: INTEGER := 0;
	CONTAINS_CONFIGURATION_BMAXPOWER_INDEX: INTEGER := 0;
	CONTAINS_CONFIGURATION_BMAXPOWER_COUNT: INTEGER := 0;
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
	CONTAINS_INTERFACE_IINTERFACE_BLENGTH_INDEX: INTEGER := 0;
	CONTAINS_INTERFACE_IINTERFACE_BLENGTH_COUNT: INTEGER := 0;
	CONTAINS_INTERFACE_IINTERFACE_INDEX: INTEGER := 0;
	CONTAINS_INTERFACE_IINTERFACE_COUNT: INTEGER := 0;
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
	CONTAINS_OTHER_SPEED_BLENGTH_INDEX: INTEGER := 0;
	CONTAINS_OTHER_SPEED_BLENGTH_COUNT: INTEGER := 0;
	CONTAINS_OTHER_SPEED_WTOTALLENGTH_INDEX: INTEGER := 0;
	CONTAINS_OTHER_SPEED_WTOTALLENGTH_COUNT: INTEGER := 0;
	CONTAINS_OTHER_SPEED_BNUMINTERFACES_INDEX: INTEGER := 0;
	CONTAINS_OTHER_SPEED_BNUMINTERFACES_COUNT: INTEGER := 0;
	CONTAINS_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX: INTEGER := 0;
	CONTAINS_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT: INTEGER := 0;
	CONTAINS_OTHER_SPEED_ICONFIGURATION_BLENGTH_INDEX: INTEGER := 0;
	CONTAINS_OTHER_SPEED_ICONFIGURATION_BLENGTH_COUNT: INTEGER := 0;
	CONTAINS_OTHER_SPEED_ICONFIGURATION_INDEX: INTEGER := 0;
	CONTAINS_OTHER_SPEED_ICONFIGURATION_COUNT: INTEGER := 0;
	CONTAINS_OTHER_SPEED_BMATTRIBUTES_INDEX: INTEGER := 0;
	CONTAINS_OTHER_SPEED_BMATTRIBUTES_COUNT: INTEGER := 0;
	CONTAINS_OTHER_SPEED_BMAXPOWER_INDEX: INTEGER := 0;
	CONTAINS_OTHER_SPEED_BMAXPOWER_COUNT: INTEGER := 0;

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
	NOT_CONTAINS_DEVICE_IMANUFACTURER_BLENGTH_INDEX: INTEGER := 0;
	NOT_CONTAINS_DEVICE_IMANUFACTURER_BLENGTH_COUNT: INTEGER := 0;
	NOT_CONTAINS_DEVICE_IMANUFACTURER_INDEX: INTEGER := 0;
	NOT_CONTAINS_DEVICE_IMANUFACTURER_COUNT: INTEGER := 0;
	NOT_CONTAINS_DEVICE_IPRODUCT_BLENGTH_INDEX: INTEGER := 0;
	NOT_CONTAINS_DEVICE_IPRODUCT_BLENGTH_COUNT: INTEGER := 0;
	NOT_CONTAINS_DEVICE_IPRODUCT_INDEX: INTEGER := 0;
	NOT_CONTAINS_DEVICE_IPRODUCT_COUNT: INTEGER := 0;
	NOT_CONTAINS_DEVICE_ISERIALNUMBER_BLENGTH_INDEX: INTEGER := 0;
	NOT_CONTAINS_DEVICE_ISERIALNUMBER_BLENGTH_COUNT: INTEGER := 0;
	NOT_CONTAINS_DEVICE_ISERIALNUMBER_INDEX: INTEGER := 0;
	NOT_CONTAINS_DEVICE_ISERIALNUMBER_COUNT: INTEGER := 0;
	NOT_CONTAINS_DEVICE_BNUMCONFIGURATIONS_INDEX: INTEGER := 0;
	NOT_CONTAINS_DEVICE_BNUMCONFIGURATIONS_COUNT: INTEGER := 0;
	NOT_CONTAINS_CONFIGURATION_BLENGTH_INDEX: INTEGER := 0;
	NOT_CONTAINS_CONFIGURATION_BLENGTH_COUNT: INTEGER := 0;
	NOT_CONTAINS_CONFIGURATION_WTOTALLENGTH_INDEX: INTEGER := 0;
	NOT_CONTAINS_CONFIGURATION_WTOTALLENGTH_COUNT: INTEGER := 0;
	NOT_CONTAINS_CONFIGURATION_BNUMINTERFACES_INDEX: INTEGER := 0;
	NOT_CONTAINS_CONFIGURATION_BNUMINTERFACES_COUNT: INTEGER := 0;
	NOT_CONTAINS_CONFIGURATION_BCONFIGURATIONVALUE_INDEX: INTEGER := 0;
	NOT_CONTAINS_CONFIGURATION_BCONFIGURATIONVALUE_COUNT: INTEGER := 0;
	NOT_CONTAINS_CONFIGURATION_ICONFIGURATION_BLENGTH_INDEX: INTEGER := 0;
	NOT_CONTAINS_CONFIGURATION_ICONFIGURATION_BLENGTH_COUNT: INTEGER := 0;
	NOT_CONTAINS_CONFIGURATION_ICONFIGURATION_INDEX: INTEGER := 0;
	NOT_CONTAINS_CONFIGURATION_ICONFIGURATION_COUNT: INTEGER := 0;
	NOT_CONTAINS_CONFIGURATION_BMATTRIBUTES_INDEX: INTEGER := 0;
	NOT_CONTAINS_CONFIGURATION_BMATTRIBUTES_COUNT: INTEGER := 0;
	NOT_CONTAINS_CONFIGURATION_BMAXPOWER_INDEX: INTEGER := 0;
	NOT_CONTAINS_CONFIGURATION_BMAXPOWER_COUNT: INTEGER := 0;
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
	NOT_CONTAINS_INTERFACE_IINTERFACE_BLENGTH_INDEX: INTEGER := 0;
	NOT_CONTAINS_INTERFACE_IINTERFACE_BLENGTH_COUNT: INTEGER := 0;
	NOT_CONTAINS_INTERFACE_IINTERFACE_INDEX: INTEGER := 0;
	NOT_CONTAINS_INTERFACE_IINTERFACE_COUNT: INTEGER := 0;
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
	NOT_CONTAINS_OTHER_SPEED_BLENGTH_INDEX: INTEGER := 0;
	NOT_CONTAINS_OTHER_SPEED_BLENGTH_COUNT: INTEGER := 0;
	NOT_CONTAINS_OTHER_SPEED_WTOTALLENGTH_INDEX: INTEGER := 0;
	NOT_CONTAINS_OTHER_SPEED_WTOTALLENGTH_COUNT: INTEGER := 0;
	NOT_CONTAINS_OTHER_SPEED_BNUMINTERFACES_INDEX: INTEGER := 0;
	NOT_CONTAINS_OTHER_SPEED_BNUMINTERFACES_COUNT: INTEGER := 0;
	NOT_CONTAINS_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX: INTEGER := 0;
	NOT_CONTAINS_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT: INTEGER := 0;
	NOT_CONTAINS_OTHER_SPEED_ICONFIGURATION_BLENGTH_INDEX: INTEGER := 0;
	NOT_CONTAINS_OTHER_SPEED_ICONFIGURATION_BLENGTH_COUNT: INTEGER := 0;
	NOT_CONTAINS_OTHER_SPEED_ICONFIGURATION_INDEX: INTEGER := 0;
	NOT_CONTAINS_OTHER_SPEED_ICONFIGURATION_COUNT: INTEGER := 0;
	NOT_CONTAINS_OTHER_SPEED_BMATTRIBUTES_INDEX: INTEGER := 0;
	NOT_CONTAINS_OTHER_SPEED_BMATTRIBUTES_COUNT: INTEGER := 0;
	NOT_CONTAINS_OTHER_SPEED_BMAXPOWER_INDEX: INTEGER := 0;
	NOT_CONTAINS_OTHER_SPEED_BMAXPOWER_COUNT: INTEGER := 0
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

END USBVerifier;

ARCHITECTURE Behavioral of USBVerifier is

------------------------------------------------------------------------
-- Component Declarations
------------------------------------------------------------------------
-- Equals Operator
COMPONENT EqualsOperator is
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
END COMPONENT;

-- NotEquals Operator
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
END COMPONENT;

-- Greater Operator
COMPONENT GreaterOperator is
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
END COMPONENT;

-- GreaterEquals Operator
COMPONENT GreaterEqualsOperator is
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
END COMPONENT;

-- Less Operator
COMPONENT LessOperator is
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
END COMPONENT;

-- LessEquals Operator
COMPONENT LessEqualsOperator is
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
END COMPONENT;

-- StartsWith Operator
COMPONENT StartsWithOperator is
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
END COMPONENT;

-- EndsWith Operator
COMPONENT EndsWithOperator is
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
END COMPONENT;

-- Contains Operator
COMPONENT ContainsOperator is
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
END COMPONENT;

-- NotContains Operator
COMPONENT NotContainsOperator is
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
END COMPONENT;

-- Operator Accumulator
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
-- Total Available Operators
constant TOTAL_OPERATORS_NUMBER: INTEGER := 10;

-- Equals Index
constant EQUALS_OPERATOR_INDEX: INTEGER := TOTAL_OPERATORS_NUMBER-1;

-- NotEquals Index
constant NOT_EQUALS_OPERATOR_INDEX: INTEGER := TOTAL_OPERATORS_NUMBER-2;

-- Greater Index
constant GREATER_OPERATOR_INDEX: INTEGER := TOTAL_OPERATORS_NUMBER-3;

-- GreaterEquals Index
constant GREATER_EQUALS_OPERATOR_INDEX: INTEGER := TOTAL_OPERATORS_NUMBER-4;

-- Less Index
constant LESS_OPERATOR_INDEX: INTEGER := TOTAL_OPERATORS_NUMBER-5;

-- LessEquals Index
constant LESS_EQUALS_OPERATOR_INDEX: INTEGER := TOTAL_OPERATORS_NUMBER-6;

-- StartsWith Index
constant STARTS_WITH_OPERATOR_INDEX: INTEGER := TOTAL_OPERATORS_NUMBER-7;

-- EndsWith Index
constant ENDS_WITH_OPERATOR_INDEX: INTEGER := TOTAL_OPERATORS_NUMBER-8;

-- Contains Index
constant CONTAINS_OPERATOR_INDEX: INTEGER := TOTAL_OPERATORS_NUMBER-9;

-- NotContains Index
constant NOT_CONTAINS_OPERATOR_INDEX: INTEGER := TOTAL_OPERATORS_NUMBER-10;

------------------------------------------------------------------------
-- Signal Declarations
------------------------------------------------------------------------
signal operators_next_part_request: STD_LOGIC_VECTOR(TOTAL_OPERATORS_NUMBER-1 downto 0) := (others => '0');
signal operators_ready: STD_LOGIC_VECTOR(TOTAL_OPERATORS_NUMBER-1 downto 0) := (others => '0');
signal operators_result: STD_LOGIC_VECTOR(TOTAL_OPERATORS_NUMBER-1 downto 0) := (others => '0');

------------------------------------------------------------------------
-- Module Implementation
------------------------------------------------------------------------
begin

	---------------------
	-- Equals Operator --
	---------------------
	equalsOperator_en: if (EQUALS_OPERATOR_ENABLE = '1') generate
		equalsOperator_inst: EqualsOperator
			GENERIC MAP (
				-- Memory Configurations (Address Length, Address Max Index, Address Count Max)
				MEMORY_ADDR_LENGTH => EQUALS_MEMORY_ADDR_LENGTH,
				MEMORY_ADDR_MAX_INDEX => EQUALS_MEMORY_ADDR_MAX_INDEX,
				MEMORY_ADDR_MAX_COUNT => EQUALS_MEMORY_ADDR_MAX_COUNT,
				-- Device Descriptor
				DEVICE_BLENGTH_INDEX => EQUALS_DEVICE_BLENGTH_INDEX,
				DEVICE_BLENGTH_COUNT => EQUALS_DEVICE_BLENGTH_COUNT,
				DEVICE_BCDUSB_INDEX => EQUALS_DEVICE_BCDUSB_INDEX,
				DEVICE_BCDUSB_COUNT => EQUALS_DEVICE_BCDUSB_COUNT,
				DEVICE_BDEVICECLASS_INDEX => EQUALS_DEVICE_BDEVICECLASS_INDEX,
				DEVICE_BDEVICECLASS_COUNT => EQUALS_DEVICE_BDEVICECLASS_COUNT,
				DEVICE_BDEVICESUBCLASS_INDEX => EQUALS_DEVICE_BDEVICESUBCLASS_INDEX,
				DEVICE_BDEVICESUBCLASS_COUNT => EQUALS_DEVICE_BDEVICESUBCLASS_COUNT,
				DEVICE_BDEVICEPROTOCOL_INDEX => EQUALS_DEVICE_BDEVICEPROTOCOL_INDEX,
				DEVICE_BDEVICEPROTOCOL_COUNT => EQUALS_DEVICE_BDEVICEPROTOCOL_COUNT,
				DEVICE_BMAXPACKETSIZE0_INDEX => EQUALS_DEVICE_BMAXPACKETSIZE0_INDEX,
				DEVICE_BMAXPACKETSIZE0_COUNT => EQUALS_DEVICE_BMAXPACKETSIZE0_COUNT,
				DEVICE_IDVENDOR_INDEX => EQUALS_DEVICE_IDVENDOR_INDEX,
				DEVICE_IDVENDOR_COUNT => EQUALS_DEVICE_IDVENDOR_COUNT,
				DEVICE_IDPRODUCT_INDEX => EQUALS_DEVICE_IDPRODUCT_INDEX,
				DEVICE_IDPRODUCT_COUNT => EQUALS_DEVICE_IDPRODUCT_COUNT,
				DEVICE_BCDDEVICE_INDEX => EQUALS_DEVICE_BCDDEVICE_INDEX,
				DEVICE_BCDDEVICE_COUNT => EQUALS_DEVICE_BCDDEVICE_COUNT,
				DEVICE_IMANUFACTURER_BLENGTH_INDEX => EQUALS_DEVICE_IMANUFACTURER_BLENGTH_INDEX,
				DEVICE_IMANUFACTURER_BLENGTH_COUNT => EQUALS_DEVICE_IMANUFACTURER_BLENGTH_COUNT,
				DEVICE_IMANUFACTURER_INDEX => EQUALS_DEVICE_IMANUFACTURER_INDEX,
				DEVICE_IMANUFACTURER_COUNT => EQUALS_DEVICE_IMANUFACTURER_COUNT,
				DEVICE_IPRODUCT_BLENGTH_INDEX => EQUALS_DEVICE_IPRODUCT_BLENGTH_INDEX,
				DEVICE_IPRODUCT_BLENGTH_COUNT => EQUALS_DEVICE_IPRODUCT_BLENGTH_COUNT,
				DEVICE_IPRODUCT_INDEX => EQUALS_DEVICE_IPRODUCT_INDEX,
				DEVICE_IPRODUCT_COUNT => EQUALS_DEVICE_IPRODUCT_COUNT,
				DEVICE_ISERIALNUMBER_BLENGTH_INDEX => EQUALS_DEVICE_ISERIALNUMBER_BLENGTH_INDEX,
				DEVICE_ISERIALNUMBER_BLENGTH_COUNT => EQUALS_DEVICE_ISERIALNUMBER_BLENGTH_COUNT,
				DEVICE_ISERIALNUMBER_INDEX => EQUALS_DEVICE_ISERIALNUMBER_INDEX,
				DEVICE_ISERIALNUMBER_COUNT => EQUALS_DEVICE_ISERIALNUMBER_COUNT,
				DEVICE_BNUMCONFIGURATIONS_INDEX => EQUALS_DEVICE_BNUMCONFIGURATIONS_INDEX,
				DEVICE_BNUMCONFIGURATIONS_COUNT => EQUALS_DEVICE_BNUMCONFIGURATIONS_COUNT,
				-- Configuration Descriptor
				CONFIGURATION_BLENGTH_INDEX => EQUALS_CONFIGURATION_BLENGTH_INDEX,
				CONFIGURATION_BLENGTH_COUNT => EQUALS_CONFIGURATION_BLENGTH_COUNT,
				CONFIGURATION_WTOTALLENGTH_INDEX => EQUALS_CONFIGURATION_WTOTALLENGTH_INDEX,
				CONFIGURATION_WTOTALLENGTH_COUNT => EQUALS_CONFIGURATION_WTOTALLENGTH_COUNT,
				CONFIGURATION_BNUMINTERFACES_INDEX => EQUALS_CONFIGURATION_BNUMINTERFACES_INDEX,
				CONFIGURATION_BNUMINTERFACES_COUNT => EQUALS_CONFIGURATION_BNUMINTERFACES_COUNT,
				CONFIGURATION_BCONFIGURATIONVALUE_INDEX => EQUALS_CONFIGURATION_BCONFIGURATIONVALUE_INDEX,
				CONFIGURATION_BCONFIGURATIONVALUE_COUNT => EQUALS_CONFIGURATION_BCONFIGURATIONVALUE_COUNT,
				CONFIGURATION_ICONFIGURATION_BLENGTH_INDEX => EQUALS_CONFIGURATION_ICONFIGURATION_BLENGTH_INDEX,
				CONFIGURATION_ICONFIGURATION_BLENGTH_COUNT => EQUALS_CONFIGURATION_ICONFIGURATION_BLENGTH_COUNT,
				CONFIGURATION_ICONFIGURATION_INDEX => EQUALS_CONFIGURATION_ICONFIGURATION_INDEX,
				CONFIGURATION_ICONFIGURATION_COUNT => EQUALS_CONFIGURATION_ICONFIGURATION_COUNT,
				CONFIGURATION_BMATTRIBUTES_INDEX => EQUALS_CONFIGURATION_BMATTRIBUTES_INDEX,
				CONFIGURATION_BMATTRIBUTES_COUNT => EQUALS_CONFIGURATION_BMATTRIBUTES_COUNT,
				CONFIGURATION_BMAXPOWER_INDEX => EQUALS_CONFIGURATION_BMAXPOWER_INDEX,
				CONFIGURATION_BMAXPOWER_COUNT => EQUALS_CONFIGURATION_BMAXPOWER_COUNT,
				-- Interface Descriptor
				INTERFACE_BLENGTH_INDEX => EQUALS_INTERFACE_BLENGTH_INDEX,
				INTERFACE_BLENGTH_COUNT => EQUALS_INTERFACE_BLENGTH_COUNT,
				INTERFACE_BINTERFACENUMBER_INDEX => EQUALS_INTERFACE_BINTERFACENUMBER_INDEX,
				INTERFACE_BINTERFACENUMBER_COUNT => EQUALS_INTERFACE_BINTERFACENUMBER_COUNT,
				INTERFACE_BALTERNATESETTING_INDEX => EQUALS_INTERFACE_BALTERNATESETTING_INDEX,
				INTERFACE_BALTERNATESETTING_COUNT => EQUALS_INTERFACE_BALTERNATESETTING_COUNT,
				INTERFACE_BNUMENDPOINTS_INDEX => EQUALS_INTERFACE_BNUMENDPOINTS_INDEX,
				INTERFACE_BNUMENDPOINTS_COUNT => EQUALS_INTERFACE_BNUMENDPOINTS_COUNT,
				INTERFACE_BINTERFACECLASS_INDEX => EQUALS_INTERFACE_BINTERFACECLASS_INDEX,
				INTERFACE_BINTERFACECLASS_COUNT => EQUALS_INTERFACE_BINTERFACECLASS_COUNT,
				INTERFACE_BINTERFACESUBCLASS_INDEX => EQUALS_INTERFACE_BINTERFACESUBCLASS_INDEX,
				INTERFACE_BINTERFACESUBCLASS_COUNT => EQUALS_INTERFACE_BINTERFACESUBCLASS_COUNT,
				INTERFACE_BINTERFACEPROTOCOL_INDEX => EQUALS_INTERFACE_BINTERFACEPROTOCOL_INDEX,
				INTERFACE_BINTERFACEPROTOCOL_COUNT => EQUALS_INTERFACE_BINTERFACEPROTOCOL_COUNT,
				INTERFACE_IINTERFACE_BLENGTH_INDEX => EQUALS_INTERFACE_IINTERFACE_BLENGTH_INDEX,
				INTERFACE_IINTERFACE_BLENGTH_COUNT => EQUALS_INTERFACE_IINTERFACE_BLENGTH_COUNT,
				INTERFACE_IINTERFACE_INDEX => EQUALS_INTERFACE_IINTERFACE_INDEX,
				INTERFACE_IINTERFACE_COUNT => EQUALS_INTERFACE_IINTERFACE_COUNT,
				-- HID Descriptor
				HID_BLENGTH_INDEX => EQUALS_HID_BLENGTH_INDEX,
				HID_BLENGTH_COUNT => EQUALS_HID_BLENGTH_COUNT,
				HID_BCDHID_INDEX => EQUALS_HID_BCDHID_INDEX,
				HID_BCDHID_COUNT => EQUALS_HID_BCDHID_COUNT,
				HID_BCOUNTRYCODE_INDEX => EQUALS_HID_BCOUNTRYCODE_INDEX,
				HID_BCOUNTRYCODE_COUNT => EQUALS_HID_BCOUNTRYCODE_COUNT,
				HID_BNUMDESCRIPTORS_INDEX => EQUALS_HID_BNUMDESCRIPTORS_INDEX,
				HID_BNUMDESCRIPTORS_COUNT => EQUALS_HID_BNUMDESCRIPTORS_COUNT,
				HID_BDESCRIPTORTYPE_INDEX => EQUALS_HID_BDESCRIPTORTYPE_INDEX,
				HID_BDESCRIPTORTYPE_COUNT => EQUALS_HID_BDESCRIPTORTYPE_COUNT,
				HID_WDESCRIPTORLENGTH_INDEX => EQUALS_HID_WDESCRIPTORLENGTH_INDEX,
				HID_WDESCRIPTORLENGTH_COUNT => EQUALS_HID_WDESCRIPTORLENGTH_COUNT,
				-- Endpoint Descriptor
				ENDPOINT_BLENGTH_INDEX => EQUALS_ENDPOINT_BLENGTH_INDEX,
				ENDPOINT_BLENGTH_COUNT => EQUALS_ENDPOINT_BLENGTH_COUNT,
				ENDPOINT_BENDPOINTADDRESS_INDEX => EQUALS_ENDPOINT_BENDPOINTADDRESS_INDEX,
				ENDPOINT_BENDPOINTADDRESS_COUNT => EQUALS_ENDPOINT_BENDPOINTADDRESS_COUNT,
				ENDPOINT_BMATTRIBUTES_INDEX => EQUALS_ENDPOINT_BMATTRIBUTES_INDEX,
				ENDPOINT_BMATTRIBUTES_COUNT => EQUALS_ENDPOINT_BMATTRIBUTES_COUNT,
				ENDPOINT_WMAXPACKETSIZE_INDEX => EQUALS_ENDPOINT_WMAXPACKETSIZE_INDEX,
				ENDPOINT_WMAXPACKETSIZE_COUNT => EQUALS_ENDPOINT_WMAXPACKETSIZE_COUNT,
				ENDPOINT_BINTERVAL_INDEX => EQUALS_ENDPOINT_BINTERVAL_INDEX,
				ENDPOINT_BINTERVAL_COUNT => EQUALS_ENDPOINT_BINTERVAL_COUNT,
				-- Device Qualifier Descriptor
				DEVICE_QUALIFIER_BLENGTH_INDEX => EQUALS_DEVICE_QUALIFIER_BLENGTH_INDEX,
				DEVICE_QUALIFIER_BLENGTH_COUNT => EQUALS_DEVICE_QUALIFIER_BLENGTH_COUNT,
				DEVICE_QUALIFIER_BCDUSB_INDEX => EQUALS_DEVICE_QUALIFIER_BCDUSB_INDEX,
				DEVICE_QUALIFIER_BCDUSB_COUNT => EQUALS_DEVICE_QUALIFIER_BCDUSB_COUNT,
				DEVICE_QUALIFIER_BDEVICECLASS_INDEX => EQUALS_DEVICE_QUALIFIER_BDEVICECLASS_INDEX,
				DEVICE_QUALIFIER_BDEVICECLASS_COUNT => EQUALS_DEVICE_QUALIFIER_BDEVICECLASS_COUNT,
				DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX => EQUALS_DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX,
				DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT => EQUALS_DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT,
				DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX => EQUALS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX,
				DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT => EQUALS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT,
				DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX => EQUALS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX,
				DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT => EQUALS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT,
				DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX => EQUALS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX,
				DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT => EQUALS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT,
				DEVICE_QUALIFIER_BRESERVED_INDEX => EQUALS_DEVICE_QUALIFIER_BRESERVED_INDEX,
				DEVICE_QUALIFIER_BRESERVED_COUNT => EQUALS_DEVICE_QUALIFIER_BRESERVED_COUNT,
				-- Other Speed Descriptor
				OTHER_SPEED_BLENGTH_INDEX => EQUALS_OTHER_SPEED_BLENGTH_INDEX,
				OTHER_SPEED_BLENGTH_COUNT => EQUALS_OTHER_SPEED_BLENGTH_COUNT,
				OTHER_SPEED_WTOTALLENGTH_INDEX => EQUALS_OTHER_SPEED_WTOTALLENGTH_INDEX,
				OTHER_SPEED_WTOTALLENGTH_COUNT => EQUALS_OTHER_SPEED_WTOTALLENGTH_COUNT,
				OTHER_SPEED_BNUMINTERFACES_INDEX => EQUALS_OTHER_SPEED_BNUMINTERFACES_INDEX,
				OTHER_SPEED_BNUMINTERFACES_COUNT => EQUALS_OTHER_SPEED_BNUMINTERFACES_COUNT,
				OTHER_SPEED_BCONFIGURATIONVALUE_INDEX => EQUALS_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX,
				OTHER_SPEED_BCONFIGURATIONVALUE_COUNT => EQUALS_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT,
				OTHER_SPEED_ICONFIGURATION_BLENGTH_INDEX => EQUALS_OTHER_SPEED_ICONFIGURATION_BLENGTH_INDEX,
				OTHER_SPEED_ICONFIGURATION_BLENGTH_COUNT => EQUALS_OTHER_SPEED_ICONFIGURATION_BLENGTH_COUNT,
				OTHER_SPEED_ICONFIGURATION_INDEX => EQUALS_OTHER_SPEED_ICONFIGURATION_INDEX,
				OTHER_SPEED_ICONFIGURATION_COUNT => EQUALS_OTHER_SPEED_ICONFIGURATION_COUNT,
				OTHER_SPEED_BMATTRIBUTES_INDEX => EQUALS_OTHER_SPEED_BMATTRIBUTES_INDEX,
				OTHER_SPEED_BMATTRIBUTES_COUNT => EQUALS_OTHER_SPEED_BMATTRIBUTES_COUNT,
				OTHER_SPEED_BMAXPOWER_INDEX => EQUALS_OTHER_SPEED_BMAXPOWER_INDEX,
				OTHER_SPEED_BMAXPOWER_COUNT => EQUALS_OTHER_SPEED_BMAXPOWER_COUNT
			)
			PORT MAP (
				i_sys_clock => i_sys_clock,
				i_enable => i_enable,
				i_descriptor_field => i_descriptor_field,
				i_descriptor_field_available => i_descriptor_field_available,
				i_descriptor_value => i_descriptor_value,
				i_descriptor_value_en => i_descriptor_value_en,
				i_descriptor_value_total_part_number => i_descriptor_value_total_part_number,
				i_descriptor_value_part_number => i_descriptor_value_part_number,
				i_descriptor_value_new_part => i_descriptor_value_new_part,
				o_descriptor_value_next_part_request => operators_next_part_request(EQUALS_OPERATOR_INDEX),
				o_ready => operators_ready(EQUALS_OPERATOR_INDEX),
				o_result => operators_result(EQUALS_OPERATOR_INDEX)
		);
	end generate;

	------------------------
	-- NotEquals Operator --
	------------------------
	notEqualsOperator_en: if (NOT_EQUALS_OPERATOR_ENABLE = '1') generate
		notEqualsOperator_inst: NotEqualsOperator
			GENERIC MAP (
				-- Memory Configurations (Address Length, Address Max Index, Address Count Max)
				MEMORY_ADDR_LENGTH => NOT_EQUALS_MEMORY_ADDR_LENGTH,
				MEMORY_ADDR_MAX_INDEX => NOT_EQUALS_MEMORY_ADDR_MAX_INDEX,
				MEMORY_ADDR_MAX_COUNT => NOT_EQUALS_MEMORY_ADDR_MAX_COUNT,
				-- Device Descriptor
				DEVICE_BLENGTH_INDEX => NOT_EQUALS_DEVICE_BLENGTH_INDEX,
				DEVICE_BLENGTH_COUNT => NOT_EQUALS_DEVICE_BLENGTH_COUNT,
				DEVICE_BCDUSB_INDEX => NOT_EQUALS_DEVICE_BCDUSB_INDEX,
				DEVICE_BCDUSB_COUNT => NOT_EQUALS_DEVICE_BCDUSB_COUNT,
				DEVICE_BDEVICECLASS_INDEX => NOT_EQUALS_DEVICE_BDEVICECLASS_INDEX,
				DEVICE_BDEVICECLASS_COUNT => NOT_EQUALS_DEVICE_BDEVICECLASS_COUNT,
				DEVICE_BDEVICESUBCLASS_INDEX => NOT_EQUALS_DEVICE_BDEVICESUBCLASS_INDEX,
				DEVICE_BDEVICESUBCLASS_COUNT => NOT_EQUALS_DEVICE_BDEVICESUBCLASS_COUNT,
				DEVICE_BDEVICEPROTOCOL_INDEX => NOT_EQUALS_DEVICE_BDEVICEPROTOCOL_INDEX,
				DEVICE_BDEVICEPROTOCOL_COUNT => NOT_EQUALS_DEVICE_BDEVICEPROTOCOL_COUNT,
				DEVICE_BMAXPACKETSIZE0_INDEX => NOT_EQUALS_DEVICE_BMAXPACKETSIZE0_INDEX,
				DEVICE_BMAXPACKETSIZE0_COUNT => NOT_EQUALS_DEVICE_BMAXPACKETSIZE0_COUNT,
				DEVICE_IDVENDOR_INDEX => NOT_EQUALS_DEVICE_IDVENDOR_INDEX,
				DEVICE_IDVENDOR_COUNT => NOT_EQUALS_DEVICE_IDVENDOR_COUNT,
				DEVICE_IDPRODUCT_INDEX => NOT_EQUALS_DEVICE_IDPRODUCT_INDEX,
				DEVICE_IDPRODUCT_COUNT => NOT_EQUALS_DEVICE_IDPRODUCT_COUNT,
				DEVICE_BCDDEVICE_INDEX => NOT_EQUALS_DEVICE_BCDDEVICE_INDEX,
				DEVICE_BCDDEVICE_COUNT => NOT_EQUALS_DEVICE_BCDDEVICE_COUNT,
				DEVICE_IMANUFACTURER_BLENGTH_INDEX => NOT_EQUALS_DEVICE_IMANUFACTURER_BLENGTH_INDEX,
				DEVICE_IMANUFACTURER_BLENGTH_COUNT => NOT_EQUALS_DEVICE_IMANUFACTURER_BLENGTH_COUNT,
				DEVICE_IMANUFACTURER_INDEX => NOT_EQUALS_DEVICE_IMANUFACTURER_INDEX,
				DEVICE_IMANUFACTURER_COUNT => NOT_EQUALS_DEVICE_IMANUFACTURER_COUNT,
				DEVICE_IPRODUCT_BLENGTH_INDEX => NOT_EQUALS_DEVICE_IPRODUCT_BLENGTH_INDEX,
				DEVICE_IPRODUCT_BLENGTH_COUNT => NOT_EQUALS_DEVICE_IPRODUCT_BLENGTH_COUNT,
				DEVICE_IPRODUCT_INDEX => NOT_EQUALS_DEVICE_IPRODUCT_INDEX,
				DEVICE_IPRODUCT_COUNT => NOT_EQUALS_DEVICE_IPRODUCT_COUNT,
				DEVICE_ISERIALNUMBER_BLENGTH_INDEX => NOT_EQUALS_DEVICE_ISERIALNUMBER_BLENGTH_INDEX,
				DEVICE_ISERIALNUMBER_BLENGTH_COUNT => NOT_EQUALS_DEVICE_ISERIALNUMBER_BLENGTH_COUNT,
				DEVICE_ISERIALNUMBER_INDEX => NOT_EQUALS_DEVICE_ISERIALNUMBER_INDEX,
				DEVICE_ISERIALNUMBER_COUNT => NOT_EQUALS_DEVICE_ISERIALNUMBER_COUNT,
				DEVICE_BNUMCONFIGURATIONS_INDEX => NOT_EQUALS_DEVICE_BNUMCONFIGURATIONS_INDEX,
				DEVICE_BNUMCONFIGURATIONS_COUNT => NOT_EQUALS_DEVICE_BNUMCONFIGURATIONS_COUNT,
				-- Configuration Descriptor
				CONFIGURATION_BLENGTH_INDEX => NOT_EQUALS_CONFIGURATION_BLENGTH_INDEX,
				CONFIGURATION_BLENGTH_COUNT => NOT_EQUALS_CONFIGURATION_BLENGTH_COUNT,
				CONFIGURATION_WTOTALLENGTH_INDEX => NOT_EQUALS_CONFIGURATION_WTOTALLENGTH_INDEX,
				CONFIGURATION_WTOTALLENGTH_COUNT => NOT_EQUALS_CONFIGURATION_WTOTALLENGTH_COUNT,
				CONFIGURATION_BNUMINTERFACES_INDEX => NOT_EQUALS_CONFIGURATION_BNUMINTERFACES_INDEX,
				CONFIGURATION_BNUMINTERFACES_COUNT => NOT_EQUALS_CONFIGURATION_BNUMINTERFACES_COUNT,
				CONFIGURATION_BCONFIGURATIONVALUE_INDEX => NOT_EQUALS_CONFIGURATION_BCONFIGURATIONVALUE_INDEX,
				CONFIGURATION_BCONFIGURATIONVALUE_COUNT => NOT_EQUALS_CONFIGURATION_BCONFIGURATIONVALUE_COUNT,
				CONFIGURATION_ICONFIGURATION_BLENGTH_INDEX => NOT_EQUALS_CONFIGURATION_ICONFIGURATION_BLENGTH_INDEX,
				CONFIGURATION_ICONFIGURATION_BLENGTH_COUNT => NOT_EQUALS_CONFIGURATION_ICONFIGURATION_BLENGTH_COUNT,
				CONFIGURATION_ICONFIGURATION_INDEX => NOT_EQUALS_CONFIGURATION_ICONFIGURATION_INDEX,
				CONFIGURATION_ICONFIGURATION_COUNT => NOT_EQUALS_CONFIGURATION_ICONFIGURATION_COUNT,
				CONFIGURATION_BMATTRIBUTES_INDEX => NOT_EQUALS_CONFIGURATION_BMATTRIBUTES_INDEX,
				CONFIGURATION_BMATTRIBUTES_COUNT => NOT_EQUALS_CONFIGURATION_BMATTRIBUTES_COUNT,
				CONFIGURATION_BMAXPOWER_INDEX => NOT_EQUALS_CONFIGURATION_BMAXPOWER_INDEX,
				CONFIGURATION_BMAXPOWER_COUNT => NOT_EQUALS_CONFIGURATION_BMAXPOWER_COUNT,
				-- Interface Descriptor
				INTERFACE_BLENGTH_INDEX => NOT_EQUALS_INTERFACE_BLENGTH_INDEX,
				INTERFACE_BLENGTH_COUNT => NOT_EQUALS_INTERFACE_BLENGTH_COUNT,
				INTERFACE_BINTERFACENUMBER_INDEX => NOT_EQUALS_INTERFACE_BINTERFACENUMBER_INDEX,
				INTERFACE_BINTERFACENUMBER_COUNT => NOT_EQUALS_INTERFACE_BINTERFACENUMBER_COUNT,
				INTERFACE_BALTERNATESETTING_INDEX => NOT_EQUALS_INTERFACE_BALTERNATESETTING_INDEX,
				INTERFACE_BALTERNATESETTING_COUNT => NOT_EQUALS_INTERFACE_BALTERNATESETTING_COUNT,
				INTERFACE_BNUMENDPOINTS_INDEX => NOT_EQUALS_INTERFACE_BNUMENDPOINTS_INDEX,
				INTERFACE_BNUMENDPOINTS_COUNT => NOT_EQUALS_INTERFACE_BNUMENDPOINTS_COUNT,
				INTERFACE_BINTERFACECLASS_INDEX => NOT_EQUALS_INTERFACE_BINTERFACECLASS_INDEX,
				INTERFACE_BINTERFACECLASS_COUNT => NOT_EQUALS_INTERFACE_BINTERFACECLASS_COUNT,
				INTERFACE_BINTERFACESUBCLASS_INDEX => NOT_EQUALS_INTERFACE_BINTERFACESUBCLASS_INDEX,
				INTERFACE_BINTERFACESUBCLASS_COUNT => NOT_EQUALS_INTERFACE_BINTERFACESUBCLASS_COUNT,
				INTERFACE_BINTERFACEPROTOCOL_INDEX => NOT_EQUALS_INTERFACE_BINTERFACEPROTOCOL_INDEX,
				INTERFACE_BINTERFACEPROTOCOL_COUNT => NOT_EQUALS_INTERFACE_BINTERFACEPROTOCOL_COUNT,
				INTERFACE_IINTERFACE_BLENGTH_INDEX => NOT_EQUALS_INTERFACE_IINTERFACE_BLENGTH_INDEX,
				INTERFACE_IINTERFACE_BLENGTH_COUNT => NOT_EQUALS_INTERFACE_IINTERFACE_BLENGTH_COUNT,
				INTERFACE_IINTERFACE_INDEX => NOT_EQUALS_INTERFACE_IINTERFACE_INDEX,
				INTERFACE_IINTERFACE_COUNT => NOT_EQUALS_INTERFACE_IINTERFACE_COUNT,
				-- HID Descriptor
				HID_BLENGTH_INDEX => NOT_EQUALS_HID_BLENGTH_INDEX,
				HID_BLENGTH_COUNT => NOT_EQUALS_HID_BLENGTH_COUNT,
				HID_BCDHID_INDEX => NOT_EQUALS_HID_BCDHID_INDEX,
				HID_BCDHID_COUNT => NOT_EQUALS_HID_BCDHID_COUNT,
				HID_BCOUNTRYCODE_INDEX => NOT_EQUALS_HID_BCOUNTRYCODE_INDEX,
				HID_BCOUNTRYCODE_COUNT => NOT_EQUALS_HID_BCOUNTRYCODE_COUNT,
				HID_BNUMDESCRIPTORS_INDEX => NOT_EQUALS_HID_BNUMDESCRIPTORS_INDEX,
				HID_BNUMDESCRIPTORS_COUNT => NOT_EQUALS_HID_BNUMDESCRIPTORS_COUNT,
				HID_BDESCRIPTORTYPE_INDEX => NOT_EQUALS_HID_BDESCRIPTORTYPE_INDEX,
				HID_BDESCRIPTORTYPE_COUNT => NOT_EQUALS_HID_BDESCRIPTORTYPE_COUNT,
				HID_WDESCRIPTORLENGTH_INDEX => NOT_EQUALS_HID_WDESCRIPTORLENGTH_INDEX,
				HID_WDESCRIPTORLENGTH_COUNT => NOT_EQUALS_HID_WDESCRIPTORLENGTH_COUNT,
				-- Endpoint Descriptor
				ENDPOINT_BLENGTH_INDEX => NOT_EQUALS_ENDPOINT_BLENGTH_INDEX,
				ENDPOINT_BLENGTH_COUNT => NOT_EQUALS_ENDPOINT_BLENGTH_COUNT,
				ENDPOINT_BENDPOINTADDRESS_INDEX => NOT_EQUALS_ENDPOINT_BENDPOINTADDRESS_INDEX,
				ENDPOINT_BENDPOINTADDRESS_COUNT => NOT_EQUALS_ENDPOINT_BENDPOINTADDRESS_COUNT,
				ENDPOINT_BMATTRIBUTES_INDEX => NOT_EQUALS_ENDPOINT_BMATTRIBUTES_INDEX,
				ENDPOINT_BMATTRIBUTES_COUNT => NOT_EQUALS_ENDPOINT_BMATTRIBUTES_COUNT,
				ENDPOINT_WMAXPACKETSIZE_INDEX => NOT_EQUALS_ENDPOINT_WMAXPACKETSIZE_INDEX,
				ENDPOINT_WMAXPACKETSIZE_COUNT => NOT_EQUALS_ENDPOINT_WMAXPACKETSIZE_COUNT,
				ENDPOINT_BINTERVAL_INDEX => NOT_EQUALS_ENDPOINT_BINTERVAL_INDEX,
				ENDPOINT_BINTERVAL_COUNT => NOT_EQUALS_ENDPOINT_BINTERVAL_COUNT,
				-- Device Qualifier Descriptor
				DEVICE_QUALIFIER_BLENGTH_INDEX => NOT_EQUALS_DEVICE_QUALIFIER_BLENGTH_INDEX,
				DEVICE_QUALIFIER_BLENGTH_COUNT => NOT_EQUALS_DEVICE_QUALIFIER_BLENGTH_COUNT,
				DEVICE_QUALIFIER_BCDUSB_INDEX => NOT_EQUALS_DEVICE_QUALIFIER_BCDUSB_INDEX,
				DEVICE_QUALIFIER_BCDUSB_COUNT => NOT_EQUALS_DEVICE_QUALIFIER_BCDUSB_COUNT,
				DEVICE_QUALIFIER_BDEVICECLASS_INDEX => NOT_EQUALS_DEVICE_QUALIFIER_BDEVICECLASS_INDEX,
				DEVICE_QUALIFIER_BDEVICECLASS_COUNT => NOT_EQUALS_DEVICE_QUALIFIER_BDEVICECLASS_COUNT,
				DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX => NOT_EQUALS_DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX,
				DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT => NOT_EQUALS_DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT,
				DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX => NOT_EQUALS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX,
				DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT => NOT_EQUALS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT,
				DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX => NOT_EQUALS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX,
				DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT => NOT_EQUALS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT,
				DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX => NOT_EQUALS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX,
				DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT => NOT_EQUALS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT,
				DEVICE_QUALIFIER_BRESERVED_INDEX => NOT_EQUALS_DEVICE_QUALIFIER_BRESERVED_INDEX,
				DEVICE_QUALIFIER_BRESERVED_COUNT => NOT_EQUALS_DEVICE_QUALIFIER_BRESERVED_COUNT,
				-- Other Speed Descriptor
				OTHER_SPEED_BLENGTH_INDEX => NOT_EQUALS_OTHER_SPEED_BLENGTH_INDEX,
				OTHER_SPEED_BLENGTH_COUNT => NOT_EQUALS_OTHER_SPEED_BLENGTH_COUNT,
				OTHER_SPEED_WTOTALLENGTH_INDEX => NOT_EQUALS_OTHER_SPEED_WTOTALLENGTH_INDEX,
				OTHER_SPEED_WTOTALLENGTH_COUNT => NOT_EQUALS_OTHER_SPEED_WTOTALLENGTH_COUNT,
				OTHER_SPEED_BNUMINTERFACES_INDEX => NOT_EQUALS_OTHER_SPEED_BNUMINTERFACES_INDEX,
				OTHER_SPEED_BNUMINTERFACES_COUNT => NOT_EQUALS_OTHER_SPEED_BNUMINTERFACES_COUNT,
				OTHER_SPEED_BCONFIGURATIONVALUE_INDEX => NOT_EQUALS_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX,
				OTHER_SPEED_BCONFIGURATIONVALUE_COUNT => NOT_EQUALS_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT,
				OTHER_SPEED_ICONFIGURATION_BLENGTH_INDEX => NOT_EQUALS_OTHER_SPEED_ICONFIGURATION_BLENGTH_INDEX,
				OTHER_SPEED_ICONFIGURATION_BLENGTH_COUNT => NOT_EQUALS_OTHER_SPEED_ICONFIGURATION_BLENGTH_COUNT,
				OTHER_SPEED_ICONFIGURATION_INDEX => NOT_EQUALS_OTHER_SPEED_ICONFIGURATION_INDEX,
				OTHER_SPEED_ICONFIGURATION_COUNT => NOT_EQUALS_OTHER_SPEED_ICONFIGURATION_COUNT,
				OTHER_SPEED_BMATTRIBUTES_INDEX => NOT_EQUALS_OTHER_SPEED_BMATTRIBUTES_INDEX,
				OTHER_SPEED_BMATTRIBUTES_COUNT => NOT_EQUALS_OTHER_SPEED_BMATTRIBUTES_COUNT,
				OTHER_SPEED_BMAXPOWER_INDEX => NOT_EQUALS_OTHER_SPEED_BMAXPOWER_INDEX,
				OTHER_SPEED_BMAXPOWER_COUNT => NOT_EQUALS_OTHER_SPEED_BMAXPOWER_COUNT
			)
			PORT MAP (
				i_sys_clock => i_sys_clock,
				i_enable => i_enable,
				i_descriptor_field => i_descriptor_field,
				i_descriptor_field_available => i_descriptor_field_available,
				i_descriptor_value => i_descriptor_value,
				i_descriptor_value_en => i_descriptor_value_en,
				i_descriptor_value_total_part_number => i_descriptor_value_total_part_number,
				i_descriptor_value_part_number => i_descriptor_value_part_number,
				i_descriptor_value_new_part => i_descriptor_value_new_part,
				o_descriptor_value_next_part_request => operators_next_part_request(NOT_EQUALS_OPERATOR_INDEX),
				o_ready => operators_ready(NOT_EQUALS_OPERATOR_INDEX),
				o_result => operators_result(NOT_EQUALS_OPERATOR_INDEX)
		);
	end generate;

	----------------------
	-- Greater Operator --
	----------------------
	greaterOperator_en: if (GREATER_OPERATOR_ENABLE = '1') generate
		greaterOperator_inst: GreaterOperator
			GENERIC MAP (
				-- Memory Configurations (Address Length, Address Max Index, Address Count Max)
				MEMORY_ADDR_LENGTH => GREATER_MEMORY_ADDR_LENGTH,
				MEMORY_ADDR_MAX_INDEX => GREATER_MEMORY_ADDR_MAX_INDEX,
				MEMORY_ADDR_MAX_COUNT => GREATER_MEMORY_ADDR_MAX_COUNT,
				-- Device Descriptor
				DEVICE_BLENGTH_INDEX => GREATER_DEVICE_BLENGTH_INDEX,
				DEVICE_BLENGTH_COUNT => GREATER_DEVICE_BLENGTH_COUNT,
				DEVICE_BCDUSB_INDEX => GREATER_DEVICE_BCDUSB_INDEX,
				DEVICE_BCDUSB_COUNT => GREATER_DEVICE_BCDUSB_COUNT,
				DEVICE_BDEVICECLASS_INDEX => GREATER_DEVICE_BDEVICECLASS_INDEX,
				DEVICE_BDEVICECLASS_COUNT => GREATER_DEVICE_BDEVICECLASS_COUNT,
				DEVICE_BDEVICESUBCLASS_INDEX => GREATER_DEVICE_BDEVICESUBCLASS_INDEX,
				DEVICE_BDEVICESUBCLASS_COUNT => GREATER_DEVICE_BDEVICESUBCLASS_COUNT,
				DEVICE_BDEVICEPROTOCOL_INDEX => GREATER_DEVICE_BDEVICEPROTOCOL_INDEX,
				DEVICE_BDEVICEPROTOCOL_COUNT => GREATER_DEVICE_BDEVICEPROTOCOL_COUNT,
				DEVICE_BMAXPACKETSIZE0_INDEX => GREATER_DEVICE_BMAXPACKETSIZE0_INDEX,
				DEVICE_BMAXPACKETSIZE0_COUNT => GREATER_DEVICE_BMAXPACKETSIZE0_COUNT,
				DEVICE_IDVENDOR_INDEX => GREATER_DEVICE_IDVENDOR_INDEX,
				DEVICE_IDVENDOR_COUNT => GREATER_DEVICE_IDVENDOR_COUNT,
				DEVICE_IDPRODUCT_INDEX => GREATER_DEVICE_IDPRODUCT_INDEX,
				DEVICE_IDPRODUCT_COUNT => GREATER_DEVICE_IDPRODUCT_COUNT,
				DEVICE_BCDDEVICE_INDEX => GREATER_DEVICE_BCDDEVICE_INDEX,
				DEVICE_BCDDEVICE_COUNT => GREATER_DEVICE_BCDDEVICE_COUNT,
				DEVICE_IMANUFACTURER_BLENGTH_INDEX => GREATER_DEVICE_IMANUFACTURER_BLENGTH_INDEX,
				DEVICE_IMANUFACTURER_BLENGTH_COUNT => GREATER_DEVICE_IMANUFACTURER_BLENGTH_COUNT,
				DEVICE_IMANUFACTURER_INDEX => GREATER_DEVICE_IMANUFACTURER_INDEX,
				DEVICE_IMANUFACTURER_COUNT => GREATER_DEVICE_IMANUFACTURER_COUNT,
				DEVICE_IPRODUCT_BLENGTH_INDEX => GREATER_DEVICE_IPRODUCT_BLENGTH_INDEX,
				DEVICE_IPRODUCT_BLENGTH_COUNT => GREATER_DEVICE_IPRODUCT_BLENGTH_COUNT,
				DEVICE_IPRODUCT_INDEX => GREATER_DEVICE_IPRODUCT_INDEX,
				DEVICE_IPRODUCT_COUNT => GREATER_DEVICE_IPRODUCT_COUNT,
				DEVICE_ISERIALNUMBER_BLENGTH_INDEX => GREATER_DEVICE_ISERIALNUMBER_BLENGTH_INDEX,
				DEVICE_ISERIALNUMBER_BLENGTH_COUNT => GREATER_DEVICE_ISERIALNUMBER_BLENGTH_COUNT,
				DEVICE_ISERIALNUMBER_INDEX => GREATER_DEVICE_ISERIALNUMBER_INDEX,
				DEVICE_ISERIALNUMBER_COUNT => GREATER_DEVICE_ISERIALNUMBER_COUNT,
				DEVICE_BNUMCONFIGURATIONS_INDEX => GREATER_DEVICE_BNUMCONFIGURATIONS_INDEX,
				DEVICE_BNUMCONFIGURATIONS_COUNT => GREATER_DEVICE_BNUMCONFIGURATIONS_COUNT,
				-- Configuration Descriptor
				CONFIGURATION_BLENGTH_INDEX => GREATER_CONFIGURATION_BLENGTH_INDEX,
				CONFIGURATION_BLENGTH_COUNT => GREATER_CONFIGURATION_BLENGTH_COUNT,
				CONFIGURATION_WTOTALLENGTH_INDEX => GREATER_CONFIGURATION_WTOTALLENGTH_INDEX,
				CONFIGURATION_WTOTALLENGTH_COUNT => GREATER_CONFIGURATION_WTOTALLENGTH_COUNT,
				CONFIGURATION_BNUMINTERFACES_INDEX => GREATER_CONFIGURATION_BNUMINTERFACES_INDEX,
				CONFIGURATION_BNUMINTERFACES_COUNT => GREATER_CONFIGURATION_BNUMINTERFACES_COUNT,
				CONFIGURATION_BCONFIGURATIONVALUE_INDEX => GREATER_CONFIGURATION_BCONFIGURATIONVALUE_INDEX,
				CONFIGURATION_BCONFIGURATIONVALUE_COUNT => GREATER_CONFIGURATION_BCONFIGURATIONVALUE_COUNT,
				CONFIGURATION_ICONFIGURATION_BLENGTH_INDEX => GREATER_CONFIGURATION_ICONFIGURATION_BLENGTH_INDEX,
				CONFIGURATION_ICONFIGURATION_BLENGTH_COUNT => GREATER_CONFIGURATION_ICONFIGURATION_BLENGTH_COUNT,
				CONFIGURATION_ICONFIGURATION_INDEX => GREATER_CONFIGURATION_ICONFIGURATION_INDEX,
				CONFIGURATION_ICONFIGURATION_COUNT => GREATER_CONFIGURATION_ICONFIGURATION_COUNT,
				CONFIGURATION_BMATTRIBUTES_INDEX => GREATER_CONFIGURATION_BMATTRIBUTES_INDEX,
				CONFIGURATION_BMATTRIBUTES_COUNT => GREATER_CONFIGURATION_BMATTRIBUTES_COUNT,
				CONFIGURATION_BMAXPOWER_INDEX => GREATER_CONFIGURATION_BMAXPOWER_INDEX,
				CONFIGURATION_BMAXPOWER_COUNT => GREATER_CONFIGURATION_BMAXPOWER_COUNT,
				-- Interface Descriptor
				INTERFACE_BLENGTH_INDEX => GREATER_INTERFACE_BLENGTH_INDEX,
				INTERFACE_BLENGTH_COUNT => GREATER_INTERFACE_BLENGTH_COUNT,
				INTERFACE_BINTERFACENUMBER_INDEX => GREATER_INTERFACE_BINTERFACENUMBER_INDEX,
				INTERFACE_BINTERFACENUMBER_COUNT => GREATER_INTERFACE_BINTERFACENUMBER_COUNT,
				INTERFACE_BALTERNATESETTING_INDEX => GREATER_INTERFACE_BALTERNATESETTING_INDEX,
				INTERFACE_BALTERNATESETTING_COUNT => GREATER_INTERFACE_BALTERNATESETTING_COUNT,
				INTERFACE_BNUMENDPOINTS_INDEX => GREATER_INTERFACE_BNUMENDPOINTS_INDEX,
				INTERFACE_BNUMENDPOINTS_COUNT => GREATER_INTERFACE_BNUMENDPOINTS_COUNT,
				INTERFACE_BINTERFACECLASS_INDEX => GREATER_INTERFACE_BINTERFACECLASS_INDEX,
				INTERFACE_BINTERFACECLASS_COUNT => GREATER_INTERFACE_BINTERFACECLASS_COUNT,
				INTERFACE_BINTERFACESUBCLASS_INDEX => GREATER_INTERFACE_BINTERFACESUBCLASS_INDEX,
				INTERFACE_BINTERFACESUBCLASS_COUNT => GREATER_INTERFACE_BINTERFACESUBCLASS_COUNT,
				INTERFACE_BINTERFACEPROTOCOL_INDEX => GREATER_INTERFACE_BINTERFACEPROTOCOL_INDEX,
				INTERFACE_BINTERFACEPROTOCOL_COUNT => GREATER_INTERFACE_BINTERFACEPROTOCOL_COUNT,
				INTERFACE_IINTERFACE_BLENGTH_INDEX => GREATER_INTERFACE_IINTERFACE_BLENGTH_INDEX,
				INTERFACE_IINTERFACE_BLENGTH_COUNT => GREATER_INTERFACE_IINTERFACE_BLENGTH_COUNT,
				INTERFACE_IINTERFACE_INDEX => GREATER_INTERFACE_IINTERFACE_INDEX,
				INTERFACE_IINTERFACE_COUNT => GREATER_INTERFACE_IINTERFACE_COUNT,
				-- HID Descriptor
				HID_BLENGTH_INDEX => GREATER_HID_BLENGTH_INDEX,
				HID_BLENGTH_COUNT => GREATER_HID_BLENGTH_COUNT,
				HID_BCDHID_INDEX => GREATER_HID_BCDHID_INDEX,
				HID_BCDHID_COUNT => GREATER_HID_BCDHID_COUNT,
				HID_BCOUNTRYCODE_INDEX => GREATER_HID_BCOUNTRYCODE_INDEX,
				HID_BCOUNTRYCODE_COUNT => GREATER_HID_BCOUNTRYCODE_COUNT,
				HID_BNUMDESCRIPTORS_INDEX => GREATER_HID_BNUMDESCRIPTORS_INDEX,
				HID_BNUMDESCRIPTORS_COUNT => GREATER_HID_BNUMDESCRIPTORS_COUNT,
				HID_BDESCRIPTORTYPE_INDEX => GREATER_HID_BDESCRIPTORTYPE_INDEX,
				HID_BDESCRIPTORTYPE_COUNT => GREATER_HID_BDESCRIPTORTYPE_COUNT,
				HID_WDESCRIPTORLENGTH_INDEX => GREATER_HID_WDESCRIPTORLENGTH_INDEX,
				HID_WDESCRIPTORLENGTH_COUNT => GREATER_HID_WDESCRIPTORLENGTH_COUNT,
				-- Endpoint Descriptor
				ENDPOINT_BLENGTH_INDEX => GREATER_ENDPOINT_BLENGTH_INDEX,
				ENDPOINT_BLENGTH_COUNT => GREATER_ENDPOINT_BLENGTH_COUNT,
				ENDPOINT_BENDPOINTADDRESS_INDEX => GREATER_ENDPOINT_BENDPOINTADDRESS_INDEX,
				ENDPOINT_BENDPOINTADDRESS_COUNT => GREATER_ENDPOINT_BENDPOINTADDRESS_COUNT,
				ENDPOINT_BMATTRIBUTES_INDEX => GREATER_ENDPOINT_BMATTRIBUTES_INDEX,
				ENDPOINT_BMATTRIBUTES_COUNT => GREATER_ENDPOINT_BMATTRIBUTES_COUNT,
				ENDPOINT_WMAXPACKETSIZE_INDEX => GREATER_ENDPOINT_WMAXPACKETSIZE_INDEX,
				ENDPOINT_WMAXPACKETSIZE_COUNT => GREATER_ENDPOINT_WMAXPACKETSIZE_COUNT,
				ENDPOINT_BINTERVAL_INDEX => GREATER_ENDPOINT_BINTERVAL_INDEX,
				ENDPOINT_BINTERVAL_COUNT => GREATER_ENDPOINT_BINTERVAL_COUNT,
				-- Device Qualifier Descriptor
				DEVICE_QUALIFIER_BLENGTH_INDEX => GREATER_DEVICE_QUALIFIER_BLENGTH_INDEX,
				DEVICE_QUALIFIER_BLENGTH_COUNT => GREATER_DEVICE_QUALIFIER_BLENGTH_COUNT,
				DEVICE_QUALIFIER_BCDUSB_INDEX => GREATER_DEVICE_QUALIFIER_BCDUSB_INDEX,
				DEVICE_QUALIFIER_BCDUSB_COUNT => GREATER_DEVICE_QUALIFIER_BCDUSB_COUNT,
				DEVICE_QUALIFIER_BDEVICECLASS_INDEX => GREATER_DEVICE_QUALIFIER_BDEVICECLASS_INDEX,
				DEVICE_QUALIFIER_BDEVICECLASS_COUNT => GREATER_DEVICE_QUALIFIER_BDEVICECLASS_COUNT,
				DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX => GREATER_DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX,
				DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT => GREATER_DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT,
				DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX => GREATER_DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX,
				DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT => GREATER_DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT,
				DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX => GREATER_DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX,
				DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT => GREATER_DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT,
				DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX => GREATER_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX,
				DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT => GREATER_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT,
				DEVICE_QUALIFIER_BRESERVED_INDEX => GREATER_DEVICE_QUALIFIER_BRESERVED_INDEX,
				DEVICE_QUALIFIER_BRESERVED_COUNT => GREATER_DEVICE_QUALIFIER_BRESERVED_COUNT,
				-- Other Speed Descriptor
				OTHER_SPEED_BLENGTH_INDEX => GREATER_OTHER_SPEED_BLENGTH_INDEX,
				OTHER_SPEED_BLENGTH_COUNT => GREATER_OTHER_SPEED_BLENGTH_COUNT,
				OTHER_SPEED_WTOTALLENGTH_INDEX => GREATER_OTHER_SPEED_WTOTALLENGTH_INDEX,
				OTHER_SPEED_WTOTALLENGTH_COUNT => GREATER_OTHER_SPEED_WTOTALLENGTH_COUNT,
				OTHER_SPEED_BNUMINTERFACES_INDEX => GREATER_OTHER_SPEED_BNUMINTERFACES_INDEX,
				OTHER_SPEED_BNUMINTERFACES_COUNT => GREATER_OTHER_SPEED_BNUMINTERFACES_COUNT,
				OTHER_SPEED_BCONFIGURATIONVALUE_INDEX => GREATER_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX,
				OTHER_SPEED_BCONFIGURATIONVALUE_COUNT => GREATER_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT,
				OTHER_SPEED_ICONFIGURATION_BLENGTH_INDEX => GREATER_OTHER_SPEED_ICONFIGURATION_BLENGTH_INDEX,
				OTHER_SPEED_ICONFIGURATION_BLENGTH_COUNT => GREATER_OTHER_SPEED_ICONFIGURATION_BLENGTH_COUNT,
				OTHER_SPEED_ICONFIGURATION_INDEX => GREATER_OTHER_SPEED_ICONFIGURATION_INDEX,
				OTHER_SPEED_ICONFIGURATION_COUNT => GREATER_OTHER_SPEED_ICONFIGURATION_COUNT,
				OTHER_SPEED_BMATTRIBUTES_INDEX => GREATER_OTHER_SPEED_BMATTRIBUTES_INDEX,
				OTHER_SPEED_BMATTRIBUTES_COUNT => GREATER_OTHER_SPEED_BMATTRIBUTES_COUNT,
				OTHER_SPEED_BMAXPOWER_INDEX => GREATER_OTHER_SPEED_BMAXPOWER_INDEX,
				OTHER_SPEED_BMAXPOWER_COUNT => GREATER_OTHER_SPEED_BMAXPOWER_COUNT
			)
			PORT MAP (
				i_sys_clock => i_sys_clock,
				i_enable => i_enable,
				i_descriptor_field => i_descriptor_field,
				i_descriptor_field_available => i_descriptor_field_available,
				i_descriptor_value => i_descriptor_value,
				i_descriptor_value_en => i_descriptor_value_en,
				i_descriptor_value_total_part_number => i_descriptor_value_total_part_number,
				i_descriptor_value_part_number => i_descriptor_value_part_number,
				i_descriptor_value_new_part => i_descriptor_value_new_part,
				o_descriptor_value_next_part_request => operators_next_part_request(GREATER_OPERATOR_INDEX),
				o_ready => operators_ready(GREATER_OPERATOR_INDEX),
				o_result => operators_result(GREATER_OPERATOR_INDEX)
		);
	end generate;

	----------------------------
	-- GreaterEquals Operator --
	----------------------------
	greaterEqualsOperator_en: if (GREATER_EQUALS_OPERATOR_ENABLE = '1') generate
		greaterEqualsOperator_inst: GreaterEqualsOperator
			GENERIC MAP (
				-- Memory Configurations (Address Length, Address Max Index, Address Count Max)
				MEMORY_ADDR_LENGTH => GREATER_EQUALS_MEMORY_ADDR_LENGTH,
				MEMORY_ADDR_MAX_INDEX => GREATER_EQUALS_MEMORY_ADDR_MAX_INDEX,
				MEMORY_ADDR_MAX_COUNT => GREATER_EQUALS_MEMORY_ADDR_MAX_COUNT,
				-- Device Descriptor
				DEVICE_BLENGTH_INDEX => GREATER_EQUALS_DEVICE_BLENGTH_INDEX,
				DEVICE_BLENGTH_COUNT => GREATER_EQUALS_DEVICE_BLENGTH_COUNT,
				DEVICE_BCDUSB_INDEX => GREATER_EQUALS_DEVICE_BCDUSB_INDEX,
				DEVICE_BCDUSB_COUNT => GREATER_EQUALS_DEVICE_BCDUSB_COUNT,
				DEVICE_BDEVICECLASS_INDEX => GREATER_EQUALS_DEVICE_BDEVICECLASS_INDEX,
				DEVICE_BDEVICECLASS_COUNT => GREATER_EQUALS_DEVICE_BDEVICECLASS_COUNT,
				DEVICE_BDEVICESUBCLASS_INDEX => GREATER_EQUALS_DEVICE_BDEVICESUBCLASS_INDEX,
				DEVICE_BDEVICESUBCLASS_COUNT => GREATER_EQUALS_DEVICE_BDEVICESUBCLASS_COUNT,
				DEVICE_BDEVICEPROTOCOL_INDEX => GREATER_EQUALS_DEVICE_BDEVICEPROTOCOL_INDEX,
				DEVICE_BDEVICEPROTOCOL_COUNT => GREATER_EQUALS_DEVICE_BDEVICEPROTOCOL_COUNT,
				DEVICE_BMAXPACKETSIZE0_INDEX => GREATER_EQUALS_DEVICE_BMAXPACKETSIZE0_INDEX,
				DEVICE_BMAXPACKETSIZE0_COUNT => GREATER_EQUALS_DEVICE_BMAXPACKETSIZE0_COUNT,
				DEVICE_IDVENDOR_INDEX => GREATER_EQUALS_DEVICE_IDVENDOR_INDEX,
				DEVICE_IDVENDOR_COUNT => GREATER_EQUALS_DEVICE_IDVENDOR_COUNT,
				DEVICE_IDPRODUCT_INDEX => GREATER_EQUALS_DEVICE_IDPRODUCT_INDEX,
				DEVICE_IDPRODUCT_COUNT => GREATER_EQUALS_DEVICE_IDPRODUCT_COUNT,
				DEVICE_BCDDEVICE_INDEX => GREATER_EQUALS_DEVICE_BCDDEVICE_INDEX,
				DEVICE_BCDDEVICE_COUNT => GREATER_EQUALS_DEVICE_BCDDEVICE_COUNT,
				DEVICE_IMANUFACTURER_BLENGTH_INDEX => GREATER_EQUALS_DEVICE_IMANUFACTURER_BLENGTH_INDEX,
				DEVICE_IMANUFACTURER_BLENGTH_COUNT => GREATER_EQUALS_DEVICE_IMANUFACTURER_BLENGTH_COUNT,
				DEVICE_IMANUFACTURER_INDEX => GREATER_EQUALS_DEVICE_IMANUFACTURER_INDEX,
				DEVICE_IMANUFACTURER_COUNT => GREATER_EQUALS_DEVICE_IMANUFACTURER_COUNT,
				DEVICE_IPRODUCT_BLENGTH_INDEX => GREATER_EQUALS_DEVICE_IPRODUCT_BLENGTH_INDEX,
				DEVICE_IPRODUCT_BLENGTH_COUNT => GREATER_EQUALS_DEVICE_IPRODUCT_BLENGTH_COUNT,
				DEVICE_IPRODUCT_INDEX => GREATER_EQUALS_DEVICE_IPRODUCT_INDEX,
				DEVICE_IPRODUCT_COUNT => GREATER_EQUALS_DEVICE_IPRODUCT_COUNT,
				DEVICE_ISERIALNUMBER_BLENGTH_INDEX => GREATER_EQUALS_DEVICE_ISERIALNUMBER_BLENGTH_INDEX,
				DEVICE_ISERIALNUMBER_BLENGTH_COUNT => GREATER_EQUALS_DEVICE_ISERIALNUMBER_BLENGTH_COUNT,
				DEVICE_ISERIALNUMBER_INDEX => GREATER_EQUALS_DEVICE_ISERIALNUMBER_INDEX,
				DEVICE_ISERIALNUMBER_COUNT => GREATER_EQUALS_DEVICE_ISERIALNUMBER_COUNT,
				DEVICE_BNUMCONFIGURATIONS_INDEX => GREATER_EQUALS_DEVICE_BNUMCONFIGURATIONS_INDEX,
				DEVICE_BNUMCONFIGURATIONS_COUNT => GREATER_EQUALS_DEVICE_BNUMCONFIGURATIONS_COUNT,
				-- Configuration Descriptor
				CONFIGURATION_BLENGTH_INDEX => GREATER_EQUALS_CONFIGURATION_BLENGTH_INDEX,
				CONFIGURATION_BLENGTH_COUNT => GREATER_EQUALS_CONFIGURATION_BLENGTH_COUNT,
				CONFIGURATION_WTOTALLENGTH_INDEX => GREATER_EQUALS_CONFIGURATION_WTOTALLENGTH_INDEX,
				CONFIGURATION_WTOTALLENGTH_COUNT => GREATER_EQUALS_CONFIGURATION_WTOTALLENGTH_COUNT,
				CONFIGURATION_BNUMINTERFACES_INDEX => GREATER_EQUALS_CONFIGURATION_BNUMINTERFACES_INDEX,
				CONFIGURATION_BNUMINTERFACES_COUNT => GREATER_EQUALS_CONFIGURATION_BNUMINTERFACES_COUNT,
				CONFIGURATION_BCONFIGURATIONVALUE_INDEX => GREATER_EQUALS_CONFIGURATION_BCONFIGURATIONVALUE_INDEX,
				CONFIGURATION_BCONFIGURATIONVALUE_COUNT => GREATER_EQUALS_CONFIGURATION_BCONFIGURATIONVALUE_COUNT,
				CONFIGURATION_ICONFIGURATION_BLENGTH_INDEX => GREATER_EQUALS_CONFIGURATION_ICONFIGURATION_BLENGTH_INDEX,
				CONFIGURATION_ICONFIGURATION_BLENGTH_COUNT => GREATER_EQUALS_CONFIGURATION_ICONFIGURATION_BLENGTH_COUNT,
				CONFIGURATION_ICONFIGURATION_INDEX => GREATER_EQUALS_CONFIGURATION_ICONFIGURATION_INDEX,
				CONFIGURATION_ICONFIGURATION_COUNT => GREATER_EQUALS_CONFIGURATION_ICONFIGURATION_COUNT,
				CONFIGURATION_BMATTRIBUTES_INDEX => GREATER_EQUALS_CONFIGURATION_BMATTRIBUTES_INDEX,
				CONFIGURATION_BMATTRIBUTES_COUNT => GREATER_EQUALS_CONFIGURATION_BMATTRIBUTES_COUNT,
				CONFIGURATION_BMAXPOWER_INDEX => GREATER_EQUALS_CONFIGURATION_BMAXPOWER_INDEX,
				CONFIGURATION_BMAXPOWER_COUNT => GREATER_EQUALS_CONFIGURATION_BMAXPOWER_COUNT,
				-- Interface Descriptor
				INTERFACE_BLENGTH_INDEX => GREATER_EQUALS_INTERFACE_BLENGTH_INDEX,
				INTERFACE_BLENGTH_COUNT => GREATER_EQUALS_INTERFACE_BLENGTH_COUNT,
				INTERFACE_BINTERFACENUMBER_INDEX => GREATER_EQUALS_INTERFACE_BINTERFACENUMBER_INDEX,
				INTERFACE_BINTERFACENUMBER_COUNT => GREATER_EQUALS_INTERFACE_BINTERFACENUMBER_COUNT,
				INTERFACE_BALTERNATESETTING_INDEX => GREATER_EQUALS_INTERFACE_BALTERNATESETTING_INDEX,
				INTERFACE_BALTERNATESETTING_COUNT => GREATER_EQUALS_INTERFACE_BALTERNATESETTING_COUNT,
				INTERFACE_BNUMENDPOINTS_INDEX => GREATER_EQUALS_INTERFACE_BNUMENDPOINTS_INDEX,
				INTERFACE_BNUMENDPOINTS_COUNT => GREATER_EQUALS_INTERFACE_BNUMENDPOINTS_COUNT,
				INTERFACE_BINTERFACECLASS_INDEX => GREATER_EQUALS_INTERFACE_BINTERFACECLASS_INDEX,
				INTERFACE_BINTERFACECLASS_COUNT => GREATER_EQUALS_INTERFACE_BINTERFACECLASS_COUNT,
				INTERFACE_BINTERFACESUBCLASS_INDEX => GREATER_EQUALS_INTERFACE_BINTERFACESUBCLASS_INDEX,
				INTERFACE_BINTERFACESUBCLASS_COUNT => GREATER_EQUALS_INTERFACE_BINTERFACESUBCLASS_COUNT,
				INTERFACE_BINTERFACEPROTOCOL_INDEX => GREATER_EQUALS_INTERFACE_BINTERFACEPROTOCOL_INDEX,
				INTERFACE_BINTERFACEPROTOCOL_COUNT => GREATER_EQUALS_INTERFACE_BINTERFACEPROTOCOL_COUNT,
				INTERFACE_IINTERFACE_BLENGTH_INDEX => GREATER_EQUALS_INTERFACE_IINTERFACE_BLENGTH_INDEX,
				INTERFACE_IINTERFACE_BLENGTH_COUNT => GREATER_EQUALS_INTERFACE_IINTERFACE_BLENGTH_COUNT,
				INTERFACE_IINTERFACE_INDEX => GREATER_EQUALS_INTERFACE_IINTERFACE_INDEX,
				INTERFACE_IINTERFACE_COUNT => GREATER_EQUALS_INTERFACE_IINTERFACE_COUNT,
				-- HID Descriptor
				HID_BLENGTH_INDEX => GREATER_EQUALS_HID_BLENGTH_INDEX,
				HID_BLENGTH_COUNT => GREATER_EQUALS_HID_BLENGTH_COUNT,
				HID_BCDHID_INDEX => GREATER_EQUALS_HID_BCDHID_INDEX,
				HID_BCDHID_COUNT => GREATER_EQUALS_HID_BCDHID_COUNT,
				HID_BCOUNTRYCODE_INDEX => GREATER_EQUALS_HID_BCOUNTRYCODE_INDEX,
				HID_BCOUNTRYCODE_COUNT => GREATER_EQUALS_HID_BCOUNTRYCODE_COUNT,
				HID_BNUMDESCRIPTORS_INDEX => GREATER_EQUALS_HID_BNUMDESCRIPTORS_INDEX,
				HID_BNUMDESCRIPTORS_COUNT => GREATER_EQUALS_HID_BNUMDESCRIPTORS_COUNT,
				HID_BDESCRIPTORTYPE_INDEX => GREATER_EQUALS_HID_BDESCRIPTORTYPE_INDEX,
				HID_BDESCRIPTORTYPE_COUNT => GREATER_EQUALS_HID_BDESCRIPTORTYPE_COUNT,
				HID_WDESCRIPTORLENGTH_INDEX => GREATER_EQUALS_HID_WDESCRIPTORLENGTH_INDEX,
				HID_WDESCRIPTORLENGTH_COUNT => GREATER_EQUALS_HID_WDESCRIPTORLENGTH_COUNT,
				-- Endpoint Descriptor
				ENDPOINT_BLENGTH_INDEX => GREATER_EQUALS_ENDPOINT_BLENGTH_INDEX,
				ENDPOINT_BLENGTH_COUNT => GREATER_EQUALS_ENDPOINT_BLENGTH_COUNT,
				ENDPOINT_BENDPOINTADDRESS_INDEX => GREATER_EQUALS_ENDPOINT_BENDPOINTADDRESS_INDEX,
				ENDPOINT_BENDPOINTADDRESS_COUNT => GREATER_EQUALS_ENDPOINT_BENDPOINTADDRESS_COUNT,
				ENDPOINT_BMATTRIBUTES_INDEX => GREATER_EQUALS_ENDPOINT_BMATTRIBUTES_INDEX,
				ENDPOINT_BMATTRIBUTES_COUNT => GREATER_EQUALS_ENDPOINT_BMATTRIBUTES_COUNT,
				ENDPOINT_WMAXPACKETSIZE_INDEX => GREATER_EQUALS_ENDPOINT_WMAXPACKETSIZE_INDEX,
				ENDPOINT_WMAXPACKETSIZE_COUNT => GREATER_EQUALS_ENDPOINT_WMAXPACKETSIZE_COUNT,
				ENDPOINT_BINTERVAL_INDEX => GREATER_EQUALS_ENDPOINT_BINTERVAL_INDEX,
				ENDPOINT_BINTERVAL_COUNT => GREATER_EQUALS_ENDPOINT_BINTERVAL_COUNT,
				-- Device Qualifier Descriptor
				DEVICE_QUALIFIER_BLENGTH_INDEX => GREATER_EQUALS_DEVICE_QUALIFIER_BLENGTH_INDEX,
				DEVICE_QUALIFIER_BLENGTH_COUNT => GREATER_EQUALS_DEVICE_QUALIFIER_BLENGTH_COUNT,
				DEVICE_QUALIFIER_BCDUSB_INDEX => GREATER_EQUALS_DEVICE_QUALIFIER_BCDUSB_INDEX,
				DEVICE_QUALIFIER_BCDUSB_COUNT => GREATER_EQUALS_DEVICE_QUALIFIER_BCDUSB_COUNT,
				DEVICE_QUALIFIER_BDEVICECLASS_INDEX => GREATER_EQUALS_DEVICE_QUALIFIER_BDEVICECLASS_INDEX,
				DEVICE_QUALIFIER_BDEVICECLASS_COUNT => GREATER_EQUALS_DEVICE_QUALIFIER_BDEVICECLASS_COUNT,
				DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX => GREATER_EQUALS_DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX,
				DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT => GREATER_EQUALS_DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT,
				DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX => GREATER_EQUALS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX,
				DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT => GREATER_EQUALS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT,
				DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX => GREATER_EQUALS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX,
				DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT => GREATER_EQUALS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT,
				DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX => GREATER_EQUALS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX,
				DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT => GREATER_EQUALS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT,
				DEVICE_QUALIFIER_BRESERVED_INDEX => GREATER_EQUALS_DEVICE_QUALIFIER_BRESERVED_INDEX,
				DEVICE_QUALIFIER_BRESERVED_COUNT => GREATER_EQUALS_DEVICE_QUALIFIER_BRESERVED_COUNT,
				-- Other Speed Descriptor
				OTHER_SPEED_BLENGTH_INDEX => GREATER_EQUALS_OTHER_SPEED_BLENGTH_INDEX,
				OTHER_SPEED_BLENGTH_COUNT => GREATER_EQUALS_OTHER_SPEED_BLENGTH_COUNT,
				OTHER_SPEED_WTOTALLENGTH_INDEX => GREATER_EQUALS_OTHER_SPEED_WTOTALLENGTH_INDEX,
				OTHER_SPEED_WTOTALLENGTH_COUNT => GREATER_EQUALS_OTHER_SPEED_WTOTALLENGTH_COUNT,
				OTHER_SPEED_BNUMINTERFACES_INDEX => GREATER_EQUALS_OTHER_SPEED_BNUMINTERFACES_INDEX,
				OTHER_SPEED_BNUMINTERFACES_COUNT => GREATER_EQUALS_OTHER_SPEED_BNUMINTERFACES_COUNT,
				OTHER_SPEED_BCONFIGURATIONVALUE_INDEX => GREATER_EQUALS_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX,
				OTHER_SPEED_BCONFIGURATIONVALUE_COUNT => GREATER_EQUALS_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT,
				OTHER_SPEED_ICONFIGURATION_BLENGTH_INDEX => GREATER_EQUALS_OTHER_SPEED_ICONFIGURATION_BLENGTH_INDEX,
				OTHER_SPEED_ICONFIGURATION_BLENGTH_COUNT => GREATER_EQUALS_OTHER_SPEED_ICONFIGURATION_BLENGTH_COUNT,
				OTHER_SPEED_ICONFIGURATION_INDEX => GREATER_EQUALS_OTHER_SPEED_ICONFIGURATION_INDEX,
				OTHER_SPEED_ICONFIGURATION_COUNT => GREATER_EQUALS_OTHER_SPEED_ICONFIGURATION_COUNT,
				OTHER_SPEED_BMATTRIBUTES_INDEX => GREATER_EQUALS_OTHER_SPEED_BMATTRIBUTES_INDEX,
				OTHER_SPEED_BMATTRIBUTES_COUNT => GREATER_EQUALS_OTHER_SPEED_BMATTRIBUTES_COUNT,
				OTHER_SPEED_BMAXPOWER_INDEX => GREATER_EQUALS_OTHER_SPEED_BMAXPOWER_INDEX,
				OTHER_SPEED_BMAXPOWER_COUNT => GREATER_EQUALS_OTHER_SPEED_BMAXPOWER_COUNT
			)
			PORT MAP (
				i_sys_clock => i_sys_clock,
				i_enable => i_enable,
				i_descriptor_field => i_descriptor_field,
				i_descriptor_field_available => i_descriptor_field_available,
				i_descriptor_value => i_descriptor_value,
				i_descriptor_value_en => i_descriptor_value_en,
				i_descriptor_value_total_part_number => i_descriptor_value_total_part_number,
				i_descriptor_value_part_number => i_descriptor_value_part_number,
				i_descriptor_value_new_part => i_descriptor_value_new_part,
				o_descriptor_value_next_part_request => operators_next_part_request(GREATER_EQUALS_OPERATOR_INDEX),
				o_ready => operators_ready(GREATER_EQUALS_OPERATOR_INDEX),
				o_result => operators_result(GREATER_EQUALS_OPERATOR_INDEX)
		);
	end generate;

	-------------------
	-- Less Operator --
	-------------------
	lessOperator_en: if (LESS_OPERATOR_ENABLE = '1') generate
		lessOperator_inst: LessOperator
			GENERIC MAP (
				-- Memory Configurations (Address Length, Address Max Index, Address Count Max)
				MEMORY_ADDR_LENGTH => LESS_MEMORY_ADDR_LENGTH,
				MEMORY_ADDR_MAX_INDEX => LESS_MEMORY_ADDR_MAX_INDEX,
				MEMORY_ADDR_MAX_COUNT => LESS_MEMORY_ADDR_MAX_COUNT,
				-- Device Descriptor
				DEVICE_BLENGTH_INDEX => LESS_DEVICE_BLENGTH_INDEX,
				DEVICE_BLENGTH_COUNT => LESS_DEVICE_BLENGTH_COUNT,
				DEVICE_BCDUSB_INDEX => LESS_DEVICE_BCDUSB_INDEX,
				DEVICE_BCDUSB_COUNT => LESS_DEVICE_BCDUSB_COUNT,
				DEVICE_BDEVICECLASS_INDEX => LESS_DEVICE_BDEVICECLASS_INDEX,
				DEVICE_BDEVICECLASS_COUNT => LESS_DEVICE_BDEVICECLASS_COUNT,
				DEVICE_BDEVICESUBCLASS_INDEX => LESS_DEVICE_BDEVICESUBCLASS_INDEX,
				DEVICE_BDEVICESUBCLASS_COUNT => LESS_DEVICE_BDEVICESUBCLASS_COUNT,
				DEVICE_BDEVICEPROTOCOL_INDEX => LESS_DEVICE_BDEVICEPROTOCOL_INDEX,
				DEVICE_BDEVICEPROTOCOL_COUNT => LESS_DEVICE_BDEVICEPROTOCOL_COUNT,
				DEVICE_BMAXPACKETSIZE0_INDEX => LESS_DEVICE_BMAXPACKETSIZE0_INDEX,
				DEVICE_BMAXPACKETSIZE0_COUNT => LESS_DEVICE_BMAXPACKETSIZE0_COUNT,
				DEVICE_IDVENDOR_INDEX => LESS_DEVICE_IDVENDOR_INDEX,
				DEVICE_IDVENDOR_COUNT => LESS_DEVICE_IDVENDOR_COUNT,
				DEVICE_IDPRODUCT_INDEX => LESS_DEVICE_IDPRODUCT_INDEX,
				DEVICE_IDPRODUCT_COUNT => LESS_DEVICE_IDPRODUCT_COUNT,
				DEVICE_BCDDEVICE_INDEX => LESS_DEVICE_BCDDEVICE_INDEX,
				DEVICE_BCDDEVICE_COUNT => LESS_DEVICE_BCDDEVICE_COUNT,
				DEVICE_IMANUFACTURER_BLENGTH_INDEX => LESS_DEVICE_IMANUFACTURER_BLENGTH_INDEX,
				DEVICE_IMANUFACTURER_BLENGTH_COUNT => LESS_DEVICE_IMANUFACTURER_BLENGTH_COUNT,
				DEVICE_IMANUFACTURER_INDEX => LESS_DEVICE_IMANUFACTURER_INDEX,
				DEVICE_IMANUFACTURER_COUNT => LESS_DEVICE_IMANUFACTURER_COUNT,
				DEVICE_IPRODUCT_BLENGTH_INDEX => LESS_DEVICE_IPRODUCT_BLENGTH_INDEX,
				DEVICE_IPRODUCT_BLENGTH_COUNT => LESS_DEVICE_IPRODUCT_BLENGTH_COUNT,
				DEVICE_IPRODUCT_INDEX => LESS_DEVICE_IPRODUCT_INDEX,
				DEVICE_IPRODUCT_COUNT => LESS_DEVICE_IPRODUCT_COUNT,
				DEVICE_ISERIALNUMBER_BLENGTH_INDEX => LESS_DEVICE_ISERIALNUMBER_BLENGTH_INDEX,
				DEVICE_ISERIALNUMBER_BLENGTH_COUNT => LESS_DEVICE_ISERIALNUMBER_BLENGTH_COUNT,
				DEVICE_ISERIALNUMBER_INDEX => LESS_DEVICE_ISERIALNUMBER_INDEX,
				DEVICE_ISERIALNUMBER_COUNT => LESS_DEVICE_ISERIALNUMBER_COUNT,
				DEVICE_BNUMCONFIGURATIONS_INDEX => LESS_DEVICE_BNUMCONFIGURATIONS_INDEX,
				DEVICE_BNUMCONFIGURATIONS_COUNT => LESS_DEVICE_BNUMCONFIGURATIONS_COUNT,
				-- Configuration Descriptor
				CONFIGURATION_BLENGTH_INDEX => LESS_CONFIGURATION_BLENGTH_INDEX,
				CONFIGURATION_BLENGTH_COUNT => LESS_CONFIGURATION_BLENGTH_COUNT,
				CONFIGURATION_WTOTALLENGTH_INDEX => LESS_CONFIGURATION_WTOTALLENGTH_INDEX,
				CONFIGURATION_WTOTALLENGTH_COUNT => LESS_CONFIGURATION_WTOTALLENGTH_COUNT,
				CONFIGURATION_BNUMINTERFACES_INDEX => LESS_CONFIGURATION_BNUMINTERFACES_INDEX,
				CONFIGURATION_BNUMINTERFACES_COUNT => LESS_CONFIGURATION_BNUMINTERFACES_COUNT,
				CONFIGURATION_BCONFIGURATIONVALUE_INDEX => LESS_CONFIGURATION_BCONFIGURATIONVALUE_INDEX,
				CONFIGURATION_BCONFIGURATIONVALUE_COUNT => LESS_CONFIGURATION_BCONFIGURATIONVALUE_COUNT,
				CONFIGURATION_ICONFIGURATION_BLENGTH_INDEX => LESS_CONFIGURATION_ICONFIGURATION_BLENGTH_INDEX,
				CONFIGURATION_ICONFIGURATION_BLENGTH_COUNT => LESS_CONFIGURATION_ICONFIGURATION_BLENGTH_COUNT,
				CONFIGURATION_ICONFIGURATION_INDEX => LESS_CONFIGURATION_ICONFIGURATION_INDEX,
				CONFIGURATION_ICONFIGURATION_COUNT => LESS_CONFIGURATION_ICONFIGURATION_COUNT,
				CONFIGURATION_BMATTRIBUTES_INDEX => LESS_CONFIGURATION_BMATTRIBUTES_INDEX,
				CONFIGURATION_BMATTRIBUTES_COUNT => LESS_CONFIGURATION_BMATTRIBUTES_COUNT,
				CONFIGURATION_BMAXPOWER_INDEX => LESS_CONFIGURATION_BMAXPOWER_INDEX,
				CONFIGURATION_BMAXPOWER_COUNT => LESS_CONFIGURATION_BMAXPOWER_COUNT,
				-- Interface Descriptor
				INTERFACE_BLENGTH_INDEX => LESS_INTERFACE_BLENGTH_INDEX,
				INTERFACE_BLENGTH_COUNT => LESS_INTERFACE_BLENGTH_COUNT,
				INTERFACE_BINTERFACENUMBER_INDEX => LESS_INTERFACE_BINTERFACENUMBER_INDEX,
				INTERFACE_BINTERFACENUMBER_COUNT => LESS_INTERFACE_BINTERFACENUMBER_COUNT,
				INTERFACE_BALTERNATESETTING_INDEX => LESS_INTERFACE_BALTERNATESETTING_INDEX,
				INTERFACE_BALTERNATESETTING_COUNT => LESS_INTERFACE_BALTERNATESETTING_COUNT,
				INTERFACE_BNUMENDPOINTS_INDEX => LESS_INTERFACE_BNUMENDPOINTS_INDEX,
				INTERFACE_BNUMENDPOINTS_COUNT => LESS_INTERFACE_BNUMENDPOINTS_COUNT,
				INTERFACE_BINTERFACECLASS_INDEX => LESS_INTERFACE_BINTERFACECLASS_INDEX,
				INTERFACE_BINTERFACECLASS_COUNT => LESS_INTERFACE_BINTERFACECLASS_COUNT,
				INTERFACE_BINTERFACESUBCLASS_INDEX => LESS_INTERFACE_BINTERFACESUBCLASS_INDEX,
				INTERFACE_BINTERFACESUBCLASS_COUNT => LESS_INTERFACE_BINTERFACESUBCLASS_COUNT,
				INTERFACE_BINTERFACEPROTOCOL_INDEX => LESS_INTERFACE_BINTERFACEPROTOCOL_INDEX,
				INTERFACE_BINTERFACEPROTOCOL_COUNT => LESS_INTERFACE_BINTERFACEPROTOCOL_COUNT,
				INTERFACE_IINTERFACE_BLENGTH_INDEX => LESS_INTERFACE_IINTERFACE_BLENGTH_INDEX,
				INTERFACE_IINTERFACE_BLENGTH_COUNT => LESS_INTERFACE_IINTERFACE_BLENGTH_COUNT,
				INTERFACE_IINTERFACE_INDEX => LESS_INTERFACE_IINTERFACE_INDEX,
				INTERFACE_IINTERFACE_COUNT => LESS_INTERFACE_IINTERFACE_COUNT,
				-- HID Descriptor
				HID_BLENGTH_INDEX => LESS_HID_BLENGTH_INDEX,
				HID_BLENGTH_COUNT => LESS_HID_BLENGTH_COUNT,
				HID_BCDHID_INDEX => LESS_HID_BCDHID_INDEX,
				HID_BCDHID_COUNT => LESS_HID_BCDHID_COUNT,
				HID_BCOUNTRYCODE_INDEX => LESS_HID_BCOUNTRYCODE_INDEX,
				HID_BCOUNTRYCODE_COUNT => LESS_HID_BCOUNTRYCODE_COUNT,
				HID_BNUMDESCRIPTORS_INDEX => LESS_HID_BNUMDESCRIPTORS_INDEX,
				HID_BNUMDESCRIPTORS_COUNT => LESS_HID_BNUMDESCRIPTORS_COUNT,
				HID_BDESCRIPTORTYPE_INDEX => LESS_HID_BDESCRIPTORTYPE_INDEX,
				HID_BDESCRIPTORTYPE_COUNT => LESS_HID_BDESCRIPTORTYPE_COUNT,
				HID_WDESCRIPTORLENGTH_INDEX => LESS_HID_WDESCRIPTORLENGTH_INDEX,
				HID_WDESCRIPTORLENGTH_COUNT => LESS_HID_WDESCRIPTORLENGTH_COUNT,
				-- Endpoint Descriptor
				ENDPOINT_BLENGTH_INDEX => LESS_ENDPOINT_BLENGTH_INDEX,
				ENDPOINT_BLENGTH_COUNT => LESS_ENDPOINT_BLENGTH_COUNT,
				ENDPOINT_BENDPOINTADDRESS_INDEX => LESS_ENDPOINT_BENDPOINTADDRESS_INDEX,
				ENDPOINT_BENDPOINTADDRESS_COUNT => LESS_ENDPOINT_BENDPOINTADDRESS_COUNT,
				ENDPOINT_BMATTRIBUTES_INDEX => LESS_ENDPOINT_BMATTRIBUTES_INDEX,
				ENDPOINT_BMATTRIBUTES_COUNT => LESS_ENDPOINT_BMATTRIBUTES_COUNT,
				ENDPOINT_WMAXPACKETSIZE_INDEX => LESS_ENDPOINT_WMAXPACKETSIZE_INDEX,
				ENDPOINT_WMAXPACKETSIZE_COUNT => LESS_ENDPOINT_WMAXPACKETSIZE_COUNT,
				ENDPOINT_BINTERVAL_INDEX => LESS_ENDPOINT_BINTERVAL_INDEX,
				ENDPOINT_BINTERVAL_COUNT => LESS_ENDPOINT_BINTERVAL_COUNT,
				-- Device Qualifier Descriptor
				DEVICE_QUALIFIER_BLENGTH_INDEX => LESS_DEVICE_QUALIFIER_BLENGTH_INDEX,
				DEVICE_QUALIFIER_BLENGTH_COUNT => LESS_DEVICE_QUALIFIER_BLENGTH_COUNT,
				DEVICE_QUALIFIER_BCDUSB_INDEX => LESS_DEVICE_QUALIFIER_BCDUSB_INDEX,
				DEVICE_QUALIFIER_BCDUSB_COUNT => LESS_DEVICE_QUALIFIER_BCDUSB_COUNT,
				DEVICE_QUALIFIER_BDEVICECLASS_INDEX => LESS_DEVICE_QUALIFIER_BDEVICECLASS_INDEX,
				DEVICE_QUALIFIER_BDEVICECLASS_COUNT => LESS_DEVICE_QUALIFIER_BDEVICECLASS_COUNT,
				DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX => LESS_DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX,
				DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT => LESS_DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT,
				DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX => LESS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX,
				DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT => LESS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT,
				DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX => LESS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX,
				DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT => LESS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT,
				DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX => LESS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX,
				DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT => LESS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT,
				DEVICE_QUALIFIER_BRESERVED_INDEX => LESS_DEVICE_QUALIFIER_BRESERVED_INDEX,
				DEVICE_QUALIFIER_BRESERVED_COUNT => LESS_DEVICE_QUALIFIER_BRESERVED_COUNT,
				-- Other Speed Descriptor
				OTHER_SPEED_BLENGTH_INDEX => LESS_OTHER_SPEED_BLENGTH_INDEX,
				OTHER_SPEED_BLENGTH_COUNT => LESS_OTHER_SPEED_BLENGTH_COUNT,
				OTHER_SPEED_WTOTALLENGTH_INDEX => LESS_OTHER_SPEED_WTOTALLENGTH_INDEX,
				OTHER_SPEED_WTOTALLENGTH_COUNT => LESS_OTHER_SPEED_WTOTALLENGTH_COUNT,
				OTHER_SPEED_BNUMINTERFACES_INDEX => LESS_OTHER_SPEED_BNUMINTERFACES_INDEX,
				OTHER_SPEED_BNUMINTERFACES_COUNT => LESS_OTHER_SPEED_BNUMINTERFACES_COUNT,
				OTHER_SPEED_BCONFIGURATIONVALUE_INDEX => LESS_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX,
				OTHER_SPEED_BCONFIGURATIONVALUE_COUNT => LESS_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT,
				OTHER_SPEED_ICONFIGURATION_BLENGTH_INDEX => LESS_OTHER_SPEED_ICONFIGURATION_BLENGTH_INDEX,
				OTHER_SPEED_ICONFIGURATION_BLENGTH_COUNT => LESS_OTHER_SPEED_ICONFIGURATION_BLENGTH_COUNT,
				OTHER_SPEED_ICONFIGURATION_INDEX => LESS_OTHER_SPEED_ICONFIGURATION_INDEX,
				OTHER_SPEED_ICONFIGURATION_COUNT => LESS_OTHER_SPEED_ICONFIGURATION_COUNT,
				OTHER_SPEED_BMATTRIBUTES_INDEX => LESS_OTHER_SPEED_BMATTRIBUTES_INDEX,
				OTHER_SPEED_BMATTRIBUTES_COUNT => LESS_OTHER_SPEED_BMATTRIBUTES_COUNT,
				OTHER_SPEED_BMAXPOWER_INDEX => LESS_OTHER_SPEED_BMAXPOWER_INDEX,
				OTHER_SPEED_BMAXPOWER_COUNT => LESS_OTHER_SPEED_BMAXPOWER_COUNT
			)
			PORT MAP (
				i_sys_clock => i_sys_clock,
				i_enable => i_enable,
				i_descriptor_field => i_descriptor_field,
				i_descriptor_field_available => i_descriptor_field_available,
				i_descriptor_value => i_descriptor_value,
				i_descriptor_value_en => i_descriptor_value_en,
				i_descriptor_value_total_part_number => i_descriptor_value_total_part_number,
				i_descriptor_value_part_number => i_descriptor_value_part_number,
				i_descriptor_value_new_part => i_descriptor_value_new_part,
				o_descriptor_value_next_part_request => operators_next_part_request(LESS_OPERATOR_INDEX),
				o_ready => operators_ready(LESS_OPERATOR_INDEX),
				o_result => operators_result(LESS_OPERATOR_INDEX)
		);
	end generate;

	-------------------------
	-- LessEquals Operator --
	-------------------------
	lessEqualsOperator_en: if (LESS_EQUALS_OPERATOR_ENABLE = '1') generate
		lessEqualsOperator_inst: LessEqualsOperator
			GENERIC MAP (
				-- Memory Configurations (Address Length, Address Max Index, Address Count Max)
				MEMORY_ADDR_LENGTH => LESS_EQUALS_MEMORY_ADDR_LENGTH,
				MEMORY_ADDR_MAX_INDEX => LESS_EQUALS_MEMORY_ADDR_MAX_INDEX,
				MEMORY_ADDR_MAX_COUNT => LESS_EQUALS_MEMORY_ADDR_MAX_COUNT,
				-- Device Descriptor
				DEVICE_BLENGTH_INDEX => LESS_EQUALS_DEVICE_BLENGTH_INDEX,
				DEVICE_BLENGTH_COUNT => LESS_EQUALS_DEVICE_BLENGTH_COUNT,
				DEVICE_BCDUSB_INDEX => LESS_EQUALS_DEVICE_BCDUSB_INDEX,
				DEVICE_BCDUSB_COUNT => LESS_EQUALS_DEVICE_BCDUSB_COUNT,
				DEVICE_BDEVICECLASS_INDEX => LESS_EQUALS_DEVICE_BDEVICECLASS_INDEX,
				DEVICE_BDEVICECLASS_COUNT => LESS_EQUALS_DEVICE_BDEVICECLASS_COUNT,
				DEVICE_BDEVICESUBCLASS_INDEX => LESS_EQUALS_DEVICE_BDEVICESUBCLASS_INDEX,
				DEVICE_BDEVICESUBCLASS_COUNT => LESS_EQUALS_DEVICE_BDEVICESUBCLASS_COUNT,
				DEVICE_BDEVICEPROTOCOL_INDEX => LESS_EQUALS_DEVICE_BDEVICEPROTOCOL_INDEX,
				DEVICE_BDEVICEPROTOCOL_COUNT => LESS_EQUALS_DEVICE_BDEVICEPROTOCOL_COUNT,
				DEVICE_BMAXPACKETSIZE0_INDEX => LESS_EQUALS_DEVICE_BMAXPACKETSIZE0_INDEX,
				DEVICE_BMAXPACKETSIZE0_COUNT => LESS_EQUALS_DEVICE_BMAXPACKETSIZE0_COUNT,
				DEVICE_IDVENDOR_INDEX => LESS_EQUALS_DEVICE_IDVENDOR_INDEX,
				DEVICE_IDVENDOR_COUNT => LESS_EQUALS_DEVICE_IDVENDOR_COUNT,
				DEVICE_IDPRODUCT_INDEX => LESS_EQUALS_DEVICE_IDPRODUCT_INDEX,
				DEVICE_IDPRODUCT_COUNT => LESS_EQUALS_DEVICE_IDPRODUCT_COUNT,
				DEVICE_BCDDEVICE_INDEX => LESS_EQUALS_DEVICE_BCDDEVICE_INDEX,
				DEVICE_BCDDEVICE_COUNT => LESS_EQUALS_DEVICE_BCDDEVICE_COUNT,
				DEVICE_IMANUFACTURER_BLENGTH_INDEX => LESS_EQUALS_DEVICE_IMANUFACTURER_BLENGTH_INDEX,
				DEVICE_IMANUFACTURER_BLENGTH_COUNT => LESS_EQUALS_DEVICE_IMANUFACTURER_BLENGTH_COUNT,
				DEVICE_IMANUFACTURER_INDEX => LESS_EQUALS_DEVICE_IMANUFACTURER_INDEX,
				DEVICE_IMANUFACTURER_COUNT => LESS_EQUALS_DEVICE_IMANUFACTURER_COUNT,
				DEVICE_IPRODUCT_BLENGTH_INDEX => LESS_EQUALS_DEVICE_IPRODUCT_BLENGTH_INDEX,
				DEVICE_IPRODUCT_BLENGTH_COUNT => LESS_EQUALS_DEVICE_IPRODUCT_BLENGTH_COUNT,
				DEVICE_IPRODUCT_INDEX => LESS_EQUALS_DEVICE_IPRODUCT_INDEX,
				DEVICE_IPRODUCT_COUNT => LESS_EQUALS_DEVICE_IPRODUCT_COUNT,
				DEVICE_ISERIALNUMBER_BLENGTH_INDEX => LESS_EQUALS_DEVICE_ISERIALNUMBER_BLENGTH_INDEX,
				DEVICE_ISERIALNUMBER_BLENGTH_COUNT => LESS_EQUALS_DEVICE_ISERIALNUMBER_BLENGTH_COUNT,
				DEVICE_ISERIALNUMBER_INDEX => LESS_EQUALS_DEVICE_ISERIALNUMBER_INDEX,
				DEVICE_ISERIALNUMBER_COUNT => LESS_EQUALS_DEVICE_ISERIALNUMBER_COUNT,
				DEVICE_BNUMCONFIGURATIONS_INDEX => LESS_EQUALS_DEVICE_BNUMCONFIGURATIONS_INDEX,
				DEVICE_BNUMCONFIGURATIONS_COUNT => LESS_EQUALS_DEVICE_BNUMCONFIGURATIONS_COUNT,
				-- Configuration Descriptor
				CONFIGURATION_BLENGTH_INDEX => LESS_EQUALS_CONFIGURATION_BLENGTH_INDEX,
				CONFIGURATION_BLENGTH_COUNT => LESS_EQUALS_CONFIGURATION_BLENGTH_COUNT,
				CONFIGURATION_WTOTALLENGTH_INDEX => LESS_EQUALS_CONFIGURATION_WTOTALLENGTH_INDEX,
				CONFIGURATION_WTOTALLENGTH_COUNT => LESS_EQUALS_CONFIGURATION_WTOTALLENGTH_COUNT,
				CONFIGURATION_BNUMINTERFACES_INDEX => LESS_EQUALS_CONFIGURATION_BNUMINTERFACES_INDEX,
				CONFIGURATION_BNUMINTERFACES_COUNT => LESS_EQUALS_CONFIGURATION_BNUMINTERFACES_COUNT,
				CONFIGURATION_BCONFIGURATIONVALUE_INDEX => LESS_EQUALS_CONFIGURATION_BCONFIGURATIONVALUE_INDEX,
				CONFIGURATION_BCONFIGURATIONVALUE_COUNT => LESS_EQUALS_CONFIGURATION_BCONFIGURATIONVALUE_COUNT,
				CONFIGURATION_ICONFIGURATION_BLENGTH_INDEX => LESS_EQUALS_CONFIGURATION_ICONFIGURATION_BLENGTH_INDEX,
				CONFIGURATION_ICONFIGURATION_BLENGTH_COUNT => LESS_EQUALS_CONFIGURATION_ICONFIGURATION_BLENGTH_COUNT,
				CONFIGURATION_ICONFIGURATION_INDEX => LESS_EQUALS_CONFIGURATION_ICONFIGURATION_INDEX,
				CONFIGURATION_ICONFIGURATION_COUNT => LESS_EQUALS_CONFIGURATION_ICONFIGURATION_COUNT,
				CONFIGURATION_BMATTRIBUTES_INDEX => LESS_EQUALS_CONFIGURATION_BMATTRIBUTES_INDEX,
				CONFIGURATION_BMATTRIBUTES_COUNT => LESS_EQUALS_CONFIGURATION_BMATTRIBUTES_COUNT,
				CONFIGURATION_BMAXPOWER_INDEX => LESS_EQUALS_CONFIGURATION_BMAXPOWER_INDEX,
				CONFIGURATION_BMAXPOWER_COUNT => LESS_EQUALS_CONFIGURATION_BMAXPOWER_COUNT,
				-- Interface Descriptor
				INTERFACE_BLENGTH_INDEX => LESS_EQUALS_INTERFACE_BLENGTH_INDEX,
				INTERFACE_BLENGTH_COUNT => LESS_EQUALS_INTERFACE_BLENGTH_COUNT,
				INTERFACE_BINTERFACENUMBER_INDEX => LESS_EQUALS_INTERFACE_BINTERFACENUMBER_INDEX,
				INTERFACE_BINTERFACENUMBER_COUNT => LESS_EQUALS_INTERFACE_BINTERFACENUMBER_COUNT,
				INTERFACE_BALTERNATESETTING_INDEX => LESS_EQUALS_INTERFACE_BALTERNATESETTING_INDEX,
				INTERFACE_BALTERNATESETTING_COUNT => LESS_EQUALS_INTERFACE_BALTERNATESETTING_COUNT,
				INTERFACE_BNUMENDPOINTS_INDEX => LESS_EQUALS_INTERFACE_BNUMENDPOINTS_INDEX,
				INTERFACE_BNUMENDPOINTS_COUNT => LESS_EQUALS_INTERFACE_BNUMENDPOINTS_COUNT,
				INTERFACE_BINTERFACECLASS_INDEX => LESS_EQUALS_INTERFACE_BINTERFACECLASS_INDEX,
				INTERFACE_BINTERFACECLASS_COUNT => LESS_EQUALS_INTERFACE_BINTERFACECLASS_COUNT,
				INTERFACE_BINTERFACESUBCLASS_INDEX => LESS_EQUALS_INTERFACE_BINTERFACESUBCLASS_INDEX,
				INTERFACE_BINTERFACESUBCLASS_COUNT => LESS_EQUALS_INTERFACE_BINTERFACESUBCLASS_COUNT,
				INTERFACE_BINTERFACEPROTOCOL_INDEX => LESS_EQUALS_INTERFACE_BINTERFACEPROTOCOL_INDEX,
				INTERFACE_BINTERFACEPROTOCOL_COUNT => LESS_EQUALS_INTERFACE_BINTERFACEPROTOCOL_COUNT,
				INTERFACE_IINTERFACE_BLENGTH_INDEX => LESS_EQUALS_INTERFACE_IINTERFACE_BLENGTH_INDEX,
				INTERFACE_IINTERFACE_BLENGTH_COUNT => LESS_EQUALS_INTERFACE_IINTERFACE_BLENGTH_COUNT,
				INTERFACE_IINTERFACE_INDEX => LESS_EQUALS_INTERFACE_IINTERFACE_INDEX,
				INTERFACE_IINTERFACE_COUNT => LESS_EQUALS_INTERFACE_IINTERFACE_COUNT,
				-- HID Descriptor
				HID_BLENGTH_INDEX => LESS_EQUALS_HID_BLENGTH_INDEX,
				HID_BLENGTH_COUNT => LESS_EQUALS_HID_BLENGTH_COUNT,
				HID_BCDHID_INDEX => LESS_EQUALS_HID_BCDHID_INDEX,
				HID_BCDHID_COUNT => LESS_EQUALS_HID_BCDHID_COUNT,
				HID_BCOUNTRYCODE_INDEX => LESS_EQUALS_HID_BCOUNTRYCODE_INDEX,
				HID_BCOUNTRYCODE_COUNT => LESS_EQUALS_HID_BCOUNTRYCODE_COUNT,
				HID_BNUMDESCRIPTORS_INDEX => LESS_EQUALS_HID_BNUMDESCRIPTORS_INDEX,
				HID_BNUMDESCRIPTORS_COUNT => LESS_EQUALS_HID_BNUMDESCRIPTORS_COUNT,
				HID_BDESCRIPTORTYPE_INDEX => LESS_EQUALS_HID_BDESCRIPTORTYPE_INDEX,
				HID_BDESCRIPTORTYPE_COUNT => LESS_EQUALS_HID_BDESCRIPTORTYPE_COUNT,
				HID_WDESCRIPTORLENGTH_INDEX => LESS_EQUALS_HID_WDESCRIPTORLENGTH_INDEX,
				HID_WDESCRIPTORLENGTH_COUNT => LESS_EQUALS_HID_WDESCRIPTORLENGTH_COUNT,
				-- Endpoint Descriptor
				ENDPOINT_BLENGTH_INDEX => LESS_EQUALS_ENDPOINT_BLENGTH_INDEX,
				ENDPOINT_BLENGTH_COUNT => LESS_EQUALS_ENDPOINT_BLENGTH_COUNT,
				ENDPOINT_BENDPOINTADDRESS_INDEX => LESS_EQUALS_ENDPOINT_BENDPOINTADDRESS_INDEX,
				ENDPOINT_BENDPOINTADDRESS_COUNT => LESS_EQUALS_ENDPOINT_BENDPOINTADDRESS_COUNT,
				ENDPOINT_BMATTRIBUTES_INDEX => LESS_EQUALS_ENDPOINT_BMATTRIBUTES_INDEX,
				ENDPOINT_BMATTRIBUTES_COUNT => LESS_EQUALS_ENDPOINT_BMATTRIBUTES_COUNT,
				ENDPOINT_WMAXPACKETSIZE_INDEX => LESS_EQUALS_ENDPOINT_WMAXPACKETSIZE_INDEX,
				ENDPOINT_WMAXPACKETSIZE_COUNT => LESS_EQUALS_ENDPOINT_WMAXPACKETSIZE_COUNT,
				ENDPOINT_BINTERVAL_INDEX => LESS_EQUALS_ENDPOINT_BINTERVAL_INDEX,
				ENDPOINT_BINTERVAL_COUNT => LESS_EQUALS_ENDPOINT_BINTERVAL_COUNT,
				-- Device Qualifier Descriptor
				DEVICE_QUALIFIER_BLENGTH_INDEX => LESS_EQUALS_DEVICE_QUALIFIER_BLENGTH_INDEX,
				DEVICE_QUALIFIER_BLENGTH_COUNT => LESS_EQUALS_DEVICE_QUALIFIER_BLENGTH_COUNT,
				DEVICE_QUALIFIER_BCDUSB_INDEX => LESS_EQUALS_DEVICE_QUALIFIER_BCDUSB_INDEX,
				DEVICE_QUALIFIER_BCDUSB_COUNT => LESS_EQUALS_DEVICE_QUALIFIER_BCDUSB_COUNT,
				DEVICE_QUALIFIER_BDEVICECLASS_INDEX => LESS_EQUALS_DEVICE_QUALIFIER_BDEVICECLASS_INDEX,
				DEVICE_QUALIFIER_BDEVICECLASS_COUNT => LESS_EQUALS_DEVICE_QUALIFIER_BDEVICECLASS_COUNT,
				DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX => LESS_EQUALS_DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX,
				DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT => LESS_EQUALS_DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT,
				DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX => LESS_EQUALS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX,
				DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT => LESS_EQUALS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT,
				DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX => LESS_EQUALS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX,
				DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT => LESS_EQUALS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT,
				DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX => LESS_EQUALS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX,
				DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT => LESS_EQUALS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT,
				DEVICE_QUALIFIER_BRESERVED_INDEX => LESS_EQUALS_DEVICE_QUALIFIER_BRESERVED_INDEX,
				DEVICE_QUALIFIER_BRESERVED_COUNT => LESS_EQUALS_DEVICE_QUALIFIER_BRESERVED_COUNT,
				-- Other Speed Descriptor
				OTHER_SPEED_BLENGTH_INDEX => LESS_EQUALS_OTHER_SPEED_BLENGTH_INDEX,
				OTHER_SPEED_BLENGTH_COUNT => LESS_EQUALS_OTHER_SPEED_BLENGTH_COUNT,
				OTHER_SPEED_WTOTALLENGTH_INDEX => LESS_EQUALS_OTHER_SPEED_WTOTALLENGTH_INDEX,
				OTHER_SPEED_WTOTALLENGTH_COUNT => LESS_EQUALS_OTHER_SPEED_WTOTALLENGTH_COUNT,
				OTHER_SPEED_BNUMINTERFACES_INDEX => LESS_EQUALS_OTHER_SPEED_BNUMINTERFACES_INDEX,
				OTHER_SPEED_BNUMINTERFACES_COUNT => LESS_EQUALS_OTHER_SPEED_BNUMINTERFACES_COUNT,
				OTHER_SPEED_BCONFIGURATIONVALUE_INDEX => LESS_EQUALS_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX,
				OTHER_SPEED_BCONFIGURATIONVALUE_COUNT => LESS_EQUALS_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT,
				OTHER_SPEED_ICONFIGURATION_BLENGTH_INDEX => LESS_EQUALS_OTHER_SPEED_ICONFIGURATION_BLENGTH_INDEX,
				OTHER_SPEED_ICONFIGURATION_BLENGTH_COUNT => LESS_EQUALS_OTHER_SPEED_ICONFIGURATION_BLENGTH_COUNT,
				OTHER_SPEED_ICONFIGURATION_INDEX => LESS_EQUALS_OTHER_SPEED_ICONFIGURATION_INDEX,
				OTHER_SPEED_ICONFIGURATION_COUNT => LESS_EQUALS_OTHER_SPEED_ICONFIGURATION_COUNT,
				OTHER_SPEED_BMATTRIBUTES_INDEX => LESS_EQUALS_OTHER_SPEED_BMATTRIBUTES_INDEX,
				OTHER_SPEED_BMATTRIBUTES_COUNT => LESS_EQUALS_OTHER_SPEED_BMATTRIBUTES_COUNT,
				OTHER_SPEED_BMAXPOWER_INDEX => LESS_EQUALS_OTHER_SPEED_BMAXPOWER_INDEX,
				OTHER_SPEED_BMAXPOWER_COUNT => LESS_EQUALS_OTHER_SPEED_BMAXPOWER_COUNT
			)
			PORT MAP (
				i_sys_clock => i_sys_clock,
				i_enable => i_enable,
				i_descriptor_field => i_descriptor_field,
				i_descriptor_field_available => i_descriptor_field_available,
				i_descriptor_value => i_descriptor_value,
				i_descriptor_value_en => i_descriptor_value_en,
				i_descriptor_value_total_part_number => i_descriptor_value_total_part_number,
				i_descriptor_value_part_number => i_descriptor_value_part_number,
				i_descriptor_value_new_part => i_descriptor_value_new_part,
				o_descriptor_value_next_part_request => operators_next_part_request(LESS_EQUALS_OPERATOR_INDEX),
				o_ready => operators_ready(LESS_EQUALS_OPERATOR_INDEX),
				o_result => operators_result(LESS_EQUALS_OPERATOR_INDEX)
		);
	end generate;

	-------------------------
	-- StartsWith Operator --
	-------------------------
	startsWithOperator_en: if (STARTS_WITH_OPERATOR_ENABLE = '1') generate
		startsWithOperator_inst: StartsWithOperator
			GENERIC MAP (
				-- Memory Configurations (Address Length, Address Max Index, Address Count Max)
				MEMORY_ADDR_LENGTH => STARTS_WITH_MEMORY_ADDR_LENGTH,
				MEMORY_ADDR_MAX_INDEX => STARTS_WITH_MEMORY_ADDR_MAX_INDEX,
				MEMORY_ADDR_MAX_COUNT => STARTS_WITH_MEMORY_ADDR_MAX_COUNT,
				-- Device Descriptor
				DEVICE_BLENGTH_INDEX => STARTS_WITH_DEVICE_BLENGTH_INDEX,
				DEVICE_BLENGTH_COUNT => STARTS_WITH_DEVICE_BLENGTH_COUNT,
				DEVICE_BCDUSB_INDEX => STARTS_WITH_DEVICE_BCDUSB_INDEX,
				DEVICE_BCDUSB_COUNT => STARTS_WITH_DEVICE_BCDUSB_COUNT,
				DEVICE_BDEVICECLASS_INDEX => STARTS_WITH_DEVICE_BDEVICECLASS_INDEX,
				DEVICE_BDEVICECLASS_COUNT => STARTS_WITH_DEVICE_BDEVICECLASS_COUNT,
				DEVICE_BDEVICESUBCLASS_INDEX => STARTS_WITH_DEVICE_BDEVICESUBCLASS_INDEX,
				DEVICE_BDEVICESUBCLASS_COUNT => STARTS_WITH_DEVICE_BDEVICESUBCLASS_COUNT,
				DEVICE_BDEVICEPROTOCOL_INDEX => STARTS_WITH_DEVICE_BDEVICEPROTOCOL_INDEX,
				DEVICE_BDEVICEPROTOCOL_COUNT => STARTS_WITH_DEVICE_BDEVICEPROTOCOL_COUNT,
				DEVICE_BMAXPACKETSIZE0_INDEX => STARTS_WITH_DEVICE_BMAXPACKETSIZE0_INDEX,
				DEVICE_BMAXPACKETSIZE0_COUNT => STARTS_WITH_DEVICE_BMAXPACKETSIZE0_COUNT,
				DEVICE_IDVENDOR_INDEX => STARTS_WITH_DEVICE_IDVENDOR_INDEX,
				DEVICE_IDVENDOR_COUNT => STARTS_WITH_DEVICE_IDVENDOR_COUNT,
				DEVICE_IDPRODUCT_INDEX => STARTS_WITH_DEVICE_IDPRODUCT_INDEX,
				DEVICE_IDPRODUCT_COUNT => STARTS_WITH_DEVICE_IDPRODUCT_COUNT,
				DEVICE_BCDDEVICE_INDEX => STARTS_WITH_DEVICE_BCDDEVICE_INDEX,
				DEVICE_BCDDEVICE_COUNT => STARTS_WITH_DEVICE_BCDDEVICE_COUNT,
				DEVICE_IMANUFACTURER_BLENGTH_INDEX => STARTS_WITH_DEVICE_IMANUFACTURER_BLENGTH_INDEX,
				DEVICE_IMANUFACTURER_BLENGTH_COUNT => STARTS_WITH_DEVICE_IMANUFACTURER_BLENGTH_COUNT,
				DEVICE_IMANUFACTURER_INDEX => STARTS_WITH_DEVICE_IMANUFACTURER_INDEX,
				DEVICE_IMANUFACTURER_COUNT => STARTS_WITH_DEVICE_IMANUFACTURER_COUNT,
				DEVICE_IPRODUCT_BLENGTH_INDEX => STARTS_WITH_DEVICE_IPRODUCT_BLENGTH_INDEX,
				DEVICE_IPRODUCT_BLENGTH_COUNT => STARTS_WITH_DEVICE_IPRODUCT_BLENGTH_COUNT,
				DEVICE_IPRODUCT_INDEX => STARTS_WITH_DEVICE_IPRODUCT_INDEX,
				DEVICE_IPRODUCT_COUNT => STARTS_WITH_DEVICE_IPRODUCT_COUNT,
				DEVICE_ISERIALNUMBER_BLENGTH_INDEX => STARTS_WITH_DEVICE_ISERIALNUMBER_BLENGTH_INDEX,
				DEVICE_ISERIALNUMBER_BLENGTH_COUNT => STARTS_WITH_DEVICE_ISERIALNUMBER_BLENGTH_COUNT,
				DEVICE_ISERIALNUMBER_INDEX => STARTS_WITH_DEVICE_ISERIALNUMBER_INDEX,
				DEVICE_ISERIALNUMBER_COUNT => STARTS_WITH_DEVICE_ISERIALNUMBER_COUNT,
				DEVICE_BNUMCONFIGURATIONS_INDEX => STARTS_WITH_DEVICE_BNUMCONFIGURATIONS_INDEX,
				DEVICE_BNUMCONFIGURATIONS_COUNT => STARTS_WITH_DEVICE_BNUMCONFIGURATIONS_COUNT,
				-- Configuration Descriptor
				CONFIGURATION_BLENGTH_INDEX => STARTS_WITH_CONFIGURATION_BLENGTH_INDEX,
				CONFIGURATION_BLENGTH_COUNT => STARTS_WITH_CONFIGURATION_BLENGTH_COUNT,
				CONFIGURATION_WTOTALLENGTH_INDEX => STARTS_WITH_CONFIGURATION_WTOTALLENGTH_INDEX,
				CONFIGURATION_WTOTALLENGTH_COUNT => STARTS_WITH_CONFIGURATION_WTOTALLENGTH_COUNT,
				CONFIGURATION_BNUMINTERFACES_INDEX => STARTS_WITH_CONFIGURATION_BNUMINTERFACES_INDEX,
				CONFIGURATION_BNUMINTERFACES_COUNT => STARTS_WITH_CONFIGURATION_BNUMINTERFACES_COUNT,
				CONFIGURATION_BCONFIGURATIONVALUE_INDEX => STARTS_WITH_CONFIGURATION_BCONFIGURATIONVALUE_INDEX,
				CONFIGURATION_BCONFIGURATIONVALUE_COUNT => STARTS_WITH_CONFIGURATION_BCONFIGURATIONVALUE_COUNT,
				CONFIGURATION_ICONFIGURATION_BLENGTH_INDEX => STARTS_WITH_CONFIGURATION_ICONFIGURATION_BLENGTH_INDEX,
				CONFIGURATION_ICONFIGURATION_BLENGTH_COUNT => STARTS_WITH_CONFIGURATION_ICONFIGURATION_BLENGTH_COUNT,
				CONFIGURATION_ICONFIGURATION_INDEX => STARTS_WITH_CONFIGURATION_ICONFIGURATION_INDEX,
				CONFIGURATION_ICONFIGURATION_COUNT => STARTS_WITH_CONFIGURATION_ICONFIGURATION_COUNT,
				CONFIGURATION_BMATTRIBUTES_INDEX => STARTS_WITH_CONFIGURATION_BMATTRIBUTES_INDEX,
				CONFIGURATION_BMATTRIBUTES_COUNT => STARTS_WITH_CONFIGURATION_BMATTRIBUTES_COUNT,
				CONFIGURATION_BMAXPOWER_INDEX => STARTS_WITH_CONFIGURATION_BMAXPOWER_INDEX,
				CONFIGURATION_BMAXPOWER_COUNT => STARTS_WITH_CONFIGURATION_BMAXPOWER_COUNT,
				-- Interface Descriptor
				INTERFACE_BLENGTH_INDEX => STARTS_WITH_INTERFACE_BLENGTH_INDEX,
				INTERFACE_BLENGTH_COUNT => STARTS_WITH_INTERFACE_BLENGTH_COUNT,
				INTERFACE_BINTERFACENUMBER_INDEX => STARTS_WITH_INTERFACE_BINTERFACENUMBER_INDEX,
				INTERFACE_BINTERFACENUMBER_COUNT => STARTS_WITH_INTERFACE_BINTERFACENUMBER_COUNT,
				INTERFACE_BALTERNATESETTING_INDEX => STARTS_WITH_INTERFACE_BALTERNATESETTING_INDEX,
				INTERFACE_BALTERNATESETTING_COUNT => STARTS_WITH_INTERFACE_BALTERNATESETTING_COUNT,
				INTERFACE_BNUMENDPOINTS_INDEX => STARTS_WITH_INTERFACE_BNUMENDPOINTS_INDEX,
				INTERFACE_BNUMENDPOINTS_COUNT => STARTS_WITH_INTERFACE_BNUMENDPOINTS_COUNT,
				INTERFACE_BINTERFACECLASS_INDEX => STARTS_WITH_INTERFACE_BINTERFACECLASS_INDEX,
				INTERFACE_BINTERFACECLASS_COUNT => STARTS_WITH_INTERFACE_BINTERFACECLASS_COUNT,
				INTERFACE_BINTERFACESUBCLASS_INDEX => STARTS_WITH_INTERFACE_BINTERFACESUBCLASS_INDEX,
				INTERFACE_BINTERFACESUBCLASS_COUNT => STARTS_WITH_INTERFACE_BINTERFACESUBCLASS_COUNT,
				INTERFACE_BINTERFACEPROTOCOL_INDEX => STARTS_WITH_INTERFACE_BINTERFACEPROTOCOL_INDEX,
				INTERFACE_BINTERFACEPROTOCOL_COUNT => STARTS_WITH_INTERFACE_BINTERFACEPROTOCOL_COUNT,
				INTERFACE_IINTERFACE_BLENGTH_INDEX => STARTS_WITH_INTERFACE_IINTERFACE_BLENGTH_INDEX,
				INTERFACE_IINTERFACE_BLENGTH_COUNT => STARTS_WITH_INTERFACE_IINTERFACE_BLENGTH_COUNT,
				INTERFACE_IINTERFACE_INDEX => STARTS_WITH_INTERFACE_IINTERFACE_INDEX,
				INTERFACE_IINTERFACE_COUNT => STARTS_WITH_INTERFACE_IINTERFACE_COUNT,
				-- HID Descriptor
				HID_BLENGTH_INDEX => STARTS_WITH_HID_BLENGTH_INDEX,
				HID_BLENGTH_COUNT => STARTS_WITH_HID_BLENGTH_COUNT,
				HID_BCDHID_INDEX => STARTS_WITH_HID_BCDHID_INDEX,
				HID_BCDHID_COUNT => STARTS_WITH_HID_BCDHID_COUNT,
				HID_BCOUNTRYCODE_INDEX => STARTS_WITH_HID_BCOUNTRYCODE_INDEX,
				HID_BCOUNTRYCODE_COUNT => STARTS_WITH_HID_BCOUNTRYCODE_COUNT,
				HID_BNUMDESCRIPTORS_INDEX => STARTS_WITH_HID_BNUMDESCRIPTORS_INDEX,
				HID_BNUMDESCRIPTORS_COUNT => STARTS_WITH_HID_BNUMDESCRIPTORS_COUNT,
				HID_BDESCRIPTORTYPE_INDEX => STARTS_WITH_HID_BDESCRIPTORTYPE_INDEX,
				HID_BDESCRIPTORTYPE_COUNT => STARTS_WITH_HID_BDESCRIPTORTYPE_COUNT,
				HID_WDESCRIPTORLENGTH_INDEX => STARTS_WITH_HID_WDESCRIPTORLENGTH_INDEX,
				HID_WDESCRIPTORLENGTH_COUNT => STARTS_WITH_HID_WDESCRIPTORLENGTH_COUNT,
				-- Endpoint Descriptor
				ENDPOINT_BLENGTH_INDEX => STARTS_WITH_ENDPOINT_BLENGTH_INDEX,
				ENDPOINT_BLENGTH_COUNT => STARTS_WITH_ENDPOINT_BLENGTH_COUNT,
				ENDPOINT_BENDPOINTADDRESS_INDEX => STARTS_WITH_ENDPOINT_BENDPOINTADDRESS_INDEX,
				ENDPOINT_BENDPOINTADDRESS_COUNT => STARTS_WITH_ENDPOINT_BENDPOINTADDRESS_COUNT,
				ENDPOINT_BMATTRIBUTES_INDEX => STARTS_WITH_ENDPOINT_BMATTRIBUTES_INDEX,
				ENDPOINT_BMATTRIBUTES_COUNT => STARTS_WITH_ENDPOINT_BMATTRIBUTES_COUNT,
				ENDPOINT_WMAXPACKETSIZE_INDEX => STARTS_WITH_ENDPOINT_WMAXPACKETSIZE_INDEX,
				ENDPOINT_WMAXPACKETSIZE_COUNT => STARTS_WITH_ENDPOINT_WMAXPACKETSIZE_COUNT,
				ENDPOINT_BINTERVAL_INDEX => STARTS_WITH_ENDPOINT_BINTERVAL_INDEX,
				ENDPOINT_BINTERVAL_COUNT => STARTS_WITH_ENDPOINT_BINTERVAL_COUNT,
				-- Device Qualifier Descriptor
				DEVICE_QUALIFIER_BLENGTH_INDEX => STARTS_WITH_DEVICE_QUALIFIER_BLENGTH_INDEX,
				DEVICE_QUALIFIER_BLENGTH_COUNT => STARTS_WITH_DEVICE_QUALIFIER_BLENGTH_COUNT,
				DEVICE_QUALIFIER_BCDUSB_INDEX => STARTS_WITH_DEVICE_QUALIFIER_BCDUSB_INDEX,
				DEVICE_QUALIFIER_BCDUSB_COUNT => STARTS_WITH_DEVICE_QUALIFIER_BCDUSB_COUNT,
				DEVICE_QUALIFIER_BDEVICECLASS_INDEX => STARTS_WITH_DEVICE_QUALIFIER_BDEVICECLASS_INDEX,
				DEVICE_QUALIFIER_BDEVICECLASS_COUNT => STARTS_WITH_DEVICE_QUALIFIER_BDEVICECLASS_COUNT,
				DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX => STARTS_WITH_DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX,
				DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT => STARTS_WITH_DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT,
				DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX => STARTS_WITH_DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX,
				DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT => STARTS_WITH_DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT,
				DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX => STARTS_WITH_DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX,
				DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT => STARTS_WITH_DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT,
				DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX => STARTS_WITH_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX,
				DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT => STARTS_WITH_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT,
				DEVICE_QUALIFIER_BRESERVED_INDEX => STARTS_WITH_DEVICE_QUALIFIER_BRESERVED_INDEX,
				DEVICE_QUALIFIER_BRESERVED_COUNT => STARTS_WITH_DEVICE_QUALIFIER_BRESERVED_COUNT,
				-- Other Speed Descriptor
				OTHER_SPEED_BLENGTH_INDEX => STARTS_WITH_OTHER_SPEED_BLENGTH_INDEX,
				OTHER_SPEED_BLENGTH_COUNT => STARTS_WITH_OTHER_SPEED_BLENGTH_COUNT,
				OTHER_SPEED_WTOTALLENGTH_INDEX => STARTS_WITH_OTHER_SPEED_WTOTALLENGTH_INDEX,
				OTHER_SPEED_WTOTALLENGTH_COUNT => STARTS_WITH_OTHER_SPEED_WTOTALLENGTH_COUNT,
				OTHER_SPEED_BNUMINTERFACES_INDEX => STARTS_WITH_OTHER_SPEED_BNUMINTERFACES_INDEX,
				OTHER_SPEED_BNUMINTERFACES_COUNT => STARTS_WITH_OTHER_SPEED_BNUMINTERFACES_COUNT,
				OTHER_SPEED_BCONFIGURATIONVALUE_INDEX => STARTS_WITH_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX,
				OTHER_SPEED_BCONFIGURATIONVALUE_COUNT => STARTS_WITH_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT,
				OTHER_SPEED_ICONFIGURATION_BLENGTH_INDEX => STARTS_WITH_OTHER_SPEED_ICONFIGURATION_BLENGTH_INDEX,
				OTHER_SPEED_ICONFIGURATION_BLENGTH_COUNT => STARTS_WITH_OTHER_SPEED_ICONFIGURATION_BLENGTH_COUNT,
				OTHER_SPEED_ICONFIGURATION_INDEX => STARTS_WITH_OTHER_SPEED_ICONFIGURATION_INDEX,
				OTHER_SPEED_ICONFIGURATION_COUNT => STARTS_WITH_OTHER_SPEED_ICONFIGURATION_COUNT,
				OTHER_SPEED_BMATTRIBUTES_INDEX => STARTS_WITH_OTHER_SPEED_BMATTRIBUTES_INDEX,
				OTHER_SPEED_BMATTRIBUTES_COUNT => STARTS_WITH_OTHER_SPEED_BMATTRIBUTES_COUNT,
				OTHER_SPEED_BMAXPOWER_INDEX => STARTS_WITH_OTHER_SPEED_BMAXPOWER_INDEX,
				OTHER_SPEED_BMAXPOWER_COUNT => STARTS_WITH_OTHER_SPEED_BMAXPOWER_COUNT
			)
			PORT MAP (
				i_sys_clock => i_sys_clock,
				i_enable => i_enable,
				i_descriptor_field => i_descriptor_field,
				i_descriptor_field_available => i_descriptor_field_available,
				i_descriptor_value => i_descriptor_value,
				i_descriptor_value_en => i_descriptor_value_en,
				i_descriptor_value_total_part_number => i_descriptor_value_total_part_number,
				i_descriptor_value_part_number => i_descriptor_value_part_number,
				i_descriptor_value_new_part => i_descriptor_value_new_part,
				o_descriptor_value_next_part_request => operators_next_part_request(STARTS_WITH_OPERATOR_INDEX),
				o_ready => operators_ready(STARTS_WITH_OPERATOR_INDEX),
				o_result => operators_result(STARTS_WITH_OPERATOR_INDEX)
		);
	end generate;

	-----------------------
	-- EndsWith Operator --
	-----------------------
	endsWithOperator_en: if (ENDS_WITH_OPERATOR_ENABLE = '1') generate
		endsWithOperator_inst: EndsWithOperator
			GENERIC MAP (
				-- Memory Configurations (Address Length, Address Max Index, Address Count Max)
				MEMORY_ADDR_LENGTH => ENDS_WITH_MEMORY_ADDR_LENGTH,
				MEMORY_ADDR_MAX_INDEX => ENDS_WITH_MEMORY_ADDR_MAX_INDEX,
				MEMORY_ADDR_MAX_COUNT => ENDS_WITH_MEMORY_ADDR_MAX_COUNT,
				-- Device Descriptor
				DEVICE_BLENGTH_INDEX => ENDS_WITH_DEVICE_BLENGTH_INDEX,
				DEVICE_BLENGTH_COUNT => ENDS_WITH_DEVICE_BLENGTH_COUNT,
				DEVICE_BCDUSB_INDEX => ENDS_WITH_DEVICE_BCDUSB_INDEX,
				DEVICE_BCDUSB_COUNT => ENDS_WITH_DEVICE_BCDUSB_COUNT,
				DEVICE_BDEVICECLASS_INDEX => ENDS_WITH_DEVICE_BDEVICECLASS_INDEX,
				DEVICE_BDEVICECLASS_COUNT => ENDS_WITH_DEVICE_BDEVICECLASS_COUNT,
				DEVICE_BDEVICESUBCLASS_INDEX => ENDS_WITH_DEVICE_BDEVICESUBCLASS_INDEX,
				DEVICE_BDEVICESUBCLASS_COUNT => ENDS_WITH_DEVICE_BDEVICESUBCLASS_COUNT,
				DEVICE_BDEVICEPROTOCOL_INDEX => ENDS_WITH_DEVICE_BDEVICEPROTOCOL_INDEX,
				DEVICE_BDEVICEPROTOCOL_COUNT => ENDS_WITH_DEVICE_BDEVICEPROTOCOL_COUNT,
				DEVICE_BMAXPACKETSIZE0_INDEX => ENDS_WITH_DEVICE_BMAXPACKETSIZE0_INDEX,
				DEVICE_BMAXPACKETSIZE0_COUNT => ENDS_WITH_DEVICE_BMAXPACKETSIZE0_COUNT,
				DEVICE_IDVENDOR_INDEX => ENDS_WITH_DEVICE_IDVENDOR_INDEX,
				DEVICE_IDVENDOR_COUNT => ENDS_WITH_DEVICE_IDVENDOR_COUNT,
				DEVICE_IDPRODUCT_INDEX => ENDS_WITH_DEVICE_IDPRODUCT_INDEX,
				DEVICE_IDPRODUCT_COUNT => ENDS_WITH_DEVICE_IDPRODUCT_COUNT,
				DEVICE_BCDDEVICE_INDEX => ENDS_WITH_DEVICE_BCDDEVICE_INDEX,
				DEVICE_BCDDEVICE_COUNT => ENDS_WITH_DEVICE_BCDDEVICE_COUNT,
				DEVICE_IMANUFACTURER_BLENGTH_INDEX => ENDS_WITH_DEVICE_IMANUFACTURER_BLENGTH_INDEX,
				DEVICE_IMANUFACTURER_BLENGTH_COUNT => ENDS_WITH_DEVICE_IMANUFACTURER_BLENGTH_COUNT,
				DEVICE_IMANUFACTURER_INDEX => ENDS_WITH_DEVICE_IMANUFACTURER_INDEX,
				DEVICE_IMANUFACTURER_COUNT => ENDS_WITH_DEVICE_IMANUFACTURER_COUNT,
				DEVICE_IPRODUCT_BLENGTH_INDEX => ENDS_WITH_DEVICE_IPRODUCT_BLENGTH_INDEX,
				DEVICE_IPRODUCT_BLENGTH_COUNT => ENDS_WITH_DEVICE_IPRODUCT_BLENGTH_COUNT,
				DEVICE_IPRODUCT_INDEX => ENDS_WITH_DEVICE_IPRODUCT_INDEX,
				DEVICE_IPRODUCT_COUNT => ENDS_WITH_DEVICE_IPRODUCT_COUNT,
				DEVICE_ISERIALNUMBER_BLENGTH_INDEX => ENDS_WITH_DEVICE_ISERIALNUMBER_BLENGTH_INDEX,
				DEVICE_ISERIALNUMBER_BLENGTH_COUNT => ENDS_WITH_DEVICE_ISERIALNUMBER_BLENGTH_COUNT,
				DEVICE_ISERIALNUMBER_INDEX => ENDS_WITH_DEVICE_ISERIALNUMBER_INDEX,
				DEVICE_ISERIALNUMBER_COUNT => ENDS_WITH_DEVICE_ISERIALNUMBER_COUNT,
				DEVICE_BNUMCONFIGURATIONS_INDEX => ENDS_WITH_DEVICE_BNUMCONFIGURATIONS_INDEX,
				DEVICE_BNUMCONFIGURATIONS_COUNT => ENDS_WITH_DEVICE_BNUMCONFIGURATIONS_COUNT,
				-- Configuration Descriptor
				CONFIGURATION_BLENGTH_INDEX => ENDS_WITH_CONFIGURATION_BLENGTH_INDEX,
				CONFIGURATION_BLENGTH_COUNT => ENDS_WITH_CONFIGURATION_BLENGTH_COUNT,
				CONFIGURATION_WTOTALLENGTH_INDEX => ENDS_WITH_CONFIGURATION_WTOTALLENGTH_INDEX,
				CONFIGURATION_WTOTALLENGTH_COUNT => ENDS_WITH_CONFIGURATION_WTOTALLENGTH_COUNT,
				CONFIGURATION_BNUMINTERFACES_INDEX => ENDS_WITH_CONFIGURATION_BNUMINTERFACES_INDEX,
				CONFIGURATION_BNUMINTERFACES_COUNT => ENDS_WITH_CONFIGURATION_BNUMINTERFACES_COUNT,
				CONFIGURATION_BCONFIGURATIONVALUE_INDEX => ENDS_WITH_CONFIGURATION_BCONFIGURATIONVALUE_INDEX,
				CONFIGURATION_BCONFIGURATIONVALUE_COUNT => ENDS_WITH_CONFIGURATION_BCONFIGURATIONVALUE_COUNT,
				CONFIGURATION_ICONFIGURATION_BLENGTH_INDEX => ENDS_WITH_CONFIGURATION_ICONFIGURATION_BLENGTH_INDEX,
				CONFIGURATION_ICONFIGURATION_BLENGTH_COUNT => ENDS_WITH_CONFIGURATION_ICONFIGURATION_BLENGTH_COUNT,
				CONFIGURATION_ICONFIGURATION_INDEX => ENDS_WITH_CONFIGURATION_ICONFIGURATION_INDEX,
				CONFIGURATION_ICONFIGURATION_COUNT => ENDS_WITH_CONFIGURATION_ICONFIGURATION_COUNT,
				CONFIGURATION_BMATTRIBUTES_INDEX => ENDS_WITH_CONFIGURATION_BMATTRIBUTES_INDEX,
				CONFIGURATION_BMATTRIBUTES_COUNT => ENDS_WITH_CONFIGURATION_BMATTRIBUTES_COUNT,
				CONFIGURATION_BMAXPOWER_INDEX => ENDS_WITH_CONFIGURATION_BMAXPOWER_INDEX,
				CONFIGURATION_BMAXPOWER_COUNT => ENDS_WITH_CONFIGURATION_BMAXPOWER_COUNT,
				-- Interface Descriptor
				INTERFACE_BLENGTH_INDEX => ENDS_WITH_INTERFACE_BLENGTH_INDEX,
				INTERFACE_BLENGTH_COUNT => ENDS_WITH_INTERFACE_BLENGTH_COUNT,
				INTERFACE_BINTERFACENUMBER_INDEX => ENDS_WITH_INTERFACE_BINTERFACENUMBER_INDEX,
				INTERFACE_BINTERFACENUMBER_COUNT => ENDS_WITH_INTERFACE_BINTERFACENUMBER_COUNT,
				INTERFACE_BALTERNATESETTING_INDEX => ENDS_WITH_INTERFACE_BALTERNATESETTING_INDEX,
				INTERFACE_BALTERNATESETTING_COUNT => ENDS_WITH_INTERFACE_BALTERNATESETTING_COUNT,
				INTERFACE_BNUMENDPOINTS_INDEX => ENDS_WITH_INTERFACE_BNUMENDPOINTS_INDEX,
				INTERFACE_BNUMENDPOINTS_COUNT => ENDS_WITH_INTERFACE_BNUMENDPOINTS_COUNT,
				INTERFACE_BINTERFACECLASS_INDEX => ENDS_WITH_INTERFACE_BINTERFACECLASS_INDEX,
				INTERFACE_BINTERFACECLASS_COUNT => ENDS_WITH_INTERFACE_BINTERFACECLASS_COUNT,
				INTERFACE_BINTERFACESUBCLASS_INDEX => ENDS_WITH_INTERFACE_BINTERFACESUBCLASS_INDEX,
				INTERFACE_BINTERFACESUBCLASS_COUNT => ENDS_WITH_INTERFACE_BINTERFACESUBCLASS_COUNT,
				INTERFACE_BINTERFACEPROTOCOL_INDEX => ENDS_WITH_INTERFACE_BINTERFACEPROTOCOL_INDEX,
				INTERFACE_BINTERFACEPROTOCOL_COUNT => ENDS_WITH_INTERFACE_BINTERFACEPROTOCOL_COUNT,
				INTERFACE_IINTERFACE_BLENGTH_INDEX => ENDS_WITH_INTERFACE_IINTERFACE_BLENGTH_INDEX,
				INTERFACE_IINTERFACE_BLENGTH_COUNT => ENDS_WITH_INTERFACE_IINTERFACE_BLENGTH_COUNT,
				INTERFACE_IINTERFACE_INDEX => ENDS_WITH_INTERFACE_IINTERFACE_INDEX,
				INTERFACE_IINTERFACE_COUNT => ENDS_WITH_INTERFACE_IINTERFACE_COUNT,
				-- HID Descriptor
				HID_BLENGTH_INDEX => ENDS_WITH_HID_BLENGTH_INDEX,
				HID_BLENGTH_COUNT => ENDS_WITH_HID_BLENGTH_COUNT,
				HID_BCDHID_INDEX => ENDS_WITH_HID_BCDHID_INDEX,
				HID_BCDHID_COUNT => ENDS_WITH_HID_BCDHID_COUNT,
				HID_BCOUNTRYCODE_INDEX => ENDS_WITH_HID_BCOUNTRYCODE_INDEX,
				HID_BCOUNTRYCODE_COUNT => ENDS_WITH_HID_BCOUNTRYCODE_COUNT,
				HID_BNUMDESCRIPTORS_INDEX => ENDS_WITH_HID_BNUMDESCRIPTORS_INDEX,
				HID_BNUMDESCRIPTORS_COUNT => ENDS_WITH_HID_BNUMDESCRIPTORS_COUNT,
				HID_BDESCRIPTORTYPE_INDEX => ENDS_WITH_HID_BDESCRIPTORTYPE_INDEX,
				HID_BDESCRIPTORTYPE_COUNT => ENDS_WITH_HID_BDESCRIPTORTYPE_COUNT,
				HID_WDESCRIPTORLENGTH_INDEX => ENDS_WITH_HID_WDESCRIPTORLENGTH_INDEX,
				HID_WDESCRIPTORLENGTH_COUNT => ENDS_WITH_HID_WDESCRIPTORLENGTH_COUNT,
				-- Endpoint Descriptor
				ENDPOINT_BLENGTH_INDEX => ENDS_WITH_ENDPOINT_BLENGTH_INDEX,
				ENDPOINT_BLENGTH_COUNT => ENDS_WITH_ENDPOINT_BLENGTH_COUNT,
				ENDPOINT_BENDPOINTADDRESS_INDEX => ENDS_WITH_ENDPOINT_BENDPOINTADDRESS_INDEX,
				ENDPOINT_BENDPOINTADDRESS_COUNT => ENDS_WITH_ENDPOINT_BENDPOINTADDRESS_COUNT,
				ENDPOINT_BMATTRIBUTES_INDEX => ENDS_WITH_ENDPOINT_BMATTRIBUTES_INDEX,
				ENDPOINT_BMATTRIBUTES_COUNT => ENDS_WITH_ENDPOINT_BMATTRIBUTES_COUNT,
				ENDPOINT_WMAXPACKETSIZE_INDEX => ENDS_WITH_ENDPOINT_WMAXPACKETSIZE_INDEX,
				ENDPOINT_WMAXPACKETSIZE_COUNT => ENDS_WITH_ENDPOINT_WMAXPACKETSIZE_COUNT,
				ENDPOINT_BINTERVAL_INDEX => ENDS_WITH_ENDPOINT_BINTERVAL_INDEX,
				ENDPOINT_BINTERVAL_COUNT => ENDS_WITH_ENDPOINT_BINTERVAL_COUNT,
				-- Device Qualifier Descriptor
				DEVICE_QUALIFIER_BLENGTH_INDEX => ENDS_WITH_DEVICE_QUALIFIER_BLENGTH_INDEX,
				DEVICE_QUALIFIER_BLENGTH_COUNT => ENDS_WITH_DEVICE_QUALIFIER_BLENGTH_COUNT,
				DEVICE_QUALIFIER_BCDUSB_INDEX => ENDS_WITH_DEVICE_QUALIFIER_BCDUSB_INDEX,
				DEVICE_QUALIFIER_BCDUSB_COUNT => ENDS_WITH_DEVICE_QUALIFIER_BCDUSB_COUNT,
				DEVICE_QUALIFIER_BDEVICECLASS_INDEX => ENDS_WITH_DEVICE_QUALIFIER_BDEVICECLASS_INDEX,
				DEVICE_QUALIFIER_BDEVICECLASS_COUNT => ENDS_WITH_DEVICE_QUALIFIER_BDEVICECLASS_COUNT,
				DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX => ENDS_WITH_DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX,
				DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT => ENDS_WITH_DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT,
				DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX => ENDS_WITH_DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX,
				DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT => ENDS_WITH_DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT,
				DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX => ENDS_WITH_DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX,
				DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT => ENDS_WITH_DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT,
				DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX => ENDS_WITH_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX,
				DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT => ENDS_WITH_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT,
				DEVICE_QUALIFIER_BRESERVED_INDEX => ENDS_WITH_DEVICE_QUALIFIER_BRESERVED_INDEX,
				DEVICE_QUALIFIER_BRESERVED_COUNT => ENDS_WITH_DEVICE_QUALIFIER_BRESERVED_COUNT,
				-- Other Speed Descriptor
				OTHER_SPEED_BLENGTH_INDEX => ENDS_WITH_OTHER_SPEED_BLENGTH_INDEX,
				OTHER_SPEED_BLENGTH_COUNT => ENDS_WITH_OTHER_SPEED_BLENGTH_COUNT,
				OTHER_SPEED_WTOTALLENGTH_INDEX => ENDS_WITH_OTHER_SPEED_WTOTALLENGTH_INDEX,
				OTHER_SPEED_WTOTALLENGTH_COUNT => ENDS_WITH_OTHER_SPEED_WTOTALLENGTH_COUNT,
				OTHER_SPEED_BNUMINTERFACES_INDEX => ENDS_WITH_OTHER_SPEED_BNUMINTERFACES_INDEX,
				OTHER_SPEED_BNUMINTERFACES_COUNT => ENDS_WITH_OTHER_SPEED_BNUMINTERFACES_COUNT,
				OTHER_SPEED_BCONFIGURATIONVALUE_INDEX => ENDS_WITH_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX,
				OTHER_SPEED_BCONFIGURATIONVALUE_COUNT => ENDS_WITH_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT,
				OTHER_SPEED_ICONFIGURATION_BLENGTH_INDEX => ENDS_WITH_OTHER_SPEED_ICONFIGURATION_BLENGTH_INDEX,
				OTHER_SPEED_ICONFIGURATION_BLENGTH_COUNT => ENDS_WITH_OTHER_SPEED_ICONFIGURATION_BLENGTH_COUNT,
				OTHER_SPEED_ICONFIGURATION_INDEX => ENDS_WITH_OTHER_SPEED_ICONFIGURATION_INDEX,
				OTHER_SPEED_ICONFIGURATION_COUNT => ENDS_WITH_OTHER_SPEED_ICONFIGURATION_COUNT,
				OTHER_SPEED_BMATTRIBUTES_INDEX => ENDS_WITH_OTHER_SPEED_BMATTRIBUTES_INDEX,
				OTHER_SPEED_BMATTRIBUTES_COUNT => ENDS_WITH_OTHER_SPEED_BMATTRIBUTES_COUNT,
				OTHER_SPEED_BMAXPOWER_INDEX => ENDS_WITH_OTHER_SPEED_BMAXPOWER_INDEX,
				OTHER_SPEED_BMAXPOWER_COUNT => ENDS_WITH_OTHER_SPEED_BMAXPOWER_COUNT
			)
			PORT MAP (
				i_sys_clock => i_sys_clock,
				i_enable => i_enable,
				i_descriptor_field => i_descriptor_field,
				i_descriptor_field_available => i_descriptor_field_available,
				i_descriptor_value => i_descriptor_value,
				i_descriptor_value_en => i_descriptor_value_en,
				i_descriptor_value_total_part_number => i_descriptor_value_total_part_number,
				i_descriptor_value_part_number => i_descriptor_value_part_number,
				i_descriptor_value_new_part => i_descriptor_value_new_part,
				o_descriptor_value_next_part_request => operators_next_part_request(ENDS_WITH_OPERATOR_INDEX),
				o_ready => operators_ready(ENDS_WITH_OPERATOR_INDEX),
				o_result => operators_result(ENDS_WITH_OPERATOR_INDEX)
		);
	end generate;

	-----------------------
	-- Contains Operator --
	-----------------------
	containsOperator_en: if (CONTAINS_OPERATOR_ENABLE = '1') generate
		containsOperator_inst: ContainsOperator
			GENERIC MAP (
				-- Memory Configurations (Address Length, Address Max Index, Address Count Max)
				MEMORY_ADDR_LENGTH => CONTAINS_MEMORY_ADDR_LENGTH,
				MEMORY_ADDR_MAX_INDEX => CONTAINS_MEMORY_ADDR_MAX_INDEX,
				MEMORY_ADDR_MAX_COUNT => CONTAINS_MEMORY_ADDR_MAX_COUNT,
				-- Device Descriptor
				DEVICE_BLENGTH_INDEX => CONTAINS_DEVICE_BLENGTH_INDEX,
				DEVICE_BLENGTH_COUNT => CONTAINS_DEVICE_BLENGTH_COUNT,
				DEVICE_BCDUSB_INDEX => CONTAINS_DEVICE_BCDUSB_INDEX,
				DEVICE_BCDUSB_COUNT => CONTAINS_DEVICE_BCDUSB_COUNT,
				DEVICE_BDEVICECLASS_INDEX => CONTAINS_DEVICE_BDEVICECLASS_INDEX,
				DEVICE_BDEVICECLASS_COUNT => CONTAINS_DEVICE_BDEVICECLASS_COUNT,
				DEVICE_BDEVICESUBCLASS_INDEX => CONTAINS_DEVICE_BDEVICESUBCLASS_INDEX,
				DEVICE_BDEVICESUBCLASS_COUNT => CONTAINS_DEVICE_BDEVICESUBCLASS_COUNT,
				DEVICE_BDEVICEPROTOCOL_INDEX => CONTAINS_DEVICE_BDEVICEPROTOCOL_INDEX,
				DEVICE_BDEVICEPROTOCOL_COUNT => CONTAINS_DEVICE_BDEVICEPROTOCOL_COUNT,
				DEVICE_BMAXPACKETSIZE0_INDEX => CONTAINS_DEVICE_BMAXPACKETSIZE0_INDEX,
				DEVICE_BMAXPACKETSIZE0_COUNT => CONTAINS_DEVICE_BMAXPACKETSIZE0_COUNT,
				DEVICE_IDVENDOR_INDEX => CONTAINS_DEVICE_IDVENDOR_INDEX,
				DEVICE_IDVENDOR_COUNT => CONTAINS_DEVICE_IDVENDOR_COUNT,
				DEVICE_IDPRODUCT_INDEX => CONTAINS_DEVICE_IDPRODUCT_INDEX,
				DEVICE_IDPRODUCT_COUNT => CONTAINS_DEVICE_IDPRODUCT_COUNT,
				DEVICE_BCDDEVICE_INDEX => CONTAINS_DEVICE_BCDDEVICE_INDEX,
				DEVICE_BCDDEVICE_COUNT => CONTAINS_DEVICE_BCDDEVICE_COUNT,
				DEVICE_IMANUFACTURER_BLENGTH_INDEX => CONTAINS_DEVICE_IMANUFACTURER_BLENGTH_INDEX,
				DEVICE_IMANUFACTURER_BLENGTH_COUNT => CONTAINS_DEVICE_IMANUFACTURER_BLENGTH_COUNT,
				DEVICE_IMANUFACTURER_INDEX => CONTAINS_DEVICE_IMANUFACTURER_INDEX,
				DEVICE_IMANUFACTURER_COUNT => CONTAINS_DEVICE_IMANUFACTURER_COUNT,
				DEVICE_IPRODUCT_BLENGTH_INDEX => CONTAINS_DEVICE_IPRODUCT_BLENGTH_INDEX,
				DEVICE_IPRODUCT_BLENGTH_COUNT => CONTAINS_DEVICE_IPRODUCT_BLENGTH_COUNT,
				DEVICE_IPRODUCT_INDEX => CONTAINS_DEVICE_IPRODUCT_INDEX,
				DEVICE_IPRODUCT_COUNT => CONTAINS_DEVICE_IPRODUCT_COUNT,
				DEVICE_ISERIALNUMBER_BLENGTH_INDEX => CONTAINS_DEVICE_ISERIALNUMBER_BLENGTH_INDEX,
				DEVICE_ISERIALNUMBER_BLENGTH_COUNT => CONTAINS_DEVICE_ISERIALNUMBER_BLENGTH_COUNT,
				DEVICE_ISERIALNUMBER_INDEX => CONTAINS_DEVICE_ISERIALNUMBER_INDEX,
				DEVICE_ISERIALNUMBER_COUNT => CONTAINS_DEVICE_ISERIALNUMBER_COUNT,
				DEVICE_BNUMCONFIGURATIONS_INDEX => CONTAINS_DEVICE_BNUMCONFIGURATIONS_INDEX,
				DEVICE_BNUMCONFIGURATIONS_COUNT => CONTAINS_DEVICE_BNUMCONFIGURATIONS_COUNT,
				-- Configuration Descriptor
				CONFIGURATION_BLENGTH_INDEX => CONTAINS_CONFIGURATION_BLENGTH_INDEX,
				CONFIGURATION_BLENGTH_COUNT => CONTAINS_CONFIGURATION_BLENGTH_COUNT,
				CONFIGURATION_WTOTALLENGTH_INDEX => CONTAINS_CONFIGURATION_WTOTALLENGTH_INDEX,
				CONFIGURATION_WTOTALLENGTH_COUNT => CONTAINS_CONFIGURATION_WTOTALLENGTH_COUNT,
				CONFIGURATION_BNUMINTERFACES_INDEX => CONTAINS_CONFIGURATION_BNUMINTERFACES_INDEX,
				CONFIGURATION_BNUMINTERFACES_COUNT => CONTAINS_CONFIGURATION_BNUMINTERFACES_COUNT,
				CONFIGURATION_BCONFIGURATIONVALUE_INDEX => CONTAINS_CONFIGURATION_BCONFIGURATIONVALUE_INDEX,
				CONFIGURATION_BCONFIGURATIONVALUE_COUNT => CONTAINS_CONFIGURATION_BCONFIGURATIONVALUE_COUNT,
				CONFIGURATION_ICONFIGURATION_BLENGTH_INDEX => CONTAINS_CONFIGURATION_ICONFIGURATION_BLENGTH_INDEX,
				CONFIGURATION_ICONFIGURATION_BLENGTH_COUNT => CONTAINS_CONFIGURATION_ICONFIGURATION_BLENGTH_COUNT,
				CONFIGURATION_ICONFIGURATION_INDEX => CONTAINS_CONFIGURATION_ICONFIGURATION_INDEX,
				CONFIGURATION_ICONFIGURATION_COUNT => CONTAINS_CONFIGURATION_ICONFIGURATION_COUNT,
				CONFIGURATION_BMATTRIBUTES_INDEX => CONTAINS_CONFIGURATION_BMATTRIBUTES_INDEX,
				CONFIGURATION_BMATTRIBUTES_COUNT => CONTAINS_CONFIGURATION_BMATTRIBUTES_COUNT,
				CONFIGURATION_BMAXPOWER_INDEX => CONTAINS_CONFIGURATION_BMAXPOWER_INDEX,
				CONFIGURATION_BMAXPOWER_COUNT => CONTAINS_CONFIGURATION_BMAXPOWER_COUNT,
				-- Interface Descriptor
				INTERFACE_BLENGTH_INDEX => CONTAINS_INTERFACE_BLENGTH_INDEX,
				INTERFACE_BLENGTH_COUNT => CONTAINS_INTERFACE_BLENGTH_COUNT,
				INTERFACE_BINTERFACENUMBER_INDEX => CONTAINS_INTERFACE_BINTERFACENUMBER_INDEX,
				INTERFACE_BINTERFACENUMBER_COUNT => CONTAINS_INTERFACE_BINTERFACENUMBER_COUNT,
				INTERFACE_BALTERNATESETTING_INDEX => CONTAINS_INTERFACE_BALTERNATESETTING_INDEX,
				INTERFACE_BALTERNATESETTING_COUNT => CONTAINS_INTERFACE_BALTERNATESETTING_COUNT,
				INTERFACE_BNUMENDPOINTS_INDEX => CONTAINS_INTERFACE_BNUMENDPOINTS_INDEX,
				INTERFACE_BNUMENDPOINTS_COUNT => CONTAINS_INTERFACE_BNUMENDPOINTS_COUNT,
				INTERFACE_BINTERFACECLASS_INDEX => CONTAINS_INTERFACE_BINTERFACECLASS_INDEX,
				INTERFACE_BINTERFACECLASS_COUNT => CONTAINS_INTERFACE_BINTERFACECLASS_COUNT,
				INTERFACE_BINTERFACESUBCLASS_INDEX => CONTAINS_INTERFACE_BINTERFACESUBCLASS_INDEX,
				INTERFACE_BINTERFACESUBCLASS_COUNT => CONTAINS_INTERFACE_BINTERFACESUBCLASS_COUNT,
				INTERFACE_BINTERFACEPROTOCOL_INDEX => CONTAINS_INTERFACE_BINTERFACEPROTOCOL_INDEX,
				INTERFACE_BINTERFACEPROTOCOL_COUNT => CONTAINS_INTERFACE_BINTERFACEPROTOCOL_COUNT,
				INTERFACE_IINTERFACE_BLENGTH_INDEX => CONTAINS_INTERFACE_IINTERFACE_BLENGTH_INDEX,
				INTERFACE_IINTERFACE_BLENGTH_COUNT => CONTAINS_INTERFACE_IINTERFACE_BLENGTH_COUNT,
				INTERFACE_IINTERFACE_INDEX => CONTAINS_INTERFACE_IINTERFACE_INDEX,
				INTERFACE_IINTERFACE_COUNT => CONTAINS_INTERFACE_IINTERFACE_COUNT,
				-- HID Descriptor
				HID_BLENGTH_INDEX => CONTAINS_HID_BLENGTH_INDEX,
				HID_BLENGTH_COUNT => CONTAINS_HID_BLENGTH_COUNT,
				HID_BCDHID_INDEX => CONTAINS_HID_BCDHID_INDEX,
				HID_BCDHID_COUNT => CONTAINS_HID_BCDHID_COUNT,
				HID_BCOUNTRYCODE_INDEX => CONTAINS_HID_BCOUNTRYCODE_INDEX,
				HID_BCOUNTRYCODE_COUNT => CONTAINS_HID_BCOUNTRYCODE_COUNT,
				HID_BNUMDESCRIPTORS_INDEX => CONTAINS_HID_BNUMDESCRIPTORS_INDEX,
				HID_BNUMDESCRIPTORS_COUNT => CONTAINS_HID_BNUMDESCRIPTORS_COUNT,
				HID_BDESCRIPTORTYPE_INDEX => CONTAINS_HID_BDESCRIPTORTYPE_INDEX,
				HID_BDESCRIPTORTYPE_COUNT => CONTAINS_HID_BDESCRIPTORTYPE_COUNT,
				HID_WDESCRIPTORLENGTH_INDEX => CONTAINS_HID_WDESCRIPTORLENGTH_INDEX,
				HID_WDESCRIPTORLENGTH_COUNT => CONTAINS_HID_WDESCRIPTORLENGTH_COUNT,
				-- Endpoint Descriptor
				ENDPOINT_BLENGTH_INDEX => CONTAINS_ENDPOINT_BLENGTH_INDEX,
				ENDPOINT_BLENGTH_COUNT => CONTAINS_ENDPOINT_BLENGTH_COUNT,
				ENDPOINT_BENDPOINTADDRESS_INDEX => CONTAINS_ENDPOINT_BENDPOINTADDRESS_INDEX,
				ENDPOINT_BENDPOINTADDRESS_COUNT => CONTAINS_ENDPOINT_BENDPOINTADDRESS_COUNT,
				ENDPOINT_BMATTRIBUTES_INDEX => CONTAINS_ENDPOINT_BMATTRIBUTES_INDEX,
				ENDPOINT_BMATTRIBUTES_COUNT => CONTAINS_ENDPOINT_BMATTRIBUTES_COUNT,
				ENDPOINT_WMAXPACKETSIZE_INDEX => CONTAINS_ENDPOINT_WMAXPACKETSIZE_INDEX,
				ENDPOINT_WMAXPACKETSIZE_COUNT => CONTAINS_ENDPOINT_WMAXPACKETSIZE_COUNT,
				ENDPOINT_BINTERVAL_INDEX => CONTAINS_ENDPOINT_BINTERVAL_INDEX,
				ENDPOINT_BINTERVAL_COUNT => CONTAINS_ENDPOINT_BINTERVAL_COUNT,
				-- Device Qualifier Descriptor
				DEVICE_QUALIFIER_BLENGTH_INDEX => CONTAINS_DEVICE_QUALIFIER_BLENGTH_INDEX,
				DEVICE_QUALIFIER_BLENGTH_COUNT => CONTAINS_DEVICE_QUALIFIER_BLENGTH_COUNT,
				DEVICE_QUALIFIER_BCDUSB_INDEX => CONTAINS_DEVICE_QUALIFIER_BCDUSB_INDEX,
				DEVICE_QUALIFIER_BCDUSB_COUNT => CONTAINS_DEVICE_QUALIFIER_BCDUSB_COUNT,
				DEVICE_QUALIFIER_BDEVICECLASS_INDEX => CONTAINS_DEVICE_QUALIFIER_BDEVICECLASS_INDEX,
				DEVICE_QUALIFIER_BDEVICECLASS_COUNT => CONTAINS_DEVICE_QUALIFIER_BDEVICECLASS_COUNT,
				DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX => CONTAINS_DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX,
				DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT => CONTAINS_DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT,
				DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX => CONTAINS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX,
				DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT => CONTAINS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT,
				DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX => CONTAINS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX,
				DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT => CONTAINS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT,
				DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX => CONTAINS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX,
				DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT => CONTAINS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT,
				DEVICE_QUALIFIER_BRESERVED_INDEX => CONTAINS_DEVICE_QUALIFIER_BRESERVED_INDEX,
				DEVICE_QUALIFIER_BRESERVED_COUNT => CONTAINS_DEVICE_QUALIFIER_BRESERVED_COUNT,
				-- Other Speed Descriptor
				OTHER_SPEED_BLENGTH_INDEX => CONTAINS_OTHER_SPEED_BLENGTH_INDEX,
				OTHER_SPEED_BLENGTH_COUNT => CONTAINS_OTHER_SPEED_BLENGTH_COUNT,
				OTHER_SPEED_WTOTALLENGTH_INDEX => CONTAINS_OTHER_SPEED_WTOTALLENGTH_INDEX,
				OTHER_SPEED_WTOTALLENGTH_COUNT => CONTAINS_OTHER_SPEED_WTOTALLENGTH_COUNT,
				OTHER_SPEED_BNUMINTERFACES_INDEX => CONTAINS_OTHER_SPEED_BNUMINTERFACES_INDEX,
				OTHER_SPEED_BNUMINTERFACES_COUNT => CONTAINS_OTHER_SPEED_BNUMINTERFACES_COUNT,
				OTHER_SPEED_BCONFIGURATIONVALUE_INDEX => CONTAINS_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX,
				OTHER_SPEED_BCONFIGURATIONVALUE_COUNT => CONTAINS_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT,
				OTHER_SPEED_ICONFIGURATION_BLENGTH_INDEX => CONTAINS_OTHER_SPEED_ICONFIGURATION_BLENGTH_INDEX,
				OTHER_SPEED_ICONFIGURATION_BLENGTH_COUNT => CONTAINS_OTHER_SPEED_ICONFIGURATION_BLENGTH_COUNT,
				OTHER_SPEED_ICONFIGURATION_INDEX => CONTAINS_OTHER_SPEED_ICONFIGURATION_INDEX,
				OTHER_SPEED_ICONFIGURATION_COUNT => CONTAINS_OTHER_SPEED_ICONFIGURATION_COUNT,
				OTHER_SPEED_BMATTRIBUTES_INDEX => CONTAINS_OTHER_SPEED_BMATTRIBUTES_INDEX,
				OTHER_SPEED_BMATTRIBUTES_COUNT => CONTAINS_OTHER_SPEED_BMATTRIBUTES_COUNT,
				OTHER_SPEED_BMAXPOWER_INDEX => CONTAINS_OTHER_SPEED_BMAXPOWER_INDEX,
				OTHER_SPEED_BMAXPOWER_COUNT => CONTAINS_OTHER_SPEED_BMAXPOWER_COUNT
			)
			PORT MAP (
				i_sys_clock => i_sys_clock,
				i_enable => i_enable,
				i_descriptor_field => i_descriptor_field,
				i_descriptor_field_available => i_descriptor_field_available,
				i_descriptor_value => i_descriptor_value,
				i_descriptor_value_en => i_descriptor_value_en,
				i_descriptor_value_total_part_number => i_descriptor_value_total_part_number,
				i_descriptor_value_part_number => i_descriptor_value_part_number,
				i_descriptor_value_new_part => i_descriptor_value_new_part,
				o_descriptor_value_next_part_request => operators_next_part_request(CONTAINS_OPERATOR_INDEX),
				o_ready => operators_ready(CONTAINS_OPERATOR_INDEX),
				o_result => operators_result(CONTAINS_OPERATOR_INDEX)
		);
	end generate;

	--------------------------
	-- NotContains Operator --
	--------------------------
	notContainsOperator_en: if (NOT_CONTAINS_OPERATOR_ENABLE = '1') generate
		notContainsOperator_inst: NotContainsOperator
			GENERIC MAP (
				-- Memory Configurations (Address Length, Address Max Index, Address Count Max)
				MEMORY_ADDR_LENGTH => NOT_CONTAINS_MEMORY_ADDR_LENGTH,
				MEMORY_ADDR_MAX_INDEX => NOT_CONTAINS_MEMORY_ADDR_MAX_INDEX,
				MEMORY_ADDR_MAX_COUNT => NOT_CONTAINS_MEMORY_ADDR_MAX_COUNT,
				-- Device Descriptor
				DEVICE_BLENGTH_INDEX => NOT_CONTAINS_DEVICE_BLENGTH_INDEX,
				DEVICE_BLENGTH_COUNT => NOT_CONTAINS_DEVICE_BLENGTH_COUNT,
				DEVICE_BCDUSB_INDEX => NOT_CONTAINS_DEVICE_BCDUSB_INDEX,
				DEVICE_BCDUSB_COUNT => NOT_CONTAINS_DEVICE_BCDUSB_COUNT,
				DEVICE_BDEVICECLASS_INDEX => NOT_CONTAINS_DEVICE_BDEVICECLASS_INDEX,
				DEVICE_BDEVICECLASS_COUNT => NOT_CONTAINS_DEVICE_BDEVICECLASS_COUNT,
				DEVICE_BDEVICESUBCLASS_INDEX => NOT_CONTAINS_DEVICE_BDEVICESUBCLASS_INDEX,
				DEVICE_BDEVICESUBCLASS_COUNT => NOT_CONTAINS_DEVICE_BDEVICESUBCLASS_COUNT,
				DEVICE_BDEVICEPROTOCOL_INDEX => NOT_CONTAINS_DEVICE_BDEVICEPROTOCOL_INDEX,
				DEVICE_BDEVICEPROTOCOL_COUNT => NOT_CONTAINS_DEVICE_BDEVICEPROTOCOL_COUNT,
				DEVICE_BMAXPACKETSIZE0_INDEX => NOT_CONTAINS_DEVICE_BMAXPACKETSIZE0_INDEX,
				DEVICE_BMAXPACKETSIZE0_COUNT => NOT_CONTAINS_DEVICE_BMAXPACKETSIZE0_COUNT,
				DEVICE_IDVENDOR_INDEX => NOT_CONTAINS_DEVICE_IDVENDOR_INDEX,
				DEVICE_IDVENDOR_COUNT => NOT_CONTAINS_DEVICE_IDVENDOR_COUNT,
				DEVICE_IDPRODUCT_INDEX => NOT_CONTAINS_DEVICE_IDPRODUCT_INDEX,
				DEVICE_IDPRODUCT_COUNT => NOT_CONTAINS_DEVICE_IDPRODUCT_COUNT,
				DEVICE_BCDDEVICE_INDEX => NOT_CONTAINS_DEVICE_BCDDEVICE_INDEX,
				DEVICE_BCDDEVICE_COUNT => NOT_CONTAINS_DEVICE_BCDDEVICE_COUNT,
				DEVICE_IMANUFACTURER_BLENGTH_INDEX => NOT_CONTAINS_DEVICE_IMANUFACTURER_BLENGTH_INDEX,
				DEVICE_IMANUFACTURER_BLENGTH_COUNT => NOT_CONTAINS_DEVICE_IMANUFACTURER_BLENGTH_COUNT,
				DEVICE_IMANUFACTURER_INDEX => NOT_CONTAINS_DEVICE_IMANUFACTURER_INDEX,
				DEVICE_IMANUFACTURER_COUNT => NOT_CONTAINS_DEVICE_IMANUFACTURER_COUNT,
				DEVICE_IPRODUCT_BLENGTH_INDEX => NOT_CONTAINS_DEVICE_IPRODUCT_BLENGTH_INDEX,
				DEVICE_IPRODUCT_BLENGTH_COUNT => NOT_CONTAINS_DEVICE_IPRODUCT_BLENGTH_COUNT,
				DEVICE_IPRODUCT_INDEX => NOT_CONTAINS_DEVICE_IPRODUCT_INDEX,
				DEVICE_IPRODUCT_COUNT => NOT_CONTAINS_DEVICE_IPRODUCT_COUNT,
				DEVICE_ISERIALNUMBER_BLENGTH_INDEX => NOT_CONTAINS_DEVICE_ISERIALNUMBER_BLENGTH_INDEX,
				DEVICE_ISERIALNUMBER_BLENGTH_COUNT => NOT_CONTAINS_DEVICE_ISERIALNUMBER_BLENGTH_COUNT,
				DEVICE_ISERIALNUMBER_INDEX => NOT_CONTAINS_DEVICE_ISERIALNUMBER_INDEX,
				DEVICE_ISERIALNUMBER_COUNT => NOT_CONTAINS_DEVICE_ISERIALNUMBER_COUNT,
				DEVICE_BNUMCONFIGURATIONS_INDEX => NOT_CONTAINS_DEVICE_BNUMCONFIGURATIONS_INDEX,
				DEVICE_BNUMCONFIGURATIONS_COUNT => NOT_CONTAINS_DEVICE_BNUMCONFIGURATIONS_COUNT,
				-- Configuration Descriptor
				CONFIGURATION_BLENGTH_INDEX => NOT_CONTAINS_CONFIGURATION_BLENGTH_INDEX,
				CONFIGURATION_BLENGTH_COUNT => NOT_CONTAINS_CONFIGURATION_BLENGTH_COUNT,
				CONFIGURATION_WTOTALLENGTH_INDEX => NOT_CONTAINS_CONFIGURATION_WTOTALLENGTH_INDEX,
				CONFIGURATION_WTOTALLENGTH_COUNT => NOT_CONTAINS_CONFIGURATION_WTOTALLENGTH_COUNT,
				CONFIGURATION_BNUMINTERFACES_INDEX => NOT_CONTAINS_CONFIGURATION_BNUMINTERFACES_INDEX,
				CONFIGURATION_BNUMINTERFACES_COUNT => NOT_CONTAINS_CONFIGURATION_BNUMINTERFACES_COUNT,
				CONFIGURATION_BCONFIGURATIONVALUE_INDEX => NOT_CONTAINS_CONFIGURATION_BCONFIGURATIONVALUE_INDEX,
				CONFIGURATION_BCONFIGURATIONVALUE_COUNT => NOT_CONTAINS_CONFIGURATION_BCONFIGURATIONVALUE_COUNT,
				CONFIGURATION_ICONFIGURATION_BLENGTH_INDEX => NOT_CONTAINS_CONFIGURATION_ICONFIGURATION_BLENGTH_INDEX,
				CONFIGURATION_ICONFIGURATION_BLENGTH_COUNT => NOT_CONTAINS_CONFIGURATION_ICONFIGURATION_BLENGTH_COUNT,
				CONFIGURATION_ICONFIGURATION_INDEX => NOT_CONTAINS_CONFIGURATION_ICONFIGURATION_INDEX,
				CONFIGURATION_ICONFIGURATION_COUNT => NOT_CONTAINS_CONFIGURATION_ICONFIGURATION_COUNT,
				CONFIGURATION_BMATTRIBUTES_INDEX => NOT_CONTAINS_CONFIGURATION_BMATTRIBUTES_INDEX,
				CONFIGURATION_BMATTRIBUTES_COUNT => NOT_CONTAINS_CONFIGURATION_BMATTRIBUTES_COUNT,
				CONFIGURATION_BMAXPOWER_INDEX => NOT_CONTAINS_CONFIGURATION_BMAXPOWER_INDEX,
				CONFIGURATION_BMAXPOWER_COUNT => NOT_CONTAINS_CONFIGURATION_BMAXPOWER_COUNT,
				-- Interface Descriptor
				INTERFACE_BLENGTH_INDEX => NOT_CONTAINS_INTERFACE_BLENGTH_INDEX,
				INTERFACE_BLENGTH_COUNT => NOT_CONTAINS_INTERFACE_BLENGTH_COUNT,
				INTERFACE_BINTERFACENUMBER_INDEX => NOT_CONTAINS_INTERFACE_BINTERFACENUMBER_INDEX,
				INTERFACE_BINTERFACENUMBER_COUNT => NOT_CONTAINS_INTERFACE_BINTERFACENUMBER_COUNT,
				INTERFACE_BALTERNATESETTING_INDEX => NOT_CONTAINS_INTERFACE_BALTERNATESETTING_INDEX,
				INTERFACE_BALTERNATESETTING_COUNT => NOT_CONTAINS_INTERFACE_BALTERNATESETTING_COUNT,
				INTERFACE_BNUMENDPOINTS_INDEX => NOT_CONTAINS_INTERFACE_BNUMENDPOINTS_INDEX,
				INTERFACE_BNUMENDPOINTS_COUNT => NOT_CONTAINS_INTERFACE_BNUMENDPOINTS_COUNT,
				INTERFACE_BINTERFACECLASS_INDEX => NOT_CONTAINS_INTERFACE_BINTERFACECLASS_INDEX,
				INTERFACE_BINTERFACECLASS_COUNT => NOT_CONTAINS_INTERFACE_BINTERFACECLASS_COUNT,
				INTERFACE_BINTERFACESUBCLASS_INDEX => NOT_CONTAINS_INTERFACE_BINTERFACESUBCLASS_INDEX,
				INTERFACE_BINTERFACESUBCLASS_COUNT => NOT_CONTAINS_INTERFACE_BINTERFACESUBCLASS_COUNT,
				INTERFACE_BINTERFACEPROTOCOL_INDEX => NOT_CONTAINS_INTERFACE_BINTERFACEPROTOCOL_INDEX,
				INTERFACE_BINTERFACEPROTOCOL_COUNT => NOT_CONTAINS_INTERFACE_BINTERFACEPROTOCOL_COUNT,
				INTERFACE_IINTERFACE_BLENGTH_INDEX => NOT_CONTAINS_INTERFACE_IINTERFACE_BLENGTH_INDEX,
				INTERFACE_IINTERFACE_BLENGTH_COUNT => NOT_CONTAINS_INTERFACE_IINTERFACE_BLENGTH_COUNT,
				INTERFACE_IINTERFACE_INDEX => NOT_CONTAINS_INTERFACE_IINTERFACE_INDEX,
				INTERFACE_IINTERFACE_COUNT => NOT_CONTAINS_INTERFACE_IINTERFACE_COUNT,
				-- HID Descriptor
				HID_BLENGTH_INDEX => NOT_CONTAINS_HID_BLENGTH_INDEX,
				HID_BLENGTH_COUNT => NOT_CONTAINS_HID_BLENGTH_COUNT,
				HID_BCDHID_INDEX => NOT_CONTAINS_HID_BCDHID_INDEX,
				HID_BCDHID_COUNT => NOT_CONTAINS_HID_BCDHID_COUNT,
				HID_BCOUNTRYCODE_INDEX => NOT_CONTAINS_HID_BCOUNTRYCODE_INDEX,
				HID_BCOUNTRYCODE_COUNT => NOT_CONTAINS_HID_BCOUNTRYCODE_COUNT,
				HID_BNUMDESCRIPTORS_INDEX => NOT_CONTAINS_HID_BNUMDESCRIPTORS_INDEX,
				HID_BNUMDESCRIPTORS_COUNT => NOT_CONTAINS_HID_BNUMDESCRIPTORS_COUNT,
				HID_BDESCRIPTORTYPE_INDEX => NOT_CONTAINS_HID_BDESCRIPTORTYPE_INDEX,
				HID_BDESCRIPTORTYPE_COUNT => NOT_CONTAINS_HID_BDESCRIPTORTYPE_COUNT,
				HID_WDESCRIPTORLENGTH_INDEX => NOT_CONTAINS_HID_WDESCRIPTORLENGTH_INDEX,
				HID_WDESCRIPTORLENGTH_COUNT => NOT_CONTAINS_HID_WDESCRIPTORLENGTH_COUNT,
				-- Endpoint Descriptor
				ENDPOINT_BLENGTH_INDEX => NOT_CONTAINS_ENDPOINT_BLENGTH_INDEX,
				ENDPOINT_BLENGTH_COUNT => NOT_CONTAINS_ENDPOINT_BLENGTH_COUNT,
				ENDPOINT_BENDPOINTADDRESS_INDEX => NOT_CONTAINS_ENDPOINT_BENDPOINTADDRESS_INDEX,
				ENDPOINT_BENDPOINTADDRESS_COUNT => NOT_CONTAINS_ENDPOINT_BENDPOINTADDRESS_COUNT,
				ENDPOINT_BMATTRIBUTES_INDEX => NOT_CONTAINS_ENDPOINT_BMATTRIBUTES_INDEX,
				ENDPOINT_BMATTRIBUTES_COUNT => NOT_CONTAINS_ENDPOINT_BMATTRIBUTES_COUNT,
				ENDPOINT_WMAXPACKETSIZE_INDEX => NOT_CONTAINS_ENDPOINT_WMAXPACKETSIZE_INDEX,
				ENDPOINT_WMAXPACKETSIZE_COUNT => NOT_CONTAINS_ENDPOINT_WMAXPACKETSIZE_COUNT,
				ENDPOINT_BINTERVAL_INDEX => NOT_CONTAINS_ENDPOINT_BINTERVAL_INDEX,
				ENDPOINT_BINTERVAL_COUNT => NOT_CONTAINS_ENDPOINT_BINTERVAL_COUNT,
				-- Device Qualifier Descriptor
				DEVICE_QUALIFIER_BLENGTH_INDEX => NOT_CONTAINS_DEVICE_QUALIFIER_BLENGTH_INDEX,
				DEVICE_QUALIFIER_BLENGTH_COUNT => NOT_CONTAINS_DEVICE_QUALIFIER_BLENGTH_COUNT,
				DEVICE_QUALIFIER_BCDUSB_INDEX => NOT_CONTAINS_DEVICE_QUALIFIER_BCDUSB_INDEX,
				DEVICE_QUALIFIER_BCDUSB_COUNT => NOT_CONTAINS_DEVICE_QUALIFIER_BCDUSB_COUNT,
				DEVICE_QUALIFIER_BDEVICECLASS_INDEX => NOT_CONTAINS_DEVICE_QUALIFIER_BDEVICECLASS_INDEX,
				DEVICE_QUALIFIER_BDEVICECLASS_COUNT => NOT_CONTAINS_DEVICE_QUALIFIER_BDEVICECLASS_COUNT,
				DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX => NOT_CONTAINS_DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX,
				DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT => NOT_CONTAINS_DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT,
				DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX => NOT_CONTAINS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX,
				DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT => NOT_CONTAINS_DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT,
				DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX => NOT_CONTAINS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX,
				DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT => NOT_CONTAINS_DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT,
				DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX => NOT_CONTAINS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX,
				DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT => NOT_CONTAINS_DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT,
				DEVICE_QUALIFIER_BRESERVED_INDEX => NOT_CONTAINS_DEVICE_QUALIFIER_BRESERVED_INDEX,
				DEVICE_QUALIFIER_BRESERVED_COUNT => NOT_CONTAINS_DEVICE_QUALIFIER_BRESERVED_COUNT,
				-- Other Speed Descriptor
				OTHER_SPEED_BLENGTH_INDEX => NOT_CONTAINS_OTHER_SPEED_BLENGTH_INDEX,
				OTHER_SPEED_BLENGTH_COUNT => NOT_CONTAINS_OTHER_SPEED_BLENGTH_COUNT,
				OTHER_SPEED_WTOTALLENGTH_INDEX => NOT_CONTAINS_OTHER_SPEED_WTOTALLENGTH_INDEX,
				OTHER_SPEED_WTOTALLENGTH_COUNT => NOT_CONTAINS_OTHER_SPEED_WTOTALLENGTH_COUNT,
				OTHER_SPEED_BNUMINTERFACES_INDEX => NOT_CONTAINS_OTHER_SPEED_BNUMINTERFACES_INDEX,
				OTHER_SPEED_BNUMINTERFACES_COUNT => NOT_CONTAINS_OTHER_SPEED_BNUMINTERFACES_COUNT,
				OTHER_SPEED_BCONFIGURATIONVALUE_INDEX => NOT_CONTAINS_OTHER_SPEED_BCONFIGURATIONVALUE_INDEX,
				OTHER_SPEED_BCONFIGURATIONVALUE_COUNT => NOT_CONTAINS_OTHER_SPEED_BCONFIGURATIONVALUE_COUNT,
				OTHER_SPEED_ICONFIGURATION_BLENGTH_INDEX => NOT_CONTAINS_OTHER_SPEED_ICONFIGURATION_BLENGTH_INDEX,
				OTHER_SPEED_ICONFIGURATION_BLENGTH_COUNT => NOT_CONTAINS_OTHER_SPEED_ICONFIGURATION_BLENGTH_COUNT,
				OTHER_SPEED_ICONFIGURATION_INDEX => NOT_CONTAINS_OTHER_SPEED_ICONFIGURATION_INDEX,
				OTHER_SPEED_ICONFIGURATION_COUNT => NOT_CONTAINS_OTHER_SPEED_ICONFIGURATION_COUNT,
				OTHER_SPEED_BMATTRIBUTES_INDEX => NOT_CONTAINS_OTHER_SPEED_BMATTRIBUTES_INDEX,
				OTHER_SPEED_BMATTRIBUTES_COUNT => NOT_CONTAINS_OTHER_SPEED_BMATTRIBUTES_COUNT,
				OTHER_SPEED_BMAXPOWER_INDEX => NOT_CONTAINS_OTHER_SPEED_BMAXPOWER_INDEX,
				OTHER_SPEED_BMAXPOWER_COUNT => NOT_CONTAINS_OTHER_SPEED_BMAXPOWER_COUNT
			)
			PORT MAP (
				i_sys_clock => i_sys_clock,
				i_enable => i_enable,
				i_descriptor_field => i_descriptor_field,
				i_descriptor_field_available => i_descriptor_field_available,
				i_descriptor_value => i_descriptor_value,
				i_descriptor_value_en => i_descriptor_value_en,
				i_descriptor_value_total_part_number => i_descriptor_value_total_part_number,
				i_descriptor_value_part_number => i_descriptor_value_part_number,
				i_descriptor_value_new_part => i_descriptor_value_new_part,
				o_descriptor_value_next_part_request => operators_next_part_request(NOT_CONTAINS_OPERATOR_INDEX),
				o_ready => operators_ready(NOT_CONTAINS_OPERATOR_INDEX),
				o_result => operators_result(NOT_CONTAINS_OPERATOR_INDEX)
		);
	end generate;

	--------------------------
	-- Operator Accumulator --
	--------------------------
	operatorAccumulator_inst: OperatorAccumulator
		GENERIC MAP (
			OPERATORS_NUMBER => TOTAL_OPERATORS_NUMBER,
			WATCHDOG_LIMIT => WATCHDOG_LIMIT
		)

		PORT MAP (
			i_sys_clock => i_sys_clock,
			i_enable => i_enable,
			i_operators_ready => operators_ready,
			i_operators_result => operators_result,
			i_operators_next_part_request => operators_next_part_request,
			o_next_part_request => o_descriptor_value_next_part_request,
			o_ready => o_ready,
			o_result => o_result
    );

end Behavioral;
