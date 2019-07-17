library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library hdl4fpga;
use hdl4fpga.std.all;

entity scopeio_downsampler is
	generic (
		inputs  : natural;
		factors : natural_vector);
	port (
		factor_id     : in  std_logic_vector;
		input_clk     : in  std_logic;
		input_dv      : in  std_logic;
		input_data    : in  std_logic_vector;
		input_shot    : in  std_logic;
		output_dv     : out std_logic;
		output_shot   : out std_logic;
		output_data   : out std_logic_vector);
end;

architecture beh of scopeio_downsampler is

	function adjust (
		constant arg : natural_vector)
		return integer_vector is
		variable retval : integer_vector(arg'range);
	begin
		for i in arg'range loop
			retval(i) := arg(i)-2;
		end loop;
		return retval;
	end;

	constant scaler_bits : natural := signed_num_bits(max(factors)-2);

	signal factor   : std_logic_vector(0 to scaler_bits-1);
	signal data_in  : std_logic_vector(0 to input_data'length-1);
	signal data_out : std_logic_vector(0 to output_data'length-1);
	signal scaler_ena : std_logic;
	signal data_shot : std_logic;
	signal data_vld : std_logic;

begin

	factorrom_e : entity hdl4fpga.rom
	generic map (
		bitrom => to_bitrom(adjust(factors), scaler_bits))
	port map (
		addr => factor_id,
		data => factor);

	scaler_p : process (input_clk)
		variable shot_dis : std_logic;
		variable scaler   : unsigned(factor'range) := (others => '0'); -- Debug purpose
	begin
		if rising_edge(input_clk) then
			if input_dv='1' then
				if input_shot='1' and shot_dis='0' then
					scaler := (others => '1');
				elsif scaler(0)='1' then
					scaler := unsigned(factor);
				else
					scaler := scaler - 1;
				end if;
				scaler_ena <= scaler(0);
				shot_dis := input_shot;
				data_vld <= input_dv;
			else
				data_vld <= '0';
			end if;
			data_in   <= input_data;
			data_shot <= shot_dis;
		end if;
	end process;

	envelope_g : for i in 0 to inputs-1 generate
		constant sel_max : std_logic := '0';
		constant sel_min : std_logic := not sel_max;

		signal sel_in  : std_logic := '0'; -- Debuging pupose
		signal sel_out : std_logic := '1'; -- Debuging pupose
		signal sample  : signed(0 to input_data'length/inputs-1);
		signal maxx    : signed(sample'range);
		signal minn    : signed(sample'range);
	begin
		sample <= signed(word2byte(data_in, i, sample'length));
		process (input_clk)
		begin
			if rising_edge(input_clk) then
				if data_vld='1' then
					if scaler_ena='1' then
						maxx <= word2byte(hdl4fpga.std.max(maxx, sample) & sample, setif(sel_out=sel_max));
						minn <= word2byte(hdl4fpga.std.min(minn, sample) & sample, setif(sel_out=sel_min));
						data_out(i*sample'length to (i+1)*sample'length-1) <=
							std_logic_vector(word2byte(minn & maxx, setif(sel_out=sel_max)));
						output_shot <= data_shot;
						sel_out     <= sel_in;
					else
						sel_in  <= not sel_out;
						maxx    <= hdl4fpga.std.max(maxx, sample);
						minn    <= hdl4fpga.std.min(minn, sample);
					end if;
				end if;
			output_dv <= data_vld and scaler_ena;
			end if;
		end process;
	end generate;
	output_data <= data_out;

end;
