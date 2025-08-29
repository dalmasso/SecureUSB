########################################################################
## Engineer:    Dalmasso Loic
## Create Date: 25/07/2025
## Module Name: DeviceDescriptor
## Description: USB Device Descriptor Class containing fields to verify
########################################################################

import statistics

from FieldFormatEnum import FieldFormatEnum
from VerificationValue import VerificationValue
from VerificationLevelEnum import VerificationLevelEnum

class DeviceDescriptor:

    #################################
    ## Device Descriptor Constants ##
    #################################
    
    # Descriptor Type
    DESCRIPTOR_TYPE = "Device"

    # Descriptor Name
    DESCRIPTOR_NAME = "Device Descriptor"

    #################################
    ## Device Descriptor Variables ##
    #################################

    # bLength (1 byte)
    bLength = []
    bLengthLength = 255
    bLengthFormat = FieldFormatEnum.NUMBER
    bLengthName = "bLength"
    bLengthMatch = bLengthName.casefold()
    bLengthLastMandatoryValueIndex = 0
    bLengthSourceIndexPattern = "DEVICE_BLENGTH_INDEX => "
    bLengthSourceCountPattern = "DEVICE_BLENGTH_COUNT => "

    # bcdUsb (2 bytes)
    bcdUsb = []
    bcdUsbLength = 4
    bcdUsbFormat = FieldFormatEnum.HEX
    bcdUsbName = "bcdUsb"
    bcdUsbMatch = bcdUsbName.casefold()
    bcdUsbLastMandatoryValueIndex = 0
    bcdUsbSourceIndexPattern = "DEVICE_BCDUSB_INDEX => "
    bcdUsbSourceCountPattern = "DEVICE_BCDUSB_COUNT => "

    # bDeviceClass (1 byte)
    bDeviceClass = []
    bDeviceClassLength = 2
    bDeviceClassFormat = FieldFormatEnum.HEX
    bDeviceClassName = "bDeviceClass"
    bDeviceClassMatch = bDeviceClassName.casefold()
    bDeviceClassLastMandatoryValueIndex = 0
    bDeviceClassSourceIndexPattern = "DEVICE_BDEVICECLASS_INDEX => "
    bDeviceClassSourceCountPattern = "DEVICE_BDEVICECLASS_COUNT => "

    # bDeviceSubClass (1 byte)
    bDeviceSubClass = []
    bDeviceSubClassLength = 2
    bDeviceSubClassFormat = FieldFormatEnum.HEX
    bDeviceSubClassName = "bDeviceSubClass"
    bDeviceSubClassMatch = bDeviceSubClassName.casefold()
    bDeviceSubClassLastMandatoryValueIndex = 0
    bDeviceSubClassSourceIndexPattern = "DEVICE_BDEVICESUBCLASS_INDEX => "
    bDeviceSubClassSourceCountPattern = "DEVICE_BDEVICESUBCLASS_COUNT => "

    # bDeviceProtocol (1 byte)
    bDeviceProtocol = []
    bDeviceProtocolLength = 2
    bDeviceProtocolFormat = FieldFormatEnum.HEX
    bDeviceProtocolName = "bDeviceProtocol"
    bDeviceProtocolMatch = bDeviceProtocolName.casefold()
    bDeviceProtocolLastMandatoryValueIndex = 0
    bDeviceProtocolSourceIndexPattern = "DEVICE_BDEVICEPROTOCOL_INDEX => "
    bDeviceProtocolSourceCountPattern = "DEVICE_BDEVICEPROTOCOL_COUNT => "

    # bMaxPacketSize0 (1 byte)
    bMaxPacketSize0 = []
    bMaxPacketSize0Length = 255
    bMaxPacketSize0Format = FieldFormatEnum.NUMBER
    bMaxPacketSize0Name = "bMaxPacketSize0"
    bMaxPacketSize0Match = bMaxPacketSize0Name.casefold()
    bMaxPacketSize0LastMandatoryValueIndex = 0
    bMaxPacketSize0SourceIndexPattern = "DEVICE_BMAXPACKETSIZE0_INDEX => "
    bMaxPacketSize0SourceCountPattern = "DEVICE_BMAXPACKETSIZE0_COUNT => "

    # idVendor (2 bytes)
    idVendor = []
    idVendorLength = 4
    idVendorFormat = FieldFormatEnum.HEX
    idVendorName = "idVendor"
    idVendorMatch = idVendorName.casefold()
    idVendorLastMandatoryValueIndex = 0
    idVendorSourceIndexPattern = "DEVICE_IDVENDOR_INDEX => "
    idVendorSourceCountPattern = "DEVICE_IDVENDOR_COUNT => "

    # idProduct (2 bytes)
    idProduct = []
    idProductLength = 4
    idProductFormat = FieldFormatEnum.HEX
    idProductName = "idProduct"
    idProductMatch = idProductName.casefold()
    idProductLastMandatoryValueIndex = 0
    idProductSourceIndexPattern = "DEVICE_IDPRODUCT_INDEX => "
    idProductSourceCountPattern = "DEVICE_IDPRODUCT_COUNT => "

    # bcdDevice (2 bytes)
    bcdDevice = []
    bcdDeviceLength = 4
    bcdDeviceFormat = FieldFormatEnum.HEX
    bcdDeviceName = "bcdDevice"
    bcdDeviceMatch = bcdDeviceName.casefold()
    bcdDeviceLastMandatoryValueIndex = 0
    bcdDeviceSourceIndexPattern = "DEVICE_BCDDEVICE_INDEX => "
    bcdDeviceSourceCountPattern = "DEVICE_BCDDEVICE_COUNT => "

    # bNumConfigurations (1 byte)
    bNumConfigurations = []
    bNumConfigurationsLength = 255
    bNumConfigurationsFormat = FieldFormatEnum.NUMBER
    bNumConfigurationsName = "bNumConfigurations"
    bNumConfigurationsMatch = bNumConfigurationsName.casefold()
    bNumConfigurationsLastMandatoryValueIndex = 0
    bNumConfigurationsSourceIndexPattern = "DEVICE_BNUMCONFIGURATIONS_INDEX => "
    bNumConfigurationsSourceCountPattern = "DEVICE_BNUMCONFIGURATIONS_COUNT => "

    ######################################
    ## Public Device Descriptor Methods ##
    ######################################

    ### is Device Descriptor Requested ###
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

            # idVendor
            case self.idVendorMatch:
                # New Value to Add
                newValue = VerificationValue(value, self.idVendorLength, self.idVendorFormat, verificationLevel, operator)

                # Handle Verification Level Priority (Mandatory First)
                if (VerificationLevelEnum.MANDATORY == newValue.verificationLevel):
                    # Add New Mandatory Value
                    self.idVendor.insert(self.idVendorLastMandatoryValueIndex, newValue)
                    self.idVendorLastMandatoryValueIndex += 1

                # Optional New Value (add the end of the list)
                else:
                    self.idVendor.append(newValue)

            # idProduct
            case self.idProductMatch:
                # New Value to Add
                newValue = VerificationValue(value, self.idProductLength, self.idProductFormat, verificationLevel, operator)

                # Handle Verification Level Priority (Mandatory First)
                if (VerificationLevelEnum.MANDATORY == newValue.verificationLevel):
                    # Add New Mandatory Value
                    self.idProduct.insert(self.idProductLastMandatoryValueIndex, newValue)
                    self.idProductLastMandatoryValueIndex += 1

                # Optional New Value (add the end of the list)
                else:
                    self.idProduct.append(newValue)
            
            # bcdDevice
            case self.bcdDeviceMatch:
                # New Value to Add
                newValue = VerificationValue(value, self.bcdDeviceLength, self.bcdDeviceFormat, verificationLevel, operator)

                # Handle Verification Level Priority (Mandatory First)
                if (VerificationLevelEnum.MANDATORY == newValue.verificationLevel):
                    # Add New Mandatory Value
                    self.bcdDevice.insert(self.bcdDeviceLastMandatoryValueIndex, newValue)
                    self.bcdDeviceLastMandatoryValueIndex += 1

                # Optional New Value (add the end of the list)
                else:
                    self.bcdDevice.append(newValue)
            
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

            # idVendor
            case self.idVendorMatch:
                if (operator == None):
                    self.idVendor = [el for el in self.idVendor if el.value != value]
                else:
                    self.idVendor = [el for el in self.idVendor if el.value != value and el.operator != operator]

            # idProduct
            case self.idProductMatch:
                if (operator == None):
                    self.idProduct = [el for el in self.idProduct if el.value != value]
                else:
                    self.idProduct = [el for el in self.idProduct if el.value != value and el.operator != operator]

            # bcdDevice
            case self.bcdDeviceMatch:
                if (operator == None):
                    self.bcdDevice = [el for el in self.bcdDevice if el.value != value]
                else:
                    self.bcdDevice = [el for el in self.bcdDevice if el.value != value and el.operator != operator]

            # bNumConfigurations
            case self.bNumConfigurationsMatch:
                if (operator == None):
                    self.bNumConfigurations = [el for el in self.bNumConfigurations if el.value != value]
                else:
                    self.bNumConfigurations = [el for el in self.bNumConfigurations if el.value != value and el.operator != operator]

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

            # idVendor
            case self.idVendorMatch:
                print(self.idVendorName + ":\n")
                for el in self.idVendor: el.showDetails()

            # idProduct
            case self.idProductMatch:
                print(self.idProductName + ":\n")
                for el in self.idProduct: el.showDetails()

            # bcdDevice
            case self.bcdDeviceMatch:
                print(self.bcdDeviceName + ":\n")
                for el in self.bcdDevice: el.showDetails()

            # bNumConfigurations
            case self.bNumConfigurationsMatch:
                print(self.bNumConfigurationsName + ":\n")
                for el in self.bNumConfigurations: el.showDetails()

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

        # idVendor
        self.displayVerificationValues(self.idVendorName)

        # idProduct
        self.displayVerificationValues(self.idProductName)

        # bcdDevice
        self.displayVerificationValues(self.bcdDeviceName)

        # bNumConfigurations
        self.displayVerificationValues(self.bNumConfigurationsName)

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

        # idVendor
        for el in self.idVendor:
            valueList.append([self.idVendorName, el.operator.name.capitalize(), el.value, el.verificationLevel.name])

        # idProduct
        for el in self.idProduct:
            valueList.append([self.idProductName, el.operator.name.capitalize(), el.value, el.verificationLevel.name])

        # bcdDevice
        for el in self.bcdDevice:
            valueList.append([self.bcdDeviceName, el.operator.name.capitalize(), el.value, el.verificationLevel.name])

        # bNumConfigurations
        for el in self.bNumConfigurations:
            valueList.append([self.bNumConfigurationsName, el.operator.name.capitalize(), el.value, el.verificationLevel.name])

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

        # idVendor
        for el in self.idVendor:
            if (operator == el.operator):
                count += el.getMemoryUsage()
        
        # Add Result & Reset Counter
        result.append([self.idVendorName, count])
        count = 0

        # idProduct
        for el in self.idProduct:
            if (operator == el.operator):
                count += el.getMemoryUsage()
        
        # Add Result & Reset Counter
        result.append([self.idProductName, count])
        count = 0

        # bcdDevice
        for el in self.bcdDevice:
            if (operator == el.operator):
                count += el.getMemoryUsage()
        
        # Add Result & Reset Counter
        result.append([self.bcdDeviceName, count])
        count = 0

        # bNumConfigurations
        for el in self.bNumConfigurations:
            if (operator == el.operatpr):
                count += el.getMemoryUsage()
        
        # Add Result & Reset Counter
        result.append([self.bNumConfigurationsName, count])
    
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

        # idVendor
        for el in self.idVendor:
            if (operator == el.operator):
                return True

        # idProduct
        for el in self.idProduct:
            if (operator == el.operator):
                return True

        # bcdDevice
        for el in self.bcdDevice:
            if (operator == el.operator):
                return True

        # bNumConfigurations
        for el in self.bNumConfigurations:
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

        # idVendor
        memoryValueConfig = []
        for el in self.idVendor:
            if (operator == el.operator):
                # Convert Memory Configurations
                for e in el.convertToMemConfig():
                    memoryValueConfig.append(e)

        # Order & Add Memory Values
        for el in VerificationValue.generateMemoryValues(memoryValueConfig):
            result.append(el)

        # idProduct
        memoryValueConfig = []
        for el in self.idProduct:
            if (operator == el.operator):
                # Convert Memory Configurations
                for e in el.convertToMemConfig():
                    memoryValueConfig.append(e)

        # Order & Add Memory Values
        for el in VerificationValue.generateMemoryValues(memoryValueConfig):
            result.append(el)

        # bcdDevice
        memoryValueConfig = []
        for el in self.bcdDevice:
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

        # idVendor
        largestPartVerif = self.__getLargestVerificationNumber(self.idVendor, largestPartVerif)

        # idProduct
        largestPartVerif = self.__getLargestVerificationNumber(self.idProduct, largestPartVerif)

        # bcdDevice
        largestPartVerif = self.__getLargestVerificationNumber(self.bcdDevice, largestPartVerif)

        # bNumConfigurations
        largestPartVerif = self.__getLargestVerificationNumber(self.bNumConfigurations, largestPartVerif)
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

        # idVendor
        for el in self.idVendor:
            return True

        # idProduct
        for el in self.idProduct:
            return True

        # bcdDevice
        for el in self.bcdDevice:
            return True

        # bNumConfigurations
        for el in self.bNumConfigurations:
            return True
    
        # Descriptor not used
        return False

    #############################################
    ## Public Static Device Descriptor Methods ##
    #############################################

    ### Get Source File Index & Count Pattern for specific Device Descriptor field ###
    ### Return (Index Pattern, Count Pattern)
    @staticmethod
    def getSourceIndexCountPattern(fieldName):
        match fieldName:

            # bLength
            case DeviceDescriptor.bLengthName:
                return (DeviceDescriptor.bLengthSourceIndexPattern, DeviceDescriptor.bLengthSourceCountPattern)

            # bcdUsb
            case DeviceDescriptor.bcdUsbName:
                return (DeviceDescriptor.bcdUsbSourceIndexPattern, DeviceDescriptor.bcdUsbSourceCountPattern)

            # bDeviceClass
            case DeviceDescriptor.bDeviceClassName:
                return (DeviceDescriptor.bDeviceClassSourceIndexPattern, DeviceDescriptor.bDeviceClassSourceCountPattern)

            # bDeviceSubClass
            case DeviceDescriptor.bDeviceSubClassName:
                return (DeviceDescriptor.bDeviceSubClassSourceIndexPattern, DeviceDescriptor.bDeviceSubClassSourceCountPattern)

            # bDeviceProtocol
            case DeviceDescriptor.bDeviceProtocolName:
                return (DeviceDescriptor.bDeviceProtocolSourceIndexPattern, DeviceDescriptor.bDeviceProtocolSourceCountPattern)

            # bMaxPacketSize0
            case DeviceDescriptor.bMaxPacketSize0Name:
                return (DeviceDescriptor.bMaxPacketSize0SourceIndexPattern, DeviceDescriptor.bMaxPacketSize0SourceCountPattern)

            # idVendor
            case DeviceDescriptor.idVendorName:
                return (DeviceDescriptor.idVendorSourceIndexPattern, DeviceDescriptor.idVendorSourceCountPattern)

            # idProduct
            case DeviceDescriptor.idProductName:
                return (DeviceDescriptor.idProductSourceIndexPattern, DeviceDescriptor.idProductSourceCountPattern)

            # bcdDevice
            case DeviceDescriptor.bcdDeviceName:
                return (DeviceDescriptor.bcdDeviceSourceIndexPattern, DeviceDescriptor.bcdDeviceSourceCountPattern)

            # bNumConfigurations
            case DeviceDescriptor.bNumConfigurationsName:
                return (DeviceDescriptor.bNumConfigurationsSourceIndexPattern, DeviceDescriptor.bNumConfigurationsSourceCountPattern)

            # Unknown Field
            case _:
                raise("Unkown", DeviceDescriptor.DESCRIPTOR_NAME, "Field:", fieldName)

    #######################################
    ## Private Device Descriptor Methods ##
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
