########################################################################
## Engineer:    Dalmasso Loic
## Create Date: 25/07/2025
## Module Name: EndpointDescriptor
## Description: USB Endpoint Descriptor Class containing fields to verify
########################################################################

import statistics

from FieldFormatEnum import FieldFormatEnum
from VerificationValue import VerificationValue
from VerificationLevelEnum import VerificationLevelEnum

class EndpointDescriptor:

    ###################################
    ## Endpoint Descriptor Constants ##
    ###################################

    # Descriptor Type
    DESCRIPTOR_TYPE = "Endpoint"

    # Descriptor Name
    DESCRIPTOR_NAME = "Endpoint Descriptor"

    ###################################
    ## Endpoint Descriptor Variables ##
    ###################################

    # bLength (1 byte)
    bLength = []
    bLengthLength = 255
    bLengthFormat = FieldFormatEnum.NUMBER
    bLengthName = "bLength"
    bLengthMatch = bLengthName.casefold()
    bLengthLastMandatoryValueIndex = 0
    bLengthSourceIndexPattern = "ENDPOINT_BLENGTH_INDEX => "
    bLengthSourceCountPattern = "ENDPOINT_BLENGTH_COUNT => "

    # bEndpointAddress (1 byte)
    bEndpointAddress = []
    bEndpointAddressLength = 2
    bEndpointAddressFormat = FieldFormatEnum.HEX
    bEndpointAddressName = "bEndpointAddress"
    bEndpointAddressMatch = bEndpointAddressName.casefold()
    bEndpointAddressLastMandatoryValueIndex = 0
    bEndpointAddressSourceIndexPattern = "ENDPOINT_BENDPOINTADDRESS_INDEX => "
    bEndpointAddressSourceCountPattern = "ENDPOINT_BENDPOINTADDRESS_COUNT => "

    # bmAttributes (1 byte)
    bmAttributes = []
    bmAttributesLength = 2
    bmAttributesFormat = FieldFormatEnum.HEX
    bmAttributesName = "bmAttributes"
    bmAttributesMatch = bmAttributesName.casefold()
    bmAttributesLastMandatoryValueIndex = 0
    bmAttributesSourceIndexPattern = "ENDPOINT_BMATTRIBUTES_INDEX => "
    bmAttributesSourceCountPattern = "ENDPOINT_BMATTRIBUTES_COUNT => "

    # wMaxPacketSize (2 bytes)
    wMaxPacketSize = []
    wMaxPacketSizeLength = 65535
    wMaxPacketSizeFormat = FieldFormatEnum.NUMBER
    wMaxPacketSizeName = "wMaxPacketSize"
    wMaxPacketSizeMatch = wMaxPacketSizeName.casefold()
    wMaxPacketSizeLastMandatoryValueIndex = 0
    wMaxPacketSizeSourceIndexPattern = "ENDPOINT_WMAXPACKETSIZE_INDEX => "
    wMaxPacketSizeSourceCountPattern = "ENDPOINT_WMAXPACKETSIZE_COUNT => "

    # bInterval (1 byte)
    bInterval = []
    bIntervalLength = 255
    bIntervalFormat = FieldFormatEnum.NUMBER
    bIntervalName = "bInterval"
    bIntervalMatch = bIntervalName.casefold()
    bIntervalLastMandatoryValueIndex = 0
    bIntervalSourceIndexPattern = "ENDPOINT_BINTERVAL_INDEX => "
    bIntervalSourceCountPattern = "ENDPOINT_BINTERVAL_COUNT => "

    ########################################
    ## Public Endpoint Descriptor Methods ##
    ########################################
    
    ### is Endpoint Descriptor Requested ###
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

            # bEndpointAddress
            case self.bEndpointAddressMatch:
                # New Value to Add
                newValue = VerificationValue(value, self.bEndpointAddressLength, self.bEndpointAddressFormat, verificationLevel, operator)

                # Handle Verification Level Priority (Mandatory First)
                if (VerificationLevelEnum.MANDATORY == newValue.verificationLevel):
                    # Add New Mandatory Value
                    self.bEndpointAddress.insert(self.bEndpointAddressLastMandatoryValueIndex, newValue)
                    self.bEndpointAddressLastMandatoryValueIndex += 1

                # Optional New Value (add the end of the list)
                else:
                    self.bEndpointAddress.append(newValue)

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

            # wMaxPacketSize
            case self.wMaxPacketSizeMatch:
                # New Value to Add
                newValue = VerificationValue(value, self.wMaxPacketSizeLength, self.wMaxPacketSizeFormat, verificationLevel, operator)

                # Handle Verification Level Priority (Mandatory First)
                if (VerificationLevelEnum.MANDATORY == newValue.verificationLevel):
                    # Add New Mandatory Value
                    self.wMaxPacketSize.insert(self.wMaxPacketSizeLastMandatoryValueIndex, newValue)
                    self.wMaxPacketSizeLastMandatoryValueIndex += 1

                # Optional New Value (add the end of the list)
                else:
                    self.wMaxPacketSize.append(newValue)

            # bInterval
            case self.bIntervalMatch:
                # New Value to Add
                newValue = VerificationValue(value, self.bIntervalLength, self.bIntervalFormat, verificationLevel, operator)

                # Handle Verification Level Priority (Mandatory First)
                if (VerificationLevelEnum.MANDATORY == newValue.verificationLevel):
                    # Add New Mandatory Value
                    self.bInterval.insert(self.bIntervalLastMandatoryValueIndex, newValue)
                    self.bIntervalLastMandatoryValueIndex += 1

                # Optional New Value (add the end of the list)
                else:
                    self.bInterval.append(newValue)

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

            # bEndpointAddress
            case self.bEndpointAddressMatch:
                if (operator == None):
                    self.bEndpointAddress = [el for el in self.bEndpointAddress if el.value != value]
                else:
                    self.bEndpointAddress = [el for el in self.bEndpointAddress if el.value != value and el.operator != operator]

            # bmAttributes
            case self.bmAttributesMatch:
                if (operator == None):
                    self.bmAttributes = [el for el in self.bmAttributes if el.value != value]
                else:
                    self.bmAttributes = [el for el in self.bmAttributes if el.value != value and el.operator != operator]

            # wMaxPacketSize
            case self.wMaxPacketSizeMatch:
                if (operator == None):
                    self.wMaxPacketSize = [el for el in self.wMaxPacketSize if el.value != value]
                else:
                    self.wMaxPacketSize = [el for el in self.wMaxPacketSize if el.value != value and el.operator != operator]

            # bInterval
            case self.bIntervalMatch:
                if (operator == None):
                    self.bInterval = [el for el in self.bInterval if el.value != value]
                else:
                    self.bInterval = [el for el in self.bInterval if el.value != value and el.operator != operator]

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

            # bEndpointAddress
            case self.bEndpointAddressMatch:
                print(self.bEndpointAddressName + ":\n")
                for el in self.bEndpointAddress: el.showDetails()

            # bmAttributes
            case self.bmAttributesMatch:
                print(self.bmAttributesName + ":\n")
                for el in self.bmAttributes: el.showDetails()

            # wMaxPacketSize
            case self.wMaxPacketSizeMatch:
                print(self.wMaxPacketSizeName + ":\n")
                for el in self.wMaxPacketSize: el.showDetails()

            # bInterval
            case self.bIntervalMatch:
                print(self.bIntervalName + ":\n")
                for el in self.bInterval: el.showDetails()

            # Unknown Field
            case _:
                raise Exception("Unkown " + self.DESCRIPTOR_NAME + " Field: " + fieldName)

    ### Print All Device Descriptor Field Values ###
    def displayAllVerificationValues(self):
        print("---", self.DESCRIPTOR_NAME, "---")

        # bLength
        self.displayVerificationValues(self.bLengthName)

        # bEndpointAddress
        self.displayVerificationValues(self.bEndpointAddressName)

        # bmAttributes
        self.displayVerificationValues(self.bmAttributesName)

        # wMaxPacketSize
        self.displayVerificationValues(self.wMaxPacketSizeName)

        # bInterval
        self.displayVerificationValues(self.bIntervalName)

    ### Get Verification Values ###
    ### Return: [ [USB Field, Operator, Value, Verification Level] ]
    def getVerificationValues(self):
        valueList = []

        # bLength
        for el in self.bLength:
            valueList.append([self.bLengthName, el.operator.name.capitalize(), el.value, el.verificationLevel.name])

        # bEndpointAddress
        for el in self.bEndpointAddress:
            valueList.append([self.bEndpointAddressName, el.operator.name.capitalize(), el.value, el.verificationLevel.name])

        # bmAttributes
        for el in self.bmAttributes:
            valueList.append([self.bmAttributesName, el.operator.name.capitalize(), el.value, el.verificationLevel.name])

        # wMaxPacketSize
        for el in self.wMaxPacketSize:
            valueList.append([self.wMaxPacketSizeName, el.operator.name.capitalize(), el.value, el.verificationLevel.name])

        # bInterval
        for el in self.bInterval:
            valueList.append([self.bIntervalName, el.operator.name.capitalize(), el.value, el.verificationLevel.name])

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

        # bEndpointAddress
        for el in self.bEndpointAddress:
            if (operator == el.operator):
                count += el.getMemoryUsage()

        # Add Result & Reset Counter
        result.append([self.bEndpointAddressName, count])
        count = 0

        # bmAttributes
        for el in self.bmAttributes:
            if (operator == el.operator):
                count += el.getMemoryUsage()

        # Add Result & Reset Counter
        result.append([self.bmAttributesName, count])
        count = 0

        # wMaxPacketSize
        for el in self.wMaxPacketSize:
            if (operator == el.operator):
                count += el.getMemoryUsage()

        # Add Result & Reset Counter
        result.append([self.wMaxPacketSizeName, count])
        count = 0

        # bInterval
        for el in self.bInterval:
            if (operator == el.operator):
                count += el.getMemoryUsage()

        # Add Result & Reset Counter
        result.append([self.bIntervalName, count])

        # End of Process
        return result

    ### Check if Operator is used by the Descriptor (at least once) ###
    ### Return: True/False
    def isOperatorInUse(self, operator):

        # bLength
        for el in self.bLength:
            if (operator == el.operator):
                return True

        # bEndpointAddress
        for el in self.bEndpointAddress:
            if (operator == el.operator):
                return True

        # bmAttributes
        for el in self.bmAttributes:
            if (operator == el.operator):
                return True

        # wMaxPacketSize
        for el in self.wMaxPacketSize:
            if (operator == el.operator):
                return True

        # bInterval
        for el in self.bInterval:
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

        # bEndpointAddress
        memoryValueConfig = []
        for el in self.bEndpointAddress:
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

        # wMaxPacketSize
        memoryValueConfig = []
        for el in self.wMaxPacketSize:
            if (operator == el.operator):
                # Convert Memory Configurations
                for e in el.convertToMemConfig():
                    memoryValueConfig.append(e)

        # Order & Add Memory Values
        for el in VerificationValue.generateMemoryValues(memoryValueConfig):
            result.append(el)

        # bInterval
        memoryValueConfig = []
        for el in self.bInterval:
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

        # bEndpointAddress
        largestPartVerif = self.__getLargestVerificationNumber(self.bEndpointAddress, largestPartVerif)

        # bmAttributes
        largestPartVerif = self.__getLargestVerificationNumber(self.bmAttributes, largestPartVerif)

        # wMaxPacketSize
        largestPartVerif = self.__getLargestVerificationNumber(self.wMaxPacketSize, largestPartVerif)

        # bInterval
        largestPartVerif = self.__getLargestVerificationNumber(self.bInterval, largestPartVerif)
        return largestPartVerif

    ### Check if the Descriptor is InUse (at least on Value) ###
    ### Return True/False
    def isDescriptorInUse(self):

        # bLength
        for el in self.bLength:
            return True

        # bEndpointAddress
        for el in self.bEndpointAddress:
            return True

        # bmAttributes
        for el in self.bmAttributes:
            return True

        # wMaxPacketSize
        for el in self.wMaxPacketSize:
            return True

        # bInterval
        for el in self.bInterval:
            return True

        # Descriptor not used
        return False

    ###############################################
    ## Public Static Endpoint Descriptor Methods ##
    ###############################################

    ### Get Source File Index & Count Pattern for specific Device Descriptor field ###
    ### Return (Index Pattern, Count Pattern)
    @staticmethod
    def getSourceIndexCountPattern(fieldName):
        match fieldName:

            # bLength
            case EndpointDescriptor.bLengthName:
                return (EndpointDescriptor.bLengthSourceIndexPattern, EndpointDescriptor.bLengthSourceCountPattern)

            # bEndpointAddress
            case EndpointDescriptor.bEndpointAddressName:
                return (EndpointDescriptor.bEndpointAddressSourceIndexPattern, EndpointDescriptor.bEndpointAddressSourceCountPattern)

            # bmAttributes
            case EndpointDescriptor.bmAttributesName:
                return (EndpointDescriptor.bmAttributesSourceIndexPattern, EndpointDescriptor.bmAttributesSourceCountPattern)

            # wMaxPacketSize
            case EndpointDescriptor.wMaxPacketSizeName:
                return (EndpointDescriptor.wMaxPacketSizeSourceIndexPattern, EndpointDescriptor.wMaxPacketSizeSourceCountPattern)

            # bInterval
            case EndpointDescriptor.bIntervalName:
                return (EndpointDescriptor.bIntervalSourceIndexPattern, EndpointDescriptor.bIntervalSourceCountPattern)

            # Unknown Field
            case _:
                raise("Unkown", EndpointDescriptor.DESCRIPTOR_NAME, "Field:", fieldName)

    #########################################
    ## Private Endpoint Descriptor Methods ##
    #########################################

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
