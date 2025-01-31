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

package std is

	type natural_vector is array (natural range <>) of natural;
	type integer_vector is array (natural range <>) of integer;
	type real_vector    is array (natural range <>) of real;

	function signed_num_bits (arg: integer) return natural;
	function unsigned_num_bits (arg: natural) return natural;

	subtype byte is std_logic_vector(8-1 downto 0);
	type byte_vector is array (natural range <>) of byte;

	subtype ascii is std_logic_vector(8-1 downto 0);

	subtype integer64 is time;
	type integer64_vector is array (natural range <>) of integer64;

	function to_stdlogicvector (
		constant arg : string)
		return std_logic_vector;

	function to_bytevector (
		constant arg : string)
		return byte_vector;

	function to_bytevector (
		constant arg : std_logic_vector) 
		return byte_vector;

	function to_bitrom (
		constant data : natural_vector;
		constant size : natural)
		return std_logic_vector;

	function to_bitrom (
		constant data : integer_vector;
		constant size : natural)
		return std_logic_vector;

	function push_left (
		constant queue   : std_logic_vector;
		constant element : std_logic_vector)
		return std_logic_vector;

	function reverse (
		constant arg : std_logic_vector)
		return std_logic_vector;
	
	function reverse (
		constant arg  : std_logic_vector;
		constant size : natural)
		return std_logic_vector;
	
	function to_ascii(
		constant arg : string)
		return std_logic_vector;

	function to_bcd (
		constant arg : string)
		return std_logic_vector;

	function neg (
		constant arg : signed;
		constant ena : std_logic := '1')
		return signed;

	function mul (
		constant op1 : signed;
		constant op2 : unsigned)
		return signed;

	function mul (
		constant op1 : signed;
		constant op2 : natural)
		return signed;

	function mul (
		constant op1 : unsigned;
		constant op2 : natural)
		return unsigned;

	--------------------
	-- Counter functions
	--------------------

	function inc (
		load : std_logic := '1';
		cntr : unsigned;
		data : unsigned;
		ena  : std_logic := '1')
		return unsigned;

	function dec (
		cntr : std_logic_vector;
		ena  : std_logic := '1';
		load : std_logic := '1';
		data : std_logic_vector)
		return std_logic_vector;

	function dec (
		cntr : std_logic_vector;
		ena  : std_logic := '1';
		load : std_logic := '1';
		data : std_logic_vector)
		return unsigned;

	function dec (
		cntr : std_logic_vector;
		ena  : std_logic := '1';
		load : std_logic := '1';
		data : integer)
		return std_logic_vector;

	function dec (
		cntr : std_logic_vector;
		ena  : std_logic := '1';
		load : std_logic := '1';
		data : integer)
		return unsigned;

	-- Logic Functions
	------------------

	function wirebus (
		constant arg1 : std_logic_vector;
		constant arg2 : std_logic_vector)
		return std_logic_vector;

	function setif (
		constant arg  : boolean;
		constant argt : std_logic := '1';
		constant argf : std_logic := '0')
		return std_logic;

	function setif (
		constant arg   : boolean;
		constant argt  : std_logic_vector;
		constant argf : std_logic_vector)
		return std_logic_vector;

	function setif (
		constant arg  : boolean;
		constant argt : natural := 1;
		constant argf : natural := 0)
		return natural;

	function demux (
		constant sel  : std_logic_vector;
		constant inp  : std_logic := '1';
		constant size : natural   := 0)
		return std_logic_vector;

	function primux (
		constant inp  : std_logic_vector;
		constant ena  : std_logic_vector;
		constant def  : std_logic_vector := (0 to 0 => '0'))
		return std_logic_vector;

	function primux (
		constant inp  : natural_vector;
		constant ena  : std_logic_vector;
		constant def  : natural := 0)
		return natural;

	function word2byte (
		constant word : std_logic_vector;
		constant addr : std_logic_vector)
		return std_logic_vector;

	function word2byte (
		constant word : std_logic_vector;
		constant addr : std_logic)
		return std_logic_vector;

	function word2byte (
		constant word : signed;
		constant addr : std_logic)
		return signed;

	function word2byte (
		constant word  : std_logic_vector;
		constant addr  : std_logic_vector;
		constant size  : natural)
		return std_logic_vector;

	function word2byte (
		constant word  : std_logic_vector;
		constant addr  : natural;
		constant size  : natural)
		return std_logic_vector;

	function word2byte (
		constant word  : natural_vector;
		constant addr  : std_logic_vector)
		return natural;

	function byte2word (
		constant word : std_logic_vector;
		constant addr : std_logic_vector;
		constant data : std_logic_vector)
		return std_logic_vector;

	subtype gray is std_logic_vector;

	function inc (
		constant arg : gray)
		return gray;
	
	function slll (
		constant arg1 : std_logic_vector;
		constant arg2 : std_logic := '0')
		return std_logic_vector;

	function pulse_delay (
		constant clk_phases : natural;
		constant phase     : std_logic_vector;
		constant latency   : natural := 12;
		constant extension : natural := 4;
		constant word_size : natural := 4;
		constant width     : natural := 3)
		return std_logic_vector;
	
	-----------
	-- ASCII --
	-----------

	function to_string (
		constant arg : integer)
		return string;

	function to_string (
		constant arg : character)
		return string;

	function to_stdlogicvector (
		constant arg : byte_vector) 
		return std_logic_vector;

	function max (
		constant data : natural_vector)
		return natural;

	function max (
		constant data : integer_vector)
		return integer;

	function max (
		constant arg1 : integer; 
		constant arg2 : integer)
		return integer;

	function max (
		constant arg1 : signed; 
		constant arg2 : signed)
		return signed;

	function min (
		constant arg1 : integer; 
		constant arg2 : integer)
		return integer;

	function min (
		constant arg1 : signed; 
		constant arg2 : signed)
		return signed;

	procedure swap (
		variable arg1 : inout std_logic_vector;
		variable arg2 : inout std_logic_vector);

	function selecton (
		constant condition : boolean;
		constant value_if_true  : integer;
		constant value_if_false : integer)
		return integer;

	function selecton (
		constant condition : boolean;
		constant value_if_true  : real;
		constant value_if_false : real)
		return real;

	function ispower2(
		constant value : natural)
		return boolean;

	function oneschecksum (
		constant data : std_logic_vector;
		constant size : natural)
		return std_logic_vector;

	function ipheader_checksummed (
		constant ipheader : std_logic_vector)
		return std_logic_vector;

	function udp_checksum (
		constant src : std_logic_vector(0 to 32-1);
		constant dst : std_logic_vector(0 to 32-1);
		constant udp : std_logic_vector)
		return std_logic_vector;

	function udp_checksummed (
		constant src : std_logic_vector(0 to 32-1);
		constant dst : std_logic_vector(0 to 32-1);
		constant udp : std_logic_vector)
		return std_logic_vector;

	function encoder (
		constant arg : std_logic_vector)
		return         std_logic_vector;

	function fill (
		constant data  : std_logic_vector;
		constant size  : natural;
		constant right : boolean := true;
		constant value : std_logic := '-')
		return std_logic_vector;

	function fill (
		constant value : std_logic_vector;
		constant size  : natural)
		return std_logic_vector;
	
	function bcd2ascii (
		constant arg : std_logic_vector)
		return std_logic_vector;

	function galois_crc (
		constant m : std_logic_vector;
		constant r : std_logic_vector;
		constant g : std_logic_vector)
		return std_logic_vector;
	
