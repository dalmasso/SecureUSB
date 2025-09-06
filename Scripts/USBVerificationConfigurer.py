########################################################################
## Engineer:    Dalmasso Loic
## Create Date: 25/07/2025
## Module Name: USBVerificationConfigurer
## Description: USB Verification Configurer Main program
########################################################################

import os
import csv
import time
import math

# USB Descriptors
from DeviceDescriptor import DeviceDescriptor
from ConfigurationDescriptor import ConfigurationDescriptor
from InterfaceDescriptor import InterfaceDescriptor
from HIDDescriptor import HIDDescriptor
from EndpointDescriptor import EndpointDescriptor
from DeviceQualifierDescriptor import DeviceQualifierDescriptor
from OtherSpeedDescriptor import OtherSpeedDescriptor

# Verification Order, Operator & Value
from VerificationOrderEnum import VerificationOrderEnum
from VerificationOperatorEnum import VerificationOperatorEnum
from VerificationValue import VerificationValue

# Source File Manager
from SourceFileManager import SourceFileManager

###########################################
## USB Verification Configurer Constants ##
###########################################

hints = "Hints:\n"\
        "add verification value(s) with specific operator\t\"add  usb_descriptor usb_field operator value [and/or operator value] ... \"\n"\
        "remove verification value(s) mathing value\t\t\"remove usb_descriptor usb_field value [operator]\"\n"\
        "import verification values from file\t\t\t\"import path_to_file\"\n"\
        "export verification values\t\t\t\t\"export [directory_path]\"\n"\
        "show all verification values\t\t\t\t\"summary\"\n"\
        "show Descriptor verification values\t\t\t\"summary [device/configuration/interface/hid/endpoint/deviceQualifier/otherSpeed]\"\n"\
        "show specific Descriptor field verification values\t\"summary usb_descriptor usb_field\"\t\t\n"\
        "quit programm\t\t\t\t\t\t\"quit\"\n\n"

# Import File - Character Comment
IMPORT_COMMENT = "#"

# Original VHDL Source Directory
VHDL_SOURCE_DIR = os.path.abspath(os.path.join(os.getcwd(), os.pardir)) + "/USB-Verifier/Sources/"

# Default Export Directory
DEFAULT_EXPORT_DIR = os.getcwd() + '/Export/'

# Exported Descriptor File
DESCRIPTOR_VALUES_FILENAME = "USBVerificationValues"
DESCRIPTOR_VALUES_FILE_EXTENSION = ".csv"
DESCRIPTOR_VALUES_HEADER_OPERATOR = "Operator"
DESCRIPTOR_VALUES_HEADER_VALUE = "Value"
DESCRIPTOR_VALUES_HEADER_VERIF_LEVEL = "Verification Level"

# Exported Operator Memory Configuration File
OPERATOR_MEM_CONFIG_FILENAME = "OperatorMemoryConfigurations"
OPERATOR_MEM_CONFIG_FILE_EXTENSION = ".csv"
OPERATOR_MEM_CONFIG_HEADER_INDEX = "Index"
OPERATOR_MEM_CONFIG_HEADER_COUNTER = "Counter"
OPERATOR_MEM_CONFIG_ADDR_LENGTH_TITLE = "Required Memory Address Bit Length"
OPERATOR_MEM_CONFIG_ADDR_MAX_INDEX_TITLE = "Memory Address Max Index"
OPERATOR_MEM_CONFIG_ADDR_MAX_COUNT_TITLE = "Memory Address Max Count"

# Exported Operator Memory Values Configuration File
OPERATOR_MEM_VALUES_CONF_DIR = "MemoryExport/"
OPERATOR_MEM_VALUES_CONF_FILE_SUFFIX_NAME = "MemoryFile"
OPERATOR_MEM_VALUES_CONF_FILE_EXTENSION = ".coe"

# Exported Operator Summary File
OPERATOR_SUMMARY_FILENAME = "OperatorsSummary"
OPERATOR_SUMMARY_FILE_EXTENSION = ".csv"
OPERATOR_SUMMARY_HEADER_OPERATOR = "Operators"
OPERATOR_SUMMARY_HEADER_STATUS = "Status"
OPERATOR_SUMMARY_OPERATOR_INUSE_TITLE = "Operators in Use"
OPERATOR_SUMMARY_OPERATOR_AVAILABLE_TITLE = "Operators Available"
OPERATOR_SUMMARY_WATCHDOG_LIMIT_TITLE = "Watchdog Limit (in clock cycles)"

# Exported VHDL Sources
VHDL_EXPORT_DIR = "HDL_Sources/"

###########################################
## USB Verification Configurer Variables ##
###########################################

# Device Descriptor
deviceDescriptor = DeviceDescriptor()

# Configuration Descriptor
configurationDescriptor = ConfigurationDescriptor()

# Interface Descriptor
interfaceDescriptor = InterfaceDescriptor()

