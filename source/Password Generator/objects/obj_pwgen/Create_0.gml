/// @desc 
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

//try to load settings on launch
event_user(5);
load_app_settings();
event_user(6);

event_user(0);