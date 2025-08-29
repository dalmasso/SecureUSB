########################################################################
## Engineer:    Dalmasso Loic
## Create Date: 25/07/2025
## Module Name: StringDescriptor
## Description: USB String Descriptor Class containing fields to verify
########################################################################

import statistics

from FieldFormatEnum import FieldFormatEnum
from VerificationValue import VerificationValue
from VerificationLevelEnum import VerificationLevelEnum

class StringDescriptor:

    #################################
    ## String Descriptor Constants ##
    #################################

    # Descriptor Type
    DESCRIPTOR_TYPE = "String"

    # Descriptor Name
    DESCRIPTOR_NAME = "String Descriptor"

    # Descriptor Dependencies
    DEVICE_DEPENDENCY = "device"
    CONFIGURATION_DEPENDENCY = "configuration"
    INTERFACE_DEPENDENCY = "interface"

    #################################
    ## String Descriptor Variables ##
    #################################

    # bLength (1 byte)
    bLength = []
    bLengthLength = 255
    bLengthFormat = FieldFormatEnum.NUMBER
    bLengthName = "bLength"
    bLengthMatch = bLengthName.casefold()
    bLengthLastMandatoryValueIndex = 0
    bLengthSourceIndexPattern = "STRING_BLENGTH_INDEX => "
    bLengthSourceCountPattern = "STRING_BLENGTH_COUNT => "

    # iManufacturer (253 bytes)
    iManufacturer = []
    iManufacturerLength = 253
    iManufacturerFormat = FieldFormatEnum.STRING
    iManufacturerName = "iManufacturer"
    iManufacturerMatch = iManufacturerName.casefold()
    iManufacturerLastMandatoryValueIndex = 0
    iManufacturerSourceIndexPattern = "STRING_IMANUFACTURER_INDEX => "
    iManufacturerSourceCountPattern = "STRING_IMANUFACTURER_COUNT => "

    # iProduct (253 bytes)
    iProduct = []
    iProductLength = 253
    iProductFormat = FieldFormatEnum.STRING
    iProductName = "iProduct"
    iProductMatch = iProductName.casefold()
    iProductLastMandatoryValueIndex = 0
    iProductSourceIndexPattern = "STRING_IPRODUCT_INDEX => "
    iProductSourceCountPattern = "STRING_IPRODUCT_COUNT => "

    # iSerialNumber (253 bytes)
    iSerialNumber = []
    iSerialNumberLength = 253
    iSerialNumberFormat = FieldFormatEnum.STRING
    iSerialNumberName = "iSerialNumber"
    iSerialNumberMatch = iSerialNumberName.casefold()
    iSerialNumberLastMandatoryValueIndex = 0
    iSerialNumberSourceIndexPattern = "STRING_ISERIALNUMBER_INDEX => "
    iSerialNumberSourceCountPattern = "STRING_ISERIALNUMBER_COUNT => "

    # iConfiguration (253 bytes)
    iConfiguration = []
    iConfigurationLength = 253
    iConfigurationFormat = FieldFormatEnum.STRING
    iConfigurationName = "iConfiguration"
    iConfigurationMatch = iConfigurationName.casefold()
    iConfigurationLastMandatoryValueIndex = 0
    iConfigurationSourceIndexPattern = "STRING_ICONFIGURATION_INDEX => "
    iConfigurationSourceCountPattern = "STRING_ICONFIGURATION_COUNT => "

    # iInterface (253 bytes)
    iInterface = []
    iInterfaceLength = 253
    iInterfaceFormat = FieldFormatEnum.STRING
    iInterfaceName = "iInterface"
    iInterfaceMatch = iInterfaceName.casefold()
    iInterfaceLastMandatoryValueIndex = 0
    iInterfaceSourceIndexPattern = "STRING_IINTERFACE_INDEX => "
    iInterfaceSourceCountPattern = "STRING_IINTERFACE_COUNT => "

    ######################################
    ## Public String Descriptor Methods ##
    ######################################

    ### is String Descriptor Requested ###
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

            # iManufacturer
            case self.iManufacturerMatch:
                # New Value to Add
                newValue = VerificationValue(value, self.iManufacturerLength, self.iManufacturerFormat, verificationLevel, operator)

                # Handle Verification Level Priority (Mandatory First)
                if (VerificationLevelEnum.MANDATORY == newValue.verificationLevel):
                    # Add New Mandatory Value
                    self.iManufacturer.insert(self.iManufacturerLastMandatoryValueIndex, newValue)
                    self.iManufacturerLastMandatoryValueIndex += 1

                # Optional New Value (add the end of the list)
                else:
                    self.iManufacturer.append(newValue)

            # iProduct
            case self.iProductMatch:
                # New Value to Add
                newValue = VerificationValue(value, self.iProductLength, self.iProductFormat, verificationLevel, operator)

                # Handle Verification Level Priority (Mandatory First)
                if (VerificationLevelEnum.MANDATORY == newValue.verificationLevel):
                    # Add New Mandatory Value
                    self.iProduct.insert(self.iProductLastMandatoryValueIndex, newValue)
                    self.iProductLastMandatoryValueIndex += 1

                # Optional New Value (add the end of the list)
                else:
                    self.iProduct.append(newValue)

            # iSerialNumber
            case self.iSerialNumberMatch:
                # New Value to Add
                newValue = VerificationValue(value, self.iSerialNumberLength, self.iSerialNumberFormat, verificationLevel, operator)

                # Handle Verification Level Priority (Mandatory First)
                if (VerificationLevelEnum.MANDATORY == newValue.verificationLevel):
                    # Add New Mandatory Value
                    self.iSerialNumber.insert(self.iSerialNumberLastMandatoryValueIndex, newValue)
                    self.iSerialNumberLastMandatoryValueIndex += 1

                # Optional New Value (add the end of the list)
                else:
                    self.iSerialNumber.append(newValue)

            # iConfiguration
            case self.iConfigurationMatch:
                # New Value to Add
                newValue = VerificationValue(value, self.iConfigurationLength, self.iConfigurationFormat, verificationLevel, operator)

                # Handle Verification Level Priority (Mandatory First)
                if (VerificationLevelEnum.MANDATORY == newValue.verificationLevel):
                    # Add New Mandatory Value
                    self.iConfiguration.insert(self.iConfigurationLastMandatoryValueIndex, newValue)
                    self.iConfigurationLastMandatoryValueIndex += 1

                # Optional New Value (add the end of the list)
                else:
                    self.iConfiguration.append(newValue)

            # iConfiguration
            case self.iInterfaceMatch:
                # New Value to Add
                newValue = VerificationValue(value, self.iInterfaceLength, self.iInterfaceFormat, verificationLevel, operator)

                # Handle Verification Level Priority (Mandatory First)
                if (VerificationLevelEnum.MANDATORY == newValue.verificationLevel):
                    # Add New Mandatory Value
                    self.iConfiguration.insert(self.iConfigurationLastMandatoryValueIndex, newValue)
                    self.iConfigurationLastMandatoryValueIndex += 1

                # Optional New Value (add the end of the list)
                else:
                    self.iConfiguration.append(newValue)

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

            # iManufacturer
            case self.iManufacturerMatch:
                if (operator == None):
                    self.iManufacturer = [el for el in self.iManufacturer if el.value != value]
                else:
                    self.iManufacturer = [el for el in self.iManufacturer if el.value != value and el.operator != operator]

            # iProduct
            case self.iProductMatch:
                if (operator == None):
                    self.iProduct = [el for el in self.iProduct if el.value != value]
                else:
                    self.iProduct = [el for el in self.iProduct if el.value != value and el.operator != operator]

            # iSerialNumber
            case self.iSerialNumberMatch:
                if (operator == None):
                    self.iSerialNumber = [el for el in self.iSerialNumber if el.value != value]
                else:
                    self.iSerialNumber = [el for el in self.iSerialNumber if el.value != value and el.operator != operator]

            # iConfiguration
            case self.iConfigurationMatch:
                if (operator == None):
                    self.iConfiguration = [el for el in self.iConfiguration if el.value != value]
                else:
                    self.iConfiguration = [el for el in self.iConfiguration if el.value != value and el.operator != operator]

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

            # iManufacturer
            case self.iManufacturerMatch:
                print(self.iManufacturerName + ":\n")
                for el in self.iManufacturer: el.showDetails()

            # iProduct
            case self.iProductMatch:
                print(self.iProductName + ":\n")
                for el in self.iProduct: el.showDetails()

            # iSerialNumber
            case self.iSerialNumberMatch:
                print(self.iSerialNumberName + ":\n")
                for el in self.iSerialNumber: el.showDetails()

            # iConfiguration
            case self.iConfigurationMatch:
                print(self.iConfigurationName + ":\n")
                for el in self.iConfiguration: el.showDetails()

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

        # iManufacturer
        self.displayVerificationValues(self.iManufacturerName)

        # iProduct
        self.displayVerificationValues(self.iProductName)

        # iSerialNumber
        self.displayVerificationValues(self.iSerialNumberName)

        # iConfiguration
        self.displayVerificationValues(self.iConfigurationName)

        # iInterface
        self.displayVerificationValues(self.iInterfaceName)

    ### Get Verification Values ###
    ### Return: [ [USB Field, Operator, Value, Verification Level] ]
    def getVerificationValues(self):
        valueList = []

        # bLength
        for el in self.bLength:
            valueList.append([self.bLengthName, el.operator.name.capitalize(), el.value, el.verificationLevel.name])

        # iManufacturer
        for el in self.iManufacturer:
            valueList.append([self.iManufacturerName, el.operator.name.capitalize(), el.value, el.verificationLevel.name])

        # iProduct
        for el in self.iProduct:
            valueList.append([self.iProductName, el.operator.name.capitalize(), el.value, el.verificationLevel.name])

        # iSerialNumber
        for el in self.iSerialNumber:
            valueList.append([self.iSerialNumberName, el.operator.name.capitalize(), el.value, el.verificationLevel.name])

        # iConfiguration
        for el in self.iConfiguration:
            valueList.append([self.iConfigurationName, el.operator.name.capitalize(), el.value, el.verificationLevel.name])

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

        # iManufacturer
        for el in self.iManufacturer:
            if (operator == el.operator):
                count += el.getMemoryUsage()

        # Add Result & Reset Counter
        result.append([self.iManufacturerName, count])
        count = 0

        # iProduct
        for el in self.iProduct:
            if (operator == el.operator):
                count += el.getMemoryUsage()

        # Add Result & Reset Counter
        result.append([self.iProductName, count])
        count = 0

        # iSerialNumber
        for el in self.iSerialNumber:
            if (operator == el.operator):
                count += el.getMemoryUsage()

        # Add Result & Reset Counter
        result.append([self.iSerialNumberName, count])
        count = 0

        # iConfiguration
        for el in self.iConfiguration:
            if (operator == el.operator):
                count += el.getMemoryUsage()

        # Add Result & Reset Counter
        result.append([self.iConfigurationName, count])
        count = 0

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

        # iManufacturer
        for el in self.iManufacturer:
            if (operator == el.operator):
                return True

        # iProduct
        for el in self.iProduct:
            if (operator == el.operator):
                return True

        # iSerialNumber
        for el in self.iSerialNumber:
            if (operator == el.operator):
                return True

        # iConfiguration
        for el in self.iConfiguration:
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

        # iManufacturer
        memoryValueConfig = []
        for el in self.iManufacturer:
            if (operator == el.operator):
                # Convert Memory Configurations
                for e in el.convertToMemConfig():
                    memoryValueConfig.append(e)

        # Order & Add Memory Values
        for el in VerificationValue.generateMemoryValues(memoryValueConfig):
            result.append(el)

        # iProduct
        memoryValueConfig = []
        for el in self.iProduct:
            if (operator == el.operator):
                # Convert Memory Configurations
                for e in el.convertToMemConfig():
                    memoryValueConfig.append(e)

        # Order & Add Memory Values
        for el in VerificationValue.generateMemoryValues(memoryValueConfig):
            result.append(el)

        # iSerialNumber
        memoryValueConfig = []
        for el in self.iSerialNumber:
            if (operator == el.operator):
                # Convert Memory Configurations
                for e in el.convertToMemConfig():
                    memoryValueConfig.append(e)

        # Order & Add Memory Values
        for el in VerificationValue.generateMemoryValues(memoryValueConfig):
            result.append(el)

        # iConfiguration
        memoryValueConfig = []
        for el in self.iConfiguration:
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

        # iManufacturer
        largestPartVerif = self.__getLargestVerificationNumber(self.iManufacturer, largestPartVerif)

        # iProduct
        largestPartVerif = self.__getLargestVerificationNumber(self.iProduct, largestPartVerif)

        # iSerialNumber
        largestPartVerif = self.__getLargestVerificationNumber(self.iSerialNumber, largestPartVerif)

        # iConfiguration
        largestPartVerif = self.__getLargestVerificationNumber(self.iConfiguration, largestPartVerif)

        # iInterface
        largestPartVerif = self.__getLargestVerificationNumber(self.iInterface, largestPartVerif)
        return largestPartVerif

    ### Check if the Descriptor is InUse (at least on Value) ###
    ### Return (True/False, List[Require Descriptors])
    def isDescriptorInUse(self):
        inUse = False
        dependencies = []

        # bLength
        for el in self.bLength:
            return (True, [self.DEVICE_DEPENDENCY, self.CONFIGURATION_DEPENDENCY, self.INTERFACE_DEPENDENCY])

        # iManufacturer
        for el in self.iManufacturer:
            inUse = True
            dependencies.append(self.DEVICE_DEPENDENCY)
            break

        # iProduct
        for el in self.iProduct:
            inUse = True
            dependencies.append(self.DEVICE_DEPENDENCY)
            break

        # iSerialNumber
        for el in self.iSerialNumber:
            inUse = True
            dependencies.append(self.DEVICE_DEPENDENCY)
            break

        # iConfiguration
        for el in self.iConfiguration:
            inUse = True
            dependencies.append(self.CONFIGURATION_DEPENDENCY)
            break

        # iInterface
        for el in self.iInterface:
            inUse = True
            dependencies.append(self.INTERFACE_DEPENDENCY)
            break

        # Descriptor not used
        return (inUse, dependencies)

    #############################################
    ## Public Static String Descriptor Methods ##
    #############################################

    ### Get Source File Index & Count Pattern for specific Device Descriptor field ###
    ### Return (Index Pattern, Count Pattern)
    @staticmethod
    def getSourceIndexCountPattern(fieldName):
        match fieldName:

            # bLength
            case StringDescriptor.bLengthName:
                return (StringDescriptor.bLengthSourceIndexPattern, StringDescriptor.bLengthSourceCountPattern)

            # iManufacturer
            case StringDescriptor.iManufacturerName:
                return (StringDescriptor.iManufacturerSourceIndexPattern, StringDescriptor.iManufacturerSourceCountPattern)

            # iProduct
            case StringDescriptor.iProductName:
                return (StringDescriptor.iProductSourceIndexPattern, StringDescriptor.iProductSourceCountPattern)

            # iSerialNumber
            case StringDescriptor.iSerialNumberName:
                return (StringDescriptor.iSerialNumberSourceIndexPattern, StringDescriptor.iSerialNumberSourceCountPattern)

            # iConfiguration
            case StringDescriptor.iConfigurationName:
                return (StringDescriptor.iConfigurationSourceIndexPattern, StringDescriptor.iConfigurationSourceCountPattern)

            # iInterface
            case StringDescriptor.iInterfaceName:
                return (StringDescriptor.iInterfaceSourceIndexPattern, StringDescriptor.iInterfaceSourceCountPattern)

            # Unknown Field
            case _:
                raise("Unkown", StringDescriptor.DESCRIPTOR_NAME, "Field:", fieldName)

    #######################################
    ## Private String Descriptor Methods ##
    #######################################

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
