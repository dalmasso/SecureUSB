------------------------------------------------------------------------
-- Engineer:    Dalmasso Loic
-- Create Date: 30/07/2025
-- Package Name: OperatorResultEnum
-- Description:
--		Package defining Operator Result Enum & Values
------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

PACKAGE OperatorResultEnum is

	-- Operator Result Enum
	TYPE OperatorResult is (IDLE, IN_PROGRESS, WAIT_NEXT_PART, OP_SUCCESS, OP_ERROR);

	-- Operator Result Success/Error
	constant OPERATOR_RESULT_SUCCESS: STD_LOGIC := '1';
	constant OPERATOR_RESULT_ERROR: STD_LOGIC := '0';

END PACKAGE OperatorResultEnum;