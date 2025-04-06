// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function cpu_cycle( _newstate)
{
	
	var oldstate = buffer_create( SIZE_REG, buffer_fast, 1)
	buffer_copy( _newstate, 0, SIZE_REG, oldstate, 0)
	
	buffer_poke( oldstate, REG.IR, buffer_u8, buffer_peek( ROM,	512*buffer_peek( _newstate, REG.PC_0, buffer_u8)+buffer_peek(_newstate, REG.PC_1, buffer_u8), buffer_u8));
	buffer_poke( oldstate, REG.D,  buffer_u8, buffer_peek( ROM, 512*buffer_peek( _newstate, REG.PC_0, buffer_u8)+buffer_peek(_newstate, REG.PC_1, buffer_u8) + 1, buffer_u8));
	
	var tins = buffer_peek( _newstate, REG.IR, buffer_u8) >> 5;
	var tmod = (buffer_peek( _newstate, REG.IR, buffer_u8) >> 2) & 7;
	var tbus = buffer_peek( _newstate, REG.IR, buffer_u8) & 3;
	
	var tw = (tins == 6);
	var tj = (tins == 7);
	
	var lo = buffer_peek( _newstate, REG.D, buffer_u8)
	var hi = 0;
	var toP = 0;
	var incX = 0;
	
	
	
	if(!tj)
	{
		//#macro E(p) (tw?0:p)
		switch(tmod)
		{
            case 0: to = tw ? 0 : REG.AC; break;
            case 1: to = tw ? 0 : REG.AC; lo = buffer_peek(_newstate, REG.X, buffer_u8); break;
            case 2: to = tw ? 0 : REG.AC; hi = buffer_peek(_newstate, REG.Y, buffer_u8); break;
            case 3: to = tw ? 0 : REG.AC; lo = buffer_peek(_newstate, REG.X, buffer_u8); hi = buffer_peek(_newstate, REG.Y, buffer_u8); break;
            case 4: to = REG.X; break;
            case 5: to = REG.Y; break;
            case 6: to = tw ? 0 : REG.OUTPUT; break;
            case 7: to = tw ? 0 : REG.OUTPUT; lo = buffer_peek(_newstate, REG.X, buffer_u8); hi = buffer_peek(_newstate, REG.Y, buffer_u8); incX = 1; break;
			
		}
	}
	
	var taddres = (hi * 256) | lo;
	
	var tB = buffer_peek( _newstate, REG.undef, buffer_u8);
	
	switch (tbus)
    {
        case 0: tB = buffer_peek( _newstate, REG.D, buffer_u8); break;
        case 1: if (!tw) { tB = buffer_peek(RAM, taddres & 0x7fff, buffer_u8);} break;
        case 2: tB = buffer_peek( _newstate, REG.AC, buffer_u8); break;
        case 3: tB = input; break;
    }
	
	if (tw)
	{
		buffer_poke( RAM, taddres & 0x7fff, buffer_u8, tB);
	}
	
	var ALU;
	
	switch (tins)
    {
        case 0: ALU = tB; break;
        case 1: ALU = buffer_peek( _newstate, REG.AC, buffer_u8) & tB; break;
        case 2: ALU = buffer_peek( _newstate, REG.AC, buffer_u8) | tB; break;
        case 3: ALU = buffer_peek( _newstate, REG.AC, buffer_u8) ^ tB; break;
        case 4: ALU = buffer_peek( _newstate, REG.AC, buffer_u8) + tB; break;
        case 5: ALU = buffer_peek( _newstate, REG.AC, buffer_u8) - tB; break;
        case 6: ALU = buffer_peek( _newstate, REG.AC, buffer_u8) break;
        case 7: ALU = -buffer_peek( _newstate, REG.AC, buffer_u8) break;
    }
	
	if (toP) 
	{
		t = ALU;
		switch(tmod)
		{
            case 0: buffer_poke(oldstate, tw ? 0 : REG.AC, buffer_u8, ALU); break;
            case 1: buffer_poke(oldstate, tw ? 0 : REG.AC, buffer_u8, ALU); break;
            case 2: buffer_poke(oldstate, tw ? 0 : REG.AC, buffer_u8, ALU); break;
            case 3: buffer_poke(oldstate, tw ? 0 : REG.AC, buffer_u8, ALU); break;
            case 4: buffer_poke(oldstate, tw ? 0 : REG.X, buffer_u8, ALU); break;
            case 5: buffer_poke(oldstate, tw ? 0 : REG.Y, buffer_u8, ALU); break;
            case 6: buffer_poke(oldstate, tw ? 0 : REG.OUTPUT, buffer_u8, ALU); break;
            case 7: buffer_poke(oldstate, tw ? 0 : REG.OUTPUT, buffer_u8, ALU); break;
		}
	}
	
	if (incX) 
	{
		//oldState.X = newState.X + 1;
		buffer_poke( oldstate, REG.X, buffer_u8, buffer_peek( _newstate, REG.X, buffer_u8) + 1);
	}
	
	
	//oldState.PC = newState.PC + 1;
	if buffer_peek(_newstate, REG.PC_1, buffer_u8) == 255
	{
		buffer_poke( oldstate, REG.PC_0, buffer_u8, buffer_peek( _newstate, REG.PC_0, buffer_u8) + 1);
		buffer_poke( oldstate, REG.PC_1, buffer_u8, 0);
	}
	else
	{
		buffer_poke( oldstate, REG.PC_0, buffer_u8, buffer_peek( _newstate, REG.PC_0, buffer_u8));
		buffer_poke( oldstate, REG.PC_1, buffer_u8, buffer_peek( _newstate, REG.PC_1, buffer_u8) + 1);
	}
	
	//buffer_poke( oldstate, REG.PC_0, buffer_u16, buffer_peek( _newstate, REG.X, buffer_u16) + 1);

    if (tj)
    {
        if (tmod != 0)
        {
            var cond = (buffer_peek( _newstate, REG.AC, buffer_u8) >> 7) + 2 * (buffer_peek( _newstate, REG.AC, buffer_u8) == 0);
            if (tmod & (1 << cond))
			{
                buffer_poke(_newstate, REG.PC_0, buffer_u8, (buffer_peek( _newstate, REG.PC_0, buffer_u8) & 0xff00) | tB/256);
                buffer_poke(_newstate, REG.PC_1, buffer_u8,  tB&256 );
			}
        } 
		else 
		{
            //oldState.PC = (newState.Y << 8) | B;
			buffer_poke( oldstate, REG.PC_0, buffer_u8, (buffer_peek( _newstate, REG.Y, buffer_u8)) | tB);
		}
    }
	
	//return oldstate;
	buffer_copy( oldstate, 0, SIZE_REG, new_state, 0)
	
	buffer_delete(oldstate)
}