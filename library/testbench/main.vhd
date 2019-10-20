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
use ieee.std_logic_textio.all;
use ieee.math_real.all;

library hdl4fpga;
use hdl4fpga.std.all;
use hdl4fpga.scopeiopkg.all;

entity main is
	port (
		tp : buffer std_logic := '1');
end;

architecture def of main is

begin
	process
		variable mesg : line;
		constant pp  : natural_vector := sgmnt_yedges(displaylayout_table(video_description(0).layout_id));
	begin

		for i in pp'range loop
			write (mesg, pp(i));
			writeline(output, mesg);
		end loop;
		wait;

	end process;

end;
