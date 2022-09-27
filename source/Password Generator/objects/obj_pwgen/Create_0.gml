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

copy_label = "Copy";
copy_active = true;

letters_percentage = 50;
numbers_percentage = 25;
specials_percentage = 25;
letters_percentage_nospecials = 65;
numbers_percentage_nospecials = 35;

drag_mode_boundary1 = false;
drag_mode_boundary2 = false;
drag_mode_boundary3 = false;

//methods
reset_copy_button = function()
{
	copy_label = "Copy";
	copy_active = true;
}

copy_password_to_clipboard = function()
{
	clipboard_set_text(password);
	copy_label = "Copied!";
	copy_active = false;
	call_later(120, time_source_units_frames, reset_copy_button, false);
}

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

save_app_settings = function()
{
	var file = working_directory + "settings.ini";
	ini_open(file);
	ini_write_real("settings", "hidden_mode", hidden_mode);
	ini_write_real("settings", "large_mode", scale_double);
	ini_close();
}

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

	//center the window manually, since the defualt function doesn't want to work
	var display_width = display_get_width();
	var display_height = display_get_height();
	window_set_position(round((display_width - window_size[0]) * 0.5), round((display_height - window_size[1]) * 0.5));
}

update_password = function()
{
	var numbers_var = numbers_percentage / 100;
	var specials_var = specials_percentage / 100;

	if (special_chars == 0)
	{
		numbers_var = numbers_percentage_nospecials / 100;
		specials_var = 0;
	}

	password = generate_password(length, special_chars, letters, numbers, specials, specials_expanded, numbers_var, specials_var);
	reset_copy_button();	
}

//try to load settings on launch
load_settings();
load_app_settings();
resize_window();

update_password();