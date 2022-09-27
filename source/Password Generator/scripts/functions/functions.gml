/// @func					draw_button_pg(_x, _y, _width, _label, _color, _active, _round_left, _round_right, _icon)
/// @desc					Draws a button using the button sprite and with the appropriate colors, returns hover state
///							Returns the hover state of the button
/// @arg {real}				_x						The x position of the button's top left corner
/// @arg {real}				_y						The y position of the button's top left corner
/// @arg {real}				_width					The width of the button
/// @arg {string}			_label					The text to draw on the button
/// @arg {real}				_color					The base color of the button
/// @arg {real}				_active					Whether the button should check for hover state (true) or not (false)
/// @arg {real}				_round_left				Whether the button should be rounded on the left edge (true) or not (false)
/// @arg {real}				_round_right			Whether the button should be rounded on the right edge (true) or not (false)
/// @arg {asset.gmsprite}	_icon					An icon to show with the text (optional)

function draw_button_pg(_x, _y, _width, _label, _color, _active, _round_left, _round_right, _icon = -1) {

	var button_color = _color;
	var mouse_down = false;
	var mouse_hover = false;

	//if the button is active and the mouse is hovering over it, change the color and set the hover state to true
	if (_active)
	{
		var m = [device_mouse_x(0), device_mouse_y(0)];
		if (m[0] > _x) && (m[0] < _x + _width) && (m[1] > _y) && (m[1] < _y + 64)
		{
			mouse_hover = true;
			mouse_down = mouse_check_button(mb_left);
			button_color = merge_color(button_color, c_white, 0.2);
		}
	}

	//reset draw color
	draw_set_color(c_white);
	
	//draw the left side of the button
	draw_sprite_ext(spr_button, (_round_left) ? 0 : 1, _x, _y, 0.5, 0.5, 0, button_color, 1);

	//draw the middle of the button
	draw_sprite_ext(spr_button, 1, _x + 10, _y, ((_width - 20) / 10) * 0.5, 0.5, 0, button_color, 1);

	//draw the right side of the button
	draw_sprite_ext(spr_button, (_round_right) ? 2 : 1, _x + 10 + (_width - 20), _y, 0.5, 0.5, 0, button_color, 1);

	//set the font and text alignment
	draw_set_font(fnt_button);
	draw_set_valign(fa_middle);

	//offset the button if it's active and being clicked
	var ty = (_active && mouse_down) ? 2 : 0;

	//draw the button without an icon if there is no icon set
	if (_icon == -1)
	{
		//if there is no icon, the text can be centered
		draw_set_halign(fa_center);
		draw_text_transformed(_x + (_width / 2), _y + 32 + ty, _label, 0.5, 0.5, 0);
	} else {
		//if there is an icon, the text should be left-aligned and centered with the icon taken into account
		var string_w = string_width(_label) * 0.5;
		var sprite_w = sprite_get_width(_icon) * 0.5;
		var spacer = string_length(_label) > 0 ? 10 : 0;
		var content_width = string_w + sprite_w + spacer;
		var offset = (_width - content_width) * 0.5;
		draw_set_halign(fa_left);
		draw_text_transformed(_x + offset, _y + 32 + ty, _label, 0.5, 0.5, 0);
		draw_sprite_ext(_icon, 0, _x + offset + string_w + spacer + (sprite_w * 0.5), _y + 32 + ty, 0.5, 0.5, 0, c_white, 1);
	}
	
	//return the hover state
	return mouse_hover;
}

/// @func					generate_password(_length, _special_characters, _letter_string, _number_string, _special_basic_string, _special_full_string, _number_ratio, _specials_ratio)
/// @desc					Takes all the appropriate variables and generates a new password from them
/// @arg {real}				_length					The length of the password to output (between 4 and 1024)
/// @arg {real}				_special_characters		Whether to use no special chars (0), some (1), or all (2)
/// @arg {string}			_letter_string			The string of letters to pull from
/// @arg {string}			_number_string			The string of numbers to pull from
/// @arg {string}			_special_basic_string	The string of basic special characters to use
/// @arg {string}			_special_full_string	The string of full special characters to use
/// @arg {real}				_number_ratio			The ratio of the password that should be numbers (min 10%)
/// @arg {real}				_specials_ratio			The ratio of the password that should be numbers (min 10%)

