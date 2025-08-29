########################################################################
## Engineer:    Dalmasso Loic
## Create Date: 25/07/2025
## Module Name: VerificationOperatorEnum
## Description: USB Verification Operator Enum
########################################################################

from enum import Enum

class VerificationOperatorEnum(Enum):
    EQUALS = ["Equals", "eq", "==", "="]
    NOT_EQUALS = ["NotEquals", "neq", "!="]
    GREATER = ["Greater", "gt", ">"]
    GREATER_EQUALS = ["GreaterEquals", "greater equals", "get", "≥", ">="]
    LESS = ["Less", "lt", "<"]
    LESS_EQUALS = ["LessEquals", "less equals", "let", "≤", "<="]
    STARTSWITH = ["StartsWith", "sw"]
    ENDSWITH = ["EndsWith", "ew"]
    CONTAINS = ["Contains", "c"]
    NOT_CONTAINS = ["NotContains", "not contains", "nc"]

    ##########################################
    ## Public Verification Operator Methods ##
    ##########################################

    ### Get Total VerificationOperator Number ###
    def getVerificationOperatorNumber():
        return len(VerificationOperatorEnum)

    ### Get Verification Operator Readable Name ###
    def getVerificationOperatorName(operator):
        return operator.value[0]

    ### Get Verification Operator Readable Names ###
    def getVerificationOperatorEnumNames():
        names = []
        for el in VerificationOperatorEnum:
            # First Value is the generic Operator Readable Value
            names.append(el.value[0])
        return names

    ### Get Last Last Verification Operator Enum ###
    def getLastVerificationOperatorEnum():
        operator = None
        for el in VerificationOperatorEnum:
            operator = el
        return operator

    ### Get Verification Operator Details ###
    def getVerificationOperatorEnumDetails():
        i = 1
        details = ""
        for el in VerificationOperatorEnum:
            details += el.name + "(" + ','.join(el.value) + ")"
            if i < len(VerificationOperatorEnum):
                details += ", "
                i += 1
        return details

    ### Get Verification Operator Enum from User Value ###
    def getVerificationOperatorEnum(userValue):
        selectedOperator = ""

        for op in VerificationOperatorEnum:
            if (userValue.casefold() in [el.casefold() for el in op.value]):
                selectedOperator = op
                break

        if (selectedOperator == ""):
            raise Exception("Wrong Operator " + str(userValue) + " ! Must be one of: " + VerificationOperatorEnum.getVerificationOperatorEnumDetails())

        return selectedOperator
