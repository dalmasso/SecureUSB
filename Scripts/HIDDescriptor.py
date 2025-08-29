########################################################################
## Engineer:    Dalmasso Loic
## Create Date: 25/07/2025
## Module Name: HIDDescriptor
## Description: USB HID Descriptor Class containing fields to verify
########################################################################

import statistics

from FieldFormatEnum import FieldFormatEnum
from VerificationValue import VerificationValue
from VerificationLevelEnum import VerificationLevelEnum

class HIDDescriptor:

    ##############################
    ## HID Descriptor Constants ##
    ##############################

    # Descriptor Type
    DESCRIPTOR_TYPE = "HID"

    # Descriptor Name
    DESCRIPTOR_NAME = "HID Descriptor"

    ##############################
    ## HID Descriptor Variables ##
    ##############################

    # bLength (1 byte)
    bLength = []
    bLengthLength = 255
    bLengthFormat = FieldFormatEnum.NUMBER
    bLengthName = "bLength"
    bLengthMatch = bLengthName.casefold()
    bLengthLastMandatoryValueIndex = 0
    bLengthSourceIndexPattern = "HID_BLENGTH_INDEX => "
    bLengthSourceCountPattern = "HID_BLENGTH_COUNT => "

    # bcdHID (2 bytes)
    bcdHID = []
    bcdHIDLength = 4
    bcdHIDFormat = FieldFormatEnum.HEX
    bcdHIDName = "bcdHID"
    bcdHIDMatch = bcdHIDName.casefold()
    bcdHIDLastMandatoryValueIndex = 0
    bcdHIDSourceIndexPattern = "HID_BCDHID_INDEX => "
    bcdHIDSourceCountPattern = "HID_BCDHID_COUNT => "

    # bCountryCode (1 byte)
    bCountryCode = []
    bCountryCodeLength = 2
    bCountryCodeFormat = FieldFormatEnum.HEX
    bCountryCodeName = "bCountryCode"
    bCountryCodeMatch = bCountryCodeName.casefold()
    bCountryCodeLastMandatoryValueIndex = 0
    bCountryCodeSourceIndexPattern = "HID_BCOUNTRYCODE_INDEX => "
    bCountryCodeSourceCountPattern = "HID_BCOUNTRYCODE_COUNT => "

    # bNumDescriptors (1 byte)
    bNumDescriptors = []
    bNumDescriptorsLength = 255
    bNumDescriptorsFormat = FieldFormatEnum.NUMBER
    bNumDescriptorsName = "bNumDescriptors"
    bNumDescriptorsMatch = bNumDescriptorsName.casefold()
    bNumDescriptorsLastMandatoryValueIndex = 0
    bNumDescriptorsSourceIndexPattern = "HID_BNUMDESCRIPTORS_INDEX => "
    bNumDescriptorsSourceCountPattern = "HID_BNUMDESCRIPTORS_COUNT => "

    # bDescriptorType (1 byte)
    bDescriptorType = []
    bDescriptorTypeLength = 2
    bDescriptorTypeFormat = FieldFormatEnum.HEX
    bDescriptorTypeName = "bDescriptorType"
    bDescriptorTypeMatch = bDescriptorTypeName.casefold()
    bDescriptorTypeLastMandatoryValueIndex = 0
    bDescriptorTypeSourceIndexPattern = "HID_BDESCRIPTORTYPE_INDEX => "
    bDescriptorTypeSourceCountPattern = "HID_BDESCRIPTORTYPE_COUNT => "

    # wDescriptorLength (1 byte)
    wDescriptorLength = []
    wDescriptorLengthLength = 65535
    wDescriptorLengthFormat = FieldFormatEnum.NUMBER
    wDescriptorLengthName = "wDescriptorLength"
    wDescriptorLengthMatch = wDescriptorLengthName.casefold()
    wDescriptorLengthLastMandatoryValueIndex = 0
    wDescriptorLengthSourceIndexPattern = "HID_WDESCRIPTORLENGTH_INDEX => "
    wDescriptorLengthSourceCountPattern = "HID_WDESCRIPTORLENGTH_COUNT => "

    ###################################
    ## Public HID Descriptor Methods ##
    ###################################

    ### is HID Descriptor Requested ###
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

            # bcdHID
            case self.bcdHIDMatch:
                # New Value to Add
                newValue = VerificationValue(value, self.bcdHIDLength, self.bcdHIDFormat, verificationLevel, operator)

                # Handle Verification Level Priority (Mandatory First)
                if (VerificationLevelEnum.MANDATORY == newValue.verificationLevel):
                    # Add New Mandatory Value
                    self.bcdHID.insert(self.bcdHIDLastMandatoryValueIndex, newValue)
                    self.bcdHIDLastMandatoryValueIndex += 1

                # Optional New Value (add the end of the list)
                else:
                    self.bcdHID.append(newValue)

            # bCountryCode
            case self.bCountryCodeMatch:
                # New Value to Add
                newValue = VerificationValue(value, self.bCountryCodeLength, self.bCountryCodeFormat, verificationLevel, operator)

                # Handle Verification Level Priority (Mandatory First)
                if (VerificationLevelEnum.MANDATORY == newValue.verificationLevel):
                    # Add New Mandatory Value
                    self.bCountryCode.insert(self.bCountryCodeLastMandatoryValueIndex, newValue)
                    self.bCountryCodeLastMandatoryValueIndex += 1

                # Optional New Value (add the end of the list)
                else:
                    self.bCountryCode.append(newValue)

            # bNumDescriptors
            case self.bNumDescriptorsMatch:
                # New Value to Add
                newValue = VerificationValue(value, self.bNumDescriptorsLength, self.bNumDescriptorsFormat, verificationLevel, operator)

                # Handle Verification Level Priority (Mandatory First)
                if (VerificationLevelEnum.MANDATORY == newValue.verificationLevel):
                    # Add New Mandatory Value
                    self.bNumDescriptors.insert(self.bNumDescriptorsLastMandatoryValueIndex, newValue)
                    self.bNumDescriptorsLastMandatoryValueIndex += 1

                # Optional New Value (add the end of the list)
                else:
                    self.bNumDescriptors.append(newValue)

            # bDescriptorType
            case self.bDescriptorTypeMatch:
                # New Value to Add
                newValue = VerificationValue(value, self.bDescriptorTypeLength, self.bDescriptorTypeFormat, verificationLevel, operator)

                # Handle Verification Level Priority (Mandatory First)
                if (VerificationLevelEnum.MANDATORY == newValue.verificationLevel):
                    # Add New Mandatory Value
                    self.bDescriptorType.insert(self.bDescriptorTypeLastMandatoryValueIndex, newValue)
                    self.bDescriptorTypeLastMandatoryValueIndex += 1

                # Optional New Value (add the end of the list)
                else:
                    self.bDescriptorType.append(newValue)

            # wDescriptorLength
            case self.wDescriptorLengthMatch:
                # New Value to Add
                newValue = VerificationValue(value, self.wDescriptorLengthLength, self.wDescriptorLengthFormat, verificationLevel, operator)

                # Handle Verification Level Priority (Mandatory First)
                if (VerificationLevelEnum.MANDATORY == newValue.verificationLevel):
                    # Add New Mandatory Value
                    self.wDescriptorLength.insert(self.wDescriptorLengthLastMandatoryValueIndex, newValue)
                    self.wDescriptorLengthLastMandatoryValueIndex += 1

                # Optional New Value (add the end of the list)
                else:
                    self.wDescriptorLength.append(newValue)

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

            # bcdHID
            case self.bcdHIDMatch:
                if (operator == None):
                    self.bcdHID = [el for el in self.bcdHID if el.value != value]
                else:
                    self.bcdHID = [el for el in self.bcdHID if el.value != value and el.operator != operator]

            # bCountryCode
            case self.bCountryCodeMatch:
                if (operator == None):
                    self.bCountryCode = [el for el in self.bCountryCode if el.value != value]
                else:
                    self.bCountryCode = [el for el in self.bCountryCode if el.value != value and el.operator != operator]

            # bNumDescriptors
            case self.bNumDescriptorsMatch:
                if (operator == None):
                    self.bNumDescriptors = [el for el in self.bNumDescriptors if el.value != value]
                else:
                    self.bNumDescriptors = [el for el in self.bNumDescriptors if el.value != value and el.operator != operator]

            # bDescriptorType
            case self.bDescriptorTypeMatch:
                if (operator == None):
                    self.bDescriptorType = [el for el in self.bDescriptorType if el.value != value]
                else:
                    self.bDescriptorType = [el for el in self.bDescriptorType if el.value != value and el.operator != operator]

            # wDescriptorLength
            case self.wDescriptorLengthMatch:
                if (operator == None):
                    self.wDescriptorLength = [el for el in self.wDescriptorLength if el.value != value]
                else:
                    self.wDescriptorLength = [el for el in self.wDescriptorLength if el.value != value and el.operator != operator]

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

            # bcdHID
            case self.bcdHIDMatch:
                print(self.bcdHIDName + ":\n")
                for el in self.bcdHID: el.showDetails()

            # bCountryCode
            case self.bCountryCodeMatch:
                print(self.bCountryCodeName + ":\n")
                for el in self.bCountryCode: el.showDetails()

            # bNumDescriptors
            case self.bNumDescriptorsMatch:
                print(self.bNumDescriptorsName + ":\n")
                for el in self.bNumDescriptors: el.showDetails()

            # bDescriptorType
            case self.bDescriptorTypeMatch:
                print(self.bDescriptorTypeName + ":\n")
                for el in self.bDescriptorType: el.showDetails()

            # wDescriptorLength
            case self.wDescriptorLengthMatch:
                print(self.wDescriptorLengthName + ":\n")
                for el in self.wDescriptorLength: el.showDetails()

            # Unknown Field
            case _:
                raise Exception("Unkown " + self.DESCRIPTOR_NAME + " Field: " + fieldName)

    ### Print All Device Descriptor Field Values ###
    def displayAllVerificationValues(self):
        print("---", self.DESCRIPTOR_NAME, "---")

        # bLength
        self.displayVerificationValues(self.bLengthName)

        # bcdHID
        self.displayVerificationValues(self.bcdHIDName)

        # bCountryCode
        self.displayVerificationValues(self.bCountryCodeName)

        # bNumDescriptors
        self.displayVerificationValues(self.bNumDescriptorsName)

        # bDescriptorType
        self.displayVerificationValues(self.bDescriptorTypeName)

        # wDescriptorLength
        self.displayVerificationValues(self.wDescriptorLengthName)

    ### Get Verification Values ###
    ### Return: [ [USB Field, Operator, Value, Verification Level] ]
    def getVerificationValues(self):
        valueList = []

        # bLength
        for el in self.bLength:
            valueList.append([self.bLengthName, el.operator.name.capitalize(), el.value, el.verificationLevel.name])

        # bcdHID
        for el in self.bcdHID:
            valueList.append([self.bcdHIDName, el.operator.name.capitalize(), el.value, el.verificationLevel.name])

        # bCountryCode
        for el in self.bCountryCode:
            valueList.append([self.bCountryCodeName, el.operator.name.capitalize(), el.value, el.verificationLevel.name])

        # bNumDescriptors
        for el in self.bNumDescriptors:
            valueList.append([self.bNumDescriptorsName, el.operator.name.capitalize(), el.value, el.verificationLevel.name])

        # bDescriptorType
        for el in self.bDescriptorType:
            valueList.append([self.bDescriptorTypeName, el.operator.name.capitalize(), el.value, el.verificationLevel.name])

        # wDescriptorLength
        for el in self.wDescriptorLength:
            valueList.append([self.wDescriptorLengthName, el.operator.name.capitalize(), el.value, el.verificationLevel.name])

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

        # bcdHID
        for el in self.bcdHID:
            if (operator == el.operator):
                count += el.getMemoryUsage()

        # Add Result & Reset Counter
        result.append([self.bcdHIDName, count])
        count = 0

        # bCountryCode
        for el in self.bCountryCode:
            if (operator == el.operator):
                count += el.getMemoryUsage()

        # Add Result & Reset Counter
        result.append([self.bCountryCodeName, count])
        count = 0

        # bNumDescriptors
        for el in self.bNumDescriptors:
            if (operator == el.operator):
                count += el.getMemoryUsage()

        # Add Result & Reset Counter
        result.append([self.bNumDescriptorsName, count])
        count = 0

        # bDescriptorType
        for el in self.bDescriptorType:
            if (operator == el.operator):
                count += el.getMemoryUsage()

        # Add Result & Reset Counter
        result.append([self.bDescriptorTypeName, count])
        count = 0

        # wDescriptorLength
        for el in self.wDescriptorLength:
            if (operator == el.operator):
                count += el.getMemoryUsage()

        # Add Result & Reset Counter
        result.append([self.wDescriptorLengthName, count])

        # End of Process
        return result

    ### Check if Operator is used by the Descriptor (at least once) ###
    ### Return: True/False
    def isOperatorInUse(self, operator):

        # bLength
        for el in self.bLength:
            if (operator == el.operator):
                return True

        # bcdHID
        for el in self.bcdHID:
            if (operator == el.operator):
                return True

        # bCountryCode
        for el in self.bCountryCode:
            if (operator == el.operator):
                return True

        # bNumDescriptors
        for el in self.bNumDescriptors:
            if (operator == el.operator):
                return True

        # bDescriptorType
        for el in self.bDescriptorType:
            if (operator == el.operator):
                return True

        # wDescriptorLength
        for el in self.wDescriptorLength:
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

        # bcdHID
        memoryValueConfig = []
        for el in self.bcdHID:
            if (operator == el.operator):
                # Convert Memory Configurations
                for e in el.convertToMemConfig():
                    memoryValueConfig.append(e)

        # Order & Add Memory Values
        for el in VerificationValue.generateMemoryValues(memoryValueConfig):
            result.append(el)

        # bCountryCode
        memoryValueConfig = []
        for el in self.bCountryCode:
            if (operator == el.operator):
                # Convert Memory Configurations
                for e in el.convertToMemConfig():
                    memoryValueConfig.append(e)

        # Order & Add Memory Values
        for el in VerificationValue.generateMemoryValues(memoryValueConfig):
            result.append(el)

        # bNumDescriptors
        memoryValueConfig = []
        for el in self.bNumDescriptors:
            if (operator == el.operator):
                # Convert Memory Configurations
                for e in el.convertToMemConfig():
                    memoryValueConfig.append(e)

        # Order & Add Memory Values
        for el in VerificationValue.generateMemoryValues(memoryValueConfig):
            result.append(el)

        # bDescriptorType
        memoryValueConfig = []
        for el in self.bDescriptorType:
            if (operator == el.operator):
                # Convert Memory Configurations
                for e in el.convertToMemConfig():
                    memoryValueConfig.append(e)

        # Order & Add Memory Values
        for el in VerificationValue.generateMemoryValues(memoryValueConfig):
            result.append(el)

        # wDescriptorLength
        memoryValueConfig = []
        for el in self.wDescriptorLength:
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

        # bcdHID
        largestPartVerif = self.__getLargestVerificationNumber(self.bcdHID, largestPartVerif)

        # bCountryCode
        largestPartVerif = self.__getLargestVerificationNumber(self.bCountryCode, largestPartVerif)

        # bNumDescriptors
        largestPartVerif = self.__getLargestVerificationNumber(self.bNumDescriptors, largestPartVerif)

        # bDescriptorType
        largestPartVerif = self.__getLargestVerificationNumber(self.bDescriptorType, largestPartVerif)

        # wDescriptorLength
        largestPartVerif = self.__getLargestVerificationNumber(self.wDescriptorLength, largestPartVerif)
        return largestPartVerif

    ### Check if the Descriptor is InUse (at least on Value) ###
    ### Return True/False
    def isDescriptorInUse(self):

        # bLength
        for el in self.bLength:
            return True

        # bcdHID
        for el in self.bcdHID:
            return True

        # bCountryCode
        for el in self.bCountryCode:
            return True

        # bNumDescriptors
        for el in self.bNumDescriptors:
            return True

        # bDescriptorType
        for el in self.bDescriptorType:
            return True

        # wDescriptorLength
        for el in self.wDescriptorLength:
            return True

        # Descriptor not used
        return False

    ##########################################
    ## Public Static HID Descriptor Methods ##
    ##########################################

    ### Get Source File Index & Count Pattern for specific Device Descriptor field ###
    ### Return (Index Pattern, Count Pattern)
    @staticmethod
    def getSourceIndexCountPattern(fieldName):
        match fieldName:

            # bLength
            case HIDDescriptor.bLengthName:
                return (HIDDescriptor.bLengthSourceIndexPattern, HIDDescriptor.bLengthSourceCountPattern)

            # bcdHID
            case HIDDescriptor.bcdHIDName:
                return (HIDDescriptor.bcdHIDSourceIndexPattern, HIDDescriptor.bcdHIDSourceCountPattern)

            # bCountryCode
            case HIDDescriptor.bCountryCodeName:
                return (HIDDescriptor.bCountryCodeSourceIndexPattern, HIDDescriptor.bCountryCodeSourceCountPattern)

            # bNumDescriptors
            case HIDDescriptor.bNumDescriptorsName:
                return (HIDDescriptor.bNumDescriptorsSourceIndexPattern, HIDDescriptor.bNumDescriptorsSourceCountPattern)

            # bDescriptorType
            case HIDDescriptor.bDescriptorTypeName:
                return (HIDDescriptor.bDescriptorTypeSourceIndexPattern, HIDDescriptor.bDescriptorTypeSourceCountPattern)

            # wDescriptorLength
            case HIDDescriptor.wDescriptorLengthName:
                return (HIDDescriptor.wDescriptorLengthSourceIndexPattern, HIDDescriptor.wDescriptorLengthSourceCountPattern)

            # Unknown Field
            case _:
                raise("Unkown", HIDDescriptor.DESCRIPTOR_NAME, "Field:", fieldName)

    ####################################
    ## Private HID Descriptor Methods ##
    ####################################

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
