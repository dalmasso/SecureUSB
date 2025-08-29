------------------------------------------------------------------------
-- Engineer:    Dalmasso Loic
-- Create Date: 05/06/2025
-- Module Name: USBCRCCalculator
-- Description:
--      USB CRC-5 & CRC-16 calculator (input data in MSB first)
--      CRC-5 Polynomial: C(x) = x^5 + x^2 + 1 = 1 00101
--      CRC-16 Polynomial: C(x) = x^16 + x^15 + x^2 + 1 = 1 1000000000000101
--
-- Ports
--		Input 	-	i_sys_clock: System Input Clock
--		Input 	-	i_reset: System Input Reset ('0': No Reset, '1': Reset)
--		Input 	-	i_crc5_enable: CRC-5 Enable ('0': Disable, '1': Enable)
--		Input 	-	i_crc16_enable: CRC-16 Enable ('0': Disable, '1': Enable)
--		Input 	-	i_data: Input Data on which to apply CRC
--		Output 	-	o_crc5: CRC-5 Value
--		Output 	-	o_crc16: CRC-16 Value
------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY USBCRCCalculator is

PORT(
    i_sys_clock: IN STD_LOGIC;
    i_reset: IN STD_LOGIC;
	i_crc5_enable: IN STD_LOGIC;
	i_crc16_enable: IN STD_LOGIC;
    i_data: IN STD_LOGIC;
    o_crc5: OUT STD_LOGIC_VECTOR(4 downto 0);
    o_crc16: OUT STD_LOGIC_VECTOR(15 downto 0)
);

END USBCRCCalculator;

ARCHITECTURE Behavioral of USBCRCCalculator is

------------------------------------------------------------------------
-- Signal Declarations
------------------------------------------------------------------------
-- CRC-5
signal crc5_feedback: STD_LOGIC := '0';
signal crc5_remainder: STD_LOGIC_VECTOR(4 downto 0) := (others => '0');

-- CRC-16
signal crc16_feedback: STD_LOGIC := '0';
signal crc16_remainder: STD_LOGIC_VECTOR(15 downto 0) := (others => '0');

------------------------------------------------------------------------
-- Module Implementation
------------------------------------------------------------------------
begin

    -----------
	-- CRC-5 --
	-----------
	process(i_sys_clock)
	begin
        if rising_edge(i_sys_clock) then

            -- Reset
            if (i_reset = '1') then
                crc5_remainder <= (others => '1');

            -- CRC-5 Enable
            elsif (i_crc5_enable = '1') then

                -- Left-Shift & Apply CRC-5 Polynome
                crc5_remainder(4) <= crc5_remainder(3);
                crc5_remainder(3) <= crc5_remainder(2);
                -- CRC-5 Polynome (x^2)
                crc5_remainder(2) <= crc5_remainder(1) xor crc5_feedback;
                crc5_remainder(1) <= crc5_remainder(0);
                -- CRC-5 Polynome (x^0)
                crc5_remainder(0) <= crc5_feedback;
            end if;
		end if;
	end process;

    -- CRC-5 FeedBack (x^5)
    crc5_feedback <= crc5_remainder(4) xor i_data;

    ------------------
	-- CRC-5 Output --
	------------------
    -- XOROut = 0xFFFF = NOT(CRC-5 Remainder)
    -- ReflectOut True (Reverse order)
    CRC_5_OUTPUT: for i in 0 to crc5_remainder'LENGTH-1 generate
        o_crc5(i) <= not(crc5_remainder((crc5_remainder'LENGTH-1) -i));
    end generate;

    ------------
	-- CRC-16 --
	------------
	process(i_sys_clock)
	begin
        if rising_edge(i_sys_clock) then

            -- Reset
            if (i_reset = '1') then
                crc16_remainder <= (others => '1');

            -- CRC-16 Enable
            elsif (i_crc16_enable = '1') then
                
                -- Left-Shift & Apply CRC-16 Polynome
                -- CRC-16 Polynome (x^15)
                crc16_remainder(15) <= crc16_remainder(14) xor crc16_feedback;
                crc16_remainder(14) <= crc16_remainder(13);
                crc16_remainder(13) <= crc16_remainder(12);
                crc16_remainder(12) <= crc16_remainder(11);
                crc16_remainder(11) <= crc16_remainder(10);
                crc16_remainder(10) <= crc16_remainder(9);
                crc16_remainder(9) <= crc16_remainder(8);
                crc16_remainder(8) <= crc16_remainder(7);
                crc16_remainder(7) <= crc16_remainder(6);
                crc16_remainder(6) <= crc16_remainder(5);
                crc16_remainder(5) <= crc16_remainder(4);
                crc16_remainder(4) <= crc16_remainder(3);
                crc16_remainder(3) <= crc16_remainder(2);
                -- CRC-16 Polynome (x^2)
                crc16_remainder(2) <= crc16_remainder(1) xor crc16_feedback;
                crc16_remainder(1) <= crc16_remainder(0);
                -- CRC-16 Polynome (x^0)
                crc16_remainder(0) <= crc16_feedback;
            end if;
		end if;
	end process;

    -- CRC-16 FeedBack (x^16)
    crc16_feedback <= crc16_remainder(15) xor i_data;

    -------------------
	-- CRC-16 Output --
	-------------------
    -- XOROut = 0xFFFF = NOT(CRC-16 Remainder)
    -- ReflectOut True (Reverse order)
    CRC_16_OUTPUT: for i in 0 to crc16_remainder'LENGTH-1 generate
        o_crc16(i) <= not(crc16_remainder((crc16_remainder'LENGTH-1) -i));
    end generate;

end Behavioral;