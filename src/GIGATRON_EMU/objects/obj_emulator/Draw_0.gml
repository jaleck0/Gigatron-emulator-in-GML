/// @description Insert description here
// You can write your code in this editor

/*
for(var vy = 0; vy < VGA_HEIGTH; vy++)
{
	for(var vx = 0; vx < FBUFF_WIDTH; vx++)
	{
		draw_set_color(color_lut[ buffer_peek(FRAME, vy * 160 + vx, buffer_u8)])
		draw_line( vx*4, vy, vx*4+4, vy)
	}
}
*/
for(var vy = 0; vy < VGA_HEIGTH; vy++)
{
	for(var vx = 0; vx < FBUFF_WIDTH; vx++)
	{
		draw_set_color(color_lut[ buffer_peek(FRAME, vy * 160 + vx, buffer_u8)])
		draw_line( vx*4, vy, vx*4+4, vy)
	}
}

draw_set_colour(c_white)    

for (var i = 0; i<SIZE_REG; i++)
{
	draw_text(32,32*i,  string(buffer_peek(current_state,i,buffer_u8)))
}
for (var i = 0; i<SIZE_REG; i++)
{
	draw_text(100,32*i,  string(buffer_peek(new_state,i,buffer_u8)))
}


draw_text(550,32, input)

draw_text(550,64, t)

draw_text(550, 96, vgaX)
draw_text(550, 128, vgaY)

draw_text(550, 196, hsync)
draw_text(550, 228, vsync)