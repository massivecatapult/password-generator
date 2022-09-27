/// @desc Button and mouse drag checks

//get current mouse position
var m = [device_mouse_x(0), device_mouse_y(0)];

//generate password button
if (m[0] > 15) && (m[0] < 515) && (m[1] > 99) && (m[1] < 163)
{
	update_password();
}

//copy button
if (copy_active)
{
	if (m[0] > 525) && (m[0] < 765) && (m[1] > 99) && (m[1] < 163)
	{
		copy_password_to_clipboard();
	}
}

//length buttons
if (m[0] > 150) && (m[0] < 214) && (m[1] > 173) && (m[1] < 237)
{
	length = clamp(length - 1, 4, 1024);
	update_password();
}

if (m[0] > 216) && (m[0] < 280) && (m[1] > 173) && (m[1] < 237)
{
	length = clamp(length + 1, 4, 1024);
	update_password();
}

//set length by entering drag mode
if (m[0] > 282) && (m[0] < 390) && (m[1] > 173) && (m[1] < 237)
{
	drag_mode_length = true;
	drag_m = [window_mouse_get_x(), window_mouse_get_y()];
}

//special characters
if (m[0] > 400) && (m[0] < 675) && (m[1] > 173) && (m[1] < 237)
{
	switch(special_chars)
	{
		case 0:
		special_chars = 1;
		break;
		
		case 1:
		special_chars = 2;
		break;
		
		default:
		special_chars = 0;
	}

	update_password();
}

//set character breakdowns by dragging boundaries
if (special_chars == 0)
{
	//figure out where the boundary is
	var letters_area = (letters_percentage_nospecials / 100) * 770;
	var numbers_area = (numbers_percentage_nospecials / 100) * 770;
	
	//letters/numbers boundary
	if (m[0] > 15 + letters_area - 10) && (m[0] < 15 + letters_area + 10) && (m[1] > 247) && (m[1] < 311)
	{
		drag_mode_boundary3 = true;
	}
	
} else {
	
	//figure out where the boundaries are
	var letters_area = (letters_percentage / 100) * 770;
	var numbers_area = (numbers_percentage / 100) * 770;

	//letters/numbers boundary
	if (m[0] > 15 + letters_area - 10) && (m[0] < 15 + letters_area + 10) && (m[1] > 247) && (m[1] < 311)
	{
		drag_mode_boundary1 = true;
	}

	//numbers/special characters boundary, which is just the other two added up
	if (m[0] > 15 + letters_area + numbers_area - 10) && (m[0] < 15 + letters_area + numbers_area + 10) && (m[1] > 247) && (m[1] < 311)
	{
		drag_mode_boundary2 = true;
	}

}

//hidden mode
if (m[0] > 15) && (m[0] < 79) && (m[1] > 321) && (m[1] < 385)
{
	hidden_mode = hidden_mode ? false : true;
}

//window_size
if (m[0] > 89) && (m[0] < 153) && (m[1] > 321) && (m[1] < 385)
{
	scale_double = scale_double ? false : true;
	resize_window();
}

//load settings
if (m[0] > 499) && (m[0] < 563) && (m[1] > 321) && (m[1] < 385)
{
	load_settings();
	update_password();
}

//save settings
if (m[0] > 573) && (m[0] < 637) && (m[1] > 321) && (m[1] < 385)
{
	save_settings();
}

//reset settings
if (m[0] > 647) && (m[0] < 711) && (m[1] > 321) && (m[1] < 385)
{
	reset_settings();
	update_password();
}

//info link
if (m[0] > 721) && (m[0] < 785) && (m[1] > 321) && (m[1] < 385)
{
	url_open("https://github.com/massivecatapult/password-generator");
}