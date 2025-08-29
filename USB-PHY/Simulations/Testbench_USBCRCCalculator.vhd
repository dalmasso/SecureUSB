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

ENTITY Testbench_USBCRCCalculator is
--  Port ( );
END Testbench_USBCRCCalculator;

ARCHITECTURE Behavioral of Testbench_USBCRCCalculator is

COMPONENT USBCRCCalculator is

PORT(
    i_sys_clock: IN STD_LOGIC;
    i_reset: IN STD_LOGIC;
	i_crc5_enable: IN STD_LOGIC;
	i_crc16_enable: IN STD_LOGIC;
    i_data: IN STD_LOGIC;
    o_crc5: OUT STD_LOGIC_VECTOR(4 downto 0);
    o_crc16: OUT STD_LOGIC_VECTOR(15 downto 0)
);

END COMPONENT;

signal sys_clock: STD_LOGIC := '0';
signal reset: STD_LOGIC := '0';
signal crc5_enable: STD_LOGIC := '0';
signal crc16_enable: STD_LOGIC := '0';
signal data: STD_LOGIC := '0';

signal crc5: STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
signal crc16: STD_LOGIC_VECTOR(15 downto 0) := (others => '0');

begin

-- System Clock
sys_clock <= not(sys_clock) after 5 ns;

-- Reset
reset <= '1', '0' after 60 ns, '1' after 3000 ns, '0' after 3200 ns;

-- CRC-5 Enable
crc5_enable <= '0', '1' after 100 ns, '0' after 210 ns;

-- CRC-16 Enable
crc16_enable <= '0', '1' after 300 ns, '0' after 945 ns;

-- Data
data <= '0',
        -- ADDR + Endpoint
        '0' after 100 ns,
        '0' after 110 ns,
        '0' after 120 ns,
        '1' after 130 ns,
        '1' after 140 ns,
        '0' after 150 ns,
        '0' after 160 ns,

        '1' after 170 ns,
        '0' after 180 ns,
        '0' after 190 ns,
        '0' after 200 ns,

        -- DATA0
        '0' after 210 ns;

uut: USBCRCCalculator
    PORT map(
        i_sys_clock => sys_clock,
        i_reset => reset,
        i_crc5_enable => crc5_enable,
        i_crc16_enable => crc16_enable,
        i_data => data,
        o_crc5 => crc5,
        o_crc16 => crc16);

end Behavioral;