# HID Descriptor
hidDescriptor = HIDDescriptor()

# Endpoint Descriptor
endpointDescriptor = EndpointDescriptor()

# Device Qualifier Descriptor
deviceQualifierDescriptor = DeviceQualifierDescriptor()

# Other Speed Descriptor
otherSpeedDescriptor = OtherSpeedDescriptor()

# Exported Values Status
requiredExportValue = False

#########################################
## USB Verification Configurer Methods ##
#########################################

### Clear Console ###
def clearConsole():
    clear = lambda: os.system('clear')
    clear()

### Get Descriptor from Descriptor Name ###
def getDescriptor(userInputValue):

    # Device Descriptor
    if (deviceDescriptor.isRequestedDescriptor(userInputValue)):
        return deviceDescriptor

    # Configuration Descriptor
    if (configurationDescriptor.isRequestedDescriptor(userInputValue)):
        return configurationDescriptor

    # Interface Descriptor
    if (interfaceDescriptor.isRequestedDescriptor(userInputValue)):
        return interfaceDescriptor
    
    # HID Descriptor
    if (hidDescriptor.isRequestedDescriptor(userInputValue)):
        return hidDescriptor

    # Endpoint Descriptor
    if (endpointDescriptor.isRequestedDescriptor(userInputValue)):
        return endpointDescriptor

    # Device Qualifier Descriptor
    if (deviceQualifierDescriptor.isRequestedDescriptor(userInputValue)):
        return deviceQualifierDescriptor

    # Other Speed Descriptor
    if (otherSpeedDescriptor.isRequestedDescriptor(userInputValue)):
        return otherSpeedDescriptor

    # No Descriptor
    raise Exception("Unkown USB Descriptor with name " + str(userInputValue))

### Add Verification Values ###
def addVerificationValues(userInputValues):

    # Get Descriptor
    descriptor = getDescriptor(userInputValues[0])

    # USB Field
    usbField = userInputValues[1]

    # Verify User Input Values
    if (len(userInputValues[2:]) < 2):
        raise Exception("Missing element !\n")

    # Parse remaining elements
    for i in range(2, len(userInputValues[2:]), 2):

        ## First Round ##
        if (i == 2):

            # Extract Operator
            operator = userInputValues[i]

            # Verification Value
            value = userInputValues[i+1]

            # Verificarion Level
            if (i+2 > len(userInputValues[2:])):
                verificationLevel = None
            else:
                verificationLevel = userInputValues[i+2]

        ## Next Round ##
        else:

            # Verify User Input Values
            if (len(userInputValues[i:]) < 3):
                raise Exception("Missing element !\n")

            # Verificarion Level
            verificationLevel = userInputValues[i]

            # Extract Operator
            operator = userInputValues[i+1]

            # Verification Value
            value = userInputValues[i+2]

        # Add Description Verification Value
        descriptor.addVerificationValue(usbField, value, verificationLevel, operator)

### Remove Verification Values ###
def removeVerificationValues(userInputValues):

    # Get Descriptor
    descriptor = getDescriptor(userInputValues[0])

    # USB Field
    usbField = userInputValues[1]

    # Value to Remove
    value = userInputValues[2]

    # Operator (optional)
    if (len(userInputValues) > 3):
        operator = userInputValues[3]
    else:
        operator = None

    # Remove Verification Value
    descriptor.deleteVerificationValue(usbField, value, operator)

### Import Verification Values from file ###
def importVerificationValues(userInputValues):

    # Get Import File
    importFile = userInputValues[0]

    # Read File Line by Line
    with open(importFile, 'r') as file:
        for line in file:
            # Remove Empty & Comment Line
            if line.strip() and not line.startswith(IMPORT_COMMENT):
                userInputHandler(line)

