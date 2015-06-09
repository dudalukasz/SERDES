----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:15:16 04/11/2015 
-- Design Name: 
-- Module Name:    deserializer - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity deserializer is
    Port ( serial_in : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           nreset : in  STD_LOGIC;
           paralel_out : out  STD_LOGIC_VECTOR (7 downto 0));
end deserializer;

architecture Behavioral of deserializer is
	signal licznik: STD_LOGIC_VECTOR(5 downto 0);
	signal licznik2: STD_LOGIC_VECTOR(2 downto 0);
	signal rejestr: STD_LOGIC_VECTOR(7 downto 0);
	signal start_stop: STD_LOGIC;
begin

deserial: process(clk, nreset)
begin
	if nreset = '0' then
		rejestr <= (others => '0');
		paralel_out <= (others => '0');
		
	elsif clk'Event and clk='1' then
		rejestr(7 downto 0) <= rejestr(6 downto 0) & serial_in;	-- dane z wejścia szeregowego przesuwamy
		
		if licznik(2 downto 0) = "111" then 			-- co 8 bitów wyrzuć dane na wyjście równoległe
			paralel_out <= rejestr;
		end if;
		
	end if;
end process deserial;

licz: process(clk, nreset)
begin
	if nreset = '0' then
		licznik <= (others=>'0');
	elsif clk'Event and clk='1' then
		if start_stop = '1' then								
			licznik <= licznik+1;				-- liczymy bity przy odbieraniu danych (od 0 do 63, czyli 64 bity)
		else 
			licznik <= (others => '0');		-- gdy zatrzymane odbieranie danych to nie liczymy bitów
		end if;
	end if;
end process licz;

startstop: process(clk, nreset)
begin
	if nreset = '0' then
		start_stop <= '0';
	elsif clk'Event and clk='1' then
		if start_stop = '0' and rejestr = "10000001" then		-- gdy pojawi się początek ramki
			start_stop <= '1';											-- zacznij odbierać dane
		end if;
		if start_stop = '1' and licznik = "111111" then		-- odbierz 64 bity danych i zatrzymaj.
			start_stop <= '0';
		end if;
	end if;
end process startstop;


end Behavioral;
