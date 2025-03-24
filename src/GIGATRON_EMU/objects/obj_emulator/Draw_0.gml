/// @description Insert description here
// You can write your code in this editor

//for (var i = 0; i<256; i++)
//{
//	draw_text(32*(i%16),32*floor(i/16),  string(buffer_peek(ROM,i,buffer_u8)))
//}
for(var vy = 0; vy < VGA_HEIGTH; vy++)
{
	for(var vx = 0; vx < FBUFF_WIDTH; vx++)
	{
		draw_set_color(color_lut[ buffer_peek(FRAME, vy * 160 + vx, buffer_u8)])
		draw_line( vx*4, vy, vx*4+4, vy)
	}
}

draw_set_colour(c_white)    
draw_text(600,32, input)