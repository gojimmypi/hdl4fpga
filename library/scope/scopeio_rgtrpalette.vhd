library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library hdl4fpga;
use hdl4fpga.std.all;
use hdl4fpga.scopeiopkg.all;

entity scopeio_rgtrpalette is
	generic (
		rgtr          : boolean := true);
	port (
		rgtr_clk      : in  std_logic;
		rgtr_dv       : in  std_logic;
		rgtr_id       : in  std_logic_vector(8-1 downto 0);
		rgtr_data     : in  std_logic_vector;

		palette_ena   : out std_logic;
		palette_dv    : out std_logic;
		palette_id    : out std_logic_vector;
		palette_color : out std_logic_vector);
	

end;

architecture def of scopeio_rgtrpalette is

	signal dv    : std_logic;
	signal id    : std_logic_vector(palette_id'range);
	signal color : std_logic_vector(palette_color'range);

begin

	dv    <= setif(rgtr_id=rid_palette, rgtr_dv);
	id    <= std_logic_vector(resize(unsigned(bitfield(rgtr_data, paletteid_id,    palette_bf)), palette_id'length));
	color <= std_logic_vector(resize(unsigned(bitfield(rgtr_data, palettecolor_id, palette_bf)), palette_color'length));

	rgtr_e : if rgtr generate
		process (rgtr_clk)
		begin
			if rising_edge(rgtr_clk) then
				palette_dv <= dv;
				if dv='1' then
					palette_id    <= id;
					palette_color <= color;
				end if;
			end if;
		end process;
	end generate;

	norgtr_e : if not rgtr generate
		palette_dv    <= dv;
		palette_id    <= id;
		palette_color <= color;
	end generate;

	palette_ena <= dv;
end;
