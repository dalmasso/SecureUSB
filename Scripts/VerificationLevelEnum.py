########################################################################
## Engineer:    Dalmasso Loic
## Create Date: 25/07/2025
## Module Name: VerificationLevelEnum
## Description: USB Expected Value Verification Level Enum
########################################################################

from enum import Enum

class VerificationLevelEnum(Enum):
    MANDATORY = ['1', 'mandatory', 'mand', 'and']
    OPTIONAL = ['0', 'optional', 'op', 'or']

    #######################################
    ## Public Verification Level Methods ##
    #######################################

    ### Get Verification Level Memory Value ###
    def getVerificationLevelMemValue(verificationLevel):
        if (VerificationLevelEnum.MANDATORY == verificationLevel):
            return VerificationLevelEnum.MANDATORY.value[0]
        else:
            return VerificationLevelEnum.OPTIONAL.value[0]

    ### Get Verification Level Details ###
    def getVerificationLevelEnumDetails():
        i = 1
        details = ""
        for el in VerificationLevelEnum:
            details += el.name + "(" + ','.join(el.value) + ")"
            if i < len(VerificationLevelEnum):
                details += ", "
                i += 1
        return details
    
    ### Get Verification Level Enum from User Value ###
    def getVerificationLevelEnum(userValue):
        selectedVerificationLevel = ""

        for level in VerificationLevelEnum:
            if (userValue.casefold() in level.value):
                selectedVerificationLevel = level
                break

        if (selectedVerificationLevel == ""):
            raise Exception("Wrong Verification Level " + str(userValue) + " ! Must be one of: " + VerificationLevelEnum.getVerificationLevelEnumDetails())

        return selectedVerificationLevel
