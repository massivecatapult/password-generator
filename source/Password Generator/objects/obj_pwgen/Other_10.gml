/// @desc Generate new password

var numbers_var = numbers_percentage / 100;
var specials_var = specials_percentage / 100;

if (special_chars == 0){
	numbers_var = numbers_percentage_nospecials / 100;
	specials_var = 0;
}

password = generate_password(length, special_chars, letters, numbers, specials, specials_expanded, numbers_var, specials_var);
event_user(2);