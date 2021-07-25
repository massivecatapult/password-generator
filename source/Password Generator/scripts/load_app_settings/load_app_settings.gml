/// @desc Load app settings that are independent from password creation
function load_app_settings() {
	var file = working_directory + "settings.ini";

	if (file_exists(file)){
		ini_open(file);
		hidden_mode = abs(ini_read_real("settings", "hidden_mode", 0)) ? true : false;
		scale_double = abs(ini_read_real("settings", "large_mode", 0)) ? true : false;
		swap_surface = abs(ini_read_real("settings", "toggle_surface_sizes", 0)) ? true : false;
		ini_close();
		show_debug_message("Loaded app settings!");
	} else {
		show_debug_message("Couldn't find any app settings to load...");
	}


}
