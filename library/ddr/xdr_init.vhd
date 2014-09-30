use std.textio.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;

library hdl4fpga;
use hdl4fpga.std.all;
use hdl4fpga.xdr_param.all;

entity xdr_init is
	generic (
		timers : timer_vector := (TMR_RST => 100_000, TMR_RRDY => 250_000, TMR_CKE => 14, TMR_MRD => 17, TMR_ZQINIT => 20, TMR_REF => 25);
		addr_size : natural := 13;
		bank_size : natural := 3);
	port (
		xdr_init_ods : in  std_logic := '0';
		xdr_init_rtt : in  std_logic_vector(1 downto 0) := "01";
		xdr_init_bl  : in  std_logic_vector(0 to 2);
		xdr_init_cl  : in  std_logic_vector(0 to 2);
		xdr_init_wr  : in  std_logic_vector(0 to 2) := (others => '0');
		xdr_init_cwl : in  std_logic_vector(0 to 2) := (others => '0');
		xdr_init_pl  : in  std_logic_vector(0 to 2) := (others => '0');
		xdr_init_dqsn : in std_logic := '0';

		xdr_init_clk : in  std_logic;
		xdr_init_req : in  std_logic;
		xdr_init_rdy : out std_logic := '1';
		xdr_init_rst : out std_logic := '0';
		xdr_init_cke : out std_logic := '0';
		xdr_init_odt : out std_logic := '0';
		xdr_init_ras : out std_logic := '1';
		xdr_init_cas : out std_logic := '1';
		xdr_init_we  : out std_logic := '1';
		xdr_init_a   : out std_logic_vector(ADDR_SIZE-1 downto 0) := (others => '1');
		xdr_init_b   : out std_logic_vector(BANK_SIZE-1 downto 0) := (others => '1'));

	constant xdrinitout_size : natural := 2;

	constant xdrinitods_size : natural := 1;
	constant cnfgreg_size : natural := 
		xdrinitods_size +
		xdr_init_pl'length +
		xdr_init_cwl'length +
		xdr_init_rtt'length +
		xdr_init_wr'length +
		xdr_init_bl'length +
		xdr_init_cl'length;

	subtype  dst_a   is natural range xdr_init_a'length-1 downto 0;
	subtype  dst_b   is natural range dst_a'high+xdr_init_b'length downto dst_a'high+1;
	subtype  dst_cmd is natural range dst_b'high+4 downto dst_b'high+1;
	constant dst_cs  : natural := dst_b'high+4;
	constant dst_ras : natural := dst_b'high+3;
	constant dst_cas : natural := dst_b'high+2;
	constant dst_we  : natural := dst_b'high+1;
	subtype  dst_o   is natural range dst_cs+xdrinitout_size downto dst_ras+1;

	subtype src_word is std_logic_vector(2+cnfgreg_size downto 1);
	subtype dst_word is std_logic_vector(dst_cmd'high downto 0);
	subtype dst_wtab is natural_vector(dst_word'range);

	type ccmds is (CFG_ZQC, CFG_MRS);

	type mr_array is array (natural range <>) of ddr3_mr;

	signal src : src_word;

	signal xdr_timer_req : std_logic;
	signal xdr_timer_rdy : std_logic;
	signal xdr_timer_id  : TMR_IDs;

	attribute fsm_encoding : string;
	attribute fsm_encoding of xdr_init : entity is "compact";

end;

architecture ddr3 of xdr_init is

	signal dst : dst_word;

	constant ddl_rdy : field_desc := (dbase => dst_o'low+0, sbase => 1, size => 1);
	constant end_rdy : field_desc := (dbase => dst_o'low+1, sbase => 1, size => 1);

	-- DDR3 Mode Register 0 --
	--------------------------

	constant bl   : field_desc := (dbase =>  0, sbase => 1, size => 3);
	constant bt   : field_desc := (dbase =>  3, sbase => 1, size => 1);
	constant cl   : field_desc := (dbase =>  4, sbase => 1, size => 3);
	constant tm   : field_desc := (dbase =>  7, sbase => 1, size => 1);
	constant rdll : field_desc := (dbase =>  8, sbase => 1, size => 1);
	constant wr   : field_desc := (dbase =>  9, sbase => 1, size => 3);
	constant pd   : field_desc := (dbase => 12, sbase => 1, size => 1);

	-- DDR3 Mode Register 1 --
	--------------------------

	constant edll : field_desc := (dbase => 0, sbase => 1, size => 1);
	constant ods  : fielddesc_vector := ((dbase => 1, sbase => 1, size => 1), (dbase => 5, sbase => 1, size => 1));
	constant rtt  : fielddesc_vector := ((dbase => 2, sbase => 1, size => 1), (dbase => 6, sbase => 1, size => 1), (dbase => 9, sbase => 1, size => 1));
	constant al   : field_desc := (dbase =>  3, sbase => 1, size => 2);
	constant wl   : field_desc := (dbase =>  7, sbase => 0, size => 1);
	constant dqs  : field_desc := (dbase => 10, sbase => 0, size => 1);
	constant tdqs : field_desc := (dbase => 11, sbase => 0, size => 1);
	constant qoff : field_desc := (dbase => 12, sbase => 0, size => 1);

	-- DDR3 Mode Register 2 --
	--------------------------

	constant cwl  : field_desc := (dbase => 3, sbase => 0, size => 3);
	constant asr  : field_desc := (dbase => 6, sbase => 0, size => 1);
	constant srt  : field_desc := (dbase => 7, sbase => 0, size => 1);
	constant rttw : field_desc := (dbase => 9, sbase => 0, size => 2);

	-- DDR3 Mode Register 3 --
	--------------------------

	constant rf  : field_desc := (dbase => 0, sbase => 0, size => 2);

	constant mr : ddr3mr_vector(0 to 3) := ( 
		(clr(rttw) or mov(cwl)),
		(clr(edll) or mov(ods) or mov(rtt) or mov(al) or set(wl)   or mov(tdqs)),
		(clr(edll) or mov(ods) or mov(rtt) or mov(al) or set(wl)   or mov(tdqs)),
		(mov(bl)   or set(bt)  or mov(cl)  or clr(tm) or set(edll) or mov(wr) or mov(pd)));

	constant mrx : std_logic_vector(dst_word'range) := (others => '-');
	constant ddr3_a10 : std_logic_vector(10 to 10) := "1";

	type yyy is record
		ccmd : ddr3_ccmd;
		id   : TMR_IDs;
	end record;

	type xxx is record
		dst : dst_word;
		id  : TMR_IDs;
	end record;

	type ddr3ccmd_vector is array (natural range <>) of yyy;

	constant pgm : ddr3ccmd_vector := (
		(ddr3_cnop + mrx, TMR_RRDY),
		(ddr3_cnop + mrx, TMR_CKE),
		(ddr3_clmr + mr2, TMR_MRD),
		(ddr3_clmr + mr3, TMR_MRD),
		(ddr3_clmr + mr1, TMR_MRD),
		(ddr3_clmr + mr0, TMR_MRD),
		(ddr3_czqc + ddr3_a10, TMR_ZQINIT));

	signal xdr_init_pc : unsigned(0 to unsigned_num_bits(pgm'length-1));

	impure function compile_pgm (
		constant pc  : unsigned;
		constant src : std_logic_vector)
		return xxx is
		variable val : dst_word := (others => '-');
		variable aux : std_logic_vector(1 to pc'length-1);
		variable msg : line;

	begin
		aux := std_logic_vector(resize(pc, pc'length-1));
		for i in pgm'range loop
			if aux=to_unsigned(pgm'length-1-i, aux'length) then
				val(dst_cmd) := pgm(i).ccmd.cmd;
				case pgm(i).id is 
				when TMR_RRDY =>
					return (dst => (dst_word'range => '-'), id => pgm(i).id);
				when TMR_CKE =>
					val := (others => '-');
					val(dst_cmd) := ddr3_cnop.id;
					return (dst => val, id => pgm(i).id);
				when TMR_MRD =>
					val := (others  => '0');
					for j in pgm(i).ccmd.addr'range loop
						if mr(to_integer(unsigned(pgm(i).ccmd.bank))).tab(j) /= 0 then
							val(j) := src(mr(to_integer(unsigned(pgm(i).ccmd.bank))).tab(j));
						end if;
					end loop;
					val(dst_cmd) := pgm(i).ccmd.cmd;
					val(dst_b)   := pgm(i).ccmd.bank;
					return (dst => val, id => TMR_MRD);
				when TMR_ZQINIT =>
					for j in pgm(i).ccmd.addr'range loop
						if pgm(i).ccmd.addr(j) /= 0 then
							val(j) := src(pgm(i).ccmd.addr(j));
						end if;
					end loop;
					return (dst => val, id => TMR_ZQINIT);
				when others =>
					report "Wrong command"
					severity ERROR;
				end case;
			end if;
		end loop;
		report "Wrong command yyy"
		severity ERROR;
		return (dst => val, id => TMR_RST);
	end;

begin

	src <=
		xdr_init_ods & 
		xdr_init_pl  & 
		xdr_init_cwl &
		xdr_init_rtt & 
		xdr_init_wr  & 
		xdr_init_bl  &
		xdr_init_cl  &
		"10";

	process (xdr_init_clk)
	begin
		if rising_edge(xdr_init_clk) then
			if xdr_init_req='0' then
				if xdr_timer_rdy='1' then
					if xdr_init_pc(0)='0' then
						xdr_init_pc <= xdr_init_pc - 1;
						dst <= compile_pgm(xdr_init_pc, src).dst;
					else
						dst <= (others => '1');
					end if;
				else
					dst <= (others => '1');
				end if;
			else
				dst <= (others => '-');
				xdr_init_pc <= to_unsigned(pgm'length-1, xdr_init_pc'length);
			end if;

			if xdr_init_req='0' then
				if xdr_timer_rdy='0' then
					if xdr_init_pc(0)='0' then
						xdr_timer_id <= compile_pgm(xdr_init_pc, src).id;
					end if;
				end if;
			else
				xdr_timer_id <= TMR_RST;
			end if;

			if xdr_init_req='0' then
				if xdr_timer_rdy='1' then
					case xdr_timer_id is
					when TMR_RST =>
						xdr_init_rst <= '0';
						xdr_init_cke <= '0';
					when TMR_RRDY =>
						xdr_init_rst <= '1';
						xdr_init_cke <= '0';
					when others =>
						xdr_init_rst <= '1';
						xdr_init_cke <= '1';
					end case;
				end if;
			else
				xdr_init_rst <= '0';
				xdr_init_cke <= '0';
			end if;

		end if;
	end process;
	xdr_timer_req <= xdr_timer_rdy or xdr_init_req;

	xdr_init_a   <= dst(dst_a);
	xdr_init_b   <= dst(dst_b);
	xdr_init_ras <= dst(dst_ras);
	xdr_init_cas <= dst(dst_cas);
	xdr_init_we  <= dst(dst_we);
	xdr_init_rdy <= xdr_init_pc(0);

	timer_e : entity hdl4fpga.xdr_timer
	generic map (
		timers => timers)
	port map (
		sys_clk => xdr_init_clk,
		tmr_id  => xdr_timer_id,
		sys_req => xdr_timer_req,
		sys_rdy => xdr_timer_rdy);
end;
