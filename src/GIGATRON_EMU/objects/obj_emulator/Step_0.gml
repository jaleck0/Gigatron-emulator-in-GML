/// @description Insert description here
// You can write your code in this editor

for (var fr = 0; fr < 1; fr++)
{
	if (t < 0) 
	{
		buffer_poke(current_state, REG.PC_0, buffer_u8, 0)
		buffer_poke(current_state, REG.PC_1, buffer_u8, 0)
	}

	cpu_cycle(current_state);
	//scount(current_state);



	hsync = (buffer_peek( new_state, REG.OUTPUT, buffer_u8) & 0x40) - (buffer_peek( current_state, REG.OUTPUT, buffer_u8) & 0x40); 
	vsync = (buffer_peek( new_state, REG.OUTPUT, buffer_u8) & 0x80) - (buffer_peek( current_state, REG.OUTPUT, buffer_u8) & 0x80); 

	if (vsync < 0 )
	{
		vgaY = -36;
		input = get_input()
           
	}
	
//vgaX++
	if (vgaX++ < 172 && vgaX > 12)
	{
	
		buffer_poke(FRAME, ((vgaY+36)*160) + (vgaX-12), buffer_u8, buffer_peek(current_state, REG.OUTPUT, buffer_u8) & 63)
	
	} 

	if (hsync > 0)
	{
		vgaX = 0;
		vgaY++;
		buffer_poke( new_state, REG.undef, buffer_u8, irandom(256) & 0xff)
	}

	buffer_copy( new_state, 0, SIZE_REG, current_state, 0)

	t++;
}