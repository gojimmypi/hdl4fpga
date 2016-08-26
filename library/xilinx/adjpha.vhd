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

use std.textio.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;

library hdl4fpga;
use hdl4fpga.std.all;

entity adjpha is
	generic (
		TCP     : natural;
		TAP_DLY : natural := 27);
	port (
		
		clk     : in  std_logic;
		req     : in  std_logic;
		rdy     : out std_logic;
		dly_rdy : in  std_logic;
		dly_req : buffer std_logic;
		edge    : in  std_logic;
		smp     : in  std_logic;
		st      : out std_logic;
		dly     : out std_logic_vector);

end;

architecture beh of adjpha is
	constant num_of_taps  : natural := tCP/(2*tap_dly);
	constant num_of_steps : natural := unsigned_num_bits(num_of_taps)+2;
	subtype gap_word is unsigned(dly'length-1 downto 0);
	type gword_vector is array(natural range <>) of gap_word;

	function create_gaps (
		constant num_of_taps  : natural;
		constant num_of_steps : natural)
		return gword_vector is
		variable val : gword_vector(2**unsigned_num_bits(num_of_steps)-1 downto 0);
		variable aux : natural;
	begin
		val := (others => (others => '-'));
		aux := num_of_taps;
		val(num_of_steps-1) := to_unsigned(2**(gap_word'length-1), gap_word'length);
		for i in num_of_steps-2 downto 1 loop
			val(i) := to_unsigned((aux+1)/2, gap_word'length);
			aux    := aux / 2;
		end loop;
		val(0) := (others => '0');
		return val;
	end;

	constant gaptab : gword_vector := create_gaps(num_of_taps, num_of_steps);

	signal   pha    : gap_word;
	signal   phb    : gap_word;
	signal   phc    : gap_word;
	signal   step   : unsigned(0 to unsigned_num_bits(num_of_steps-1));

begin
  
	process(req, clk)
	begin
		if rising_edge(clk) then
			if req='0' then
				step <= to_unsigned(num_of_steps-1, step'length);
				phb  <= (others => '0');
				pha  <= (others => '0');
				rdy  <= '0';
				dly_req <= '0';
			elsif step(0)='0' then
				if dly_rdy='1' then
					if dly_req='1' then
						if smp=edge then
							phb <= pha;
						end if;
						pha  <= phc + gaptab(to_integer(step(1 to step'right)));
						step <= step - 1;
					end if;
					dly_req <= '0';
				else
					if smp=edge then
						phc <= pha;
					else
						phc <= phb;
					end if;
					dly_req <= '1';
				end if;
				rdy <= '0';
			elsif dly_rdy='0' then
				dly_req <= '1';
				rdy <= '1';
			end if;
		end if;
	end process;
	dly <= std_logic_vector(pha(pha'left) & resize(pha(pha'left-1 downto 0), dly'length-1));

end;
