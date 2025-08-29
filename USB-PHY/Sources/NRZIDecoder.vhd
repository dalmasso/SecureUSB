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

ENTITY NRZIDecoder is

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

END NRZIDecoder;

ARCHITECTURE Behavioral of NRZIDecoder is

------------------------------------------------------------------------
-- Signal Declarations
------------------------------------------------------------------------
-- Previous Data Register
signal prev_data_reg: STD_LOGIC := '0';

-- Decoded Data Ready Register
signal decoded_data_ready_reg: STD_LOGIC := '0';

-- Decoded Data Register
signal decoded_data_reg: STD_LOGIC := '0';

-- Bit Stuffing Counter
signal bit_stuffing_counter: INTEGER range 0 to BIT_STUFFING_NUMBER := BIT_STUFFING_NUMBER;
signal bit_stuffing_trigger: STD_LOGIC := '0';

------------------------------------------------------------------------
-- Module Implementation
------------------------------------------------------------------------
begin

	-------------------
	-- Previous Data --
	-------------------
    process(i_sys_clock)
    begin
        if rising_edge(i_sys_clock) then

            -- Clock Enable
            if (i_sys_clock_en = '1') then
                prev_data_reg <= i_data;
            end if;
        end if;
    end process;

	--------------------------
	-- Bit Stuffing Counter --
	--------------------------
    process(i_sys_clock)
    begin
        if rising_edge(i_sys_clock) then

            -- Reset Bit Stuffing Counter
            if (i_reset = '1') or (bit_stuffing_counter = 0) then
                bit_stuffing_counter <= BIT_STUFFING_NUMBER;

            -- Clock Enable
            elsif (i_sys_clock_en = '1') then

                -- Decrement Bit Stuffing Counter (Data No Change)
                if (prev_data_reg = i_data) then
                    bit_stuffing_counter <= bit_stuffing_counter -1;
                
                -- Reset Bit Stuffing Counter (Data Change)
                else
                    bit_stuffing_counter <= BIT_STUFFING_NUMBER;
                end if;
            end if;
        end if;
    end process;

    -- Bit Stuffing Trigger
    bit_stuffing_trigger <= '1' when bit_stuffing_counter = 0 else '0';

	-----------------------------
	-- NRZI Decoded Data Ready --
	-----------------------------
    process(i_sys_clock)
    begin
        if rising_edge(i_sys_clock) then

            -- Reset or Bit Stuffing
            if (i_reset = '1') or (bit_stuffing_trigger = '1') then
                decoded_data_ready_reg <= '0';

            -- Clock Enable
            elsif (i_sys_clock_en = '1') then
                decoded_data_ready_reg <= '1';
            end if;
        end if;
    end process;
    o_data_ready <= decoded_data_ready_reg;

	-----------------------
	-- NRZI Decoded Data --
	-----------------------
    process(i_sys_clock)
    begin
        if rising_edge(i_sys_clock) then

            -- Clock Enable
            if (i_sys_clock_en = '1') then

                -- Data No Change
                if (prev_data_reg = i_data) then
                    decoded_data_reg <= DATA_NO_CHANGE_VALUE;
                
                -- Data Change
                else
                    decoded_data_reg <= DATA_CHANGE_VALUE;
                end if;
            end if;
        end if;
    end process;

    -- Decoded Data
    o_data <= decoded_data_reg;

end Behavioral;