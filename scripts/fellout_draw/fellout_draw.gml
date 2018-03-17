/// @function fellout_draw(id, x1, y1, x2, y2)
/// @arg id
/// @arg x1
/// @arg y1
/// @arg x2
/// @arg y2
{
    var _id = argument0;
    var _x1 = argument1;
    var _y1 = argument2;
    var _x2 = argument3;
    var _y2 = argument4;
    
    var _nc = HeaderTextColor; //  hightlighted text color
    var htc = c_gray; // hightlighted text back col
    var bkc = HeaderColor; // menu back color
    var lbc = c_ltblue;
    
    draw_set_color(bkc);
    if( open[_id] ) draw_set_color(htc);
    
    draw_rectangle(_x1, _y1, _x2, _y2, 0);
    
    if( mouse_in_rectangle(_x1, _y1, _x2, _y2) ) {
        draw_set_colour(lbc);
        draw_rectangle(_x1, _y1, _x2, _y2, 1);
    }
    
    draw_set_color(_nc);
    if( open[_id] ) draw_set_color(bkc);
    
    draw_text(_x1, _y1, name[_id]);
    
    draw_set_font(fSmall);
    if( open[_id] ) {
#region
        var _x = _x2 + 144;
        
        // global.menu_shadows
        draw_set_color(c_black);
        draw_set_alpha(.5);
        
        //draw_rectangle(_x1+8, _y2+8, _x2+8, _y2+8+16*array_length_2d(scrpt, _id), 0);
        
        draw_set_alpha(1);
        draw_set_color(bkc);
        
        draw_rectangle(_x1, _y2+16, _x, _y2+16*(array_length_2d(scrpt, _id)-1), 0);
        
        var j = 0;
        
        // draw menu text
        for( var i = 0; i < array_length_2d(name2, _id); i++ ) {
            var colour;
                colour[0] = bkc;
                colour[1] = _nc;
            
            var in_focus = mouse_in_rectangle(_x1, _y2+16*j, _x, _y2+16*(j+1)-1);
            
            if( name2[_id, i] != "-" ) {
                if( in_focus ) {
                    colour[0] = htc; // rectangle colour
                    colour[1] = bkc; // text colour
                }
                
                var _text = name2[_id, i];
                var p = string_pos("{", _text); // {[v1|v2|v3]:key} => values[key]
                if( p > 0 ) {
                    var asIs = true;
                    var in = string_copy(_text, p + 1, string_pos("}", _text) - (p + 1));
                    
                    var p2 = string_pos("[", in);
                    if( p2 > 0 ) {
                        var left = string_copy(in, p2 + 1, string_pos("]", in) - (p2 + 1));
                        var values = string_split(left, "|", false);
                        asIs = false;
                    }
                    
                    var p3 = string_pos(":", in);
                    var right = string_copy(in, p3 + 1, string_length(in));
                    
                    var main = string_copy(_text, 1, p - 1);
                    
                    var v = global.Values[? right];
                    if( asIs ) {
                        _text = main + v;
                    } else {
                        _text = main + values[v];
                    }
                }
                
                var p = string_pos("|", _text); // meow|cat    | => meow    cat|
                if( p > 0 ) {
                    var right = string_copy(_text, p + 1, string_length(_text));
                    _text = string_copy(_text, 1, p - 1);
                    
                    draw_set_halign(fa_right);
                    
                    draw_text(_x, _y2 + 16 * i, right);
                    
                    draw_set_halign(fa_left);
                }
                
                draw_set_color(colour[0]);
                draw_rectangle(_x1, _y2+16*i, _x, _y2+16*(i+1), 0);
                
                draw_set_color(colour[1]);
                draw_text(_x1, _y2+16*i, _text);
                
                // execute script
                if( in_focus ) {
                    if( mouse_check_button_pressed(mb_left) ) {
                        if( script_exists(scrpt[_id, i]) ) {
                            script_execute(scrpt[_id, i]);
                        }
                        
                        open[_id] = false;
                        anyopened = false;
                        openedid  = -1;
                        
                        mouse_clear(mb_left);
                    }
                }
                
                j++;
            } else {
                draw_set_color(c_black);
                draw_text(_x1, _y2+16*i, string_repeat("-", (_x-_x1)/string_width("-")));
                
                j++;
            }
            
            if( in_focus ) M_ = true;
        }
        
        if( mouse_in_rectangle(_x1, _y1, _x, _y2) ) M_ = true;; // Set default cursor
#endregion
    }
    
    draw_set_font(fRegular);
    
    if( mouse_in_rectangle(_x1, _y1, _x2, _y2) ) {
        if( anyopened == false ) {
            if( mouse_check_button_pressed(mb_left) ) {
                anyopened   = true;
                openedid    = _id;
                open[@ _id] = true;
                
                mouse_clear(mb_left);
            }
        } else {
            if( openedid != _id ) {
                open[openedid] = false;
                open[@ _id]    = true;
                openedid       = _id;
            } else {
                if( mouse_check_button_pressed(mb_left) ) {
                    open[_id] = false;
                    anyopened = false;
                    openedid  = -1;
                    
                    mouse_clear(mb_left);
                }
            }
        }
    } else {
        if( mouse_check_button_pressed(mb_left) ) {
            if( anyopened == true ) {
                if( openedid == _id ) {
                    if( !mouse_in_rectangle(_x1, _y1+16, _x2, _y2+16*(array_length_2d(scrpt, _id)-1)) ) {
                        open[@ _id] = false;
                        anyopened   = false;
                        openedid    = -1;
                        
                        mouse_clear(mb_left);
                    }
                }
            }
        }
    }
    
    draw_set_color(_nc);
}
