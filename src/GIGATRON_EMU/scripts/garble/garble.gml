// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function garble( _buffer, _length)
{
	for(var i = 0; i < _length; i++)
	{
		buffer_poke( _buffer, i, buffer_u8, irandom(256))
	}
}