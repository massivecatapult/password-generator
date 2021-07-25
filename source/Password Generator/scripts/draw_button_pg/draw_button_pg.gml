/// @desc Draws a button using the button sprite and with the appropriate colors, returns hover state
/// @arg x {real} The x position of the button's top left corner
/// @arg y {real} The y position of the button's top left corner
/// @arg width {real} The width of the button
/// @arg label {string} The text to draw on the button
/// @arg color {real} The base color of the button
/// @arg active {real} Whether the button should check for hover state (true) or not (false)
/// @arg edge_left {real} Whether the button should be rounded on the left edge (true) or not (false)
/// @arg edge_right {real} Whether the button should be rounded on the right edge (true) or not (false)
/// @arg icon {real} An icon to show with the text

function draw_button_pg() {

	var c = argument[4];
	var md = false;
	var h = false;

	if (argument[5]){
		var m = [device_mouse_x(0), device_mouse_y(0)];
		if (m[0] > argument[0]) && (m[0] < argument[0] + argument[2]) && (m[1] > argument[1]) && (m[1] < argument[1] + 64){
			h = true;
			md = mouse_check_button(mb_left);
			c = merge_color(c, c_white, 0.2);
		}
	}

	draw_set_color(c_white);
	if (argument[6]){
		draw_sprite_ext(spr_button, 0, argument[0], argument[1], 0.5, 0.5, 0, c, 1);
	} else {
		draw_sprite_ext(spr_button, 1, argument[0], argument[1], 0.5, 0.5, 0, c, 1);
	}

	var w = (argument[2] - 20);
	draw_sprite_ext(spr_button, 1, argument[0] + 10, argument[1], (w / 10) * 0.5, 0.5, 0, c, 1);

	if (argument[7]){
		draw_sprite_ext(spr_button, 2, argument[0] + 10 + w, argument[1], 0.5, 0.5, 0, c, 1);
	} else {
		draw_sprite_ext(spr_button, 1, argument[0] + 10 + w, argument[1], 0.5, 0.5, 0, c, 1);
	}
	
	draw_set_font(fnt_button);
	draw_set_valign(fa_middle);

	var ty = (argument[5] && md) ? 2 : 0;

	if (argument_count < 9){
		
		draw_set_halign(fa_center);
		draw_text_transformed(argument[0] + (argument[2] / 2), argument[1] + 32 + ty, argument[3], 0.5, 0.5, 0);
		
	} else {
		
		var string_w = string_width(argument[3]) * 0.5;
		var sprite_w = sprite_get_width(argument[8]) * 0.5;
		var spacer = 10;
		var content_width = string_w + sprite_w + spacer;
		var offset = (argument[2] - content_width) * 0.5;
		
		draw_set_halign(fa_left);
		draw_text_transformed(argument[0] + offset, argument[1] + 32 + ty, argument[3], 0.5, 0.5, 0);
		draw_sprite_ext(argument[8], 0, argument[0] + offset + string_w + spacer + (sprite_w * 0.5), argument[1] + 32 + ty, 0.5, 0.5, 0, c_white, 1);
		
	}

	return h;

}
