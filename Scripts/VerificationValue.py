########################################################################
## Engineer:    Dalmasso Loic
## Create Date: 25/07/2025
## Module Name: VerificationValue
## Description: USB Verification Value Class
########################################################################

import re
import math

from FieldFormatEnum import FieldFormatEnum
from VerificationLevelEnum import VerificationLevelEnum
from VerificationOperatorEnum import VerificationOperatorEnum

class VerificationValue:

    ##################################
    ## Verification Value Constants ##
    ##################################

    # Memory Expected Value Part Number Bit Length
    MEM_VALUE_PART_NUMBER_BIT_LENGTH = 8

    # Memory Expected Value Bit Width & Quartet Enable Bit Length
    MEM_DATA_WIDTH_BIT = 24
    MEM_DATA_QUARTET_ENABLE_BIT_LENGTH = 6

    # Memory Verification Level Bit Length
    MEM_VERIF_LEVEL_BIT_LENGTH = 1

    # Memory Total Width
    MEM_TOTAL_WIDTH = MEM_VALUE_PART_NUMBER_BIT_LENGTH + MEM_DATA_WIDTH_BIT + MEM_DATA_QUARTET_ENABLE_BIT_LENGTH + MEM_VERIF_LEVEL_BIT_LENGTH

    # Memory Value Part Number Format
    MEM_VALUE_PART_NUMBER_BIT_LENGTH_FORMAT = '0' + str(MEM_VALUE_PART_NUMBER_BIT_LENGTH) + 'b'

    # Memory Data Format
    MEM_DATA_BIT_LENGTH_FORMAT = '0' + str(MEM_DATA_WIDTH_BIT) + 'b'

    # Memory String Character Bit Size & Length
    MEM_STRING_CHAR_BIT_LENGTH = 8
    MEM_STRING_CHAR_BIT_LENGTH_FORMAT = '0' + str(MEM_STRING_CHAR_BIT_LENGTH) + 'b'
    MEM_STRING_CHAR_NUMBER = 3

    # Memory Quartet Enable
    MEM_QUARTET_1_ENABLE = '000001'
    MEM_QUARTET_2_ENABLE = '000011'
    MEM_QUARTET_3_ENABLE = '000111'
    MEM_QUARTET_4_ENABLE = '001111'
    MEM_QUARTET_5_ENABLE = '011111'
    MEM_QUARTET_6_ENABLE = '111111'

    # Memory Disable Field
    MEM_DISABLE_FIELD = ['x', 0]

    # Operator Watchdog Limit
    OPERATOR_WATCHDOG_LIMIT_PER_VERIF = 18

    # Operator Enable/Disable
    OPERATOR_ENABLE = ["ENABLE", '1']
    OPERATOR_DISABLE = ["DISABLE", '0']

    ##################################
    ## Verification Value Variables ##
    ##################################

    # Value
    value = ""

    # Value Format
    valueFormat = None

    # Verification Level
    verificationLevel = None

    # Operator
    operator = None

    #######################################
    ## Public Verification Value Methods ##
    #######################################

    ### Constructor (All Args) ###
    def __init__(self, value, maxValueLength, valueFormat, verificationLevel, operator):

        # Check Value & Format
        self.__checkValue(maxValueLength, valueFormat, value)

        # Construct Verification Value
        self.value = value
        self.valueFormat = valueFormat

        # Verification Level
        if (verificationLevel != None):
            self.verificationLevel = VerificationLevelEnum.getVerificationLevelEnum(verificationLevel)
        else:
            self.verificationLevel = VerificationLevelEnum.MANDATORY

        # Operator
        self.operator = VerificationOperatorEnum.getVerificationOperatorEnum(operator)

    ### Display Verification Value ###
    def showDetails(self):
        print("\t", self.operator.name, "\t", self.verificationLevel.name, "\t", self.value)

    ### Get Memory Usage (in Rows) ###
    def getMemoryUsage(self):

        # Value Format
        match self.valueFormat:
            case FieldFormatEnum.NUMBER:
                return 1

            case FieldFormatEnum.HEX:
                return 1

            case FieldFormatEnum.STRING:
                if (len(self.value) <= self.MEM_STRING_CHAR_NUMBER):
                    return 1
                else:
                    # User String Legnth / Memory Data Length
                    return math.ceil(len(self.value) / self.MEM_STRING_CHAR_NUMBER)

            case _:
                raise Exception("Unknown Field Format !")

    ### Convert Verification Value to Memory Configuration ###
    ### Return: List of (Value Part Number, Verification Level, Converted Data Value, Quartet Enable)
    def convertToMemConfig(self):

        # Value Format
        match self.valueFormat:
            case FieldFormatEnum.NUMBER:
                return self.__convertNumberValue()

            case FieldFormatEnum.HEX:
                return self.__convertHexValue()

            case FieldFormatEnum.STRING:
                return self.__convertStringValue()

            case _:
                raise Exception("Unknown Field Format !")

    ##############################################
    ## Public Static Verification Value Methods ##
    ##############################################

    ### Get Operator Watchdog Limit ###
    def getOperatorWatchdogLimit():
        return VerificationValue.OPERATOR_WATCHDOG_LIMIT_PER_VERIF
    
    ### Get Operator Enable String Value ###
    def getOperatorEnableStr():
        return VerificationValue.OPERATOR_ENABLE[0]
    
    ### Get Operator Enable Logical Value ###
    def getOperatorEnableLogic():
        return "\'" + VerificationValue.OPERATOR_ENABLE[1] + "\'"

    ### Get Operator Disable String Value ###
    def getOperatorDisableStr():
        return VerificationValue.OPERATOR_DISABLE[0]

    ### Get Operator Disable Logical Value ###
    def getOperatorDisableLogic():
        return "\'" + VerificationValue.OPERATOR_DISABLE[1] + "\'"

    ### Get Memory Disable Field String Value ###
    def getMemoryDisableFieldStr():
        return VerificationValue.MEM_DISABLE_FIELD[0]

    ### Get Memory Disable Field Logical Value ###
    def getMemoryDisableFieldLogic():
        return VerificationValue.MEM_DISABLE_FIELD[1]

    ### Get Memory File Header ###
    def getMemoryHeader(operatorName, depth):
        return \
            "; Memory Configuration - " + operatorName + " Operator\n" + \
            "; Memory Row Format: Value Part Number (" + str(VerificationValue.MEM_VALUE_PART_NUMBER_BIT_LENGTH) + " bits) - Expected Value (" + str(VerificationValue.MEM_DATA_WIDTH_BIT) + " bits) - Value Quartet Enable (" + str(VerificationValue.MEM_DATA_QUARTET_ENABLE_BIT_LENGTH) + " bits) - Mandatory Level (" + str(VerificationValue.MEM_VERIF_LEVEL_BIT_LENGTH) + " bit)\n" + \
            "; Memory Format: Depth=" + str(depth) + ", Width=" + str(VerificationValue.MEM_TOTAL_WIDTH) + " bits\n" + \
            "MEMORY_INITIALIZATION_RADIX=2;\n" + \
            "MEMORY_INITIALIZATION_VECTOR=\n"

    ### Generate Memory Values ###
    ### Input: List of (Value Part Number, Verification Level, Converted Data Value, Quartet Enable)
    ### Return: Memory Values
    def generateMemoryValues(memoryConfigValues):
        # Order by Value Part Number (Mandatory First, Optional then)
        memoryConfigValues.sort(key=lambda x:(x[0], -x[1]))

        # Generate Memory Values
        memoryValues = []
        for el in memoryConfigValues:
            
            # Converted Memory Value Format: Value Part Number (8 bits) - Expected Value (24 bits) - Quartet Enable (6 bits) - Mandatory Level (1 bit)
            convertedMemoryValue = format(abs(el[0]), VerificationValue.MEM_VALUE_PART_NUMBER_BIT_LENGTH_FORMAT) + el[2] + el[3] + str(el[1])

            # Add Converted Memory Value
            memoryValues.append(convertedMemoryValue)

        # Return Memory Values
        return memoryValues

    ########################################
    ## Private Verification Value Methods ##
    ########################################

    ### Verify User Value Format & Length ###
    def __checkValue(self, maxValueLength, valueFormat, value):
        match valueFormat:
            case FieldFormatEnum.NUMBER:
                self.__checkNumberValue(maxValueLength, value)
            
            case FieldFormatEnum.HEX:
                self.__checkHexValue(maxValueLength, value)

            case FieldFormatEnum.STRING:
                self.__checkStringValue(maxValueLength, value)

            case _:
                raise Exception("Unknown Field Format !")

    ### Verify Number Value ###
    def __checkNumberValue(self, maxValue, value):
        
        # Verify Value format (only number characters)
        if (bool(re.fullmatch(r'^[0-9]+$', value)) == False):
            raise Exception("Wrong value Format ! Must contains only NUMBER values (0-9)!")

        # Verify Max Value
        if (int(value) > maxValue):
            raise Exception("Wrong value " + str(value) + " ! Must be from 0 to " + str(maxValue))

    ### Verify Hex Value ###
    def __checkHexValue(self, maxValueLength, value):

        # Verify Value format (only Hex characters)
        if (bool(re.fullmatch(r'^[0-9a-fA-F]+$', value)) == False):
            raise Exception("Wrong value Format ! Must contains only HEX values (0-9, A-F or a-f)")

        # Verify Value length
        if (len(value) > maxValueLength):
            raise Exception("Wrong value Length of " + str(len(value)) + " ! Must be up to " + str(maxValueLength) + " HEX characters")

    ### Verify String Value ###
    def __checkStringValue(self, maxValueLength, value):
        
        # Verify Value length
        if (len(value) > maxValueLength):
            raise Exception("Wrong value Length of " + str(len(value)) + " ! Must be up to " + str(maxValueLength) + " ASCII characters")

    ### Convert Number Value to Memory Value ###
    ### Return: (Value Part Number, Verification Level, Converted Data Value, Quartet Enable)
    def __convertNumberValue(self):

        # Check Operator
        if (self.operator == VerificationOperatorEnum.ENDSWITH):
            # Value Part Number (always Value Part Number -1)
            valuePartNumber = -1

        # Value Part Number (always Value Part Number 0)
        else:
            valuePartNumber = 0

        # Verification Level
        verifLevel = VerificationLevelEnum.getVerificationLevelMemValue(self.verificationLevel)

        # Converted Data Value
        convertedDataValue = format(int(self.value), self.MEM_DATA_BIT_LENGTH_FORMAT)

        # Quartet Enable (always All Quartet Enable)
        quartetEnable = self.MEM_QUARTET_6_ENABLE

        return [(valuePartNumber, int(verifLevel), convertedDataValue, quartetEnable)]

    ### Convert Hex Value to Memory Value ###
    ### Return: (Value Part Number, Verification Level, Converted Data Value, Quartet Enable)
    def __convertHexValue(self):
        
        # Check Operator
        if (self.operator == VerificationOperatorEnum.ENDSWITH):
            # Value Part Number (always Value Part Number -1)
            valuePartNumber = -1

        # Value Part Number (always Value Part Number 0)
        else:
            valuePartNumber = 0

        # Verification Level
        verifLevel = VerificationLevelEnum.getVerificationLevelMemValue(self.verificationLevel)

        # Converted Data Value
        convertedDataValue = format(int(str(self.value), 16), self.MEM_DATA_BIT_LENGTH_FORMAT)

        # Quartet Enable
        # Check Value Length
        match (len(self.value)):
            
            # Hex Value on 0 quartet: not allowed
            # Hex Value on 1 quartet
            case 1:
                quartetEnable = self.MEM_QUARTET_1_ENABLE

            # Hex Value on 2 quartets
            case 2:
                quartetEnable = self.MEM_QUARTET_2_ENABLE

            # Hex Value on 3 quartets
            case 3:
                quartetEnable = self.MEM_QUARTET_3_ENABLE

            # Hex Value on 4 quartets
            case 4:
                quartetEnable = self.MEM_QUARTET_4_ENABLE

            # Hex Value on 5 quartets
            case 5:
                quartetEnable = self.MEM_QUARTET_5_ENABLE

            # Hex Value on 6 quartets
            case _:
                quartetEnable = self.MEM_QUARTET_6_ENABLE

        return [(valuePartNumber, int(verifLevel), convertedDataValue, quartetEnable)]

    ### Convert String Value to Memory Value ###
    ### Return: (Value Part Number, Verification Level, Converted Data Value, Quartet Enable)
    def __convertStringValue(self):

        # Verification Level (same for all String parts)
        verifLevel = VerificationLevelEnum.getVerificationLevelMemValue(self.verificationLevel)

        # Split String Value in parts
        stringPart = [self.value[i:i+self.MEM_STRING_CHAR_NUMBER] for i in range(0, len(self.value), self.MEM_STRING_CHAR_NUMBER)]

        # Check Operator
        if (self.operator == VerificationOperatorEnum.ENDSWITH):
            # Value Part Number (Negative Order)
            valuePartNumber = -(len(stringPart)-1)

        # Value Part Number (Positive Order)
        else:
            valuePartNumber = 0

        # Convert each String Part
        result = []
        for part in stringPart:

            # Check String Part Length:
            match (len(part)):

                # String Value on 0 character: not allowed
                # String Value on 1 character (Padding + 2 x 4bits)
                case 1:
                    # Converted Data Value
                    convertedDataValue = "0000000000000000" + ''.join(format(ord(char), self.MEM_STRING_CHAR_BIT_LENGTH_FORMAT) for char in part)
                    quartetEnable = self.MEM_QUARTET_2_ENABLE

                # String Value on 2 characters (Padding + 4 x 4bits)
                case 2:
                    # Converted Data Value
                    convertedDataValue = "00000000" + ''.join(format(ord(char), self.MEM_STRING_CHAR_BIT_LENGTH_FORMAT) for char in part)
                    quartetEnable = self.MEM_QUARTET_4_ENABLE

                # String Value on 3 characters (6 x 4bits)
                case _:
                    # Converted Data Value
                    convertedDataValue = ''.join(format(ord(char), self.MEM_STRING_CHAR_BIT_LENGTH_FORMAT) for char in part)
                    quartetEnable = self.MEM_QUARTET_6_ENABLE

            # Append Result
            result.append((valuePartNumber, int(verifLevel), convertedDataValue, quartetEnable))

            # Increment Value Part Number
            valuePartNumber += 1

        # Converted String
        return result
