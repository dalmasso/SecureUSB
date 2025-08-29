########################################################################
## Engineer:    Dalmasso Loic
## Create Date: 25/07/2025
## Module Name: InterfaceDescriptor
## Description: USB Interface Descriptor Class containing fields to verify
########################################################################

import statistics

from FieldFormatEnum import FieldFormatEnum
from VerificationValue import VerificationValue
from VerificationLevelEnum import VerificationLevelEnum

class InterfaceDescriptor:

    ####################################
    ## Interface Descriptor Constants ##
    ####################################

    # Descriptor Type
    DESCRIPTOR_TYPE = "Interface"

    # Descriptor Name
    DESCRIPTOR_NAME = "Interface Descriptor"

    ####################################
    ## Interface Descriptor Variables ##
    ####################################

    # bLength (1 byte)
    bLength = []
    bLengthLength = 255
    bLengthFormat = FieldFormatEnum.NUMBER
    bLengthName = "bLength"
    bLengthMatch = bLengthName.casefold()
    bLengthLastMandatoryValueIndex = 0
    bLengthSourceIndexPattern = "INTERFACE_BLENGTH_INDEX => "
    bLengthSourceCountPattern = "INTERFACE_BLENGTH_COUNT => "

    # bInterfaceNumber (1 byte)
    bInterfaceNumber = []
    bInterfaceNumberLength = 255
    bInterfaceNumberFormat = FieldFormatEnum.NUMBER
    bInterfaceNumberName = "bInterfaceNumber"
    bInterfaceNumberMatch = bInterfaceNumberName.casefold()
    bInterfaceNumberLastMandatoryValueIndex = 0
    bInterfaceNumberSourceIndexPattern = "INTERFACE_BINTERFACENUMBER_INDEX => "
    bInterfaceNumberSourceCountPattern = "INTERFACE_BINTERFACENUMBER_COUNT => "

    # bAlternateSetting (1 byte)
    bAlternateSetting = []
    bAlternateSettingLength = 255
    bAlternateSettingFormat = FieldFormatEnum.NUMBER
    bAlternateSettingName = "bAlternateSetting"
    bAlternateSettingMatch = bAlternateSettingName.casefold()
    bAlternateSettingLastMandatoryValueIndex = 0
    bAlternateSettingSourceIndexPattern = "INTERFACE_BALTERNATESETTING_INDEX => "
    bAlternateSettingSourceCountPattern = "INTERFACE_BALTERNATESETTING_COUNT => "

    # bNumEndpoints (1 byte)
    bNumEndpoints = []
    bNumEndpointsLength = 255
    bNumEndpointsFormat = FieldFormatEnum.NUMBER
    bNumEndpointsName = "bNumEndpoints"
    bNumEndpointsMatch = bNumEndpointsName.casefold()
    bNumEndpointsLastMandatoryValueIndex = 0
    bNumEndpointsSourceIndexPattern = "INTERFACE_BNUMENDPOINTS_INDEX => "
    bNumEndpointsSourceCountPattern = "INTERFACE_BNUMENDPOINTS_COUNT => "

    # bInterfaceClass (1 byte)
    bInterfaceClass = []
    bInterfaceClassLength = 2
    bInterfaceClassFormat = FieldFormatEnum.HEX
    bInterfaceClassName = "bInterfaceClass"
    bInterfaceClassMatch = bInterfaceClassName.casefold()
    bInterfaceClassLastMandatoryValueIndex = 0
    bInterfaceClassSourceIndexPattern = "INTERFACE_BINTERFACECLASS_INDEX => "
    bInterfaceClassSourceCountPattern = "INTERFACE_BINTERFACECLASS_COUNT => "

    # bInterfaceSubClass (1 byte)
    bInterfaceSubClass = []
    bInterfaceSubClassLength = 2
    bInterfaceSubClassFormat = FieldFormatEnum.HEX
    bInterfaceSubClassName = "bInterfaceSubClass"
    bInterfaceSubClassMatch = bInterfaceSubClassName.casefold()
    bInterfaceSubClassLastMandatoryValueIndex = 0
    bInterfaceSubClassSourceIndexPattern = "INTERFACE_BINTERFACESUBCLASS_INDEX => "
    bInterfaceSubClassSourceCountPattern = "INTERFACE_BINTERFACESUBCLASS_COUNT => "

    # bInterfaceProtocol (1 byte)
    bInterfaceProtocol = []
    bInterfaceProtocolLength = 2
    bInterfaceProtocolFormat = FieldFormatEnum.HEX
    bInterfaceProtocolName = "bInterfaceProtocol"
    bInterfaceProtocolMatch = bInterfaceProtocolName.casefold()
    bInterfaceProtocolLastMandatoryValueIndex = 0
    bInterfaceProtocolSourceIndexPattern = "INTERFACE_BINTERFACEPROTOCOL_INDEX => "
    bInterfaceProtocolSourceCountPattern = "INTERFACE_BINTERFACEPROTOCOL_COUNT => "

    # Interface String Special Field
    # iInterface bLength (1 byte)
    iInterfacebLength = []
    iInterfacebLengthLength = 255
    iInterfacebLengthFormat = FieldFormatEnum.NUMBER
    iInterfacebLengthName = "iInterfacebLength"
    iInterfacebLengthMatch = iInterfacebLengthName.casefold()
    iInterfacebLengthLastMandatoryValueIndex = 0
    iInterfacebLengthSourceIndexPattern = "INTERFACE_IINTERFACE_BLENGTH_INDEX => "
    iInterfacebLengthSourceCountPattern = "INTERFACE_IINTERFACE_BLENGTH_COUNT => "

    # Interface String Special Field
    # iInterface (253 bytes)
    iInterface = []
    iInterfaceLength = 253
    iInterfaceFormat = FieldFormatEnum.STRING
    iInterfaceName = "iInterface"
    iInterfaceMatch = iInterfaceName.casefold()
    iInterfaceLastMandatoryValueIndex = 0
    iInterfaceSourceIndexPattern = "INTERFACE_IINTERFACE_INDEX => "
    iInterfaceSourceCountPattern = "INTERFACE_IINTERFACE_COUNT => "

    #########################################
    ## Public Interface Descriptor Methods ##
    #########################################

    ### is Interface Descriptor Requested ###
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

            # bInterfaceNumber
            case self.bInterfaceNumberMatch:
                # New Value to Add
                newValue = VerificationValue(value, self.bInterfaceNumberLength, self.bInterfaceNumberFormat, verificationLevel, operator)

                # Handle Verification Level Priority (Mandatory First)
                if (VerificationLevelEnum.MANDATORY == newValue.verificationLevel):
                    # Add New Mandatory Value
                    self.bInterfaceNumber.insert(self.bInterfaceNumberLastMandatoryValueIndex, newValue)
                    self.bInterfaceNumberLastMandatoryValueIndex += 1

                # Optional New Value (add the end of the list)
                else:
                    self.bInterfaceNumber.append(newValue)

            # bAlternateSetting
            case self.bAlternateSettingMatch:
                # New Value to Add
                newValue = VerificationValue(value, self.bAlternateSettingLength, self.bAlternateSettingFormat, verificationLevel, operator)

                # Handle Verification Level Priority (Mandatory First)
                if (VerificationLevelEnum.MANDATORY == newValue.verificationLevel):
                    # Add New Mandatory Value
                    self.bAlternateSetting.insert(self.bAlternateSettingLastMandatoryValueIndex, newValue)
                    self.bAlternateSettingLastMandatoryValueIndex += 1

                # Optional New Value (add the end of the list)
                else:
                    self.bAlternateSetting.append(newValue)

            # bNumEndpoints
            case self.bNumEndpointsMatch:
                # New Value to Add
                newValue = VerificationValue(value, self.bNumEndpointsLength, self.bNumEndpointsFormat, verificationLevel, operator)

                # Handle Verification Level Priority (Mandatory First)
                if (VerificationLevelEnum.MANDATORY == newValue.verificationLevel):
                    # Add New Mandatory Value
                    self.bNumEndpoints.insert(self.bNumEndpointsLastMandatoryValueIndex, newValue)
                    self.bNumEndpointsLastMandatoryValueIndex += 1

                # Optional New Value (add the end of the list)
                else:
                    self.bNumEndpoints.append(newValue)

            # bInterfaceClass
            case self.bInterfaceClassMatch:
                # New Value to Add
                newValue = VerificationValue(value, self.bInterfaceClassLength, self.bInterfaceClassFormat, verificationLevel, operator)

                # Handle Verification Level Priority (Mandatory First)
                if (VerificationLevelEnum.MANDATORY == newValue.verificationLevel):
                    # Add New Mandatory Value
                    self.bInterfaceClass.insert(self.bInterfaceClassLastMandatoryValueIndex, newValue)
                    self.bInterfaceClassLastMandatoryValueIndex += 1

                # Optional New Value (add the end of the list)
                else:
                    self.bInterfaceClass.append(newValue)

            # bInterfaceSubClass
            case self.bInterfaceSubClassMatch:
                # New Value to Add
                newValue = VerificationValue(value, self.bInterfaceSubClassLength, self.bInterfaceSubClassFormat, verificationLevel, operator)

                # Handle Verification Level Priority (Mandatory First)
                if (VerificationLevelEnum.MANDATORY == newValue.verificationLevel):
                    # Add New Mandatory Value
                    self.bInterfaceSubClass.insert(self.bInterfaceSubClassLastMandatoryValueIndex, newValue)
                    self.bInterfaceSubClassLastMandatoryValueIndex += 1

                # Optional New Value (add the end of the list)
                else:
                    self.bInterfaceSubClass.append(newValue)

            # bInterfaceProtocol
            case self.bInterfaceProtocolMatch:
                # New Value to Add
                newValue = VerificationValue(value, self.bInterfaceProtocolLength, self.bInterfaceProtocolFormat, verificationLevel, operator)

                # Handle Verification Level Priority (Mandatory First)
                if (VerificationLevelEnum.MANDATORY == newValue.verificationLevel):
                    # Add New Mandatory Value
                    self.bInterfaceProtocol.insert(self.bInterfaceProtocolLastMandatoryValueIndex, newValue)
                    self.bInterfaceProtocolLastMandatoryValueIndex += 1

                # Optional New Value (add the end of the list)
                else:
                    self.bInterfaceProtocol.append(newValue)

            # iInterface bLength
            case self.iInterfacebLengthMatch:
                # New Value to Add
                newValue = VerificationValue(value, self.iInterfacebLengthLength, self.iInterfacebLengthFormat, verificationLevel, operator)

                # Handle Verification Level Priority (Mandatory First)
                if (VerificationLevelEnum.MANDATORY == newValue.verificationLevel):
                    # Add New Mandatory Value
                    self.iInterfacebLength.insert(self.iInterfacebLengthLastMandatoryValueIndex, newValue)
                    self.iInterfacebLengthLastMandatoryValueIndex += 1

                # Optional New Value (add the end of the list)
                else:
                    self.iInterfacebLength.append(newValue)

            # iInterface
            case self.iInterfaceMatch:
                # New Value to Add
                newValue = VerificationValue(value, self.iInterfaceLength, self.iInterfaceFormat, verificationLevel, operator)

                # Handle Verification Level Priority (Mandatory First)
                if (VerificationLevelEnum.MANDATORY == newValue.verificationLevel):
                    # Add New Mandatory Value
                    self.iInterface.insert(self.iInterfaceLastMandatoryValueIndex, newValue)
                    self.iInterfaceLastMandatoryValueIndex += 1

                # Optional New Value (add the end of the list)
                else:
                    self.iInterface.append(newValue)

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

            # bInterfaceNumber
            case self.bInterfaceNumberMatch:
                if (operator == None):
                    self.bInterfaceNumber = [el for el in self.bInterfaceNumber if el.value != value]
                else:
                    self.bInterfaceNumber = [el for el in self.bInterfaceNumber if el.value != value and el.operator != operator]

            # bAlternateSetting
            case self.bAlternateSettingMatch:
                if (operator == None):
                    self.bAlternateSetting = [el for el in self.bAlternateSetting if el.value != value]
                else:
                    self.bAlternateSetting = [el for el in self.bAlternateSetting if el.value != value and el.operator != operator]

            # bNumEndpoints
            case self.bNumEndpointsMatch:
                if (operator == None):
                    self.bNumEndpoints = [el for el in self.bNumEndpoints if el.value != value]
                else:
                    self.bNumEndpoints = [el for el in self.bNumEndpoints if el.value != value and el.operator != operator]

            # bInterfaceClass
            case self.bInterfaceClassMatch:
                if (operator == None):
                    self.bInterfaceClass = [el for el in self.bInterfaceClass if el.value != value]
                else:
                    self.bInterfaceClass = [el for el in self.bInterfaceClass if el.value != value and el.operator != operator]

            # bInterfaceSubClass
            case self.bInterfaceSubClassMatch:
                if (operator == None):
                    self.bInterfaceSubClass = [el for el in self.bInterfaceSubClass if el.value != value]
                else:
                    self.bInterfaceSubClass = [el for el in self.bInterfaceSubClass if el.value != value and el.operator != operator]

            # bInterfaceProtocol
            case self.bInterfaceProtocolMatch:
                if (operator == None):
                    self.bInterfaceProtocol = [el for el in self.bInterfaceProtocol if el.value != value]
                else:
                    self.bInterfaceProtocol = [el for el in self.bInterfaceProtocol if el.value != value and el.operator != operator]

            # iInterface bLength
            case self.iInterfacebLengthMatch:
                if (operator == None):
                    self.iInterfacebLength = [el for el in self.iInterfacebLength if el.value != value]
                else:
                    self.iInterfaceLength = [el for el in self.iInterfacebLength if el.value != value and el.operator != operator]

            # iInterface
            case self.iInterfaceMatch:
                if (operator == None):
                    self.iInterface = [el for el in self.iInterface if el.value != value]
                else:
                    self.iInterface = [el for el in self.iInterface if el.value != value and el.operator != operator]

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

            # bInterfaceNumber
            case self.bInterfaceNumberMatch:
                print(self.bInterfaceNumberName + ":\n")
                for el in self.bInterfaceNumber: el.showDetails()

            # bAlternateSetting
            case self.bAlternateSettingMatch:
                print(self.bAlternateSettingName + ":\n")
                for el in self.bAlternateSetting: el.showDetails()

            # bNumEndpoints
            case self.bNumEndpointsMatch:
                print(self.bNumEndpointsName + ":\n")
                for el in self.bNumEndpoints: el.showDetails()

            # bInterfaceClass
            case self.bInterfaceClassMatch:
                print(self.bInterfaceClassName + ":\n")
                for el in self.bInterfaceClass: el.showDetails()

            # bInterfaceSubClass
            case self.bInterfaceSubClassMatch:
                print(self.bInterfaceSubClassName + ":\n")
                for el in self.bInterfaceSubClass: el.showDetails()

            # bInterfaceProtocol
            case self.bInterfaceProtocolMatch:
                print(self.bInterfaceProtocolName + ":\n")
                for el in self.bInterfaceProtocol: el.showDetails()

            # iInterface bLength
            case self.iInterfacebLengthMatch:
                print(self.iInterfacebLengthName + ":\n")
                for el in self.iInterfacebLength: el.showDetails()

            # iInterface
            case self.iInterfaceMatch:
                print(self.iInterfaceName + ":\n")
                for el in self.iInterface: el.showDetails()

            # Unknown Field
            case _:
                raise Exception("Unkown " + self.DESCRIPTOR_NAME + " Field: " + fieldName)

    ### Print All Device Descriptor Field Values ###
    def displayAllVerificationValues(self):
        print("---", self.DESCRIPTOR_NAME, "---")

        # bLength
        self.displayVerificationValues(self.bLengthName)

        # bInterfaceNumber
        self.displayVerificationValues(self.bInterfaceNumberName)

        # bAlternateSetting
        self.displayVerificationValues(self.bAlternateSettingName)

        # bNumEndpoints
        self.displayVerificationValues(self.bNumEndpointsName)

        # bInterfaceClass
        self.displayVerificationValues(self.bInterfaceClassName)

        # bInterfaceSubClass
        self.displayVerificationValues(self.bInterfaceSubClassName)

        # bInterfaceProtocol
        self.displayVerificationValues(self.bInterfaceProtocolName)

        # iInterface bLength
        self.displayVerificationValues(self.iInterfacebLengthName)

        # iInterface
        self.displayVerificationValues(self.iInterfaceName)

    ### Get Verification Values ###
    ### Return: [ [USB Field, Operator, Value, Verification Level] ]
    def getVerificationValues(self):
        valueList = []

        # bLength
        for el in self.bLength:
            valueList.append([self.bLengthName, el.operator.name.capitalize(), el.value, el.verificationLevel.name])

        # bInterfaceNumber
        for el in self.bInterfaceNumber:
            valueList.append([self.bInterfaceNumberName, el.operator.name.capitalize(), el.value, el.verificationLevel.name])

        # bAlternateSetting
        for el in self.bAlternateSetting:
            valueList.append([self.bAlternateSettingName, el.operator.name.capitalize(), el.value, el.verificationLevel.name])

        # bNumEndpoints
        for el in self.bNumEndpoints:
            valueList.append([self.bNumEndpointsName, el.operator.name.capitalize(), el.value, el.verificationLevel.name])

        # bInterfaceClass
        for el in self.bInterfaceClass:
            valueList.append([self.bInterfaceClassName, el.operator.name.capitalize(), el.value, el.verificationLevel.name])

        # bInterfaceSubClass
        for el in self.bInterfaceSubClass:
            valueList.append([self.bInterfaceSubClassName, el.operator.name.capitalize(), el.value, el.verificationLevel.name])

        # bInterfaceProtocol
        for el in self.bInterfaceProtocol:
            valueList.append([self.bInterfaceProtocolName, el.operator.name.capitalize(), el.value, el.verificationLevel.name])

        # iInterface bLength
        for el in self.iInterfacebLength:
            valueList.append([self.iInterfacebLengthName, el.operator.name.capitalize(), el.value, el.verificationLevel.name])

        # iInterface
        for el in self.iInterface:
            valueList.append([self.iInterfaceName, el.operator.name.capitalize(), el.value, el.verificationLevel.name])

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

        # bInterfaceNumber
        for el in self.bInterfaceNumber:
            if (operator == el.operator):
                count += el.getMemoryUsage()

        # Add Result & Reset Counter
        result.append([self.bInterfaceNumberName, count])
        count = 0

        # bAlternateSetting
        for el in self.bAlternateSetting:
            if (operator == el.operator):
                count += el.getMemoryUsage()

        # Add Result & Reset Counter
        result.append([self.bAlternateSettingName, count])
        count = 0

        # bNumEndpoints
        for el in self.bNumEndpoints:
            if (operator == el.operator):
                count += el.getMemoryUsage()

        # Add Result & Reset Counter
        result.append([self.bNumEndpointsName, count])
        count = 0

        # bInterfaceClass
        for el in self.bInterfaceClass:
            if (operator == el.operator):
                count += el.getMemoryUsage()

        # Add Result & Reset Counter
        result.append([self.bInterfaceClassName, count])
        count = 0

        # bInterfaceSubClass
        for el in self.bInterfaceSubClass:
            if (operator == el.operator):
                count += el.getMemoryUsage()

        # Add Result & Reset Counter
        result.append([self.bInterfaceSubClassName, count])
        count = 0

        # bInterfaceProtocol
        for el in self.bInterfaceProtocol:
            if (operator == el.operator):
                count += el.getMemoryUsage()

        # Add Result & Reset Counter
        result.append([self.bInterfaceProtocolName, count])

        # iInterface bLength
        for el in self.iInterfacebLength:
            if (operator == el.operator):
                count += el.getMemoryUsage()

        # Add Result & Reset Counter
        result.append([self.iInterfacebLengthName, count])

        # iInterface
        for el in self.iInterface:
            if (operator == el.operator):
                count += el.getMemoryUsage()

        # Add Result & Reset Counter
        result.append([self.iInterfaceName, count])

        # End of Process
        return result

    ### Check if Operator is used by the Descriptor (at least once) ###
    ### Return: True/False
    def isOperatorInUse(self, operator):

        # bLength
        for el in self.bLength:
            if (operator == el.operator):
                return True

        # bInterfaceNumber
        for el in self.bInterfaceNumber:
            if (operator == el.operator):
                return True

        # bAlternateSetting
        for el in self.bAlternateSetting:
            if (operator == el.operator):
                return True

        # bNumEndpoints
        for el in self.bNumEndpoints:
            if (operator == el.operator):
                return True

        # bInterfaceClass
        for el in self.bInterfaceClass:
            if (operator == el.operator):
                return True

        # bInterfaceSubClass
        for el in self.bInterfaceSubClass:
            if (operator == el.operator):
                return True

        # bInterfaceProtocol
        for el in self.bInterfaceProtocol:
            if (operator == el.operator):
                return True

        # iInterface bLength
        for el in self.iInterfacebLength:
            if (operator == el.operator):
                return True

        # iInterface
        for el in self.iInterface:
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

        # bInterfaceNumber
        memoryValueConfig = []
        for el in self.bInterfaceNumber:
            if (operator == el.operator):
                # Convert Memory Configurations
                for e in el.convertToMemConfig():
                    memoryValueConfig.append(e)

        # Order & Add Memory Values
        for el in VerificationValue.generateMemoryValues(memoryValueConfig):
            result.append(el)

        # bAlternateSetting
        memoryValueConfig = []
        for el in self.bAlternateSetting:
            if (operator == el.operator):
                # Convert Memory Configurations
                for e in el.convertToMemConfig():
                    memoryValueConfig.append(e)

        # Order & Add Memory Values
        for el in VerificationValue.generateMemoryValues(memoryValueConfig):
            result.append(el)

        # bNumEndpoints
        memoryValueConfig = []
        for el in self.bNumEndpoints:
            if (operator == el.operator):
                # Convert Memory Configurations
                for e in el.convertToMemConfig():
                    memoryValueConfig.append(e)

        # Order & Add Memory Values
        for el in VerificationValue.generateMemoryValues(memoryValueConfig):
            result.append(el)

        # bInterfaceClass
        memoryValueConfig = []
        for el in self.bInterfaceClass:
            if (operator == el.operator):
                # Convert Memory Configurations
                for e in el.convertToMemConfig():
                    memoryValueConfig.append(e)

        # Order & Add Memory Values
        for el in VerificationValue.generateMemoryValues(memoryValueConfig):
            result.append(el)

        # bInterfaceSubClass
        memoryValueConfig = []
        for el in self.bInterfaceSubClass:
            if (operator == el.operator):
                # Convert Memory Configurations
                for e in el.convertToMemConfig():
                    memoryValueConfig.append(e)

        # Order & Add Memory Values
        for el in VerificationValue.generateMemoryValues(memoryValueConfig):
            result.append(el)

        # bInterfaceProtocol
        memoryValueConfig = []
        for el in self.bInterfaceProtocol:
            if (operator == el.operator):
                # Convert Memory Configurations
                for e in el.convertToMemConfig():
                    memoryValueConfig.append(e)

        # Order & Add Memory Values
        for el in VerificationValue.generateMemoryValues(memoryValueConfig):
            result.append(el)

        # iInterface bLength
        memoryValueConfig = []
        for el in self.iInterfacebLength:
            if (operator == el.operator):
                # Convert Memory Configurations
                for e in el.convertToMemConfig():
                    memoryValueConfig.append(e)

        # Order & Add Memory Values
        for el in VerificationValue.generateMemoryValues(memoryValueConfig):
            result.append(el)
            
        # iInterface
        memoryValueConfig = []
        for el in self.iInterface:
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

        # bInterfaceNumber
        largestPartVerif = self.__getLargestVerificationNumber(self.bInterfaceNumber, largestPartVerif)

        # bAlternateSetting
        largestPartVerif = self.__getLargestVerificationNumber(self.bAlternateSetting, largestPartVerif)

        # bNumEndpoints
        largestPartVerif = self.__getLargestVerificationNumber(self.bNumEndpoints, largestPartVerif)

        # bInterfaceClass
        largestPartVerif = self.__getLargestVerificationNumber(self.bInterfaceClass, largestPartVerif)

        # bInterfaceSubClass
        largestPartVerif = self.__getLargestVerificationNumber(self.bInterfaceSubClass, largestPartVerif)

        # bInterfaceProtocol
        largestPartVerif = self.__getLargestVerificationNumber(self.bInterfaceProtocol, largestPartVerif)        

        # iInterface bLength
        largestPartVerif = self.__getLargestVerificationNumber(self.iInterfacebLength, largestPartVerif)        

        # iInterface
        largestPartVerif = self.__getLargestVerificationNumber(self.iInterface, largestPartVerif)        

        return largestPartVerif

    ### Check if the Descriptor is InUse (at least on Value) ###
    ### Return True/False
    def isDescriptorInUse(self):

        # bLength
        for el in self.bLength:
            return True

        # bInterfaceNumber
        for el in self.bInterfaceNumber:
            return True

        # bAlternateSetting
        for el in self.bAlternateSetting:
            return True

        # bNumEndpoints
        for el in self.bNumEndpoints:
            return True

        # bInterfaceClass
        for el in self.bInterfaceClass:
            return True

        # bInterfaceSubClass
        for el in self.bInterfaceSubClass:
            return True

        # bInterfaceProtocol
        for el in self.bInterfaceProtocol:
            return True

        # iInterface bLength
        for el in self.iInterfacebLength:
            return True

        # iInterface
        for el in self.iInterface:
            return True

        # Descriptor not used
        return False

    ################################################
    ## Public Static Interface Descriptor Methods ##
    ################################################

    ### Get Source File Index & Count Pattern for specific Device Descriptor field ###
    ### Return (Index Pattern, Count Pattern)
    @staticmethod
    def getSourceIndexCountPattern(fieldName):
        match fieldName:

            # bLength
            case InterfaceDescriptor.bLengthName:
                return (InterfaceDescriptor.bLengthSourceIndexPattern, InterfaceDescriptor.bLengthSourceCountPattern)

            # bInterfaceNumber
            case InterfaceDescriptor.bInterfaceNumberName:
                return (InterfaceDescriptor.bInterfaceNumberSourceIndexPattern, InterfaceDescriptor.bInterfaceNumberSourceCountPattern)
            
            # bAlternateSetting
            case InterfaceDescriptor.bAlternateSettingName:
                return (InterfaceDescriptor.bAlternateSettingSourceIndexPattern, InterfaceDescriptor.bAlternateSettingSourceCountPattern)
            
            # bNumEndpoints
            case InterfaceDescriptor.bNumEndpointsName:
                return (InterfaceDescriptor.bNumEndpointsSourceIndexPattern, InterfaceDescriptor.bNumEndpointsSourceCountPattern)
            
            # bInterfaceClass
            case InterfaceDescriptor.bInterfaceClassName:
                return (InterfaceDescriptor.bInterfaceClassSourceIndexPattern, InterfaceDescriptor.bInterfaceClassSourceCountPattern)
            
            # bInterfaceSubClass
            case InterfaceDescriptor.bInterfaceSubClassName:
                return (InterfaceDescriptor.bInterfaceSubClassSourceIndexPattern, InterfaceDescriptor.bInterfaceSubClassSourceCountPattern)
            
            # bInterfaceProtocol
            case InterfaceDescriptor.bInterfaceProtocolName:
                return (InterfaceDescriptor.bInterfaceProtocolSourceIndexPattern, InterfaceDescriptor.bInterfaceProtocolSourceCountPattern)

            # iInterface bLength
            case InterfaceDescriptor.iInterfacebLengthName:
                return (InterfaceDescriptor.iInterfacebLengthSourceIndexPattern, InterfaceDescriptor.iInterfacebLengthSourceCountPattern)

            # iInterface
            case InterfaceDescriptor.iInterfaceName:
                return (InterfaceDescriptor.iInterfaceSourceIndexPattern, InterfaceDescriptor.iInterfaceSourceCountPattern)

            # Unknown Field
            case _:
                raise("Unkown", InterfaceDescriptor.DESCRIPTOR_NAME, "Field:", fieldName)

    ##########################################
    ## Private Interface Descriptor Methods ##
    ##########################################

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
