------------------------------------------------------------------------
-- Engineer:    Dalmasso Loic
-- Create Date: 16/04/2025
-- Module Name: NRZIClockRecovery
-- Description:
--      Non-Return-to-Zero Inverted Clock Recovery module from Sync Pattern (typically: KJ KJ KJ KK) and Bit Stuffing (typically: KK KK KK KJ)
--
--      /!\ The System Clock of this module must be greater than the expected NRZI clock (oversampling) /!\
--
-- Generics
--      SYS_CLOCK_HZ: System Clock Frequency (in HZ)
--      USB_SPEED_BPS: USB Speed (in BPS)
--      K_VALUE: the USB K value
--      J_VALUE: the USB J value
--
-- Ports
--		Input 	-	i_sys_clock: System Input Clock
--		Input 	-	i_reset: System Input Reset ('0': No Reset, '1': Reset)
--		Input 	-	i_nrzi_data: NRZI Data
--		Output 	-	o_nrzi_clock: NRZI Clock (to use as Clock Enable)
------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY Testbench_NRZIClockRecovery is
--  Port ( );
END Testbench_NRZIClockRecovery;

ARCHITECTURE Behavioral of Testbench_NRZIClockRecovery is

COMPONENT NRZIClockRecovery is

GENERIC(
    -- System Configurations
    SYS_CLOCK_HZ: INTEGER := 100_000_000;
    -- USB Configurations
    USB_SPEED_BPS: INTEGER := 12_000_000;
    K_VALUE: STD_LOGIC := '0';
    J_VALUE: STD_LOGIC := '1'
);

PORT(
    i_sys_clock: IN STD_LOGIC;
    i_reset: IN STD_LOGIC;
    i_nrzi_data: IN STD_LOGIC;
    o_nrzi_clock: OUT STD_LOGIC
);

END COMPONENT;

constant K_VALUE: STD_LOGIC := '0';
constant J_VALUE: STD_LOGIC := '1';

signal sys_clock: STD_LOGIC := '0';
signal reset: STD_LOGIC := '0';
signal nrzi_data: STD_LOGIC := '0';
signal nrzi_clock: STD_LOGIC := '0';

signal nrzi_data_verif: STD_LOGIC := '0';

begin

-- System Clock
sys_clock <= not(sys_clock) after 5 ns;

-- Reset
reset <= '1', '0' after 60 ns, '1' after 3000 ns, '0' after 3200 ns;

-- NRZI Data input (12 MBps)
nrzi_data <=    J_VALUE, -- IDLE
                -- Sync Pattern: KJ KJ KJ KK
                K_VALUE after 112 ns,
                J_VALUE after 192 ns,
                K_VALUE after 272 ns,
                J_VALUE after 352 ns,
                K_VALUE after 452 ns, -- too late (should be 432)
                J_VALUE after 492 ns, -- too earlier (should be 512)
                K_VALUE after 572 ns, -- too earlier (should be 592)
                K_VALUE after 672 ns,

                -- Data
                J_VALUE after 752 ns,
                J_VALUE after 832 ns,

                -- Bit Stuffing: KK KK KK KJ
                K_VALUE after 912 ns,
                K_VALUE after 992 ns,
                K_VALUE after 1072 ns,
                K_VALUE after 1152 ns,
                K_VALUE after 1232 ns,
                K_VALUE after 1312 ns,
                K_VALUE after 1392 ns,
                J_VALUE after 1472 ns,

                -- Data
                J_VALUE after 1552 ns,
                J_VALUE after 1632 ns;

uut: NRZIClockRecovery
    GENERIC map(
        SYS_CLOCK_HZ => 100_000_000,
        USB_SPEED_BPS => 12_000_000,
        K_VALUE => K_VALUE,
        J_VALUE => J_VALUE
    )
    
    PORT map(
        i_sys_clock => sys_clock,
        i_reset => reset,
        i_nrzi_data => nrzi_data,
        o_nrzi_clock => nrzi_clock);

-- Data Verification
process(sys_clock)
begin
    if rising_edge(sys_clock) then

        -- NRZI Clock Enable
        if (nrzi_clock = '1') then
            nrzi_data_verif <= nrzi_data;
        end if;
    end if;
end process;

end Behavioral;