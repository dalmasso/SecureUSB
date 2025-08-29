########################################################################
## Engineer:    Dalmasso Loic
## Create Date: 25/07/2025
## Module Name: DeviceQualifierDescriptor
## Description: USB Device Qualifier Descriptor Class containing fields to verify
########################################################################

import statistics

from FieldFormatEnum import FieldFormatEnum
from VerificationValue import VerificationValue
from VerificationLevelEnum import VerificationLevelEnum

class DeviceQualifierDescriptor:

    ###########################################
    ## Device Qualifier Descriptor Constants ##
    ###########################################
    
    # Descriptor Type
    DESCRIPTOR_TYPE = "DeviceQualifier"

    # Descriptor Name
    DESCRIPTOR_NAME = "Device Qualifier Descriptor"

    ###########################################
    ## Device Qualifier Descriptor Variables ##
    ###########################################

    # bLength (1 byte)
    bLength = []
    bLengthLength = 255
    bLengthFormat = FieldFormatEnum.NUMBER
    bLengthName = "bLength"
    bLengthMatch = bLengthName.casefold()
    bLengthLastMandatoryValueIndex = 0
    bLengthSourceIndexPattern = "DEVICE_QUALIFIER_BLENGTH_INDEX => "
    bLengthSourceCountPattern = "DEVICE_QUALIFIER_BLENGTH_COUNT => "

    # bcdUsb (2 bytes)
    bcdUsb = []
    bcdUsbLength = 4
    bcdUsbFormat = FieldFormatEnum.HEX
    bcdUsbName = "bcdUsb"
    bcdUsbMatch = bcdUsbName.casefold()
    bcdUsbLastMandatoryValueIndex = 0
    bcdUsbSourceIndexPattern = "DEVICE_QUALIFIER_BCDUSB_INDEX => "
    bcdUsbSourceCountPattern = "DEVICE_QUALIFIER_BCDUSB_COUNT => "

    # bDeviceClass (1 byte)
    bDeviceClass = []
    bDeviceClassLength = 2
    bDeviceClassFormat = FieldFormatEnum.HEX
    bDeviceClassName = "bDeviceClass"
    bDeviceClassMatch = bDeviceClassName.casefold()
    bDeviceClassLastMandatoryValueIndex = 0
    bDeviceClassSourceIndexPattern = "DEVICE_QUALIFIER_BDEVICECLASS_INDEX => "
    bDeviceClassSourceCountPattern = "DEVICE_QUALIFIER_BDEVICECLASS_COUNT => "

    # bDeviceSubClass (1 byte)
    bDeviceSubClass = []
    bDeviceSubClassLength = 2
    bDeviceSubClassFormat = FieldFormatEnum.HEX
    bDeviceSubClassName = "bDeviceSubClass"
    bDeviceSubClassMatch = bDeviceSubClassName.casefold()
    bDeviceSubClassLastMandatoryValueIndex = 0
    bDeviceSubClassSourceIndexPattern = "DEVICE_QUALIFIER_BDEVICESUBCLASS_INDEX => "
    bDeviceSubClassSourceCountPattern = "DEVICE_QUALIFIER_BDEVICESUBCLASS_COUNT => "

    # bDeviceProtocol (1 byte)
    bDeviceProtocol = []
    bDeviceProtocolLength = 2
    bDeviceProtocolFormat = FieldFormatEnum.HEX
    bDeviceProtocolName = "bDeviceProtocol"
    bDeviceProtocolMatch = bDeviceProtocolName.casefold()
    bDeviceProtocolLastMandatoryValueIndex = 0
    bDeviceProtocolSourceIndexPattern = "DEVICE_QUALIFIER_BDEVICEPROTOCOL_INDEX => "
    bDeviceProtocolSourceCountPattern = "DEVICE_QUALIFIER_BDEVICEPROTOCOL_COUNT => "

    # bMaxPacketSize0 (1 byte)
    bMaxPacketSize0 = []
    bMaxPacketSize0Length = 255
    bMaxPacketSize0Format = FieldFormatEnum.NUMBER
    bMaxPacketSize0Name = "bMaxPacketSize0"
    bMaxPacketSize0Match = bMaxPacketSize0Name.casefold()
    bMaxPacketSize0LastMandatoryValueIndex = 0
    bMaxPacketSize0SourceIndexPattern = "DEVICE_QUALIFIER_BMAXPACKETSIZE0_INDEX => "
    bMaxPacketSize0SourceCountPattern = "DEVICE_QUALIFIER_BMAXPACKETSIZE0_COUNT => "

    # bNumConfigurations (1 byte)
    bNumConfigurations = []
    bNumConfigurationsLength = 255
    bNumConfigurationsFormat = FieldFormatEnum.NUMBER
    bNumConfigurationsName = "bNumConfigurations"
    bNumConfigurationsMatch = bNumConfigurationsName.casefold()
    bNumConfigurationsLastMandatoryValueIndex = 0
    bNumConfigurationsSourceIndexPattern = "DEVICE_QUALIFIER_BNUMCONFIGURATIONS_INDEX => "
    bNumConfigurationsSourceCountPattern = "DEVICE_QUALIFIER_BNUMCONFIGURATIONS_COUNT => "

    # bReserved (1 byte)
    bReserved = []
    bReservedLength = 255
    bReservedFormat = FieldFormatEnum.NUMBER
    bReservedName = "bReserved"
    bReservedMatch = bReservedName.casefold()
    bReservedLastMandatoryValueIndex = 0
    bReservedSourceIndexPattern = "DEVICE_QUALIFIER_BRESERVED_INDEX => "
    bReservedSourceCountPattern = "DEVICE_QUALIFIER_BRESERVED_COUNT => "

    ################################################
    ## Public Device Qualifier Descriptor Methods ##
    ################################################
   
    ### is Device Qualifier Descriptor Requested ###
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

            # bcdUsb
            case self.bcdUsbMatch:
                # New Value to Add
                newValue = VerificationValue(value, self.bcdUsbLength, self.bcdUsbFormat, verificationLevel, operator)
                
                # Handle Verification Level Priority (Mandatory First)
                if (VerificationLevelEnum.MANDATORY == newValue.verificationLevel):
                    # Add New Mandatory Value
                    self.bcdUsb.insert(self.bcdUsbLastMandatoryValueIndex, newValue)
                    self.bcdUsbLastMandatoryValueIndex += 1

                # Optional New Value (add the end of the list)
                else:
                    self.bcdUsb.append(newValue)

            # bDeviceClass
            case self.bDeviceClassMatch:
                # New Value to Add
                newValue = VerificationValue(value, self.bDeviceClassLength, self.bDeviceClassFormat, verificationLevel, operator)

                # Handle Verification Level Priority (Mandatory First)
                if (VerificationLevelEnum.MANDATORY == newValue.verificationLevel):
                    # Add New Mandatory Value
                    self.bDeviceClassMatch.insert(self.bDeviceClassMatchLastMandatoryValueIndex, newValue)
                    self.bDeviceClassMatchLastMandatoryValueIndex += 1

                # Optional New Value (add the end of the list)
                else:
                    self.bDeviceClassMatch.append(newValue)

            # bDeviceSubClass
            case self.bDeviceSubClassMatch:
                # New Value to Add
                newValue = VerificationValue(value, self.bDeviceSubClassLength, self.bDeviceSubClassFormat, verificationLevel, operator)
                
                # Handle Verification Level Priority (Mandatory First)
                if (VerificationLevelEnum.MANDATORY == newValue.verificationLevel):
                    # Add New Mandatory Value
                    self.bDeviceSubClass.insert(self.bDeviceSubClassLastMandatoryValueIndex, newValue)
                    self.bDeviceSubClassLastMandatoryValueIndex += 1

                # Optional New Value (add the end of the list)
                else:
                    self.bDeviceSubClass.append(newValue)

            # bDeviceProtocol
            case self.bDeviceProtocolMatch:
                # New Value to Add
                newValue = VerificationValue(value, self.bDeviceProtocolLength, self.bDeviceProtocolFormat, verificationLevel, operator)

                # Handle Verification Level Priority (Mandatory First)
                if (VerificationLevelEnum.MANDATORY == newValue.verificationLevel):
                    # Add New Mandatory Value
                    self.bDeviceProtocol.insert(self.bDeviceProtocolLastMandatoryValueIndex, newValue)
                    self.bDeviceProtocolLastMandatoryValueIndex += 1

                # Optional New Value (add the end of the list)
                else:
                    self.bDeviceProtocol.append(newValue)

            # bMaxPacketSize0
            case self.bMaxPacketSize0Match:
                # New Value to Add
                newValue = VerificationValue(value, self.bMaxPacketSize0Length, self.bMaxPacketSize0Format, verificationLevel, operator)

                # Handle Verification Level Priority (Mandatory First)
                if (VerificationLevelEnum.MANDATORY == newValue.verificationLevel):
                    # Add New Mandatory Value
                    self.bMaxPacketSize0.insert(self.bMaxPacketSize0LastMandatoryValueIndex, newValue)
                    self.bMaxPacketSize0LastMandatoryValueIndex += 1

                # Optional New Value (add the end of the list)
                else:
                    self.bMaxPacketSize0.append(newValue)
            
            # bNumConfigurations
            case self.bNumConfigurationsMatch:
                # New Value to Add
                newValue = VerificationValue(value, self.bNumConfigurationsLength, self.bNumConfigurationsFormat, verificationLevel, operator)

                # Handle Verification Level Priority (Mandatory First)
                if (VerificationLevelEnum.MANDATORY == newValue.verificationLevel):
                    # Add New Mandatory Value
                    self.bNumConfigurations.insert(self.bNumConfigurationsLastMandatoryValueIndex, newValue)
                    self.bNumConfigurationsLastMandatoryValueIndex += 1

                # Optional New Value (add the end of the list)
                else:
                    self.bNumConfigurations.append(newValue)

            # bReserved
            case self.bReservedMatch:
                # New Value to Add
                newValue = VerificationValue(value, self.bReservedLength, self.bReservedFormat, verificationLevel, operator)

                # Handle Verification Level Priority (Mandatory First)
                if (VerificationLevelEnum.MANDATORY == newValue.verificationLevel):
                    # Add New Mandatory Value
                    self.bReserved.insert(self.bReservedLastMandatoryValueIndex, newValue)
                    self.bReservedLastMandatoryValueIndex += 1

                # Optional New Value (add the end of the list)
                else:
                    self.bReserved.append(newValue)

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

            # bcdUsb
            case self.bcdUsbMatch:
                if (operator == None):
                    self.bcdUsb = [el for el in self.bcdUsb if el.value != value]
                else:
                    self.bcdUsb = [el for el in self.bcdUsb if el.value != value and el.operator != operator]

            # bDeviceClass
            case self.bDeviceClassMatch:
                if (operator == None):
                    self.bDeviceClass = [el for el in self.bDeviceClass if el.value != value]
                else:
                    self.bDeviceClass = [el for el in self.bDeviceClass if el.value != value and el.operator != operator]

            # bDeviceSubClass
            case self.bDeviceSubClassMatch:
                if (operator == None):
                    self.bDeviceSubClass = [el for el in self.bDeviceSubClass if el.value != value]
                else:
                    self.bDeviceSubClass = [el for el in self.bDeviceSubClass if el.value != value and el.operator != operator]

            # bDeviceProtocol
            case self.bDeviceProtocolMatch:
                if (operator == None):
                    self.bDeviceProtocol = [el for el in self.bDeviceProtocol if el.vallue != value]
                else:
                    self.bDeviceProtocol = [el for el in self.bDeviceProtocol if el.vallue != value and el.operator != operator]

            # bMaxPacketSize0
            case self.bMaxPacketSize0Match:
                if (operator == None):
                    self.bMaxPacketSize0 = [el for el in self.bMaxPacketSize0 if el.value != value]
                else:
                    self.bMaxPacketSize0 = [el for el in self.bMaxPacketSize0 if el.value != value and el.operator != operator]

            # bNumConfigurations
            case self.bNumConfigurationsMatch:
                if (operator == None):
                    self.bNumConfigurations = [el for el in self.bNumConfigurations if el.value != value]
                else:
                    self.bNumConfigurations = [el for el in self.bNumConfigurations if el.value != value and el.operator != operator]

            # bReserved
            case self.bReservedMatch:
                if (operator == None):
                    self.bReserved = [el for el in self.bReserved if el.value != value]
                else:
                    self.bReserved = [el for el in self.bReserved if el.value != value and el.operator != operator]

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

            # bcdUsb
            case self.bcdUsbMatch:
                print(self.bcdUsbName + ":\n")
                for el in self.bcdUsb: el.showDetails()

            # bDeviceClass
            case self.bDeviceClassMatch:
                print(self.bDeviceClassName + ":\n")
                for el in self.bDeviceClass: el.showDetails()

            # bDeviceSubClass
            case self.bDeviceSubClassMatch:
                print(self.bDeviceSubClassName + ":\n")
                for el in self.bDeviceSubClass: el.showDetails()

            # bDeviceProtocol
            case self.bDeviceProtocolMatch:
                print(self.bDeviceProtocolName + ":\n")
                for el in self.bDeviceProtocol: el.showDetails()

            # bMaxPacketSize0
            case self.bMaxPacketSize0Match:
                print(self.bMaxPacketSize0Name + ":\n")
                for el in self.bMaxPacketSize0: el.showDetails()

            # bNumConfigurations
            case self.bNumConfigurationsMatch:
                print(self.bNumConfigurationsName + ":\n")
                for el in self.bNumConfigurations: el.showDetails()

            # bReserved
            case self.bReservedMatch:
                print(self.bReservedName + ":\n")
                for el in self.bReserved: el.showDetails()

            # Unknown Field
            case _:
                raise Exception("Unkown " + self.DESCRIPTOR_NAME + " Field: " + fieldName)

    ### Print All Device Descriptor Field Values ###
    def displayAllVerificationValues(self):
        print("---", self.DESCRIPTOR_NAME, "---")

        # bLength
        self.displayVerificationValues(self.bLengthName)

        # bcdUsb
        self.displayVerificationValues(self.bcdUsbName)

        # bDeviceClass
        self.displayVerificationValues(self.bDeviceClassName)

        # bDeviceSubClass
        self.displayVerificationValues(self.bDeviceSubClassName)

        # bDeviceProtocol
        self.displayVerificationValues(self.bDeviceProtocolName)

        # bMaxPacketSize0
        self.displayVerificationValues(self.bMaxPacketSize0Name)

        # bNumConfigurations
        self.displayVerificationValues(self.bNumConfigurationsName)

        # bReserved
        self.displayVerificationValues(self.bReservedName)

    ### Get Verification Values ###
    ### Return: [ [USB Field, Operator, Value, Verification Level] ]
    def getVerificationValues(self):
        valueList = []

        # bLength
        for el in self.bLength:
            valueList.append([self.bLengthName, el.operator.name.capitalize(), el.value, el.verificationLevel.name])

        # bcdUsb
        for el in self.bcdUsb:
            valueList.append([self.bcdUsbName, el.operator.name.capitalize(), el.value, el.verificationLevel.name])

        # bDeviceClass
        for el in self.bDeviceClass:
            valueList.append([self.bDeviceClassName, el.operator.name.capitalize(), el.value, el.verificationLevel.name])

        # bDeviceSubClass
        for el in self.bDeviceSubClass:
            valueList.append([self.bDeviceSubClassName, el.operator.name.capitalize(), el.value, el.verificationLevel.name])

        # bDeviceProtocol
        for el in self.bDeviceProtocol:
            valueList.append([self.bDeviceProtocolName, el.operator.name.capitalize(), el.value, el.verificationLevel.name])

        # bMaxPacketSize0
        for el in self.bMaxPacketSize0:
            valueList.append([self.bMaxPacketSize0Name, el.operator.name.capitalize(), el.value, el.verificationLevel.name])

        # bNumConfigurations
        for el in self.bNumConfigurations:
            valueList.append([self.bNumConfigurationsName, el.operator.name.capitalize(), el.value, el.verificationLevel.name])

        # bReserved
        for el in self.bReserved:
            valueList.append([self.bReservedName, el.operator.name.capitalize(), el.value, el.verificationLevel.name])

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

        # bcdUsb
        for el in self.bcdUsb:
            if (operator == el.operator):
                count += el.getMemoryUsage()

        # Add Result & Reset Counter
        result.append([self.bcdUsbName, count])
        count = 0

        # bDeviceClass
        for el in self.bDeviceClass:
            if (operator == el.operator):
                count += el.getMemoryUsage()
        
        # Add Result & Reset Counter
        result.append([self.bDeviceClassName, count])
        count = 0

        # bDeviceSubClass
        for el in self.bDeviceSubClass:
            if (operator == el.operator):
                count += el.getMemoryUsage()
        
        # Add Result & Reset Counter
        result.append([self.bDeviceSubClassName, count])
        count = 0

        # bDeviceProtocol
        for el in self.bDeviceProtocol:
            if (operator == el.operator):
                count += el.getMemoryUsage()
        
        # Add Result & Reset Counter
        result.append([self.bDeviceProtocolName, count])
        count = 0

        # bMaxPacketSize0
        for el in self.bMaxPacketSize0:
            if (operator == el.operator):
                count += el.getMemoryUsage()
        
        # Add Result & Reset Counter
        result.append([self.bMaxPacketSize0Name, count])
        count = 0

        # bNumConfigurations
        for el in self.bNumConfigurations:
            if (operator == el.operatpr):
                count += el.getMemoryUsage()
        
        # Add Result & Reset Counter
        result.append([self.bNumConfigurationsName, count])

        # bReserved
        for el in self.bReserved:
            if (operator == el.operatpr):
                count += el.getMemoryUsage()
        
        # Add Result & Reset Counter
        result.append([self.bReservedName, count])

        # End of Process
        return result

    ### Check if Operator is used by the Descriptor (at least once) ###
    ### Return: True/False
    def isOperatorInUse(self, operator):

        # bLength
        for el in self.bLength:
            if (operator == el.operator):
                return True

        # bcdUsb
        for el in self.bcdUsb:
            if (operator == el.operator):
                return True

        # bDeviceClass
        for el in self.bDeviceClass:
            if (operator == el.operator):
                return True

        # bDeviceSubClass
        for el in self.bDeviceSubClass:
            if (operator == el.operator):
                return True

        # bDeviceProtocol
        for el in self.bDeviceProtocol:
            if (operator == el.operator):
                return True

        # bMaxPacketSize0
        for el in self.bMaxPacketSize0:
            if (operator == el.operator):
                return True

        # bNumConfigurations
        for el in self.bNumConfigurations:
            if (operator == el.operatpr):
                return True

        # bReserved
        for el in self.bReserved:
            if (operator == el.operatpr):
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

        # bcdUsb
        memoryValueConfig = []
        for el in self.bcdUsb:
            if (operator == el.operator):
                # Convert Memory Configurations
                for e in el.convertToMemConfig():
                    memoryValueConfig.append(e)

        # Order & Add Memory Values
        for el in VerificationValue.generateMemoryValues(memoryValueConfig):
            result.append(el)

        # bDeviceClass
        memoryValueConfig = []
        for el in self.bDeviceClass:
            if (operator == el.operator):
                # Convert Memory Configurations
                for e in el.convertToMemConfig():
                    memoryValueConfig.append(e)

        # Order & Add Memory Values
        for el in VerificationValue.generateMemoryValues(memoryValueConfig):
            result.append(el)

        # bDeviceSubClass
        memoryValueConfig = []
        for el in self.bDeviceSubClass:
            if (operator == el.operator):
                # Convert Memory Configurations
                for e in el.convertToMemConfig():
                    memoryValueConfig.append(e)

        # Order & Add Memory Values
        for el in VerificationValue.generateMemoryValues(memoryValueConfig):
            result.append(el)

        # bDeviceProtocol
        memoryValueConfig = []
        for el in self.bDeviceProtocol:
            if (operator == el.operator):
                # Convert Memory Configurations
                for e in el.convertToMemConfig():
                    memoryValueConfig.append(e)

        # Order & Add Memory Values
        for el in VerificationValue.generateMemoryValues(memoryValueConfig):
            result.append(el)

        # bMaxPacketSize0
        memoryValueConfig = []
        for el in self.bMaxPacketSize0:
            if (operator == el.operator):
                # Convert Memory Configurations
                for e in el.convertToMemConfig():
                    memoryValueConfig.append(e)

        # Order & Add Memory Values
        for el in VerificationValue.generateMemoryValues(memoryValueConfig):
            result.append(el)

        # bNumConfigurations
        memoryValueConfig = []
        for el in self.bNumConfigurations:
            if (operator == el.operator):
                # Convert Memory Configurations
                for e in el.convertToMemConfig():
                    memoryValueConfig.append(e)

        # Order & Add Memory Values
        for el in VerificationValue.generateMemoryValues(memoryValueConfig):
            result.append(el)

        # bReserved
        memoryValueConfig = []
        for el in self.bReserved:
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

        # bcdUsb
        largestPartVerif = self.__getLargestVerificationNumber(self.bcdUsb, largestPartVerif)

        # bDeviceClass
        largestPartVerif = self.__getLargestVerificationNumber(self.bDeviceClass, largestPartVerif)

        # bDeviceSubClass
        largestPartVerif = self.__getLargestVerificationNumber(self.bDeviceSubClass, largestPartVerif)

        # bDeviceProtocol
        largestPartVerif = self.__getLargestVerificationNumber(self.bDeviceProtocol, largestPartVerif)

        # bMaxPacketSize0
        largestPartVerif = self.__getLargestVerificationNumber(self.bMaxPacketSize0, largestPartVerif)

        # bNumConfigurations
        largestPartVerif = self.__getLargestVerificationNumber(self.bNumConfigurations, largestPartVerif)

        # bReserved
        largestPartVerif = self.__getLargestVerificationNumber(self.bReserved, largestPartVerif)
        return largestPartVerif

    ### Check if the Descriptor is InUse (at least on Value) ###
    ### Return True/False
    def isDescriptorInUse(self):

        # bLength
        for el in self.bLength:
            return True

        # bcdUsb
        for el in self.bcdUsb:
            return True

        # bDeviceClass
        for el in self.bDeviceClass:
            return True

        # bDeviceSubClass
        for el in self.bDeviceSubClass:
            return True

        # bDeviceProtocol
        for el in self.bDeviceProtocol:
            return True

        # bMaxPacketSize0
        for el in self.bMaxPacketSize0:
            return True

        # bNumConfigurations
        for el in self.bNumConfigurations:
            return True

        # bReserved
        for el in self.bReserved:
            return True
    
        # Descriptor not used
        return False

    #######################################################
    ## Public Static Device Qualifier Descriptor Methods ##
    #######################################################

    ### Get Source File Index & Count Pattern for specific Device Descriptor field ###
    ### Return (Index Pattern, Count Pattern)
    @staticmethod
    def getSourceIndexCountPattern(fieldName):
        match fieldName:

            # bLength
            case DeviceQualifierDescriptor.bLengthName:
                return (DeviceQualifierDescriptor.bLengthSourceIndexPattern, DeviceQualifierDescriptor.bLengthSourceCountPattern)

            # bcdUsb
            case DeviceQualifierDescriptor.bcdUsbName:
                return (DeviceQualifierDescriptor.bcdUsbSourceIndexPattern, DeviceQualifierDescriptor.bcdUsbSourceCountPattern)

            # bDeviceClass
            case DeviceQualifierDescriptor.bDeviceClassName:
                return (DeviceQualifierDescriptor.bDeviceClassSourceIndexPattern, DeviceQualifierDescriptor.bDeviceClassSourceCountPattern)

            # bDeviceSubClass
            case DeviceQualifierDescriptor.bDeviceSubClassName:
                return (DeviceQualifierDescriptor.bDeviceSubClassSourceIndexPattern, DeviceQualifierDescriptor.bDeviceSubClassSourceCountPattern)

            # bDeviceProtocol
            case DeviceQualifierDescriptor.bDeviceProtocolName:
                return (DeviceQualifierDescriptor.bDeviceProtocolSourceIndexPattern, DeviceQualifierDescriptor.bDeviceProtocolSourceCountPattern)

            # bMaxPacketSize0
            case DeviceQualifierDescriptor.bMaxPacketSize0Name:
                return (DeviceQualifierDescriptor.bMaxPacketSize0SourceIndexPattern, DeviceQualifierDescriptor.bMaxPacketSize0SourceCountPattern)

            # bNumConfigurations
            case DeviceQualifierDescriptor.bNumConfigurationsName:
                return (DeviceQualifierDescriptor.bNumConfigurationsSourceIndexPattern, DeviceQualifierDescriptor.bNumConfigurationsSourceCountPattern)

            # bReserved
            case DeviceQualifierDescriptor.bReservedName:
                return (DeviceQualifierDescriptor.bReservedSourceIndexPattern, DeviceQualifierDescriptor.bReservedSourceCountPattern)

            # Unknown Field
            case _:
                raise("Unkown", DeviceQualifierDescriptor.DESCRIPTOR_NAME, "Field:", fieldName)

    #################################################
    ## Private Device Qualifier Descriptor Methods ##
    #################################################

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
