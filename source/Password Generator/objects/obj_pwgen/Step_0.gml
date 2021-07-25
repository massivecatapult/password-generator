/// @desc 
var m = [device_mouse_x(0), device_mouse_y(0)];

//show_debug_message("Mouse position: " + string(m[0]) + ", " + string(m[1]) + " at scale: " + string(window_get_width() / 800));

if (drag_mode_length){
	var old_length = length;
	var d = round( (window_mouse_get_x() - drag_m[0]) * 0.5 );
	show_debug_message("Drag difference: " + string(d));
	window_mouse_set(drag_m[0], drag_m[1]);
	
	length = clamp(length + d, 4, 1024);
	
	//only generate a new password if the length changed
	if (length != old_length){
		event_user(0);
	}
}

if (drag_mode_boundary1){
	var old_percentage = letters_percentage;
	var dmin = 770 * .1;
	var dmax = 800 - 15 - dmin - (specials_percentage / 100 * 770);
	var dnew = clamp(m[0], 15 + dmin, dmax);
	show_debug_message("dnew: " + string(dnew));
	letters_percentage = clamp(round(((dnew - 15) / 770) * 100), 1, 98);
	numbers_percentage = 100 - letters_percentage - specials_percentage;
	show_debug_message("letters_percentage: " + string(letters_percentage));
	if (letters_percentage != old_percentage){
		event_user(0);
	}
}

if (drag_mode_boundary2){
	var old_percentage = numbers_percentage;
	var dmin = 15 + (letters_percentage / 100 * 770) + (770 * .1);
	var dmax = 800 - 15 - (770 * .1);
	var dnew = clamp(m[0], dmin, dmax);
	show_debug_message("dnew: " + string(dnew));
	numbers_percentage = clamp(round(((dnew - 15) / 770) * 100) - letters_percentage, 1, 98);
	specials_percentage = 100 - letters_percentage - numbers_percentage;
	show_debug_message("numbers_percentage: " + string(numbers_percentage));
	if (numbers_percentage != old_percentage){
		event_user(0);
	}
}

if (drag_mode_boundary3){
	var old_percentage = letters_percentage_nospecials;
	var dmin = 770 * .1;
	var dmax = 800 - 15 - dmin;
	var dnew = clamp(m[0], 15 + dmin, dmax);
	show_debug_message("dnew: " + string(dnew));
	letters_percentage_nospecials = clamp(round(((dnew - 15) / 770) * 100), 1, 99);
	numbers_percentage_nospecials = 100 - letters_percentage_nospecials;
	show_debug_message("letters_percentage_nospecials: " + string(letters_percentage_nospecials));
	if (letters_percentage_nospecials != old_percentage){
		event_user(0);
	}
}