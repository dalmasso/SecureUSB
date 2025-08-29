########################################################################
## Engineer:    Dalmasso Loic
## Create Date: 25/07/2025
## Module Name: VerificationOrderEnum
## Description: USB Verification Order Enum
########################################################################

from enum import Enum

class VerificationOrderEnum(Enum):
    ADD = ["add", "a"]
    REMOVE = ["remove", "rm", "r"]
    IMPORT = ["import", "imp", "i"]
    EXPORT = ["export", "exp", "e"]
    SUMMARY = ["summary", "sum", "s"]
    HELP = ["help", "hint", "h"]
    QUIT = ["quit", "exit", "q"]

    ### Get Verification Order Details ###
    def getVerificationOrderEnumDetails():
        i = 1
        details = ""
        for el in VerificationOrderEnum:
            details += el.name + "(" + ','.join(el.value) + ")"
            if i < len(VerificationOrderEnum):
                details += ", "
                i += 1
        return details

    ### Get Verification Order Enum from User Value ###
    def getVerificationOrderEnum(userValue):
        selectedOrder = ""

        for order in VerificationOrderEnum:
            if (userValue.casefold() in order.value):
                selectedOrder = order
                break

        if (selectedOrder == ""):
            raise Exception("Wrong Order " + str(userValue) + " ! Must be one of: " + VerificationOrderEnum.getVerificationOrderEnumDetails())

        return selectedOrder
