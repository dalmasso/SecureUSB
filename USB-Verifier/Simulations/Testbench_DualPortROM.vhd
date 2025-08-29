------------------------------------------------------------------------
-- Engineer:    Dalmasso Loic
-- Create Date: 22/08/2025
-- Module Name: DualPortROM (Template)
-- Description:
--		Module in charge of inferring a Dual-Port ROM with Enables and Output Registers, containing Verification Values
--
-- Usage:
--      Once enable, each port of the ROM outputs Data of the corresponding Address
--      The Read operation requires 2 Clock Cycles
--
-- Generics:
--		MEMORY_ADDR_LENGTH: Define the Memory Address Bus Length (in line with the maximum index value)
--		MEMORY_DATA_LENGTH: Define the Memory Data Bus Length (in line with the Verification Value length)
--
-- Ports
--		Input 	-	clka: Memory Clock Input for Port A
--		Input 	-	ena: Memory Enable Input for Port A ('0': Disabled, '1': Enabled)
--		Input 	-	addra: Memory Address Input for Port A
--		Output 	-	douta: Memory Data Output for Port A
--		Input 	-	clkb: Memory Clock Input for Port B
--		Input 	-	enb: Memory Enable Input for Port B ('0': Disabled, '1': Enabled)
--		Input 	-	addrb: Memory Address Input for Port B
--		Output 	-	doutb: Memory Data Output for Port B
------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY Testbench_DualPortROM is
--  Port ( );
END Testbench_DualPortROM;

ARCHITECTURE Behavioral of Testbench_DualPortROM is

------------------------------------------------------------------------
-- Component Declarations
------------------------------------------------------------------------
COMPONENT DualPortROM is

GENERIC(
	-- Memory Configurations (Address Length, Data Length)
	MEMORY_ADDR_LENGTH: INTEGER := 1;
	MEMORY_DATA_LENGTH: INTEGER := 39
);

PORT(
	-- Port A
	clka: IN STD_LOGIC;
	ena: IN STD_LOGIC;
	addra: IN STD_LOGIC_VECTOR(MEMORY_ADDR_LENGTH-1 downto 0);
	douta: OUT STD_LOGIC_VECTOR(MEMORY_DATA_LENGTH-1 downto 0);
	-- Port B
	clkb: IN STD_LOGIC;
	enb: IN STD_LOGIC;
	addrb: IN STD_LOGIC_VECTOR(MEMORY_ADDR_LENGTH-1 downto 0);
	doutb: OUT STD_LOGIC_VECTOR(MEMORY_DATA_LENGTH-1 downto 0)
);

END COMPONENT;

------------------------------------------------------------------------
-- Constant Declarations
------------------------------------------------------------------------
constant MEMORY_ADDR_LENGTH: INTEGER := 2;
constant MEMORY_DATA_LENGTH: INTEGER := 2;

------------------------------------------------------------------------
-- Signal Declarations
------------------------------------------------------------------------
signal sys_clock: STD_LOGIC := '0';
signal ena: STD_LOGIC := '0';
signal enb: STD_LOGIC := '0';
signal addra: STD_LOGIC_VECTOR(MEMORY_ADDR_LENGTH-1 downto 0) := (others => '0');
signal addrb: STD_LOGIC_VECTOR(MEMORY_ADDR_LENGTH-1 downto 0) := (others => '0');
signal douta: STD_LOGIC_VECTOR(MEMORY_DATA_LENGTH-1 downto 0) := (others => '0');
signal doutb: STD_LOGIC_VECTOR(MEMORY_DATA_LENGTH-1 downto 0) := (others => '0');

------------------------------------------------------------------------
-- Module Implementation
------------------------------------------------------------------------
begin

-- System Clock
sys_clock <= not(sys_clock) after 5 ns;

-- Enables
ena <= '0', '1' after 30 ns, '0' after 135 ns, '1' after 145 ns;
enb <= ena;

-- Addresses
addra <= "00", "10" after 45 ns;
addrb <= "01", "11" after 45 ns;

uut: DualPortROM
	GENERIC MAP (
		-- Memory Configurations (Address Length, Data Length)
		MEMORY_ADDR_LENGTH => MEMORY_ADDR_LENGTH,
		MEMORY_DATA_LENGTH => MEMORY_DATA_LENGTH
	)

	PORT MAP (
		-- Port A
		clka => sys_clock,
		ena => ena,
		addra => addra,
		douta => douta,
		-- Port B
		clkb => sys_clock,
		enb => enb,
		addrb => addrb,
		doutb => doutb
	);

end Behavioral;