function generate_password(_length, _special_characters, _letter_string, _number_string, _special_basic_string, _special_full_string, _number_ratio, _specials_ratio) {

	var output_string = "";
	var length = clamp(_length, 4, 1024);
	var use_specials = _special_characters;

	//make lists for all the characters in each supplied string
	var letters_array = ds_list_create();
	for (var i = 1; i <= string_length(_letter_string); i++)
	{
		ds_list_add(letters_array, string_char_at(_letter_string, i));
	}

	var numbers_array = ds_list_create();
	for (var i = 1; i <= string_length(_number_string); i++)
	{
		ds_list_add(numbers_array, string_char_at(_number_string, i));
	}

	var specials_array = ds_list_create();
	for (var i = 1; i <= string_length(_special_basic_string); i++)
	{
		ds_list_add(specials_array, string_char_at(_special_basic_string, i));
	}

	var specials_expanded_array = ds_list_create();
	for (var i = 1; i <= string_length(_special_full_string); i++)
	{
		ds_list_add(specials_expanded_array, string_char_at(_special_full_string, i));
	}

	//shuffle character lists
	ds_list_shuffle(letters_array);
	ds_list_shuffle(numbers_array);
	ds_list_shuffle(specials_array);
	ds_list_shuffle(specials_expanded_array);

	//set the number of numbers, special characters, and capital letters in the password
	var number_of_numbers = 0;
	var number_of_specials = 0;
	var number_of_caps = 0;

	//set a default list for specials
	var use_list = specials_array;

	//alter the above numbers a bit for other special character circumstances
	switch (use_specials)
	{
		case 1:
		number_of_numbers = max(floor(length * _number_ratio), 1);
		number_of_specials = max(floor(length * _specials_ratio), 1);
		number_of_caps = round((length - number_of_numbers - number_of_specials) * 0.5);
		use_list = specials_array;
		break;
		
		case 2:
		number_of_numbers = max(floor(length * _number_ratio), 1);
		number_of_specials = max(floor(length * _specials_ratio), 1);
		number_of_caps = round((length - number_of_numbers - number_of_specials) * 0.5);
		use_list = specials_expanded_array;
		break;
	
		default:
		number_of_numbers = max(floor(length * _number_ratio), 1);
		number_of_specials = 0;
		number_of_caps = round((length - number_of_numbers) * 0.5);
	}

	//create a list that contains all the numbers and special characters
	var output_others = ds_list_create();

	//then pull from the numbers list to add to it
	for (var i = 0; i < number_of_numbers; i++)
	{
		var add = ds_list_find_value(numbers_array,0);
		ds_list_add(output_others, add);
		ds_list_shuffle(numbers_array);
	}

	//add to the same list with some special characters now
	for (var i = 0; i < number_of_specials; i++)
	{
		var add = ds_list_find_value(use_list,0);
		ds_list_add(output_others, add);
		ds_list_shuffle(use_list);
	}

	//make a new list for our letters output
	var output_letters = ds_list_create();

	//and pull from the letters list to add to it
	for (var i = 0; i < (length - number_of_numbers - number_of_specials); i++)
	{
		var add = ds_list_find_value(letters_array,0);
		ds_list_add(output_letters, add);
		ds_list_shuffle(letters_array);
	}

	//shuffle the new letters list, then capitalize some of them
	ds_list_shuffle(output_letters);
	for (var i = 0; i < number_of_caps; i++)
	{
		ds_list_replace(output_letters, i, string_upper(ds_list_find_value(output_letters,i)));
	}

	//create a final list for output and add all the numbers and special characters we selected previously to it
	var output_all = ds_list_create();
	for (var i = 0; i < ds_list_size(output_others); i++)
	{
		var char = ds_list_find_value(output_others, i);
		ds_list_add(output_all, char);
	}

	//add our list of letters to the new output list as well
	for (var i = 0; i < ds_list_size(output_letters); i++)
	{
		var char = ds_list_find_value(output_letters, i);
		ds_list_add(output_all, char);
	}

	//clear the lists we made for letters and numbers/special characters, since we don't need them anymore
	ds_list_destroy(letters_array);
	ds_list_destroy(numbers_array);
	ds_list_destroy(specials_array);
	ds_list_destroy(specials_expanded_array);
	ds_list_destroy(output_letters);
	ds_list_destroy(output_others);

	//randomize the output list
	ds_list_shuffle(output_all);

	//create an empty output string, then itterate through the output list to add characters to it
	for (var i = 0; i < ds_list_size(output_all); i++)
	{
		var char = ds_list_find_value(output_all, i);
		output_string = output_string + char;
	}

	//destroy the output list, as it is no longer needed
	ds_list_destroy(output_all);

	//return the final password
	return output_string;

}
