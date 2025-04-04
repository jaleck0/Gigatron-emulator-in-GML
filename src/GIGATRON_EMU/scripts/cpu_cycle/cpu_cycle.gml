// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function cpu_cycle( _newstate)
{
	
	var oldstate = buffer_create( SIZE_REG, buffer_fast, 1)
	buffer_copy( _newstate, 0, SIZE_REG, oldstate, 0)
	
	buffer_poke( oldstate, REG.IR, buffer_u8, buffer_peek( _newstate, buffer_peek( oldstate, REG.PC_0, buffer_u16) * 2, buffer_u8));
	buffer_poke( oldstate, REG.D,  buffer_u8, buffer_peek( _newstate, buffer_peek( oldstate, REG.PC_0, buffer_u16), buffer_u8));
	
	var tins = buffer_peek( _newstate, REG.IR, buffer_u8) >> 5;
	var tmod = (buffer_peek( _newstate, REG.IR, buffer_u8) >> 2) & 7;
	var tbus = buffer_peek( _newstate, REG.IR, buffer_u8) & 3;
	
	var tw = (tins == 6);
	var tj = (tins == 7);
	
	var lo = buffer_peek( _newstate, REG.D, buffer_u8)
	var hi = 0;
	
	
	return oldstate;
}