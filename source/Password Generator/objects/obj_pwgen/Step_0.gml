//get current mouse position
var m = [device_mouse_x(0), device_mouse_y(0)];

//if the password length panel is being dragged
if (drag_mode_length)
{
	//get the difference in mouse position from the last step, rounded to an integer
	var old_length = length;
	var d = round( (window_mouse_get_x() - drag_m[0]) * 0.5 );
	
	//reset mouse position to the place it began dragging
	window_mouse_set(drag_m[0], drag_m[1]);
	
	//update the password length
	length = clamp(length + d, 4, 1024);
	
	//only generate a new password if the length changed
	if (length != old_length)
	{
		update_password();
	}
}

//if the letters/numbers boundary in the character breakdown panel is being dragged
if (drag_mode_boundary1)
{
	//set boundaries, then get the difference in mouse position from the last step
	var old_percentage = letters_percentage;
	var dmin = 770 * .1;
	var dmax = 800 - 15 - dmin - (specials_percentage / 100 * 770);
	var dnew = clamp(m[0], 15 + dmin, dmax);
	
	//recalculate percentages
	letters_percentage = clamp(round(((dnew - 15) / 770) * 100), 1, 98);
	numbers_percentage = 100 - letters_percentage - specials_percentage;
	
	//only generate a new password if the letters percentage changed
	if (letters_percentage != old_percentage)
	{
		update_password();
	}
}

//if the numbers/special characters boundary in the character breakdown panel is being dragged
if (drag_mode_boundary2)
{
	//set boundaries, then get the difference in mouse position from the last step
	var old_percentage = numbers_percentage;
	var dmin = 15 + (letters_percentage / 100 * 770) + (770 * .1);
	var dmax = 800 - 15 - (770 * .1);
	var dnew = clamp(m[0], dmin, dmax);
	
	//recalculate percentages
	numbers_percentage = clamp(round(((dnew - 15) / 770) * 100) - letters_percentage, 1, 98);
	specials_percentage = 100 - letters_percentage - numbers_percentage;
	
	//only generate a new password if the numbers percentage changed
	if (numbers_percentage != old_percentage)
	{
		update_password();
	}
}

//if the letters/numbers boundary in the character breakdown panel is being dragged (and special characters are disabled)
if (drag_mode_boundary3)
{
	//set boundaries, then get the difference in mouse position from the last step
	var old_percentage = letters_percentage_nospecials;
	var dmin = 770 * .1;
	var dmax = 800 - 15 - dmin;
	var dnew = clamp(m[0], 15 + dmin, dmax);
	
	//recalculate percentages
	letters_percentage_nospecials = clamp(round(((dnew - 15) / 770) * 100), 1, 99);
	numbers_percentage_nospecials = 100 - letters_percentage_nospecials;
	
	//only generate a new password if the letters percentage changed
	if (letters_percentage_nospecials != old_percentage)
	{
		update_password();
	}
}