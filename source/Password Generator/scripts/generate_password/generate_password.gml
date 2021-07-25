/// @desc takes all the appropriate variables and generates a password from them
/// @arg length {real} The length of the password to output (between 4 and 1024)
/// @arg special_characters {real} Whether to use no special chars (0), some (1), or all (2)
/// @arg letter_string {string} The string of letters to pull from
/// @arg number_string {string} The string of numbers to pull from
/// @arg special_basic_string {string} The string of basic special characters to use
/// @arg special_full_string {string} The string of full special characters to use
/// @arg number_ratio {real} The ratio of the password that should be numbers (min 10%)
/// @arg specials_ratio {real} The ratio of the password that should be numbers (min 10%)
function generate_password() {

	var output_string = "";
	var length = clamp(argument[0], 4, 1024);
	var use_specials = argument[1];

	//make lists for all the characters in each supplied string
	var letters_array = ds_list_create();
	for (var i = 1; i <= string_length(argument[2]); i++){
		ds_list_add(letters_array, string_char_at(argument[2], i));
	}

	var numbers_array = ds_list_create();
	for (var i = 1; i <= string_length(argument[3]); i++){
		ds_list_add(numbers_array, string_char_at(argument[3], i));
	}

	var specials_array = ds_list_create();
	for (var i = 1; i <= string_length(argument[4]); i++){
		ds_list_add(specials_array, string_char_at(argument[4], i));
	}

	var specials_expanded_array = ds_list_create();
	for (var i = 1; i <= string_length(argument[5]); i++){
		ds_list_add(specials_expanded_array, string_char_at(argument[5], i));
	}

	//shuffle lists
	ds_list_shuffle(letters_array);
	ds_list_shuffle(numbers_array);
	ds_list_shuffle(specials_array);
	ds_list_shuffle(specials_expanded_array);

	//set the number of numbers, special characters, and capital letters in the password
	var number_of_numbers = 0;
	var number_of_specials = 0;
	var number_of_caps = 0; //max(floor(length / 4), 1)

	//set a default list for specials
	var use_list = specials_array;

	//alter the above numbers a bit for other special character circumstances
	switch (use_specials){
		case 0:
		number_of_numbers = max(floor(length * argument[6]), 1);
		number_of_specials = 0;
		number_of_caps = round((length - number_of_numbers) * 0.5);
		break;
	
		case 2:
		number_of_numbers = max(floor(length * argument[6]), 1);
		number_of_specials = max(floor(length * argument[7]), 1);
		number_of_caps = round((length - number_of_numbers - number_of_specials) * 0.5);
		use_list = specials_expanded_array;
		break;
	
		default:
		number_of_numbers = max(floor(length * argument[6]), 1);
		number_of_specials = max(floor(length * argument[7]), 1);
		number_of_caps = round((length - number_of_numbers - number_of_specials) * 0.5);
		use_list = specials_array;
	}

	//create a list that contains all the numbers and special characters
	var output_others = ds_list_create();

	//then pull from the numbers list to add to it
	for (var i = 0; i < number_of_numbers; i++){
		var add = ds_list_find_value(numbers_array,0);
		ds_list_add(output_others, add);
		ds_list_shuffle(numbers_array);
	}

	//add to the same list with some special characters now
	for (var i = 0; i < number_of_specials; i++){
		var add = ds_list_find_value(use_list,0);
		ds_list_add(output_others, add);
		ds_list_shuffle(use_list);
	}

	//make a new list for our letters output
	var output_letters = ds_list_create();

	//and pull from the letters list to add to it
	for (var i = 0; i < (length - number_of_numbers - number_of_specials); i++){
		var add = ds_list_find_value(letters_array,0);
		ds_list_add(output_letters, add);
		ds_list_shuffle(letters_array);
	}

	//shuffle the new letters list, then capitalize some of them
	ds_list_shuffle(output_letters);
	for (var i = 0; i < number_of_caps; i++){
		ds_list_replace(output_letters, i, string_upper(ds_list_find_value(output_letters,i)));
	}

	//create a final list for output and add all the numbers and special characters we selected previously to it
	var output_all = ds_list_create();
	for (var i = 0; i < ds_list_size(output_others); i++){
		var char = ds_list_find_value(output_others, i);
		ds_list_add(output_all, char);
	}

	//add our list of letters to the new output list as well
	for (var i = 0; i < ds_list_size(output_letters); i++){
		var char = ds_list_find_value(output_letters, i);
		ds_list_add(output_all, char);
	}

	//clear the lists we made for letters and numbers/special characters, since we don't need them anymore
	ds_list_destroy(letters_array);
	ds_list_destroy(numbers_array);
	ds_list_destroy(specials_array);
	ds_list_destroy(specials_expanded_array);
	ds_list_destroy(output_letters);
	ds_list_destroy(output_others);

	//randomize the output list
	ds_list_shuffle(output_all);

	//create an empty output string, then itterate through the output list to add characters to it
	for (var i = 0; i < ds_list_size(output_all); i++){
		var char = ds_list_find_value(output_all, i);
		output_string = output_string + char;
	}

	//destroy the output list, as it is no longer needed
	ds_list_destroy(output_all);

	//return the final password
	return output_string;


}