### Export Verification Values ###
def exportVerificationValues(userInputValues):

    # Default Export Directory
    exportDir = DEFAULT_EXPORT_DIR

    # Check Input Type
    if (isinstance(userInputValues, list)):

        # Get Export Directory
        if (len(userInputValues) > 0):
            # User Directory
            exportDir = userInputValues[0]

    elif (isinstance(userInputValues, str)):
        # Get Export Directory
        if (len(userInputValues) > 0):
            # User Directory
            exportDir = userInputValues

    # Check if Export Directory Ends with '/'
    if (exportDir.endswith('/') == False):
        exportDir += '/'

    # Check if Export Directory Exists
    if (os.path.exists(exportDir)):
        # Rename old Directory
        commonCreationDate = time.strptime(time.ctime(os.path.getctime(exportDir)))
        newDirName = exportDir[:-1] + "_" + time.strftime('%Y-%m-%d-%H:%M:%S', commonCreationDate) + '/'
        os.rename(exportDir, newDirName)

    # Create Directory
    os.makedirs(exportDir)

    # Export New Descriptor Verification Values
    # Return: Dict {Descriptor Name: Enable/Disable}
    descriptorEnables = exportDescriptorVerificationValues(exportDir)

    # Export New Operator Memory Configurations (Indexes & Values)
    # Return: Dict { OperatorName: (List[(Descriptor, USB Field, Index, Counter)], Required Memory Address Bit Length, Max Index, Max Counter, Total Index)}
    operatorConfig = exportOperatorMemoryConfigurations(exportDir)

    # Export Operator Memory Values Configurations
    # Input: List[(OperatorName, Depth)]
    # Return: Dict {OperatorName, List[MemoryValues]}
    memoryValues = exportOperatorMemoryValuesConfigurations(exportDir, [(el, operatorConfig[el][4]) for el in operatorConfig])

    # Export New Operator Summary
    # Return: (Dict {OperatorName, Enable/Disable}, Watchdog Limit)
    operatorSummary = exportOperatorSummary(exportDir)

    # Export New Operator VHDL Sources
    # Operator Config Input: Dict { OperatorName: (List[(Descriptor, USB Field, Index, Counter)], Required Memory Address Bit Length, Max Index, Max Counter, Total Index)}
    # Memory Values Input: Dict {OperatorName, List[MemoryValues]}
    # Operator Summary Input: (Dict {OperatorName, Enable/Disable}, Watchdog Limit)
    exportVHDLSources(exportDir, operatorConfig, memoryValues, operatorSummary)

### Export Descriptor Verification Values ###
### Return: Dict {Descriptor Name: Enable/Disable}
def exportDescriptorVerificationValues(exportDir):

    # Export Descriptor Values File
    with open(exportDir + DESCRIPTOR_VALUES_FILENAME + DESCRIPTOR_VALUES_FILE_EXTENSION, 'w', encoding='UTF8', newline='') as csvfile:
        fileWriter = csv.writer(csvfile)
        
        # Device Descriptor
        fileWriter.writerow(["Device Descriptor Fields", DESCRIPTOR_VALUES_HEADER_OPERATOR, DESCRIPTOR_VALUES_HEADER_VALUE, DESCRIPTOR_VALUES_HEADER_VERIF_LEVEL])
        for el in deviceDescriptor.getVerificationValues():
            fileWriter.writerow(el)
        
        # Write Empty Line
        fileWriter.writerow(["", "", "", ""])

        # Configuration Descriptor
        fileWriter.writerow(["Configuration Descriptor Fields", DESCRIPTOR_VALUES_HEADER_OPERATOR, DESCRIPTOR_VALUES_HEADER_VALUE, DESCRIPTOR_VALUES_HEADER_VERIF_LEVEL])
        for el in configurationDescriptor.getVerificationValues():
            fileWriter.writerow(el)

        # Write Empty Line
        fileWriter.writerow(["", "", "", ""])

        # Interface Descriptor
        fileWriter.writerow(["Interface Descriptor Fields", DESCRIPTOR_VALUES_HEADER_OPERATOR, DESCRIPTOR_VALUES_HEADER_VALUE, DESCRIPTOR_VALUES_HEADER_VERIF_LEVEL])
        for el in interfaceDescriptor.getVerificationValues():
            fileWriter.writerow(el)
    
        # Write Empty Line
        fileWriter.writerow(["", "", "", ""])

        # HID Descriptor
        fileWriter.writerow(["HID Descriptor Fields", DESCRIPTOR_VALUES_HEADER_OPERATOR, DESCRIPTOR_VALUES_HEADER_VALUE, DESCRIPTOR_VALUES_HEADER_VERIF_LEVEL])
        for el in hidDescriptor.getVerificationValues():
            fileWriter.writerow(el)

        # Write Empty Line
        fileWriter.writerow(["", "", "", ""])

        # Endpoint Descriptor
        fileWriter.writerow(["Endpoint Descriptor Fields", DESCRIPTOR_VALUES_HEADER_OPERATOR, DESCRIPTOR_VALUES_HEADER_VALUE, DESCRIPTOR_VALUES_HEADER_VERIF_LEVEL])
        for el in endpointDescriptor.getVerificationValues():
            fileWriter.writerow(el)

        # Write Empty Line
        fileWriter.writerow(["", "", "", ""])

        # Device Qualifier Descriptor
        fileWriter.writerow(["Device Qualifier Descriptor Fields", DESCRIPTOR_VALUES_HEADER_OPERATOR, DESCRIPTOR_VALUES_HEADER_VALUE, DESCRIPTOR_VALUES_HEADER_VERIF_LEVEL])
        for el in deviceQualifierDescriptor.getVerificationValues():
            fileWriter.writerow(el)
        
        # Write Empty Line
        fileWriter.writerow(["", "", "", ""])

        # Other Speed Descriptor
        fileWriter.writerow(["Other Speed Descriptor Fields", DESCRIPTOR_VALUES_HEADER_OPERATOR, DESCRIPTOR_VALUES_HEADER_VALUE, DESCRIPTOR_VALUES_HEADER_VERIF_LEVEL])
        for el in otherSpeedDescriptor.getVerificationValues():
            fileWriter.writerow(el)

        # Write Empty Line
        fileWriter.writerow(["", "", "", ""])

        # Extract Descriptor Enables
        return extractDescriptorEnable()

