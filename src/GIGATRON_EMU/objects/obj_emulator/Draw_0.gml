/// @description Insert description here
// You can write your code in this editor

for (var i = 0; i<256; i++)
{
	draw_text(32*(i%16),32*floor(i/16),  string(buffer_peek(ROM,i,buffer_u8)))
}