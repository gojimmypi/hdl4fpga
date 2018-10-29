--                                                                            --
-- Author(s):                                                                 --
--   Miguel Angel Sagreras                                                    --
--                                                                            --
-- Copyright (C) 2015                                                         --
--    Miguel Angel Sagreras                                                   --
--                                                                            --
-- This source file may be used and distributed without restriction provided  --
-- that this copyright statement is not removed from the file and that any    --
-- derivative work contains  the original copyright notice and the associated --
-- disclaimer.                                                                --
--                                                                            --
-- This source file is free software; you can redistribute it and/or modify   --
-- it under the terms of the GNU General Public License as published by the   --
-- Free Software Foundation, either version 3 of the License, or (at your     --
-- option) any later version.                                                 --
--                                                                            --
-- This source is distributed in the hope that it will be useful, but WITHOUT --
-- ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or      --
-- FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for   --
-- more details at http://www.gnu.org/licenses/.                              --
--                                                                            --

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library hdl4fpga;
use hdl4fpga.std.all;

entity mult is
	port (
		clk     : in  std_logic := '-';
		ini     : in  std_logic := '1';
		accmltr : in  std_logic_vector := (0 to 0 => '0');
		multand : in  std_logic_vector;
		multier : in  std_logic_vector;
		product : out std_logic_vector);
end;

architecture def of mult is

	function mult_f (
		constant accmltr : signed;
		constant multand : signed;
		constant multier : unsigned)
		return signed is
		variable lsb    : std_logic;
		variable retval : signed(0 to multand'length+multier'length-1);
	begin
		retval(0 to multier'length-1) := signed(multier);
		retval := retval rol multier'length;
		retval(0 to accmltr'length-1) := accmltr;
		for i in multier'range loop
			lsb    := retval(retval'right);
			retval := shift_right(retval, 1);
			if lsb='1' then
				retval(0 to multand'length) := retval(0 to multand'length) + resize(multand, multand'length+1);
			end if;
		end loop;
		return retval;
	end;

	signal product_d : signed(0 to product'length-1);
	signal accmltr_d : signed(0 to multand'length-1);
	signal accmltr_q : signed(accmltr_d'range);

begin

	accmltr_d <= resize(signed(accmltr), accmltr_d'length) when ini='1' else accmltr_q;
	product_d <= mult_f(accmltr_d, signed(multand), unsigned(multier));
	process(clk)
	begin
		if rising_edge(clk) then
			accmltr_q <= product_d(accmltr_d'range);
		end if;
	end process;
	product <= std_logic_vector(product_d);

end;

--library ieee;
--use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;
--
--library hdl4fpga;
--use hdl4fpga.std.all;
--
--entity mult is
--	port (
--		clk     : in  std_logic := '-';
--		ini     : in  std_logic := '1';
--		multand : in  std_logic_vector;
--		multier : in  std_logic_vector;
--		product : out std_logic_vector);
--end;
--
--architecture def of mult is
--
--	signal product_d : signed(0 to product'length-1);
--	signal accmltr_dg : signed(0 to multand'length-1);
--	signal accmltr_q : signed(accmltr_d'range);
--
--	procedure accy (
--		variable co  : out   std_logic;
--		variable op1 : inout unsigned;
--		constant op2 : in    unsigned;
--		constant ci  : in    std_logic) is
--		variable acc : signed(0 to accmltr'length+1);
--	begin
--			paccmltr := paccmltr + signed('0' & product_d(accmltr_d'range) & ci);
--	end;
--
--begin
--
--	multp_e : entity hdl4fpga.multp
--	port map (
--		clk     => clk,
--		ini     => 
--		accmltr => accmltr_dg,
--		multand => multand_dg,
--		multier => multier_dg,
--		product => product_dg);
--
--	process
--	process(clk)
--		variable ci : std_logic;
--		variable co : std_logic;
--		variable paccmultr : signed(0 to accmltr'length+1);
--	begin
--		if rising_edge(clk) then
--			paccmltr := (others => '0')
--			paccmltr(multa'range
--			paccmltr := paccmltr + signed('0' & product_d(accmltr_d'range) & ci);
--			:= paccmltr(1 to l
--		end if;
--	end process;
--	product <= std_logic_vector(product_d);
--
--end;
--
