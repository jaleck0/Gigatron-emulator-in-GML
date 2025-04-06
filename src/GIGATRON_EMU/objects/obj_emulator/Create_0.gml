/// @description Insert description here
// You can write your code in this editor
enum REG 
{
	PC_0,
	PC_1,
	IR,
	D,
	AC,
	X,
	Y,
	OUTPUT,
	undef
}

VGA_WIDTH  = 640;
VGA_HEIGTH = 480;

FBUFF_WIDTH  = 160;
FBUFF_HEIGTH = 120;

SIZE_ROM = 1<<17;
SIZE_RAM = 1<<15;
SIZE_REG = 9;

current_state = buffer_create( SIZE_REG, buffer_fast, 1);
new_state = buffer_create( SIZE_REG, buffer_fast, 1);

FRAME = buffer_create( FBUFF_WIDTH * VGA_HEIGTH, buffer_fast, 1);

ROM = buffer_create( SIZE_ROM, buffer_fast, 1);
RAM = buffer_create( SIZE_RAM, buffer_fast, 1);
input = 0xff;

hsync = 0;
vsync = 0;

garble(current_state, SIZE_REG)
garble(ROM, SIZE_ROM)
garble(RAM, SIZE_RAM)

t = -2;

vgaX = 0;
vgaY = 0;

var file = file_bin_open($"{game_save_id}ROMv4.rom", 0);

if (file_bin_size(file) <= 0)
{
	show_message("failed to load ROM")
}

repeat(SIZE_ROM)
{
	//var val = file_bin_read_byte(file)
	buffer_write(ROM, buffer_u8, file_bin_read_byte(file));
}

file_bin_close(file);

color_lut = [
	make_color_rgb(  0,  0,  0),
	make_color_rgb( 85,  0,  0),
	make_color_rgb(170,  0,  0),
	make_color_rgb(255,  0,  0),
	make_color_rgb(  0, 85,  0),
	make_color_rgb( 85, 85,  0),
	make_color_rgb(170, 85,  0),
	make_color_rgb(255, 85,  0),
	make_color_rgb(  0,170,  0),
	make_color_rgb( 85,170,  0),
	make_color_rgb(170,170,  0),
	make_color_rgb(255,170,  0),
	make_color_rgb(  0,255,  0),
	make_color_rgb( 85,255,  0),
	make_color_rgb(170,255,  0),
	make_color_rgb(255,255,  0),
	make_color_rgb(  0,  0, 85),
	make_color_rgb( 85,  0, 85),
	make_color_rgb(170,  0, 85),
	make_color_rgb(255,  0, 85),
	make_color_rgb(  0, 85, 85),
	make_color_rgb( 85, 85, 85),
	make_color_rgb(170, 85, 85),
	make_color_rgb(255, 85, 85),
	make_color_rgb(  0,170, 85),
	make_color_rgb( 85,170, 85),
	make_color_rgb(170,170, 85),
	make_color_rgb(255,170, 85),
	make_color_rgb(  0,255, 85),
	make_color_rgb( 85,255, 85),
	make_color_rgb(170,255, 85),
	make_color_rgb(255,255, 85),
	make_color_rgb(  0,  0,170),
	make_color_rgb( 85,  0,170),
	make_color_rgb(170,  0,170),
	make_color_rgb(255,  0,170),
	make_color_rgb(  0, 85,170),
	make_color_rgb( 85, 85,170),
	make_color_rgb(170, 85,170),
	make_color_rgb(255, 85,170),
	make_color_rgb(  0,170,170),
	make_color_rgb( 85,170,170),
	make_color_rgb(170,170,170),
	make_color_rgb(255,170,170),
	make_color_rgb(  0,255,170),
	make_color_rgb( 85,255,170),
	make_color_rgb(170,255,170),
	make_color_rgb(255,255,170),
	make_color_rgb(  0,  0,255),
	make_color_rgb( 85,  0,255),
	make_color_rgb(170,  0,255),
	make_color_rgb(255,  0,255),
	make_color_rgb(  0, 85,255),
	make_color_rgb( 85, 85,255),
	make_color_rgb(170, 85,255),
	make_color_rgb(255, 85,255),
	make_color_rgb(  0,170,255),
	make_color_rgb( 85,170,255),
	make_color_rgb(170,170,255),
	make_color_rgb(255,170,255),
	make_color_rgb(  0,255,255),
	make_color_rgb( 85,255,255),
	make_color_rgb(170,255,255),
	make_color_rgb(255,255,255),
]