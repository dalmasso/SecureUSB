------------------------------------------------------------------------
-- Engineer:    Dalmasso Loic
-- Create Date: 15/04/2025
-- Module Name: NRZIDecoder
-- Description:
--      Non-Return-to-Zero Inverted Decoder
--
-- Usage:
--      This module decodes the NRZI binary code, according to the Data Change / No Change configurations
--
-- Generics
--      DATA_CHANGE_VALUE: the Decoded Data value when NRZI transition occurs
--      DATA_NO_CHANGE_VALUE: the Decoded Data value when NRZI NO transition occurs
--      BIT_STUFFING_NUMBER: the number of consecutive identical Data value before a forced NRZI transition (must be ignored in decoded data)
--
-- Ports
--		Input 	-	i_sys_clock: System Input Clock
--		Input 	-	i_sys_clock_en: System Input Clock Enable ('0': Disable, '1': Enable)
--		Input 	-	i_reset: System Input Reset ('0': No Reset, '1': Reset)
--		Input 	-	i_data: Data Input to decode
--		Output 	-	o_data_ready: Decoded Data Ready ('0': No Ready, '1': Ready)
--		Output 	-	o_data: Decoded Data
------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Testbench_NRZIDecoder is
--  Port ( );
END Testbench_NRZIDecoder;

ARCHITECTURE Behavioral of Testbench_NRZIDecoder is

COMPONENT NRZIDecoder is

    GENERIC(
        DATA_CHANGE_VALUE: STD_LOGIC := '0';
        DATA_NO_CHANGE_VALUE: STD_LOGIC := '1';
        BIT_STUFFING_NUMBER: INTEGER := 6
    );
    
    PORT(
        i_sys_clock: IN STD_LOGIC;
        i_sys_clock_en: IN STD_LOGIC;
        i_reset: IN STD_LOGIC;
        i_data: IN STD_LOGIC;
        o_data_ready: OUT STD_LOGIC;
        o_data: OUT STD_LOGIC
    );

END COMPONENT;

signal sys_clock: STD_LOGIC := '0';
signal sys_clock_en: STD_LOGIC := '0';
signal reset: STD_LOGIC := '0';
signal data_in: STD_LOGIC := '0';
signal data_ready: STD_LOGIC := '0';
signal data_out: STD_LOGIC := '0';

begin

-- System Clock
sys_clock <= not(sys_clock) after 5 ns;

-- System Clock Enable
sys_clock_en <= '0', '1' after 50 ns;

-- Reset
reset <= '1', '0' after 60 ns, '1' after 285 ns, '0' after 300 ns;

-- Data Input
-- NRZ Stream:    0 0 0 1 1 0 0 1 0 1 1 0 1 1 1 0
-- Expected Data: 0 1 1 0 1 0 1 0 0 0 1 0 0 1 1 0
data_in <=  '1',
            '0' after 100 ns,
            '0' after 110 ns,
            '0' after 120 ns,
            '1' after 130 ns,
            '1' after 140 ns,
            '0' after 150 ns,
            '0' after 160 ns,
            '1' after 170 ns,
            '0' after 180 ns,
            '1' after 190 ns,
            '1' after 200 ns,
            '0' after 210 ns,
            '1' after 220 ns,
            '1' after 230 ns,
            '1' after 240 ns,
            '0' after 250 ns,
            -- Bit Stuffing (6)
            '1' after 365 ns,
            -- Bit Stuffing (6)
            '0' after 435 ns;

uut: NRZIDecoder
    GENERIC map(
        DATA_CHANGE_VALUE => '0',
        DATA_NO_CHANGE_VALUE => '1',
        BIT_STUFFING_NUMBER => 6
    )
    
    PORT map(
        i_sys_clock => sys_clock,
        i_sys_clock_en => sys_clock_en,
        i_reset => reset,
        i_data => data_in,
        o_data_ready => data_ready,
        o_data => data_out);

end Behavioral;