### Extract Descriptor Enable ###
# Return: Dict {Descriptor Name: Enable/Disable}
def extractDescriptorEnable():
    descriptorEnables = {}

    # Disable all Descriptors
    descriptorEnables.update({deviceDescriptor.DESCRIPTOR_NAME: False})
    descriptorEnables.update({configurationDescriptor.DESCRIPTOR_NAME: False})
    descriptorEnables.update({interfaceDescriptor.DESCRIPTOR_NAME: False})
    descriptorEnables.update({hidDescriptor.DESCRIPTOR_NAME: False})
    descriptorEnables.update({endpointDescriptor.DESCRIPTOR_NAME: False})
    descriptorEnables.update({deviceQualifierDescriptor.DESCRIPTOR_NAME: False})
    descriptorEnables.update({otherSpeedDescriptor.DESCRIPTOR_NAME: False})

    # Endpoint Descriptor require Interface/Configuration/Device Descriptors
    if (endpointDescriptor.isDescriptorInUse()):
        descriptorEnables.update({endpointDescriptor.DESCRIPTOR_NAME: True})
        descriptorEnables.update({interfaceDescriptor.DESCRIPTOR_NAME: True})
        descriptorEnables.update({configurationDescriptor.DESCRIPTOR_NAME: True})
        descriptorEnables.update({deviceDescriptor.DESCRIPTOR_NAME: True})

    # HID Descriptor require Interface/Configuration/Device Descriptors
    if (hidDescriptor.isDescriptorInUse()):
        descriptorEnables.update({hidDescriptor.DESCRIPTOR_NAME: True})
        descriptorEnables.update({interfaceDescriptor.DESCRIPTOR_NAME: True})
        descriptorEnables.update({configurationDescriptor.DESCRIPTOR_NAME: True})
        descriptorEnables.update({deviceDescriptor.DESCRIPTOR_NAME: True})

    # Interface Descriptor requires Configuration Descriptor
    if (interfaceDescriptor.isDescriptorInUse()):
        descriptorEnables.update({interfaceDescriptor.DESCRIPTOR_NAME: True})
        descriptorEnables.update({configurationDescriptor.DESCRIPTOR_NAME: True})
        descriptorEnables.update({deviceDescriptor.DESCRIPTOR_NAME: True})

    # Configuration Descriptor requires Device Descriptor
    if (configurationDescriptor.isDescriptorInUse()):
        descriptorEnables.update({configurationDescriptor.DESCRIPTOR_NAME: True})
        descriptorEnables.update({deviceDescriptor.DESCRIPTOR_NAME: True})

    return descriptorEnables

