/// @desc Save settings
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