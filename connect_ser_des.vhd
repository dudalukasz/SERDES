----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:09:25 05/26/2015 
-- Design Name: 
-- Module Name:    connect_ser_des - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity connect_ser_des is
    Port ( in_comp : in  STD_LOGIC_VECTOR (7 downto 0);
           out_comp : out  STD_LOGIC_VECTOR (7 downto 0);
           clk : in  STD_LOGIC;
           nreset : in  STD_LOGIC);
end connect_ser_des;

architecture Behavioral of connect_ser_des is

component serializer is 
  Port (   paralel_in : in  STD_LOGIC_VECTOR (7 downto 0);
           clk : in  STD_LOGIC;
           nreset : in  STD_LOGIC;
           serial_out : out  STD_LOGIC
		  );
end component;
		  
component deserializer is
    port ( serial_in : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           nreset : in  STD_LOGIC;
           paralel_out : out  STD_LOGIC_VECTOR (7 downto 0)
			 );
end component;

signal enter: std_logic:='0';
begin

-- mapowanie portow 
ser: serializer port map 
		(
				paralel_in => in_comp,
				clk => clk, 
				nreset => nreset, 
				serial_out => enter
		);
		
des: deserializer port map
		(
				serial_in => enter, 
				clk => clk, 
				nreset => nreset, 
				paralel_out => out_comp
		);

end Behavioral;
