// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function get_input()
{
	var result = 255
	
	if keyboard_check(vk_up)
	{
		result &= 247
	}
	if keyboard_check(vk_left)
	{
		result &= 253
	}
	if keyboard_check(vk_down)
	{
		result &= 251
	}
	if keyboard_check(vk_right)
	{
		result &= 254
	}
	if keyboard_check(ord("Z"))
	{
		result &= 127
	}
	if keyboard_check(ord("X"))
	{
		result &= 191
	}
	if keyboard_check(vk_tab)
	{
		result &= 223
	}
	if keyboard_check(vk_escape)
	{
		result &= 239
	}
	
	return result
}