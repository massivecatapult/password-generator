/// @desc Resize window

//set a small array for window sizes
var window_size = [800, 400];

//check to see if we should make the app large
if (scale_double){
	window_size = [1600, 800];
} else {
	window_size = [800, 400];
}

//resize the window
window_set_size(window_size[0], window_size[1]);

//if this hidden setting is true, swap to a smaller application surface when the app size changes
//otherwise, always use the large application surface
if (swap_surface){
	surface_resize(application_surface, window_size[0], window_size[1]);
} else {
	
	surface_resize(application_surface, 1600, 800);
}

//center the window manually, since the defualt function doesn't want to work
var display_width = display_get_width();
var display_height = display_get_height();
window_set_position(round((display_width - window_size[0]) * 0.5), round((display_height - window_size[1]) * 0.5));