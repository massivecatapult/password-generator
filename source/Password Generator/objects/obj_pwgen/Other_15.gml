/// @desc Load settings

var file = working_directory + "settings.ini";

if (file_exists(file)){
	ini_open(file);
	length = abs(ini_read_real("settings", "length", 16));
	special_chars = abs(clamp(ini_read_real("settings", "use_special_characters", 1), 0, 2));
	numbers_percentage = abs(ini_read_real("with_specials", "number_percentage", 25));
	specials_percentage = abs(ini_read_real("with_specials", "special_percentage", 25));
	letters_percentage = 100 - numbers_percentage - specials_percentage;
	numbers_percentage_nospecials = abs(ini_read_real("without_specials", "number_percentage", 35));
	letters_percentage_nospecials = 100 - numbers_percentage_nospecials;
	ini_close();
	show_debug_message("Loaded settings!");
} else {
	show_debug_message("Couldn't find any settings to load...");
}