/// @description Insert description here
// You can write your code in this editor
SIZE_ROM = 1<<17
SIZE_RAM = 1<<15

ROM = buffer_create( SIZE_ROM, buffer_fast, 1);
RAM = buffer_create( SIZE_RAM, buffer_fast, 1);
input = 0xff;

var file = file_bin_open($"{game_save_id}ROMv4.rom", 0);


repeat(SIZE_ROM)
{
	//var val = file_bin_read_byte(file)
	buffer_write(ROM, buffer_u8, file_bin_read_byte(file));
}

file_bin_close(file);