### Export Operator Memory Configurations (Memory Indexes & Values) ###
### Return: Dict { OperatorName: (List[(Descriptor, USB Field, Index, Counter)], Required Memory Address Bit Length, Max Index, Max Counter, Total Index)}
def exportOperatorMemoryConfigurations(exportDir):

    # Export Operator Memory Configuration
    with open(exportDir + OPERATOR_MEM_CONFIG_FILENAME + OPERATOR_MEM_CONFIG_FILE_EXTENSION, 'w', encoding='UTF8', newline='') as csvfile:
        fileWriter = csv.writer(csvfile)

        # Operator Config Dict: { OperatorName: (List[(Descriptor, USB Field, Index, Counter)], Required Memory Address Bit Length, Max Index, Max Counter, Total Index)}
        operatorConfig = {}

        # For each Operator
        for op in VerificationOperatorEnum:

            # Reset Index & Counter
            index = 0
            last_index = 0
            max_index = 0
            max_count = 0

            # Init Operator Config List
            operatorConfigList = []

            # Headers
            fileWriter.writerow([VerificationOperatorEnum.getVerificationOperatorName(op), OPERATOR_MEM_CONFIG_HEADER_INDEX, OPERATOR_MEM_CONFIG_HEADER_COUNTER])

            # Device Descriptor [USB Field, Counter of Operator Value]
            fileWriter.writerow([deviceDescriptor.DESCRIPTOR_NAME, "", ""])
            for el in deviceDescriptor.countPerOperator(op):
                # Check Count Value
                if (el[1] == 0):
                    # No Value, Disable Field (x)
                    fileWriter.writerow([el[0], VerificationValue.getMemoryDisableFieldStr(), el[1]])
                    operatorConfigList.append((deviceDescriptor, el[0], VerificationValue.getMemoryDisableFieldLogic(), el[1]))
                else:
                    # Value, Enable Field
                    fileWriter.writerow([el[0], index, el[1]])
                    operatorConfigList.append((deviceDescriptor, el[0], index, el[1]))

                    # Set Last Index (-1 to handle Index 0)
                    last_index = index + el[1] -1

                    # Set new Max Index
                    max_index = index

                    # Check Max Count Value
                    if (el[1] > max_count):
                        max_count = el[1]
                
                # Increment Index (for Next Value)
                index += el[1]

            fileWriter.writerow(["", "", ""])

            # Configuration Descriptor [USB Field, Counter of Operator Value]
            fileWriter.writerow([configurationDescriptor.DESCRIPTOR_NAME, "", ""])
            for el in configurationDescriptor.countPerOperator(op):
                # Check Count Value
                if (el[1] == 0):
                    # No Value, Disable Field (x)
                    fileWriter.writerow([el[0], VerificationValue.getMemoryDisableFieldStr(), el[1]])
                    operatorConfigList.append((configurationDescriptor, el[0], VerificationValue.getMemoryDisableFieldLogic(), el[1]))

                else:
                    # Value, Enable Field
                    fileWriter.writerow([el[0], index, el[1]])
                    operatorConfigList.append((configurationDescriptor, el[0], index, el[1]))

                    # Set Last Index (-1 to handle Index 0)
                    last_index = index + el[1] -1

                    # Set new Max Index
                    max_index = index

                    # Check Max Count Value
                    if (el[1] > max_count):
                        max_count = el[1]
                
                # Increment Index (for Next Value)
                index += el[1]

            fileWriter.writerow(["", "", ""])

            # Interface Descriptor [USB Field, Counter of Operator Value]
            fileWriter.writerow([interfaceDescriptor.DESCRIPTOR_NAME, "", ""])
            for el in interfaceDescriptor.countPerOperator(op):
                # Check Count Value
                if (el[1] == 0):
                    # No Value, Disable Field (x)
                    fileWriter.writerow([el[0], VerificationValue.getMemoryDisableFieldStr(), el[1]])
                    operatorConfigList.append((interfaceDescriptor, el[0], VerificationValue.getMemoryDisableFieldLogic(), el[1]))

                else:
                    # Value, Enable Field
                    fileWriter.writerow([el[0], index, el[1]])
                    operatorConfigList.append((interfaceDescriptor, el[0], index, el[1]))

                    # Set Last Index (-1 to handle Index 0)
                    last_index = index + el[1] -1

                    # Set new Max Index
                    max_index = index

                    # Check Max Count Value
                    if (el[1] > max_count):
                        max_count = el[1]
                
                # Increment Index (for Next Value)
                index += el[1]

            fileWriter.writerow(["", "", ""])

            # HID Descriptor [USB Field, Counter of Operator Value]
            fileWriter.writerow([hidDescriptor.DESCRIPTOR_NAME, "", ""])
            for el in hidDescriptor.countPerOperator(op):
                # Check Count Value
                if (el[1] == 0):
                    # No Value, Disable Field (x)
                    fileWriter.writerow([el[0], VerificationValue.getMemoryDisableFieldStr(), el[1]])
                    operatorConfigList.append((hidDescriptor, el[0], VerificationValue.getMemoryDisableFieldLogic(), el[1]))

                else:
                    # Value, Enable Field
                    fileWriter.writerow([el[0], index, el[1]])
                    operatorConfigList.append((hidDescriptor, el[0], index, el[1]))

                    # Set Last Index (-1 to handle Index 0)
                    last_index = index + el[1] -1

                    # Set new Max Index
                    max_index = index

                    # Check Max Count Value
                    if (el[1] > max_count):
                        max_count = el[1]
                
                # Increment Index (for Next Value)
                index += el[1]

            fileWriter.writerow(["", "", ""])

            # Endpoint Descriptor [USB Field, Counter of Operator Value]
            fileWriter.writerow([endpointDescriptor.DESCRIPTOR_NAME, "", ""])
            for el in endpointDescriptor.countPerOperator(op):
                # Check Count Value
                if (el[1] == 0):
                    # No Value, Disable Field (x)
                    fileWriter.writerow([el[0], VerificationValue.getMemoryDisableFieldStr(), el[1]])
                    operatorConfigList.append((endpointDescriptor, el[0], VerificationValue.getMemoryDisableFieldLogic(), el[1]))

                else:
                    # Value, Enable Field
                    fileWriter.writerow([el[0], index, el[1]])
                    operatorConfigList.append((endpointDescriptor, el[0], index, el[1]))

                    # Set Last Index (-1 to handle Index 0)
                    last_index = index + el[1] -1

                    # Set new Max Index
                    max_index = index

                    # Check Max Count Value
                    if (el[1] > max_count):
                        max_count = el[1]
                
                # Increment Index (for Next Value)
                index += el[1]

            fileWriter.writerow(["", "", ""])

            # Device Qualifier Descriptor [USB Field, Counter of Operator Value]
            fileWriter.writerow([deviceQualifierDescriptor.DESCRIPTOR_NAME, "", ""])
            for el in deviceQualifierDescriptor.countPerOperator(op):
                # Check Count Value
                if (el[1] == 0):
                    # No Value, Disable Field (x)
                    fileWriter.writerow([el[0], VerificationValue.getMemoryDisableFieldStr(), el[1]])
                    operatorConfigList.append((deviceQualifierDescriptor, el[0], VerificationValue.getMemoryDisableFieldLogic(), el[1]))
                else:
                    # Value, Enable Field
                    fileWriter.writerow([el[0], index, el[1]])
                    operatorConfigList.append((deviceQualifierDescriptor, el[0], index, el[1]))

                    # Set Last Index (-1 to handle Index 0)
                    last_index = index + el[1] -1

                    # Set new Max Index
                    max_index = index

                    # Check Max Count Value
                    if (el[1] > max_count):
                        max_count = el[1]
                
                # Increment Index (for Next Value)
                index += el[1]

            fileWriter.writerow(["", "", ""])

            # Other Speed Descriptor [USB Field, Counter of Operator Value]
            fileWriter.writerow([otherSpeedDescriptor.DESCRIPTOR_NAME, "", ""])
            for el in otherSpeedDescriptor.countPerOperator(op):
                # Check Count Value
                if (el[1] == 0):
                    # No Value, Disable Field (x)
                    fileWriter.writerow([el[0], VerificationValue.getMemoryDisableFieldStr(), el[1]])
                    operatorConfigList.append((otherSpeedDescriptor, el[0], VerificationValue.getMemoryDisableFieldLogic(), el[1]))
                else:
                    # Value, Enable Field
                    fileWriter.writerow([el[0], index, el[1]])
                    operatorConfigList.append((otherSpeedDescriptor, el[0], index, el[1]))

                    # Set Last Index (-1 to handle Index 0)
                    last_index = index + el[1] -1

                    # Set new Max Index
                    max_index = index

                    # Check Max Count Value
                    if (el[1] > max_count):
                        max_count = el[1]
                
                # Increment Index (for Next Value)
                index += el[1]

            fileWriter.writerow(["", "", ""])

            # Operator Memory Address Bit Length
            if (last_index <= 1):
                memAddrBitLength = 1
            else:
                memAddrBitLength = math.ceil(math.log2(last_index+1))
            fileWriter.writerow([OPERATOR_MEM_CONFIG_ADDR_LENGTH_TITLE, memAddrBitLength, ""])

            # Operator Memory Address Max Index
            fileWriter.writerow([OPERATOR_MEM_CONFIG_ADDR_MAX_INDEX_TITLE, max_index, ""])

            # Operator Memory Address Max Count
            fileWriter.writerow([OPERATOR_MEM_CONFIG_ADDR_MAX_COUNT_TITLE, max_count, ""])

            # End of current Operator
            if (VerificationOperatorEnum.getLastVerificationOperatorEnum() != op):
                fileWriter.writerow(["", "", ""])
                fileWriter.writerow(["", "", ""])

            # Update Operator Config
            operatorConfig.update({VerificationOperatorEnum.getVerificationOperatorName(op): (operatorConfigList, memAddrBitLength, max_index, max_count, index)})

        # Return Operator Config
        return operatorConfig

