########################################################################
## Engineer:    Dalmasso Loic
## Create Date: 22/08/2025
## Module Name: SourceFileManager
## Description: USB Verification VHDL Source File Manager
########################################################################

import os
import shutil

# Verification Operator & Value
from VerificationOperatorEnum import VerificationOperatorEnum
from VerificationValue import VerificationValue

class SourceFileManager:

    ###################################
    ## Source File Manager Constants ##
    ###################################

    # VHDL ROM Source File Configs
    VHDL_DUAL_PORT_ROM_TEMPLATE = "DualPortROM.vhd"
    VHDL_DUAL_PORT_ROM_TEMPORARY = "DualPortROM_temp.vhd"
    VHDL_DUAL_PORT_ROM_MEM_ADDR_LENGTH_PATTERN = "MEMORY_ADDR_LENGTH: INTEGER := "
    VHDL_DUAL_PORT_ROM_MEM_DATA_LENGTH_PATTERN = "MEMORY_DATA_LENGTH: INTEGER := "
    VHDL_DUAL_PORT_ROM_START_PATTERN = "-- Start ROM Values"
    VHDL_DUAL_PORT_ROM_END_PATTERN = "-- End ROM Values"
    VHDL_DUAL_PORT_ROM_VALUE_ALIGNEMENT = "	"

    # VHDL USB Verifier Wrapper File Configs
    VHDL_USB_VERIFIER_WRAPPER_FILE_NAME = "USBVerifierWrapper.vhd"
    VHDL_USB_VERIFIER_WRAPPER_TEMPORARY_FILE_NAME = "USBVerifierWrapper_temp.vhd"
    VHDL_USB_VERIFIER_ASSIGNEMENT = "=> "
    VHDL_USB_VERIFIER_VALUE_ALIGNEMENT = "			"
    VHDL_USB_VERIFIER_VALUE_SEPARATOR = ","

    # USB Verifier Operator Enable & Watchdog Limit
    VHDL_USB_VERIFIER_EQUALS_ENABLE_PATTERN = "EQUALS_OPERATOR_ENABLE => "
    VHDL_USB_VERIFIER_NOT_EQUALS_ENABLE_PATTERN = "NOT_EQUALS_OPERATOR_ENABLE => "
    VHDL_USB_VERIFIER_GREATER_ENABLE_PATTERN = "GREATER_OPERATOR_ENABLE => "
    VHDL_USB_VERIFIER_GREATER_EQUALS_ENABLE_PATTERN = "GREATER_EQUALS_OPERATOR_ENABLE => "
    VHDL_USB_VERIFIER_LESS_ENABLE_PATTERN = "LESS_OPERATOR_ENABLE => "
    VHDL_USB_VERIFIER_LESS_EQUALS_ENABLE_PATTERN = "LESS_EQUALS_OPERATOR_ENABLE => "
    VHDL_USB_VERIFIER_STARTS_WITH_ENABLE_PATTERN = "STARTS_WITH_OPERATOR_ENABLE => "
    VHDL_USB_VERIFIER_ENDS_WITH_ENABLE_PATTERN = "ENDS_WITH_OPERATOR_ENABLE => "
    VHDL_USB_VERIFIER_CONTAINS_ENABLE_PATTERN = "CONTAINS_OPERATOR_ENABLE => "
    VHDL_USB_VERIFIER_NOT_CONTAINS_ENABLE_PATTERN = "NOT_CONTAINS_OPERATOR_ENABLE => "
    VHDL_USB_VERIFIER_WATCHDOG_LIMIT_PATTERN = "WATCHDOG_LIMIT => "

    # USB Verifier Operator Configs
    VHDL_USB_VERIFIER_OPERATOR_MEM_ADDR_LENGTH_PATTERN = "_MEMORY_ADDR_LENGTH => "
    VHDL_USB_VERIFIER_OPERATOR_MEM_ADDR_MAX_INDEX_PATTERN = "_MEMORY_ADDR_MAX_INDEX => "
    VHDL_USB_VERIFIER_OPERATOR_MEM_ADDR_MAX_COUNT_PATTERN = "_MEMORY_ADDR_MAX_COUNT => "
    VHDL_USB_VERIFIER_DESC_FIELD_SEPARATOR = "_"
    VHDL_USB_VERIFIER_LAST_DESC_FIELD = "NOT_CONTAINS_STRING_IINTERFACE_COUNT => "

    ###################################
    ## Source File Manager Variables ##
    ###################################

    # Export Directory
    exportDirectory = ""

    ########################################
    ## Public Source File Manager Methods ##
    ########################################

    ### Constructor (All Args) ###
    def __init__(self, exportDirectory):
        self.exportDirectory = exportDirectory

    ### Copy Source Files ###
    def copySourceFiles(self, sourceDir):
        shutil.copytree(sourceDir, self.exportDirectory)    

    ### Generate Specific Source Files ###
    def generateSourceFiles(self, operatorNameList):

        # Duplicate Template File with New File Name List
        for opName in operatorNameList:
            shutil.copy(self.exportDirectory + self.VHDL_DUAL_PORT_ROM_TEMPLATE, self.exportDirectory + opName + self.VHDL_DUAL_PORT_ROM_TEMPLATE)

        # Remove Template File
        os.remove(self.exportDirectory + self.VHDL_DUAL_PORT_ROM_TEMPLATE)

    ### Configure Memory Source Files ###
    ### Memory Values Input: OperatorName, List[MemoryValues]
    def configureMemorySourceFiles(self, operatorName, memoryValues):

        # Special Case: Only 1 Memory Value - Require at least 2
        if (len(memoryValues) == 1):
            validMemoryValues = [memoryValues[0], memoryValues[0]]
        else:
            validMemoryValues = memoryValues

        # Format Memory Values
        formatedMemoryValues = []
        lastMemValue = len(validMemoryValues)
        for i in range(0, lastMemValue):

            # Last Memory Values
            if (i == lastMemValue-1):
                formatedMemoryValues.append(self.VHDL_DUAL_PORT_ROM_VALUE_ALIGNEMENT + "\"" + validMemoryValues[i] + "\"" + "\n")

            # Memory Values
            else:
                formatedMemoryValues.append(self.VHDL_DUAL_PORT_ROM_VALUE_ALIGNEMENT + "\"" + validMemoryValues[i] + "\"" + "," + "\n")

        # Create Temporary Memory Source File to update
        temporaryFileName = self.exportDirectory + operatorName + self.VHDL_DUAL_PORT_ROM_TEMPORARY

        # Open Memory Source File (Original & Temporary Files)
        enableUpdate = False
        skipOldValue = False
        memoryFileName = self.exportDirectory + operatorName + self.VHDL_DUAL_PORT_ROM_TEMPLATE
        with open(memoryFileName, "r") as originalFile, open(temporaryFileName, "w") as updateFile:
            # Read Original File
            for line in originalFile:

                # Detect Memory End Pattern
                if (self.VHDL_DUAL_PORT_ROM_END_PATTERN in line):
                    skipOldValue = False
                
                # Skip Old Value
                elif(enableUpdate):
                    skipOldValue = True

                # Update File
                if (enableUpdate):
                    updateFile.writelines(formatedMemoryValues)

                # Copy Original Line (no modification)
                elif (not(skipOldValue)):
                    updateFile.write(line)

                # Detect Memory Start Pattern (and Memory Value to write)
                if (self.VHDL_DUAL_PORT_ROM_START_PATTERN in line) and len(formatedMemoryValues) > 0:
                    enableUpdate = True
                else:
                    enableUpdate = False
        
        # Replace Original File with the Updated one
        os.replace(temporaryFileName, memoryFileName)

    ### Configure USB Verifier Source File ###
    ### Operator Config Input: Dict { Operator: (List[(Descriptor, USB Field, Index, Counter)], Required Memory Address Bit Length, Max Index, Max Counter, Total Index)}
    ### Operator Summary Input: (Dict {OperatorName, Enable/Disable}, Watchdog Limit)
    def configureUSBVerifierSourceFile(self, operatorConfig, operatorSummary):

        # Operators Configs to Update
        opConfigs = {}

        # Operator Enable & Watchdog
        # Operator Summary Input: (Dict {OperatorName, Enable/Disable}, Watchdog Limit)
        for opName in operatorSummary[0]:

            # Recover Operator
            operator = VerificationOperatorEnum.getVerificationOperatorEnum(opName)

            # Process by Operator
            match operator:

                # Equals
                case VerificationOperatorEnum.EQUALS:
                    opConfigs.update({self.VHDL_USB_VERIFIER_EQUALS_ENABLE_PATTERN: self.VHDL_USB_VERIFIER_EQUALS_ENABLE_PATTERN + operatorSummary[0][opName] + self.VHDL_USB_VERIFIER_VALUE_SEPARATOR + "\n"})

                # Not Equals
                case VerificationOperatorEnum.NOT_EQUALS:
                    opConfigs.update({self.VHDL_USB_VERIFIER_NOT_EQUALS_ENABLE_PATTERN: self.VHDL_USB_VERIFIER_NOT_EQUALS_ENABLE_PATTERN + operatorSummary[0][opName] + self.VHDL_USB_VERIFIER_VALUE_SEPARATOR + "\n"})

                # Greater
                case VerificationOperatorEnum.GREATER:
                    opConfigs.update({self.VHDL_USB_VERIFIER_GREATER_ENABLE_PATTERN: self.VHDL_USB_VERIFIER_GREATER_ENABLE_PATTERN + operatorSummary[0][opName] + self.VHDL_USB_VERIFIER_VALUE_SEPARATOR + "\n"})

                # Greater Equals
                case VerificationOperatorEnum.GREATER_EQUALS:
                    opConfigs.update({self.VHDL_USB_VERIFIER_GREATER_EQUALS_ENABLE_PATTERN: self.VHDL_USB_VERIFIER_GREATER_EQUALS_ENABLE_PATTERN + operatorSummary[0][opName] + self.VHDL_USB_VERIFIER_VALUE_SEPARATOR + "\n"})

                # Less
                case VerificationOperatorEnum.LESS:
                    opConfigs.update({self.VHDL_USB_VERIFIER_LESS_ENABLE_PATTERN: self.VHDL_USB_VERIFIER_LESS_ENABLE_PATTERN + operatorSummary[0][opName] + self.VHDL_USB_VERIFIER_VALUE_SEPARATOR + "\n"})

                # Less Equals
                case VerificationOperatorEnum.LESS_EQUALS:
                    opConfigs.update({self.VHDL_USB_VERIFIER_LESS_EQUALS_ENABLE_PATTERN: self.VHDL_USB_VERIFIER_LESS_EQUALS_ENABLE_PATTERN + operatorSummary[0][opName] + self.VHDL_USB_VERIFIER_VALUE_SEPARATOR + "\n"})

                # Starts With
                case VerificationOperatorEnum.STARTSWITH:
                    opConfigs.update({self.VHDL_USB_VERIFIER_STARTS_WITH_ENABLE_PATTERN: self.VHDL_USB_VERIFIER_STARTS_WITH_ENABLE_PATTERN + operatorSummary[0][opName] + self.VHDL_USB_VERIFIER_VALUE_SEPARATOR + "\n"})

                # Ends With
                case VerificationOperatorEnum.ENDSWITH:
                    opConfigs.update({self.VHDL_USB_VERIFIER_ENDS_WITH_ENABLE_PATTERN: self.VHDL_USB_VERIFIER_ENDS_WITH_ENABLE_PATTERN + operatorSummary[0][opName] + self.VHDL_USB_VERIFIER_VALUE_SEPARATOR + "\n"})

                # Contains
                case VerificationOperatorEnum.CONTAINS:
                    opConfigs.update({self.VHDL_USB_VERIFIER_CONTAINS_ENABLE_PATTERN: self.VHDL_USB_VERIFIER_CONTAINS_ENABLE_PATTERN + operatorSummary[0][opName] + self.VHDL_USB_VERIFIER_VALUE_SEPARATOR + "\n"})

                # Not Contains
                case _:
                    opConfigs.update({self.VHDL_USB_VERIFIER_NOT_CONTAINS_ENABLE_PATTERN: self.VHDL_USB_VERIFIER_NOT_CONTAINS_ENABLE_PATTERN + operatorSummary[0][opName] + self.VHDL_USB_VERIFIER_VALUE_SEPARATOR + "\n"})

        # Watchdog Limit Config
        opConfigs.update({self.VHDL_USB_VERIFIER_WATCHDOG_LIMIT_PATTERN: self.VHDL_USB_VERIFIER_WATCHDOG_LIMIT_PATTERN + str(operatorSummary[1]) + self.VHDL_USB_VERIFIER_VALUE_SEPARATOR + "\n"})

        # Operator Memory & USB Configs
        # Operator Config Input: Dict { OperatorName: (List[(Descriptor Name, USB Field, Index, Counter)], Required Memory Address Bit Length, Max Index, Max Counter, Total Index)}
        for opName in operatorConfig:

            # Recover Operator
            operator = VerificationOperatorEnum.getVerificationOperatorEnum(opName)

            # Memory Config: Address Length
            opConfigs.update({operator.name + self.VHDL_USB_VERIFIER_OPERATOR_MEM_ADDR_LENGTH_PATTERN: operator.name + self.VHDL_USB_VERIFIER_OPERATOR_MEM_ADDR_LENGTH_PATTERN + str(operatorConfig[opName][1]) + self.VHDL_USB_VERIFIER_VALUE_SEPARATOR + "\n"})

            # Memory Config: Address Max Index
            opConfigs.update({operator.name + self.VHDL_USB_VERIFIER_OPERATOR_MEM_ADDR_MAX_INDEX_PATTERN: operator.name + self.VHDL_USB_VERIFIER_OPERATOR_MEM_ADDR_MAX_INDEX_PATTERN + str(operatorConfig[opName][2]) + self.VHDL_USB_VERIFIER_VALUE_SEPARATOR + "\n"})
            
            # Memory Config: Address Max Count
            opConfigs.update({operator.name + self.VHDL_USB_VERIFIER_OPERATOR_MEM_ADDR_MAX_COUNT_PATTERN: operator.name + self.VHDL_USB_VERIFIER_OPERATOR_MEM_ADDR_MAX_COUNT_PATTERN + str(operatorConfig[opName][3]) + self.VHDL_USB_VERIFIER_VALUE_SEPARATOR + "\n"})

            # USB Fields (Index & Counter)
            # List[(Descriptor, USB Field, Index, Counter)]
            for fieldInfo in operatorConfig[opName][0]:

                # Recover Descriptor
                descriptor = fieldInfo[0]

                # Recover Index/Count Pattern
                (indexPattern, countPattern) = descriptor.getSourceIndexCountPattern(fieldInfo[1])

                # USB Field Index
                opConfigs.update({operator.name + self.VHDL_USB_VERIFIER_DESC_FIELD_SEPARATOR + indexPattern: operator.name + self.VHDL_USB_VERIFIER_DESC_FIELD_SEPARATOR + indexPattern + str(fieldInfo[2]) + self.VHDL_USB_VERIFIER_VALUE_SEPARATOR + "\n"})

                # USB Field Count (Verify Last USB Field to Update)
                opConfigCountKey = operator.name + self.VHDL_USB_VERIFIER_DESC_FIELD_SEPARATOR + countPattern
                if (opConfigCountKey != self.VHDL_USB_VERIFIER_LAST_DESC_FIELD):
                    opConfigs.update({opConfigCountKey: opConfigCountKey + str(fieldInfo[3]) + self.VHDL_USB_VERIFIER_VALUE_SEPARATOR + "\n"})
                
                # Last USB Field to Update
                else:
                    opConfigs.update({opConfigCountKey: opConfigCountKey + str(fieldInfo[3]) + "\n"})

        # Update USB Verifier Wrapper Source File
        # Create Temporary Memory Source File to update
        temporaryFileName = self.exportDirectory + self.VHDL_USB_VERIFIER_WRAPPER_TEMPORARY_FILE_NAME

        # Open USB Verifier Wrapper Source File (Original & Temporary Files)
        fileName = self.exportDirectory + self.VHDL_USB_VERIFIER_WRAPPER_FILE_NAME
        with open(fileName, "r") as originalFile, open(temporaryFileName, "w") as updateFile:
            # Read Original File
            for line in originalFile:

                # Strip Line
                cleanLine = line.strip()

                # Get VHDL Assignement Index in Line
                assignIndex = cleanLine.find(self.VHDL_USB_VERIFIER_ASSIGNEMENT)

                # Assignement Detected
                if (assignIndex != -1):

                    # Line to Update
                    lineToUpdate = cleanLine[:assignIndex + len(self.VHDL_USB_VERIFIER_ASSIGNEMENT)]

                    # Detect Line to Update
                    if (lineToUpdate in opConfigs):
                        updateFile.write(self.VHDL_USB_VERIFIER_VALUE_ALIGNEMENT + opConfigs[lineToUpdate])
                    
                    # Copy Original Line (no modification)
                    else:
                        updateFile.write(line)

                # Copy Original Line (no modification)
                else:
                    updateFile.write(line)

        # Replace Original File with the Updated one
        os.replace(temporaryFileName, fileName)
