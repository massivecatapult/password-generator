/// @desc Save app settings that are independent from password creation
function save_app_settings() {
	var file = working_directory + "settings.ini";

	ini_open(file);
	ini_write_real("settings", "hidden_mode", hidden_mode);
	ini_write_real("settings", "large_mode", scale_double);
	ini_close();


}