### Export Operator Memory Values Configurations ###
### Input: List[(OperatorName, Depth)]
### Return: Dict {OperatorName, List[MemoryValues]}
def exportOperatorMemoryValuesConfigurations(exportDir, operatorConfigList):

    # Create Memory Export Directory
    os.makedirs(exportDir + OPERATOR_MEM_VALUES_CONF_DIR)

    # Operator Memory Values: Dict {OperatorName, List[MemoryValues]}
    operatorMemValues = {}

    # For each Operator Config List element
    for op in operatorConfigList:

        # Operator[0]: OperatorName
        # Operator[1]: OperatorDepth
        operatorName = op[0]
        operatorDepth = op[1]
        operator = VerificationOperatorEnum.getVerificationOperatorEnum(op[0])

        # Create Operator Memory Values Configuration File
        opMemFileName = exportDir + OPERATOR_MEM_VALUES_CONF_DIR + operatorName + OPERATOR_MEM_VALUES_CONF_FILE_SUFFIX_NAME + OPERATOR_MEM_VALUES_CONF_FILE_EXTENSION
        with open(opMemFileName, 'w') as opMemFile:

            # Write Memory Header
            opMemFile.write(VerificationValue.getMemoryHeader(operatorName, operatorDepth))

            # Memory Values
            valueToWrite = []

            # Device Descriptor
            for el in deviceDescriptor.getConvertedVerificationValues(operator):
                valueToWrite.append(el)

            # Configuration Descriptor
            for el in configurationDescriptor.getConvertedVerificationValues(operator):
                valueToWrite.append(el)

            # Interface Descriptor
            for el in interfaceDescriptor.getConvertedVerificationValues(operator):
                valueToWrite.append(el)

            # HID Descriptor
            for el in hidDescriptor.getConvertedVerificationValues(operator):
                valueToWrite.append(el)

            # Endpoint Descriptor
            for el in endpointDescriptor.getConvertedVerificationValues(operator):
                valueToWrite.append(el)

            # Device Qualifier Descriptor
            for el in deviceQualifierDescriptor.getConvertedVerificationValues(operator):
                valueToWrite.append(el)

            # Other Speed Descriptor
            for el in otherSpeedDescriptor.getConvertedVerificationValues(operator):
                valueToWrite.append(el)

            # Write to Memory Configuration File
            nb_value = len(valueToWrite)
            for i in range(0, nb_value):

                # Memory End of File
                if (i == nb_value-1):
                    opMemFile.write(valueToWrite[i])

                # Memory Value Delimiter
                else:
                    opMemFile.write(valueToWrite[i] + ",\n")

            # Memory End of File
            opMemFile.write(';')

            # Add Memory Values
            operatorMemValues.update({operatorName: valueToWrite})
    
    # Return Operator Memory Values: Dict {OperatorName, List[MemoryValues]}
    return operatorMemValues

