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

ENTITY DualPortROM is

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

END DualPortROM;

ARCHITECTURE Behavioral of DualPortROM is

------------------------------------------------------------------------
-- Constant Declarations
------------------------------------------------------------------------
constant ROM_LENGTH: INTEGER := 2**MEMORY_ADDR_LENGTH;

------------------------------------------------------------------------
-- Signal Declarations
------------------------------------------------------------------------
-- ROM Description
type ROM_TYPE is array (ROM_LENGTH-1 downto 0) of STD_LOGIC_VECTOR(MEMORY_DATA_LENGTH-1 downto 0);
signal ROM : ROM_TYPE := (
	-- Start ROM Values
	(others => '0'),
	(others => '0')
	-- End ROM Values
	);
ATTRIBUTE ROM_STYLE : STRING;
ATTRIBUTE ROM_STYLE of ROM: signal is "block";

-- ROM Port A Output Register
signal douta_reg: STD_LOGIC_VECTOR(MEMORY_DATA_LENGTH-1 downto 0) := (others => '0');

-- ROM Port B Output Register
signal doutb_reg: STD_LOGIC_VECTOR(MEMORY_DATA_LENGTH-1 downto 0) := (others => '0');

------------------------------------------------------------------------
-- Module Implementation
------------------------------------------------------------------------
begin

	------------------------
	-- ROM Port A Handler --
	------------------------
	process(clka)
	begin
		if rising_edge(clka) then

			-- ROM Port A Enable
			if (ena = '1') then
				douta_reg <= ROM(TO_INTEGER(UNSIGNED((addra))));
			end if;
		end if;
	end process;

	--------------------------------
	-- ROM Port A Output Register --
	--------------------------------
	process(clka)
	begin
		if rising_edge(clka) then
			-- Port A Output Register
			douta <= douta_reg;
		end if;
	end process;

	------------------------
	-- ROM Port B Handler --
	------------------------
	process(clkb)
	begin
		if rising_edge(clkb) then

			-- ROM Port B Enable
			if (enb = '1') then
				doutb_reg <= ROM(TO_INTEGER(UNSIGNED((addrb))));
			end if;
		end if;
	end process;

	--------------------------------
	-- ROM Port B Output Register --
	--------------------------------
	process(clkb)
	begin
		if rising_edge(clkb) then
			-- Port B Output Register
			doutb <= doutb_reg;
		end if;
	end process;

end Behavioral;