end;

use std.textio.all;

library ieee;
use ieee.std_logic_textio.all;

package body std is

	function encoder (
		constant arg : std_logic_vector)
		return   std_logic_vector is
		variable val : std_logic_vector(0 to unsigned_num_bits(arg'length-1)-1) := (others => '-');
		variable aux : unsigned(0 to arg'length-1) := (0 => '1', others => '0');
	begin
		for i in aux'range loop
			if arg=std_logic_vector(aux) then
				val := std_logic_vector(to_unsigned(i, val'length));
			end if;
			aux := aux ror 1;
		end loop;
		return val;
	end;

	function oneschecksum (
		constant data : std_logic_vector;
		constant size : natural)
		return std_logic_vector is
		constant n        : natural := (data'length+size-1)/size;
		variable aux      : unsigned(0 to data'length-1);
		variable checksum : unsigned(0 to size);
	begin
		aux      := unsigned(data);
		checksum := (others => '0');
		for i in 0 to n-1 loop
			checksum := checksum + resize(aux(0 to size-1), checksum'length);
			if checksum(0)='1' then
				checksum := checksum + 1;
			end if;
			checksum(0) := '0';
			aux := aux sll size;
		end loop;
		return std_logic_vector(checksum(1 to size));	
	end;

	function ipheader_checksummed(
		constant ipheader : std_logic_vector)
		return std_logic_vector is
		variable aux : std_logic_vector(0 to ipheader'length-1);
	begin
		aux := ipheader;
		aux(80 to 96-1) := (others => '0');
		aux(80 to 96-1) := not oneschecksum(aux, 16);
		return aux;
	end;

	function udp_checksum(
		constant src : std_logic_vector(0 to 32-1);
		constant dst : std_logic_vector(0 to 32-1);
		constant udp : std_logic_vector)
		return std_logic_vector is
		variable aux : unsigned(0 to 32+src'length+dst'length+udp'length-1) := (others => '0');
		variable retval : std_logic_vector(16-1 downto 0);
	begin
		aux(src'range) := unsigned(src);
		aux := aux rol src'length;
		aux(dst'range) := unsigned(dst);
		aux := aux rol dst'length;
		aux(0 to 32-1) := x"0011" & to_unsigned(udp'length/8, 16);
		aux := aux rol 32;

		aux(0 to udp'length-1) := unsigned(udp);
		retval := not oneschecksum(std_logic_vector(aux), 16);
		if retval=(retval'range => '0') then
			retval := (others => '1');
		end if;
		return retval;
	end;

	function udp_checksummed(
		constant src  : std_logic_vector(0 to 32-1);
		constant dst  : std_logic_vector(0 to 32-1);
		constant udp  : std_logic_vector)
		return std_logic_vector is
		variable aux1 : unsigned(0 to udp'length-1) := (others => '0');
		variable aux  : unsigned(0 to 32+src'length+dst'length+udp'length-1) := (others => '0');
	begin
		aux1 := unsigned(udp);
		aux(src'range) := unsigned(src);
		aux := aux rol src'length;
		aux(dst'range) := unsigned(dst);
		aux := aux rol dst'length;
		aux(0 to 32-1) := x"0011" & aux1(32 to 32+16-1);
		aux := aux rol 32;

		aux(0 to udp'length-1) := unsigned(udp);
		aux(48 to 64-1) := unsigned(not oneschecksum(std_logic_vector(aux), 16));
		if aux(48 to 64-1)=(1 to 16 => '0') then
			aux(48 to 64-1) := (others => '1');
		end if;
		return std_logic_vector(aux(0 to udp'length-1));
	end;

	------------------
	-- Array functions
	------------------

	function reverse (
		constant arg : std_logic_vector)
		return std_logic_vector is
		variable aux : std_logic_vector(arg'reverse_range);
		variable val : std_logic_vector(arg'range);
	begin
		for i in arg'range loop
			aux(i) := arg(i);
		end loop;
		val := aux;
		return val;
	end;

	function reverse (
		constant arg  : std_logic_vector;
		constant size : natural)
		return std_logic_vector is
		variable aux : std_logic_vector(0 to size*((arg'length+size-1)/size)-1);
	begin
		aux := arg;
		for i in 0 to aux'length/size-1 loop
			aux(0 to size-1) := reverse(aux(0 to size-1));
			aux:= std_logic_vector(unsigned(aux) rol size);
		end loop;
		return aux;
	end;

	function push_left (
		constant queue   : std_logic_vector;
		constant element : std_logic_vector)
		return std_logic_vector is
		variable retval  : unsigned(0 to queue'length-1);
	begin
		retval := unsigned(queue);
		retval := retval srl element'length;
		retval(0 to element'length-1) := unsigned(element);
		return std_logic_vector(retval);
	end;

	function to_ascii(
		constant arg : string)
		return std_logic_vector is
		variable retval : unsigned(ascii'length*arg'length-1 downto 0) := (others => '0');
	begin
		for i in arg'range loop
			retval := retval sll ascii'length;
			retval(ascii'range) := to_unsigned(character'pos(arg(i)), ascii'length);
		end loop;
		return std_logic_vector(retval);
	end;

	function to_bcd(
		constant arg    : string)
		return std_logic_vector is
		constant tab    : natural_vector(0 to 12) := (
			character'pos('0'), character'pos('1'), character'pos('2'), character'pos('3'),
			character'pos('4'), character'pos('5'), character'pos('6'), character'pos('7'),
			character'pos('8'), character'pos('9'), character'pos('.'), character'pos('+'),
		   	character'pos('-'));
		variable retval : unsigned(4*arg'length-1 downto 0) := (others => '0');
	begin
		for i in arg'range loop
			retval := retval sll 4;
			for j in tab'range loop
				if character'pos(arg(i))=tab(j) then
					retval(4-1 downto 0) := to_unsigned(j, 4);
					exit;
				end if;
			end loop;
		end loop;
		return std_logic_vector(retval);
	end;

	function to_bytevector (
		constant arg : std_logic_vector) 
		return byte_vector is
		variable dat : unsigned(arg'length-1 downto 0);
		variable val : byte_vector(arg'length/byte'length-1 downto 0);
	begin	
		dat := unsigned(arg);
		for i in val'reverse_range loop
			val(i) := std_logic_vector(dat(byte'length-1 downto 0));
			dat := dat srl byte'length;
		end loop;
		return val;
	end;

	function to_stdlogicvector (
		constant arg : character)
		return std_logic_vector is
		variable val : unsigned(byte'length-1 downto 0);
	begin
		val(byte'range) := to_unsigned(character'pos(arg),byte'length);
		return std_logic_vector(val);
	end function;

	function to_stdlogicvector (
		constant arg : string)
		return std_logic_vector is
		variable val : unsigned(arg'length*byte'length-1 downto 0);
	begin
		for i in arg'range loop
			val := val sll byte'length;
			val(byte'range) := to_unsigned(character'pos(arg(i)),byte'length);
		end loop;
		return std_logic_vector(val);
	end function;

	function to_bytevector (
		constant arg : string)
		return byte_vector is
		variable val : byte_vector(arg'range);
	begin
		for i in arg'range loop
			val(i) := std_logic_vector(unsigned'(to_unsigned(character'pos(arg(i)),byte'length)));
		end loop;
		return val;
	end function;

	function to_bitrom (
		constant data : natural_vector;
		constant size : natural)
		return std_logic_vector is
		alias    dataa  : natural_vector(0 to data'length-1) is data;
		variable retval : unsigned(0 to data'length*size-1);
	begin
		for i in dataa'range loop
			retval(i*size to (i+1)*size-1) := to_unsigned(dataa(i), size);
		end loop;
		return std_logic_vector(retval);
	end;

	function to_bitrom (
		constant data : integer_vector;
		constant size : natural)
		return std_logic_vector is
		alias    dataa  : integer_vector(0 to data'length-1) is data;
		variable retval : signed(0 to data'length*size-1);
	begin
		for i in dataa'range loop
			retval(i*size to (i+1)*size-1) := to_signed(dataa(i), size);
		end loop;
		return std_logic_vector(retval);
	end;

	--------------------
	-- Logical functions
	--------------------

	function wirebus (
		constant arg1 : std_logic_vector;
		constant arg2 : std_logic_vector)
		return std_logic_vector is
		variable aux    : unsigned(0 to arg1'length-1) := (others => '0');
		variable retval : std_logic_vector(0 to (arg1'length+arg2'length-1)/arg2'length-1);
	begin
		assert arg1'length mod arg2'length = 0
			report "wirebus"
			severity failure;
		aux(0 to arg1'length-1) := unsigned(arg1);
		retval := (others => '0');
		for i in arg2'range loop
			if arg2(i)='1' then
				retval := retval or std_logic_vector(aux(retval'range));
			end if;
			aux := aux sll retval'length;
		end loop;
		return retval;
	end;

	function setif (
		constant arg  : boolean;
		constant argt : std_logic := '1';
		constant argf : std_logic := '0')
		return std_logic is
		variable val : std_logic;
	begin
		if arg then
			return argt;
		end if;
		return argf;
	end function;

	function setif (
		constant arg  : boolean;
		constant argt : std_logic_vector;
		constant argf : std_logic_vector)
		return std_logic_vector is
	begin
		if arg then
			return argt;
		end if;
		return argf;
	end function;

	function setif (
		constant arg  : boolean;
		constant argt : natural := 1;
		constant argf : natural := 0)
		return natural is
	begin
		if arg then
			return argt;
		end if;
		return argf;
	end function;

	function slll (
		constant arg1 : std_logic_vector;
		constant arg2 : std_logic := '0')
		return std_logic_vector is
		variable aux : std_logic_vector(arg1'range);
	begin
		aux := std_logic_vector(shift_left(unsigned(arg1),1));
		aux(aux'right) := arg2;
		return aux;
	end;

	function neg (
		constant arg : signed;
		constant ena : std_logic := '1')
		return signed is
	begin
		if ena='1' then
			return -arg;
		end if;
		return arg;
	end;

	function mul (
		constant op1 : signed;
		constant op2 : unsigned)
		return signed is
		variable muld : signed(op1'length-1 downto 0);
		variable mulr : unsigned(op2'length-1 downto 0);
		variable rval : signed(0 to muld'length+mulr'length-1);
	begin
		muld := op1;
		mulr := op2;
		rval := (others => '0');
		for i in mulr'range loop
			rval := shift_right(rval, 1);
			if mulr(0)='1' then
				rval(0 to muld'length) := rval(0 to muld'length) + muld;
			end if;
			mulr := mulr srl 1;
		end loop;
		return rval;
	end;

	function mul (
		constant op1 : signed;
		constant op2 : natural)
		return signed is
		variable mulr : natural;
		variable muld : signed(op1'length-1 downto 0);
		variable rval : signed(0 to muld'length+unsigned_num_bits(op2)-1);
	begin
		muld := op1;
		mulr := op2;
		rval := (others => '0');
		while mulr /= 0 loop
			rval := shift_right(rval, 1);
			if (mulr mod 2)=1 then
				rval(0 to muld'length) := rval(0 to muld'length) + muld;
			end if;
			mulr := mulr / 2;
		end loop;
		return rval;
	end;

	function mul (
		constant op1 : unsigned;
		constant op2 : natural)
		return unsigned is
		variable mulr : natural;
		variable muld : unsigned(op1'length-1 downto 0);
		variable rval : unsigned(0 to muld'length+unsigned_num_bits(op2)-1);
	begin
		muld := op1;
		mulr := op2;
		rval := (others => '0');
		while mulr /= 0 loop
			rval := shift_right(rval, 1);
			if (mulr mod 2)=1 then
				rval(0 to muld'length) := rval(0 to muld'length) + muld;
			end if;
			mulr := mulr / 2;
		end loop;
		return rval;
	end;

	--------------------
	-- Counter functions
	--------------------

	function count (
		load : std_logic;
		cntr : unsigned;
		data : unsigned;
		ena  : std_logic := '1';
		down : std_logic := '1')
		return unsigned is
	begin
		if ena='1' then
			if load='1' then
				return resize(data,cntr'length);
			else
				if down='1' then
					return cntr-1;
				else
					return cntr+1;
				end if;
			end if;
		else
			return cntr;
		end if;
	end;

	function inc (
		load : std_logic := '1';
		cntr : unsigned;
		data : unsigned;
		ena  : std_logic := '1')
		return unsigned is
	begin
		return count(load,cntr,data,ena,std_logic'('1'));
	end;

	function inc (
		load : std_logic := '1';
		cntr : std_logic_vector;
		data : integer;
		ena  : std_logic := '1')
		return std_logic_vector is
		variable aux : unsigned(cntr'range);
	begin
		aux := unsigned(to_signed(data, cntr'length));
		return std_logic_vector(count(load,unsigned(cntr),aux,ena,std_logic'('1')));
	end;

	function dec (
		cntr : std_logic_vector;
		ena  : std_logic := '1';
		load : std_logic := '1';
		data : std_logic_vector)
		return std_logic_vector is
	begin
		if ena='1' then
			if load='1' then
				return std_logic_vector(resize(unsigned(data), cntr'length));
			else
				return std_logic_vector(unsigned(cntr)-1);
			end if;
		end if;
		return cntr;
	end;

	function dec (
		cntr : std_logic_vector;
		ena  : std_logic := '1';
		load : std_logic := '1';
		data : std_logic_vector)
		return unsigned is
	begin
		return unsigned'(dec(cntr, ena, load, data));
	end;

	function dec (
		cntr : std_logic_vector;
		ena  : std_logic := '1';
		load : std_logic := '1';
		data : integer)
		return std_logic_vector is
	begin
		if ena='1' then
			if load='1' then
				if data < 0 then
					return std_logic_vector(to_signed(data,cntr'length));
				else
					return std_logic_vector(ieee.numeric_std.to_unsigned(data,cntr'length));
				end if;
			else
				return std_logic_vector(unsigned(cntr)-1);
			end if;
		end if;
		return cntr;
	end;

	function dec (
		cntr : std_logic_vector;
		ena  : std_logic := '1';
		load : std_logic := '1';
		data : integer)
		return unsigned is
	begin
		return unsigned(std_logic_vector'(dec(cntr, ena, load, data)));
	end;

	procedure dec (
		signal cntr : inout unsigned;
		constant val : in unsigned) is
	begin
		if cntr(0)/='1' then
			cntr <= cntr - 1;
		else
			cntr <= val;
		end if;
	end procedure;

	function demux (
		constant sel  : std_logic_vector;
		constant inp  : std_logic := '1';
		constant size : natural   := 0)
		return std_logic_vector is
		variable retval : std_logic_vector(0 to 2**sel'length-1);
	begin
		retval := (others => '0');
		retval(to_integer(unsigned(sel))) := inp;
		return retval(0 to size-1);
	end;

	function primux (
		constant inp  : std_logic_vector;
		constant ena  : std_logic_vector;
		constant def  : std_logic_vector := (0 to 0 => '0'))
		return std_logic_vector is
		constant size : natural := (inp'length+ena'length-1)/ena'length;
		variable aux  : unsigned(0 to size*ena'length-1) := (others => '0');
		variable rval : std_logic_vector(0 to size-1) := fill(data => def, size => size);
	begin
		assert inp'length mod ena'length = 0
			report "primux mod"
			severity failure;
		assert inp'length = aux'length
			report "primux length"
			severity failure;
		aux(0 to inp'length-1) := unsigned(inp);
		for i in ena'range loop
			if ena(i)='1' then
				rval := std_logic_vector(aux(0 to size-1));
				exit;
			end if;
			aux := aux rol size;
		end loop;
		return rval;
	end;

	function primux (
		constant inp  : natural_vector;
		constant ena  : std_logic_vector;
		constant def  : natural := 0)
		return natural is
		alias alias_inp : natural_vector(0 to inp'length-1) is inp;
		alias alias_ena : std_logic_vector(0 to ena'length-1) is ena;
	begin
		for i in alias_ena'range loop
			if i < alias_inp'length then
				if alias_ena(i)='1' then
					return alias_inp(i);
				end if;
			else
				exit;
			end if;
		end loop;
		return def;
	end;

	function word2byte (
		constant word : std_logic_vector;
		constant addr : std_logic_vector)
		return std_logic_vector is
		variable aux  : std_logic_vector(0 to word'length-1);
		variable byte : std_logic_vector(0 to word'length/2**addr'length-1); 
	begin
		assert word'length mod byte'length = 0
			report "word2byte mod"
			severity failure;
		aux := word;
		for i in byte'range loop
			byte(i) := aux(byte'length*to_integer(unsigned(addr))+i);
		end loop;
		return byte;
	end;

	function word2byte (
		constant word : std_logic_vector;
		constant addr : std_logic)
		return std_logic_vector is
	begin
		return word2byte(word, (0 to 0 => addr));
	end;

	function word2byte (
		constant word : signed;
		constant addr : std_logic)
		return signed is
	begin
		return signed(word2byte(std_logic_vector(word), (0 to 0 => addr)));
	end;

	function word2byte (
		constant word  : std_logic_vector;
		constant addr  : std_logic_vector;
		constant size  : natural)
		return std_logic_vector is
	begin
		assert word'length mod size = 0
			report "word2byte mod"
			severity failure;
		return word2byte(fill(data => word, size => size*(2**addr'length)), addr);
	end;

	function word2byte (
		constant word  : std_logic_vector;
		constant addr  : natural;
		constant size  : natural)
		return std_logic_vector is
		variable aux : unsigned(0 to size*((word'length+size-1)/size)-1);
	begin
		assert word'length mod size = 0
			report "word2byte mod"
			severity failure;
		aux(0 to word'length-1) := unsigned(word);
		aux := aux rol ((addr*size) mod word'length);
		return std_logic_vector(aux(0 to size-1));
	end;

	function word2byte (
		constant word  : natural_vector;
		constant addr  : std_logic_vector)
		return natural is
		alias    arg    : natural_vector(0 to word'length-1) is word;
		variable retval : natural_vector(0 to 2**addr'length-1);
	begin
		retval := (others => 0);
		if retval'length < arg'length then
			retval := arg(retval'range);
		else
			retval(arg'range) := arg;
		end if;

		return retval(to_integer(unsigned(addr)));
	end;

	function byte2word (
		constant word : std_logic_vector;
		constant addr : std_logic_vector;
		constant data : std_logic_vector)
		return std_logic_vector is
		variable retval : unsigned(0 to data'length*((word'length+data'length-1)/data'length)-1);
	begin
		retval(0 to word'length-1) := unsigned(word);
		for i in 0 to retval'length/data'length-1 loop
			if to_unsigned(i,addr'length)=unsigned(addr) then
				retval(0 to data'length-1) := unsigned(data);
			end if;
			retval := rotate_left(retval, data'length);
		end loop;
		return std_logic_vector(retval(0 to word'length-1));
	end;

	function inc (
		constant arg : gray)
		return gray is
		variable a : std_logic_vector(arg'length-1 downto 0);
		variable t : std_logic_vector(a'range) := (others => '0');
	begin
		a := std_logic_vector(arg);
		for i in a'reverse_range loop
			for j in i to a'left loop
				t(i) := t(i) xor a(j);
			end loop;
			t(i) := not t(i);
			if i > 0 then
				for j in 0 to i-1 loop
					t(i) := t(i) and (not t(j));
				end loop;
			end if;
		end loop;
		if t(a'left-1 downto 0)=(1 to a'left => '0') then
			t(a'left) := '1';
		end if;
		return gray(a xor t);
	end function;

	-----------
	-- ASCII --
	-----------

	function to_string (
		constant arg : integer)
		return string is
		variable msg : line;
	begin
		write (msg, arg);
		return msg.all;
	end function;

	function to_string (
		constant arg : character)
		return string is
		variable msg : line;
	begin
		write (msg, arg);
		return msg.all;
	end function;
		
	function to_stdlogicvector (
		constant arg : byte_vector)
		return std_logic_vector is
		variable dat : byte_vector(arg'length-1 downto 0);
		variable val : unsigned(byte'length*arg'length-1 downto 0);
	begin
		dat := arg;
		for i in dat'range loop
			val := val sll byte'length;
			val(byte'range) := unsigned(dat(i));
		end loop;
		return std_logic_vector(val);
	end;

	function max (
		constant data : natural_vector) 
		return natural is
		variable val : natural:= data(data'left);
	begin
		for i in data'range loop
			if val < data(i) then
				val := data(i);
			end if;
		end loop;
		return val;
	end;

	function max (
		constant data : integer_vector) 
		return integer is
		variable val : integer:= data(data'left);
	begin
		for i in data'range loop
			if val < data(i) then
				val := data(i);
			end if;
		end loop;
		return val;
	end;

	function max (
		constant arg1 : integer; 
		constant arg2 : integer)
		return integer is
	begin
		if arg1 > arg2 then
			return arg1;
		else 
			return arg2;
		end if;
	end;

	function max (
		constant arg1 : signed; 
		constant arg2 : signed)
		return signed is
	begin
		if arg1 > arg2 then
			return arg1;
		else 
			return arg2;
		end if;
	end;

	function min (
		constant arg1 : integer;
		constant arg2 : integer)
		return integer is
	begin
		if arg1 < arg2 then
			return arg1;
		else
			return arg2;
		end if;
	end;

	function min (
		constant arg1 : signed;
		constant arg2 : signed)
		return signed is
	begin
		if arg1 < arg2 then
			return arg1;
		else
			return arg2;
		end if;
	end;

	procedure swap (
		variable arg1 : inout std_logic_vector;
		variable arg2 : inout std_logic_vector)
	is
		variable aux : std_logic_vector(arg1'range);
	begin
		aux  := arg1;
		arg1 := arg2;
		arg2 := aux;
	end;

	function ispower2(
		constant value : natural)
		return boolean is
		variable div  : natural;
		variable rmdr : natural;
	begin
		rmdr := 0;
		div  := value;
		while div /= 0 loop
			exit when rmdr /= 0;
			rmdr := div mod 2;
			div  := div  /  2;
		end loop;
		if div /= 0 then
			return false;
		end if;
		return true;
	end;

	function selecton (
		constant condition : boolean;
		constant value_if_true  : real;
		constant value_if_false : real)
		return real is
	begin
		if condition then
			return value_if_true;
		else
			return value_if_false;
		end if;
	end;

	function selecton (
		constant condition : boolean;
		constant value_if_true  : integer;
		constant value_if_false : integer)
		return integer is
	begin
		if condition then
			return value_if_true;
		else
			return value_if_false;
		end if;
	end;

	function signed_num_bits (
		arg: integer)
		return natural is
		variable nbits : natural;
		variable n : natural;
	begin
		if arg>= 0 then
			n := arg;
		else
			n := -(arg+1);
		end if;
		nbits := 1;
		while n>0 loop
			nbits := nbits + 1;
			n := n / 2;
		end loop;
		return nbits;
	end;

	function unsigned_num_bits (
		arg: natural)
		return natural is
		variable nbits: natural;
		variable n: natural;
	begin
		n := arg;
		nbits := 1;
		while n > 1 loop
			nbits := nbits+1;
			n := n / 2;
		end loop;
		return nbits;
	end;

	function pulse_delay (
		constant clk_phases : natural;
		constant phase     : std_logic_vector;
		constant latency   : natural := 12;
		constant extension : natural := 4;
		constant word_size : natural := 4;
		constant width     : natural := 3)
		return std_logic_vector is
	
		variable latency_mod : natural;
		variable latency_quo : natural;
		variable delay : natural;
		variable pulse : std_logic;

		variable distance : natural;
		variable width_quo : natural;
		variable width_mod : natural;
		variable tail : natural;
		variable tail_quo : natural;
		variable tail_mod : natural;
		variable pulses : std_logic_vector(0 to word_size-1);
		variable ph : natural;
	begin

		latency_mod := latency mod pulses'length;
		latency_quo := latency  /  pulses'length;
		for j in pulses'range loop
			ph := (latency+j) mod pulses'length;
			distance  := (extension-j+pulses'length-1)/pulses'length;
			width_quo := (distance+width-1)/width;
			width_mod := (width_quo*width-distance) mod width;

			delay := latency_quo+(j+latency_mod)/pulses'length;
--			pulse := phase(delay);
			pulse := phase(delay*clk_phases+ph mod clk_phases);


			if width_quo /= 0 then
				tail_quo := width_mod  /  width_quo;
				tail_mod := width_mod mod width_quo;
				for l in 1 to width_quo loop
					tail  := tail_quo + (l*tail_mod) / width_quo;
--					pulse := pulse or phase(delay+l*width-tail);
					pulse := pulse or phase((delay+l*width-tail)*clk_phases+ph mod clk_phases);
				end loop;
			end if;
--			pulses((latency+j) mod pulses'length) := pulse;
			pulses(ph) := pulse;
		end loop;
		return pulses;
	end;

	function fill (
		constant data  : std_logic_vector;
		constant size  : natural;
		constant right : boolean := true;
		constant value : std_logic := '-')
		return std_logic_vector is
		variable retval_right : std_logic_vector(0 to size-1)     := (others => value);
		variable retval_left  : std_logic_vector(size-1 downto 0) := (others => value);
	begin
		retval_right(0 to data'length-1)    := data;
		retval_left(data'length-1 downto 0) := data;
		if right then
			return retval_right;
		end if;
		return retval_left;
	end;

	function fill (
		constant value : std_logic_vector;
		constant size  : natural)
		return std_logic_vector is
		variable retval : unsigned(0 to size-1);
	begin
		for i in 0 to size/value'length-1 loop
			retval := retval srl value'length;
			retval(0 to value'length-1) := unsigned(value);
		end loop;
		return std_logic_vector(retval);
	end;

	function bcd2ascii (
		constant arg : std_logic_vector)
		return std_logic_vector is
		variable aux : unsigned(0 to arg'length-1);
		variable val : unsigned(8*arg'length/4-1 downto 0);
	begin
		val := (others => '-');
		aux := unsigned(arg);
		for i in 0 to aux'length/4-1 loop
			val := val sll 8;
			if to_integer(unsigned(aux(0 to 4-1))) < 10 then
				val(8-1 downto 0) := unsigned'("0011") & unsigned(aux(0 to 4-1));
			elsif to_integer(unsigned(aux(0 to 4-1))) < 15 then
				val(8-1 downto 0) := unsigned'("0010") & unsigned(aux(0 to 4-1));
			else
				val(8-1 downto 0) := x"20";
			end if;
			aux := aux sll 4;
		end loop;
		return std_logic_vector(val);
	end;

	function galois_crc(
		constant m : std_logic_vector;
		constant r : std_logic_vector;
		constant g : std_logic_vector)
		return std_logic_vector is
		variable aux_m : unsigned(0 to m'length-1) := unsigned(m);
		variable aux_r : unsigned(0 to r'length-1) := unsigned(r);
	begin
		for i in aux_m'range loop
			aux_r := (aux_r sll 1) xor ((aux_r'range => aux_r(0) xor aux_m(0)) and unsigned(g));
			aux_m := aux_m sll 1;
		end loop;
		return std_logic_vector(aux_r);
	end;

end;