### Export Operator Summary ###
### Return: (Dict {OperatorName, Enable/Disable}, Watchdog Limit)
def exportOperatorSummary(exportDir):
    
    # Operator Summary: Dict {OperatorName, Enable/Disable}
    operatorSummary = {}

    # Export Operator Summary
    with open(exportDir + OPERATOR_SUMMARY_FILENAME + OPERATOR_SUMMARY_FILE_EXTENSION, 'w', encoding='UTF8', newline='') as csvfile:
        fileWriter = csv.writer(csvfile)

        # Write Headers
        fileWriter.writerow([OPERATOR_SUMMARY_HEADER_OPERATOR, OPERATOR_SUMMARY_HEADER_STATUS])

        # inUse Operators
        inUseOperators = 0

        # Operator Status (Enable/Disable)
        for op in VerificationOperatorEnum:

            # Check if Operator is used (at least 1)
            isInUse = deviceDescriptor.isOperatorInUse(op) or configurationDescriptor.isOperatorInUse(op) or interfaceDescriptor.isOperatorInUse(op) or hidDescriptor.isOperatorInUse(op) or endpointDescriptor.isOperatorInUse(op) or deviceQualifierDescriptor.isOperatorInUse(op) or otherSpeedDescriptor.isOperatorInUse(op)
            if (isInUse):
                fileWriter.writerow([op.name, VerificationValue.getOperatorEnableStr()])
                inUseOperators += 1
                operatorSummary.update({VerificationOperatorEnum.getVerificationOperatorName(op): VerificationValue.getOperatorEnableLogic()})
            else:
                fileWriter.writerow([op.name, VerificationValue.getOperatorDisableStr()])
                operatorSummary.update({VerificationOperatorEnum.getVerificationOperatorName(op): VerificationValue.getOperatorDisableLogic()})

        # Operators in Use & Operators Available Summary
        fileWriter.writerow(["", ""])
        fileWriter.writerow([OPERATOR_SUMMARY_OPERATOR_INUSE_TITLE, inUseOperators])
        fileWriter.writerow([OPERATOR_SUMMARY_OPERATOR_AVAILABLE_TITLE, VerificationOperatorEnum.getVerificationOperatorNumber()])

        # Compute Operator Watchdog (common for all Operators)
        # Overall Watchdog Limit = Largest Verification Number of Value Part x Watchdog Limit per Verification
        largestVerifNumber = 1

        # Device Descriptor
        largestVerifNumber = deviceDescriptor.getLargestVerificationNumber(largestVerifNumber)

        # Configuration Descriptor
        largestVerifNumber = configurationDescriptor.getLargestVerificationNumber(largestVerifNumber)

        # Interface Descriptor
        largestVerifNumber = interfaceDescriptor.getLargestVerificationNumber(largestVerifNumber)
        
        # HID Descriptor
        largestVerifNumber = hidDescriptor.getLargestVerificationNumber(largestVerifNumber)
    
        # Endpoint Descriptor
        largestVerifNumber = endpointDescriptor.getLargestVerificationNumber(largestVerifNumber)

        # Device Qualifier Descriptor
        largestVerifNumber = deviceQualifierDescriptor.getLargestVerificationNumber(largestVerifNumber)

        # Other Speed Descriptor
        largestVerifNumber = otherSpeedDescriptor.getLargestVerificationNumber(largestVerifNumber)

        # Operator Watchdog Limit
        watchdogLimit = largestVerifNumber * VerificationValue.getOperatorWatchdogLimit()
        fileWriter.writerow([OPERATOR_SUMMARY_WATCHDOG_LIMIT_TITLE, watchdogLimit])

    # Return: (Dict {OperatorName, Enable/Disable}, Watchdog Limit)
    return (operatorSummary, watchdogLimit)

