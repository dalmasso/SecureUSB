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
USE IEEE.NUMERIC_STD.ALL;

ENTITY Testbench_NRZIDataDecoder is
--  Port ( );
END Testbench_NRZIDataDecoder;

ARCHITECTURE Behavioral of Testbench_NRZIDataDecoder is

COMPONENT NRZIDataDecoder is

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

END COMPONENT;

signal usb_data: UNSIGNED(1 downto 0) := "00";
signal type_output: STD_LOGIC := '0';
signal data_output: STD_LOGIC := '0';

begin

-- USB Differential Data Lines
process
begin
    usb_data <= usb_data +1 after 5 ns;
    wait for 5 ns;
end process;

uut: NRZIDataDecoder
    GENERIC map(
        se0_pattern => "00",
        se1_pattern => "11",
        logical_0 => "01",
        logical_1 => "10"
    )
    
    PORT map(
        i_usb_data => STD_LOGIC_VECTOR(usb_data),
        o_type => type_output,
        o_data => data_output);

end Behavioral;