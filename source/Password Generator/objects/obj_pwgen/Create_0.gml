randomize();

password = "";
length = 16;
special_chars = 1;
hidden_mode = false;
scale_double = false;
swap_surface = false;

letters = "abcdefghijklmnopqrstuvwxyz";
numbers = "0123456789";
specials = "!@#$%^&*()-+_=";
specials_expanded = "!@#$%^&*()[]{}:;<>?,.~'+=-_\"\\/|";

drag_mode_length = false;
drag_m = [0, 0];
drag_mode_boundary1 = false;
drag_mode_boundary2 = false;
drag_mode_boundary3 = false;

copy_label = "Copy";
copy_active = true;

letters_percentage = 50;
numbers_percentage = 25;
specials_percentage = 25;
letters_percentage_nospecials = 65;
numbers_percentage_nospecials = 35;

/// @func		reset_copy_button()
/// @desc		Resets the Copy button to an active state, and changes the label back to "Copy"
reset_copy_button = function()
{
	copy_label = "Copy";
	copy_active = true;
}

/// @func		copy_password_to_clipboard()
/// @desc		Copies the current password to the clipboard and changes the state of the Copy button
copy_password_to_clipboard = function()
{
	clipboard_set_text(password);
	copy_label = "Copied!";
	copy_active = false;
	call_later(120, time_source_units_frames, reset_copy_button, false);
}

/// @func		reset_settings()
/// @desc		Resets all settings related to password creation
reset_settings = function()
{
	length = 16;
	special_chars = 1;
	letters_percentage = 50;
	numbers_percentage = 25;
	specials_percentage = 25;
	letters_percentage_nospecials = 65;
	numbers_percentage_nospecials = 35;
}

/// @func		save_settings()
/// @desc		Saves settings related to password creation in settings.ini
save_settings = function()
{
	var file = working_directory + "settings.ini";
	ini_open(file);
	ini_write_real("settings", "length", length);
	ini_write_real("settings", "use_special_characters", special_chars);
	ini_write_real("with_specials", "letter_percentage", letters_percentage);
	ini_write_real("with_specials", "number_percentage", numbers_percentage);
	ini_write_real("with_specials", "special_percentage", specials_percentage);
	ini_write_real("without_specials", "letter_percentage", letters_percentage_nospecials);
	ini_write_real("without_specials", "number_percentage", numbers_percentage_nospecials);
	ini_close();
}

/// @func		load_settings()
/// @desc		Loads settings related to password creation from settings.ini
load_settings = function()
{
var file = working_directory + "settings.ini";
	if (file_exists(file))
	{
		ini_open(file);
		length = abs(ini_read_real("settings", "length", 16));
		special_chars = abs(clamp(ini_read_real("settings", "use_special_characters", 1), 0, 2));
		numbers_percentage = abs(ini_read_real("with_specials", "number_percentage", 25));
		specials_percentage = abs(ini_read_real("with_specials", "special_percentage", 25));
		letters_percentage = 100 - numbers_percentage - specials_percentage;
		numbers_percentage_nospecials = abs(ini_read_real("without_specials", "number_percentage", 35));
		letters_percentage_nospecials = 100 - numbers_percentage_nospecials;
		ini_close();
	} else {
		show_debug_message("NOTE: Couldn't find any settings to load");
	}	
}

/// @func		save_app_settings()
/// @desc		Saves general app settings to the settings.ini
save_app_settings = function()
{
	var file = working_directory + "settings.ini";
	ini_open(file);
	ini_write_real("settings", "hidden_mode", hidden_mode);
	ini_write_real("settings", "large_mode", scale_double);
	ini_close();
}

/// @func		load_app_settings()
/// @desc		Loads general app settings to the settings.ini
load_app_settings = function()
{
	var file = working_directory + "settings.ini";
	if (file_exists(file))
	{
		ini_open(file);
		hidden_mode = abs(ini_read_real("settings", "hidden_mode", 0)) ? true : false;
		scale_double = abs(ini_read_real("settings", "large_mode", 0)) ? true : false;
		swap_surface = abs(ini_read_real("settings", "toggle_surface_sizes", 0)) ? true : false;
		ini_close();
	} else {
		show_debug_message("NOTE: Couldn't find any app settings to load");
	}
}

/// @func		resize_window()
/// @desc		Resizes and centers the app window, toggling between normal and big modes
resize_window = function()
{
	//set an array for window sizes
	var window_size = [800, 400];

	//check to see if we should make the app large
	if (scale_double)
	{
		window_size = [1600, 800];
	} else {
		window_size = [800, 400];
	}

	//resize the window
	window_set_size(window_size[0], window_size[1]);

	//if this hidden setting is true, swap to a smaller application surface when the app size changes
	//otherwise, always use the large application surface
	if (swap_surface)
	{
		surface_resize(application_surface, window_size[0], window_size[1]);
	} else {
	
		surface_resize(application_surface, 1600, 800);
	}

	//center the window manually, since the default function doesn't want to work
	var display_width = display_get_width();
	var display_height = display_get_height();
	window_set_position(round((display_width - window_size[0]) * 0.5), round((display_height - window_size[1]) * 0.5));
}

/// @func		update_password()
/// @desc		Creates parameters and gets a new password from generate_password()
update_password = function()
{
	//get ratios for letter/number/special character balance
	var numbers_var = numbers_percentage / 100;
	var specials_var = specials_percentage / 100;

	if (special_chars == 0)
	{
		numbers_var = numbers_percentage_nospecials / 100;
		specials_var = 0;
	}
	
	//get a new password
	password = generate_password(length, special_chars, letters, numbers, specials, specials_expanded, numbers_var, specials_var);
	
	//since we have an updated password, reset the Copy button to its default state
	reset_copy_button();	
}

//try to load settings on launch
load_settings();
load_app_settings();

//force a window resize
resize_window();

//generate the initial random password
update_password();