### Export VHDL Sources ###
### Operator Config Input: Dict { Operator: (List[(Descriptor, USB Field, Index, Counter)], Required Memory Address Bit Length, Max Index, Max Counter, Total Index)}
### Memory Values Input: Dict {OperatorName, List[MemoryValues]}
### Operator Summary Input: (Dict {OperatorName, Enable/Disable}, Watchdog Limit)
def exportVHDLSources(exportDir, operatorConfig, memoryValues, operatorSummary):

    # Set VHDL Sources Directory
    exportSourceDir = exportDir + VHDL_EXPORT_DIR

    # Source File Manager Instance
    sourceFileManager = SourceFileManager(exportSourceDir)

    # Copy all VHDL Sources Files of USB Verifier
    sourceFileManager.copySourceFiles(VHDL_SOURCE_DIR)

    # Generate Memory VHDL Sources Files
    sourceFileManager.generateSourceFiles(VerificationOperatorEnum.getVerificationOperatorEnumNames())

    # Configure Memory VHDL Sources Files
    for mem in memoryValues:
        sourceFileManager.configureMemorySourceFiles(mem, memoryValues[mem])
    
    # Configure USB Verifier
    sourceFileManager.configureUSBVerifierSourceFile(operatorConfig, operatorSummary)

### Summary Verification Values ###
def summaryVerificationValues(userInputValues):

    # Summary of All Verification Values
    if (len(userInputValues) == 0):
        deviceDescriptor.displayAllVerificationValues()
        configurationDescriptor.displayAllVerificationValues()
        interfaceDescriptor.displayAllVerificationValues()
        hidDescriptor.displayAllVerificationValues()
        endpointDescriptor.displayAllVerificationValues()
        deviceQualifierDescriptor.displayAllVerificationValues()
        otherSpeedDescriptor.displayAllVerificationValues()

    else:

        # Get Descriptor
        descriptor = getDescriptor(userInputValues[0])

        # Summary of Descriptor
        if (len(userInputValues) == 1):
            descriptor.displayAllVerificationValues()
        
        # Summary of Specific Descriptor USB Field
        else:
            descriptor.displayVerificationValues(userInputValues[1])

### Quit Program ###
def quitProgram(requiredExportValue):

    # Some Verification Values are not exported (require Export)
    if (requiredExportValue == True):
        nextStep = False
        userExportOrder = False
        print("Some of Verification Values are not exported (May override previously files)")
        while (nextStep == False):

            userInput = input("Do you want to export them ? [Y/N]")

            if (userInput.casefold() in ['yes', 'y']):
                userExportOrder = True
                nextStep = True
            elif (userInput.casefold() in ['no', 'n']):
                userExportOrder = False
                nextStep = True
            else:
                print("Unknown command")

        # Export Verification Values
        if (userExportOrder == True):
            exportDir = input("Enter directory path to export files (press enter to use default directory: " + DEFAULT_EXPORT_DIR + ")")
            exportVerificationValues(exportDir)

    # Quit Programm
    print("Exiting USB Verification Configurer Program")
    exit()

### User Input Handler ###
def userInputHandler(userInput):

    # Exported Values Status
    global requiredExportValue

    # Split User Input Value
    userInputValues = userInput.split()

    # Process each User Input Values
    try:

        # Extract User Order
        userOrder = VerificationOrderEnum.getVerificationOrderEnum(userInputValues[0])

        # Mode
        match(userOrder):

            # Add Verification Values
            case VerificationOrderEnum.ADD:
                addVerificationValues(userInputValues[1:])
                requiredExportValue = True
                print("Add Process Completed")
                
            # Remove Verification Values
            case VerificationOrderEnum.REMOVE:
                removeVerificationValues(userInputValues[1:])
                requiredExportValue = True
                print("Remove Process Completed")

            # Import Verification Values
            case VerificationOrderEnum.IMPORT:
                importVerificationValues(userInputValues[1:])
                requiredExportValue = True
                print("Import Process Completed")

            # Export Verification Values
            case VerificationOrderEnum.EXPORT:
                exportVerificationValues(userInputValues[1:])
                requiredExportValue = False
                print("Export Process Completed")

            # Summary
            case VerificationOrderEnum.SUMMARY:
                summaryVerificationValues(userInputValues[1:])

            # Hints
            case VerificationOrderEnum.HELP:
                print(hints)

            # Quit
            case _:
                quitProgram(requiredExportValue)

    except IndexError as ie:
        print("Missing element !\n")
    except Exception as e:
        print(e)

#################################
## USB Verification Configurer ##
#################################

if __name__ == '__main__':
    clearConsole()

    print("#########################################")
    print("## USB Verification Configurer Program ##")
    print("#########################################\n")

    # Display Hints
    print(hints)

    # Start USB Verification Configurer
    while(True):

        # User Input & Menu
        userInput = input("\nWrite your command:")

        # Handle User Input
        userInputHandler(userInput)
