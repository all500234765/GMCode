a = (1024 / 540);

width  = 220;
height = max(220 / a, HeaderHeight + 64 + string_height_ext(text, -1, width - 32));

x = WIDTH / 2  - width / 2;
y = HEIGHT / 2 - height / 2;

if( point_in_rectangle(mouse_x, mouse_y, x, y, x + width, y + height) ) {
    window_set_cursor(cr_default);
}

in = point_in_rectangle(mouse_x, mouse_y, x + 16, y + height - 56, x + width - 16, y + height - 16);
button = (in + in * mouse_check_button(mb_left)) / 3;

draw_set_color(HeaderColor);
draw_rectangle(x, y, x + width, y + HeaderHeight, 0); // Header

draw_set_color(c_gray);
draw_rectangle(x, y + HeaderHeight, x + width, y + height, 0); // Background

draw_set_color(HeaderTextColor);
draw_text(x + 2, y + 2, "Oki");

draw_set_halign(fa_middle);
draw_text_ext(x + width / 2, y + HeaderHeight + 2, text, -1, width - 32); // Text

draw_set_color(merge_color(HeaderColor, HeaderColor2, button));
draw_rectangle(x + 16, y + height - 56, x + width - 16, y + height - 16, 0); // Button

draw_set_valign(fa_center);
draw_set_color(merge_color(HeaderTextColor, c_ltgray, button));
draw_text(x + width / 2, y + height - 40, "Ohh... Oki!"); // Button text
draw_set_halign(fa_left);
draw_set_valign(fa_top);

if( mouse_check_button_released(mb_left) && in ) instance_destroy();
