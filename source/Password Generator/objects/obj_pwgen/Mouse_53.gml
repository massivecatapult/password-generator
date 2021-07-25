/// @desc 
var m = [device_mouse_x(0), device_mouse_y(0)];

//password generate button
if (m[0] > 15) && (m[0] < 515) && (m[1] > 99) && (m[1] < 163){
	event_user(0);
}

//copy button
if (copy_active){
	if (m[0] > 525) && (m[0] < 765) && (m[1] > 99) && (m[1] < 163){
		event_user(1);
	}
}

//length buttons
if (m[0] > 150) && (m[0] < 214) && (m[1] > 173) && (m[1] < 237){
	length = clamp(length - 1, 4, 1024);
	event_user(0);
}

if (m[0] > 216) && (m[0] < 280) && (m[1] > 173) && (m[1] < 237){
	length = clamp(length + 1, 4, 1024);
	event_user(0);
}

//set length by entering typing mode
if (m[0] > 282) && (m[0] < 390) && (m[1] > 173) && (m[1] < 237){
	drag_mode_length = true;
	drag_m = [window_mouse_get_x(), window_mouse_get_y()];
}

//special characters
if (m[0] > 400) && (m[0] < 675) && (m[1] > 173) && (m[1] < 237){
	special_chars += 1;
	if (special_chars > 2){
		special_chars = 0;
	}
	event_user(0);
}

//set numbers percentage
if (special_chars == 0){
	
	var letters_area = (letters_percentage_nospecials / 100) * 770;
	var numbers_area = (numbers_percentage_nospecials / 100) * 770;
	
	//single boundary
	if (m[0] > 15 + letters_area - 10) && (m[0] < 15 + letters_area + 10) && (m[1] > 247) && (m[1] < 311){
		drag_mode_boundary3 = true;
	}
	
} else {
	
	var letters_area = (letters_percentage / 100) * 770;
	var numbers_area = (numbers_percentage / 100) * 770;
	var specials_area = (specials_percentage / 100) * 770;

	//first boundary
	if (m[0] > 15 + letters_area - 10) && (m[0] < 15 + letters_area + 10) && (m[1] > 247) && (m[1] < 311){
		drag_mode_boundary1 = true;
	}

	//second boundary
	if (m[0] > 15 + letters_area + numbers_area - 10) && (m[0] < 15 + letters_area + numbers_area + 10) && (m[1] > 247) && (m[1] < 311){
		drag_mode_boundary2 = true;
	}

}

//blind mode
if (m[0] > 15) && (m[0] < 79) && (m[1] > 321) && (m[1] < 385){
	hidden_mode = hidden_mode ? false : true;
	//save_app_settings();
}

//window_size
if (m[0] > 89) && (m[0] < 153) && (m[1] > 321) && (m[1] < 385){
	scale_double = scale_double ? false : true;
	event_user(6);
	//save_app_settings();
}

//load settings
if (m[0] > 573) && (m[0] < 637) && (m[1] > 321) && (m[1] < 385){
	event_user(5);
	event_user(0);
}

//save settings
if (m[0] > 647) && (m[0] < 711) && (m[1] > 321) && (m[1] < 385){
	event_user(4);
}

//reset settings
if (m[0] > 721) && (m[0] < 785) && (m[1] > 321) && (m[1] < 385){
	event_user(3);
	event_user(0);
}