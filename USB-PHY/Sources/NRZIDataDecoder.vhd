------------------------------------------------------------------------
-- Engineer:    Dalmasso Loic
-- Create Date: 14/04/2025
-- Module Name: NRZIDataDecoder
-- Description:
--      Decoder of differential Non-Return-to-Zero Inverted USB Data lines (D+ and D-)
--
-- Usage:
--      This module listens Non-Return-to-Zero Inverted USB differential data pair and extract the logical value according to the configuration (SE0, SE1, '0' and '1').
--
-- Generics
--      se0_pattern: Differential pattern of SE0 (pattern format: D+ & D-)
--      se1_pattern: Differential pattern of SE1 (pattern format: D+ & D-)
--      logical_0: Differential pattern of logical 0 (pattern format: D+ & D-)
--      logical_1: Differential pattern of logical 1 (pattern format: D+ & D-)
--
-- Ports
--		Input 	-	i_usb_data: USB Differential Data
--		Output 	-	o_type: Type of Decoded USB Data (Single-Ended: '0', Logical: '1')
--		Output 	-	o_data: Decoded USB Data ('0' or '1')
------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY NRZIDataDecoder is

GENERIC(
    se0_pattern: STD_LOGIC_VECTOR(1 downto 0) := "00";
    se1_pattern: STD_LOGIC_VECTOR(1 downto 0) := "11";
    logical_0: STD_LOGIC_VECTOR(1 downto 0) := "01";
    logical_1: STD_LOGIC_VECTOR(1 downto 0) := "10"
);

PORT(
    i_usb_data: IN STD_LOGIC_VECTOR(1 downto 0);
    o_type: OUT STD_LOGIC;
    o_data: OUT STD_LOGIC
);

END NRZIDataDecoder;

ARCHITECTURE Behavioral of NRZIDataDecoder is

------------------------------------------------------------------------
-- Constant Declarations
------------------------------------------------------------------------
-- USB Data Type
constant USB_SINGLE_ENDED: STD_LOGIC := '0';
constant USB_DATA: STD_LOGIC := '1';

------------------------------------------------------------------------
-- Module Implementation
------------------------------------------------------------------------
begin

	------------------------
	-- NRZI USB Data Type --
	------------------------
    o_type <= USB_SINGLE_ENDED when i_usb_data = se0_pattern or i_usb_data = se1_pattern else USB_DATA;

    -------------------
	-- NRZI USB Data --
	-------------------
    o_data <= '1' when i_usb_data = logical_1 or i_usb_data = se1_pattern else '0';

end Behavioral;