----------------------------------------------------------------------------------
-- Company: Wroclaw University of Technology
-- Engineer: dr inż. Tomasz Fałat
-- 
-- Create Date:    19:54:41 04/11/2015 
-- Design Name: 	SERDES
-- Module Name:    serializer - Behavioral 
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


entity serializer is
    Port ( paralel_in : in  STD_LOGIC_VECTOR (7 downto 0);
           clk : in  STD_LOGIC;
           nreset : in  STD_LOGIC;
           serial_out : out  STD_LOGIC);
end serializer;

architecture Behavioral of serializer is

signal licznik: STD_LOGIC_VECTOR(2 downto 0);
signal rejestr: STD_LOGIC_VECTOR(7 downto 0);

begin

serial: process(clk, nreset)
begin
	if nreset = '0' then
		rejestr <= (others=>'0');
	elsif clk'Event and clk='1' then
		if licznik = "111" then
			rejestr <= paralel_in;
		else
			rejestr(7 downto 0) <= rejestr(6 downto 0) & '1';
		end if;
	end if;
end process serial;

serial_out <= rejestr(7);

licz: process(clk, nreset)
begin
	if nreset = '0' then
		licznik <= (others=>'0');
	elsif clk'Event and clk='1' then
		licznik <= licznik+1;
	end if;
end process licz;


end Behavioral;
