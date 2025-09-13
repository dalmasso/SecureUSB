########################################################################
## Engineer:    Dalmasso Loic
## Create Date: 12/09/2025
## Module Name: DescriptorEnableStatusEnum
## Description: USB Descriptor Enable Status Enum
########################################################################

from enum import Enum

class DescriptorEnableStatusEnum(Enum):
    ENABLE = [0, "Verification Enable"]
    DEPENDENCY = [1, "Read-only"]
    DISABLE = [2, "Verification Disable"]

    #############################################
    ## Public Descriptor Enable Status Methods ##
    #############################################

    ### Get Descriptor Enable Status String Value ###
    def getDescriptorEnableStatusStringValue(descriptorEnableStatus):
        
        if (DescriptorEnableStatusEnum.ENABLE == descriptorEnableStatus):
            return DescriptorEnableStatusEnum.ENABLE.value[1]
        
        elif (DescriptorEnableStatusEnum.DEPENDENCY == descriptorEnableStatus):
            return DescriptorEnableStatusEnum.DEPENDENCY.value[1]
        
        elif (DescriptorEnableStatusEnum.DISABLE == descriptorEnableStatus):
            return DescriptorEnableStatusEnum.DISABLE.value[1]
        
        else:
            raise Exception("Wrong Descriptor Enable Status " + str(descriptorEnableStatus) + " !")

