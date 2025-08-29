########################################################################
## Engineer:    Dalmasso Loic
## Create Date: 25/07/2025
## Module Name: OtherSpeedDescriptor
## Description: USB Configuration Descriptor Class containing fields to verify
########################################################################

import statistics

from FieldFormatEnum import FieldFormatEnum
from VerificationValue import VerificationValue
from VerificationLevelEnum import VerificationLevelEnum

class OtherSpeedDescriptor:

    ######################################
    ## Other Speed Descriptor Constants ##
    ######################################

    # Descriptor Type
    DESCRIPTOR_TYPE = "OtherSpeed"

    # Descriptor Name
    DESCRIPTOR_NAME = "Other Speed Descriptor"

    ######################################
    ## Other Speed Descriptor Variables ##
    ######################################

    # bLength (1 byte)
    bLength = []
    bLengthLength = 255
    bLengthFormat = FieldFormatEnum.NUMBER
    bLengthName = "bLength"
    bLengthMatch = bLengthName.casefold()
    bLengthLastMandatoryValueIndex = 0
    bLengthSourceIndexPattern = "OTHER_SPEED_BLENGTH_INDEX => "
    bLengthSourceCountPattern = "OTHER_SPEED_BLENGTH_COUNT => "

    # wTotalLength (2 bytes)
    wTotalLength = []
    wTotalLengthLength = 65535
    wTotalLengthFormat = FieldFormatEnum.NUMBER
    wTotalLengthName = "wTotalLength"
    wTotalLengthMatch = wTotalLengthName.casefold()
    wTotalLengthLastMandatoryValueIndex = 0
    wTotalLengthSourceIndexPattern = "OTHER_SPEED_WTOTALLENGTH_INDEX => "
    wTotalLengthSourceCountPattern = "OTHER_SPEED_WTOTALLENGTH_COUNT => "
    
    # bNumInterfaces (1 byte)
    bNumInterfaces = []
    bNumInterfacesLength = 255
    bNumInterfacesFormat = FieldFormatEnum.NUMBER
    bNumInterfacesName = "bNumInterfaces"
    bNumInterfacesMatch = bNumInterfacesName.casefold()
    bNumInterfacesLastMandatoryValueIndex = 0
    bNumInterfacesSourceIndexPattern = "OTHER_SPEED_BNUMINTERFACES_INDEX => "
    bNumInterfacesSourceCountPattern = "OTHER_SPEED_BNUMINTERFACES_COUNT => "

    # bConfigurationValue (1 bytes)
    bConfigurationValue = []
    bConfigurationValueLength = 255
    bConfigurationValueFormat = FieldFormatEnum.NUMBER
    bConfigurationValueName = "bConfigurationValue"
    bConfigurationValueMatch = bConfigurationValueName.casefold()
    bConfigurationValueLastMandatoryValueIndex = 0
    bConfigurationValueSourceIndexPattern = "OTHER_SPEED_BCONFIGURATIONVALUE_INDEX => "
    bConfigurationValueSourceCountPattern = "OTHER_SPEED_BCONFIGURATIONVALUE_COUNT => "

    # bmAttributes (1 byte)
    bmAttributes = []
    bmAttributesLength = 2
    bmAttributesFormat = FieldFormatEnum.HEX
    bmAttributesName = "bmAttributes"
    bmAttributesMatch = bmAttributesName.casefold()
    bmAttributesLastMandatoryValueIndex = 0
    bmAttributesSourceIndexPattern = "OTHER_SPEED_BMATTRIBUTES_INDEX => "
    bmAttributesSourceCountPattern = "OTHER_SPEED_BMATTRIBUTES_COUNT => "

    # bMaxPower (1 byte)
    bMaxPower = []
    bMaxPowerLength = 255
    bMaxPowerFormat = FieldFormatEnum.NUMBER
    bMaxPowerName = "bMaxPower"
    bMaxPowerMatch = bMaxPowerName.casefold()
    bMaxPowerLastMandatoryValueIndex = 0
    bMaxPowerSourceIndexPattern = "OTHER_SPEED_BMAXPOWER_INDEX => "
    bMaxPowerSourceCountPattern = "OTHER_SPEED_BMAXPOWER_COUNT => "

    ###########################################
    ## Public Other Speed Descriptor Methods ##
    ###########################################

    ### is Other Speed Descriptor Requested ###
    def isRequestedDescriptor(self, userDescriptor):
        return userDescriptor.casefold() == self.DESCRIPTOR_TYPE.casefold()

    ### Add Verification Value ###
    def addVerificationValue(self, fieldName, value, verificationLevel, operator):
        match fieldName.casefold():

            # bLength
            case self.bLengthMatch:
                # New Value to Add
                newValue = VerificationValue(value, self.bLengthLength, self.bLengthFormat, verificationLevel, operator)

                # Handle Verification Level Priority (Mandatory First)
                if (VerificationLevelEnum.MANDATORY == newValue.verificationLevel):
                    # Add New Mandatory Value
                    self.bLength.insert(self.bLengthLastMandatoryValueIndex, newValue)
                    self.bLengthLastMandatoryValueIndex += 1

                # Optional New Value (add the end of the list)
                else:
                    self.bLength.append(newValue)

            # wTotalLength
            case self.wTotalLengthMatch:
                # New Value to Add
                newValue = VerificationValue(value, self.wTotalLengthLength, self.wTotalLengthFormat, verificationLevel, operator)

                # Handle Verification Level Priority (Mandatory First)
                if (VerificationLevelEnum.MANDATORY == newValue.verificationLevel):
                    # Add New Mandatory Value
                    self.wTotalLength.insert(self.wTotalLengthLastMandatoryValueIndex, newValue)
                    self.wTotalLengthLastMandatoryValueIndex += 1

                # Optional New Value (add the end of the list)
                else:
                    self.wTotalLength.append(newValue)

            # bNumInterfaces
            case self.bNumInterfacesMatch:
                # New Value to Add
                newValue = VerificationValue(value, self.bNumInterfacesLength, self.bNumInterfacesFormat, verificationLevel, operator)

                # Handle Verification Level Priority (Mandatory First)
                if (VerificationLevelEnum.MANDATORY == newValue.verificationLevel):
                    # Add New Mandatory Value
                    self.bNumInterfaces.insert(self.bNumInterfacesLastMandatoryValueIndex, newValue)
                    self.bNumInterfacesLastMandatoryValueIndex += 1

                # Optional New Value (add the end of the list)
                else:
                    self.bNumInterfaces.append(newValue)

            # bConfigurationValue
            case self.bConfigurationValueMatch:
                # New Value to Add
                newValue = VerificationValue(value, self.bConfigurationValueLength, self.bConfigurationValueFormat, verificationLevel, operator)

                # Handle Verification Level Priority (Mandatory First)
                if (VerificationLevelEnum.MANDATORY == newValue.verificationLevel):
                    # Add New Mandatory Value
                    self.bConfigurationValue.insert(self.bConfigurationValueLastMandatoryValueIndex, newValue)
                    self.bConfigurationValueLastMandatoryValueIndex += 1

                # Optional New Value (add the end of the list)
                else:
                    self.bConfigurationValue.append(newValue)

            # bmAttributes
            case self.bmAttributesMatch:
                # New Value to Add
                newValue = VerificationValue(value, self.bmAttributesLength, self.bmAttributesFormat, verificationLevel, operator)

                # Handle Verification Level Priority (Mandatory First)
                if (VerificationLevelEnum.MANDATORY == newValue.verificationLevel):
                    # Add New Mandatory Value
                    self.bmAttributes.insert(self.bmAttributesLastMandatoryValueIndex, newValue)
                    self.bmAttributesLastMandatoryValueIndex += 1

                # Optional New Value (add the end of the list)
                else:
                    self.bmAttributes.append(newValue)

            # bMaxPower
            case self.bMaxPowerMatch:
                # New Value to Add
                newValue = VerificationValue(value, self.bMaxPowerLength, self.bMaxPowerFormat, verificationLevel, operator)

                # Handle Verification Level Priority (Mandatory First)
                if (VerificationLevelEnum.MANDATORY == newValue.verificationLevel):
                    # Add New Mandatory Value
                    self.bMaxPower.insert(self.bMaxPowerLastMandatoryValueIndex, newValue)
                    self.bMaxPowerLastMandatoryValueIndex += 1

                # Optional New Value (add the end of the list)
                else:
                    self.bMaxPower.append(newValue)

            # Unknown Field
            case _:
                raise Exception("Unkown " + self.DESCRIPTOR_NAME + " Field: " + fieldName)

    ### Delete Verification Value ###
    def deleteVerificationValue(self, fieldName, value, operator):
        match fieldName.casefold():

            # bLength
            case self.bLengthMatch:
                if (operator == None):
                    self.bLength = [el for el in self.bLength if el.value != value]
                else:
                    self.bLength = [el for el in self.bLength if el.value != value and el.operator != operator]

            # wTotalLength
            case self.wTotalLengthMatch:
                if (operator == None):
                    self.wTotalLength = [el for el in self.wTotalLength if el.value != value]
                else:
                    self.wTotalLength = [el for el in self.wTotalLength if el.value != value and el.operator != operator]

            # bNumInterfaces
            case self.bNumInterfacesMatch:
                if (operator == None):
                    self.bNumInterfaces = [el for el in self.bNumInterfaces if el.value != value]
                else:
                    self.bNumInterfaces = [el for el in self.bNumInterfaces if el.value != value and el.operator != operator]

            # bConfigurationValue
            case self.bConfigurationValueMatch:
                if (operator == None):
                    self.bConfigurationValue = [el for el in self.bConfigurationValue if el.value != value]
                else:
                    self.bConfigurationValue = [el for el in self.bConfigurationValue if el.value != value and el.operator != operator]

            # bmAttributes
            case self.bmAttributesMatch:
                if (operator == None):
                    self.bmAttributes = [el for el in self.bmAttributes if el.value != value]
                else:
                    self.bmAttributes = [el for el in self.bmAttributes if el.value != value and el.operator != operator]

            # bMaxPower
            case self.bMaxPowerMatch:
                if (operator == None):
                    self.bMaxPower = [el for el in self.bMaxPowerName if el.value != value]
                else:
                    self.bMaxPower = [el for el in self.bMaxPowerName if el.value != value and el.operator != operator]

            # Unknown Field
            case _:
                raise Exception("Unkown " + self.DESCRIPTOR_NAME + " Field: " + fieldName)

    ### Display Descriptor Field Values ###
    def displayVerificationValues(self, fieldName):
        match fieldName.casefold():

            # bLength
            case self.bLengthMatch:
                print(self.bLengthName + ":\n")
                for el in self.bLength: el.showDetails()

            # wTotalLength
            case self.wTotalLengthMatch:
                print(self.wTotalLengthName + ":\n")
                for el in self.wTotalLength: el.showDetails()

            # bNumInterfaces
            case self.bNumInterfacesMatch:
                print(self.bNumInterfacesName + ":\n")
                for el in self.bNumInterfaces: el.showDetails()

            # bConfigurationValue
            case self.bConfigurationValueMatch:
                print(self.bConfigurationValueName + ":\n")
                for el in self.bConfigurationValue: el.showDetails()

            # bmAttributes
            case self.bmAttributesMatch:
                print(self.bmAttributesName + ":\n")
                for el in self.bmAttributes: el.showDetails()

            # bMaxPower
            case self.bMaxPowerMatch:
                print(self.bMaxPowerName + ":\n")
                for el in self.bMaxPower: el.showDetails()

            # Unknown Field
            case _:
                raise Exception("Unkown " + self.DESCRIPTOR_NAME + " Field: " + fieldName)

    ### Print All Device Descriptor Field Values ###
    def displayAllVerificationValues(self):
        print("---", self.DESCRIPTOR_NAME, "---")

        # bLength
        self.displayVerificationValues(self.bLengthName)

        # wTotalLength
        self.displayVerificationValues(self.wTotalLengthName)

        # bNumInterfaces
        self.displayVerificationValues(self.bNumInterfacesName)

        # bConfigurationValue
        self.displayVerificationValues(self.bConfigurationValueName)

        # bmAttributes
        self.displayVerificationValues(self.bmAttributesName)

        # bMaxPower
        self.displayVerificationValues(self.bMaxPowerName)

    ### Get Verification Values ###
    ### Return: [ [USB Field, Operator, Value, Verification Level] ]
    def getVerificationValues(self):
        valueList = []

        # bength
        for el in self.bLength:
            valueList.append([self.bLengthName, el.operator.name.capitalize(), el.value, el.verificationLevel.name])

        # wTotalLength
        for el in self.wTotalLength:
            valueList.append([self.wTotalLengthName, el.operator.name.capitalize(), el.value, el.verificationLevel.name])

        # bNumInterfaces
        for el in self.bNumInterfaces:
            valueList.append([self.bNumInterfacesName, el.operator.name.capitalize(), el.value, el.verificationLevel.name])

        # bConfigurationValue
        for el in self.bConfigurationValue:
            valueList.append([self.bConfigurationValueName, el.operator.name.capitalize(), el.value, el.verificationLevel.name])

        # bmAttributes
        for el in self.bmAttributes:
            valueList.append([self.bmAttributesName, el.operator.name.capitalize(), el.value, el.verificationLevel.name])

        # bMaxPower
        for el in self.bMaxPower:
            valueList.append([self.bMaxPowerName, el.operator.name.capitalize(), el.value, el.verificationLevel.name])

        return valueList

    ### Count Descriptor Field by Name & Operator ###
    ### Return: [USB Field, Counter of Operator Value]
    def countPerOperator(self, operator):
        count = 0
        result = []

        # bLength
        for el in self.bLength:
            if (operator == el.operator):
                count += el.getMemoryUsage()

        # Add Result & Reset Counter
        result.append([self.bLengthName, count])
        count = 0

        # wTotalLength
        for el in self.wTotalLength:
            if (operator == el.operator):
                count += el.getMemoryUsage()

        # Add Result & Reset Counter
        result.append([self.wTotalLengthName, count])
        count = 0

        # bNumInterfaces
        for el in self.bNumInterfaces:
            if (operator == el.operator):
                count += el.getMemoryUsage()

        # Add Result & Reset Counter
        result.append([self.bNumInterfacesName, count])
        count = 0

        # bConfigurationValue
        for el in self.bConfigurationValue:
            if (operator == el.operator):
                count += el.getMemoryUsage()

        # Add Result & Reset Counter
        result.append([self.bConfigurationValueName, count])
        count = 0

        # bmAttributes
        for el in self.bmAttributes:
            if (operator == el.operator):
                count += el.getMemoryUsage()

        # Add Result & Reset Counter
        result.append([self.bmAttributesName, count])
        count = 0

        # bMaxPower
        for el in self.bMaxPower:
            if (operator == el.operator):
                count += el.getMemoryUsage()

        # Add Result & Reset Counter
        result.append([self.bMaxPowerName, count])
    
        # End of Process
        return result

    ### Check if Operator is used by the Descriptor (at least once) ###
    ### Return: True/False
    def isOperatorInUse(self, operator):

        # bLength
        for el in self.bLength:
            if (operator == el.operator):
                return True

        # wTotalLength
        for el in self.wTotalLength:
            if (operator == el.operator):
                return True

        # bNumInterfaces
        for el in self.bNumInterfaces:
            if (operator == el.operator):
                return True

        # bConfigurationValue
        for el in self.bConfigurationValue:
            if (operator == el.operator):
                return True

        # bmAttributes
        for el in self.bmAttributes:
            if (operator == el.operator):
                return True

        # bMaxPower
        for el in self.bMaxPower:
            if (operator == el.operator):
                return True
    
        # Operator not used
        return False

    ### Get Converted Verification Values per Operator ###
    def getConvertedVerificationValues(self, operator):
        result = []

        # bLength
        memoryValueConfig = []
        for el in self.bLength:
            if (operator == el.operator):
                # Convert Memory Configurations
                for e in el.convertToMemConfig():
                    memoryValueConfig.append(e)

        # Order & Add Memory Values
        for el in VerificationValue.generateMemoryValues(memoryValueConfig):
            result.append(el)

        # wTotalLength
        memoryValueConfig = []
        for el in self.wTotalLength:
            if (operator == el.operator):
                # Convert Memory Configurations
                for e in el.convertToMemConfig():
                    memoryValueConfig.append(e)

        # Order & Add Memory Values
        for el in VerificationValue.generateMemoryValues(memoryValueConfig):
            result.append(el)

        # bNumInterfaces
        memoryValueConfig = []
        for el in self.bNumInterfaces:
            if (operator == el.operator):
                # Convert Memory Configurations
                for e in el.convertToMemConfig():
                    memoryValueConfig.append(e)

        # Order & Add Memory Values
        for el in VerificationValue.generateMemoryValues(memoryValueConfig):
            result.append(el)

        # bConfigurationValue
        memoryValueConfig = []
        for el in self.bConfigurationValue:
            if (operator == el.operator):
                # Convert Memory Configurations
                for e in el.convertToMemConfig():
                    memoryValueConfig.append(e)

        # Order & Add Memory Values
        for el in VerificationValue.generateMemoryValues(memoryValueConfig):
            result.append(el)

        # bmAttributes
        memoryValueConfig = []
        for el in self.bmAttributes:
            if (operator == el.operator):
                # Convert Memory Configurations
                for e in el.convertToMemConfig():
                    memoryValueConfig.append(e)

        # Order & Add Memory Values
        for el in VerificationValue.generateMemoryValues(memoryValueConfig):
            result.append(el)

        # bMaxPower
        memoryValueConfig = []
        for el in self.bMaxPower:
            if (operator == el.operator):
                # Convert Memory Configurations
                for e in el.convertToMemConfig():
                    memoryValueConfig.append(e)

        # Order & Add Memory Values
        for el in VerificationValue.generateMemoryValues(memoryValueConfig):
            result.append(el)
    
        # End of Process
        return result
            
    ### Get Largest Verification Number per Value Part ###
    ### Return Largest Verification Number
    def getLargestVerificationNumber(self, currentLargestVerificationNumber=1):

        # bLength
        largestPartVerif = self.__getLargestVerificationNumber(self.bLength, currentLargestVerificationNumber)

        # wTotalLength
        largestPartVerif = self.__getLargestVerificationNumber(self.wTotalLength, largestPartVerif)

        # bNumInterfaces
        largestPartVerif = self.__getLargestVerificationNumber(self.bNumInterfaces, largestPartVerif)

        # bConfigurationValue
        largestPartVerif = self.__getLargestVerificationNumber(self.bConfigurationValue, largestPartVerif)

        # bmAttributes
        largestPartVerif = self.__getLargestVerificationNumber(self.bmAttributes, largestPartVerif)

        # bMaxPower
        largestPartVerif = self.__getLargestVerificationNumber(self.bMaxPower, largestPartVerif)
        return largestPartVerif

    ### Check if the Descriptor is InUse (at least on Value) ###
    ### Return True/False
    def isDescriptorInUse(self):

        # bLength
        for el in self.bLength:
            return True

        # wTotalLength
        for el in self.wTotalLength:
            return True

        # bNumInterfaces
        for el in self.bNumInterfaces:
            return True

        # bConfigurationValue
        for el in self.bConfigurationValue:
            return True

        # bmAttributes
        for el in self.bmAttributes:
            return True

        # bMaxPower
        for el in self.bMaxPower:
            return True
    
        # Descriptor not used
        return False

    ##################################################
    ## Public Static Other Speed Descriptor Methods ##
    ##################################################

    ### Get Source File Index & Count Pattern for specific Device Descriptor field ###
    ### Return (Index Pattern, Count Pattern)
    @staticmethod
    def getSourceIndexCountPattern(fieldName):
        match fieldName:

            # bLength
            case OtherSpeedDescriptor.bLengthName:
                return (OtherSpeedDescriptor.bLengthSourceIndexPattern, OtherSpeedDescriptor.bLengthSourceCountPattern)

            # wTotalLength
            case OtherSpeedDescriptor.wTotalLengthName:
                return (OtherSpeedDescriptor.wTotalLengthSourceIndexPattern, OtherSpeedDescriptor.wTotalLengthSourceCountPattern)

            # bNumInterfaces
            case OtherSpeedDescriptor.bNumInterfacesName:
                return (OtherSpeedDescriptor.bNumInterfacesSourceIndexPattern, OtherSpeedDescriptor.bNumInterfacesSourceCountPattern)

            # bConfigurationValue
            case OtherSpeedDescriptor.bConfigurationValueName:
                return (OtherSpeedDescriptor.bConfigurationValueSourceIndexPattern, OtherSpeedDescriptor.bConfigurationValueSourceCountPattern)

            # bmAttributes
            case OtherSpeedDescriptor.bmAttributesName:
                return (OtherSpeedDescriptor.bmAttributesSourceIndexPattern, OtherSpeedDescriptor.bmAttributesSourceCountPattern)

            # bMaxPower
            case OtherSpeedDescriptor.bMaxPowerName:
                return (OtherSpeedDescriptor.bMaxPowerSourceIndexPattern, OtherSpeedDescriptor.bMaxPowerSourceCountPattern)

            # Unknown Field
            case _:
                raise("Unkown", OtherSpeedDescriptor.DESCRIPTOR_NAME, "Field:", fieldName)

    ############################################
    ## Private Other Speed Descriptor Methods ##
    ############################################

    ### Get Largest Verification Number per Value Part per Operator ###
    def __getLargestVerificationNumber(self, field, currentMaxCount=1):

        # Init Operator & Value Part Number List [(Operator - Value Part Number)]
        operatorValuePart = []

        # Loop on each Field
        for el in field:
            # Convert to Memory Config: [(Value Part Number, Verification Level, Converted Data Value, Quartet Enable)]
            for e in el.convertToMemConfig():
                operatorValuePart.append((el.operator.name, e[0]))

        # Empty Field
        if (len(operatorValuePart) == 0):
            return currentMaxCount

        else:
            # Compute Largest Verification Number per Value Part per Operator
            maxCount = operatorValuePart.count(statistics.mode(operatorValuePart))
            
            # Update new Largest Verification Number per Value Part per Operator
            if (maxCount > currentMaxCount):
                return maxCount
            else:
                return currentMaxCount