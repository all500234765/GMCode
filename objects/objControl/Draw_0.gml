ConsoleHeight = 128;
Height = HEIGHT - ConsoleHeight;

var g = string_repeat("*", !FileSaved[? HeaderTextBox.text]);

#region Header / Background
draw_set_color(HeaderColor);
draw_rectangle(0, 0, WIDTH, HeaderHeight1, 0); // Header
draw_rectangle(0, HeaderHeight1, WIDTH, HeaderHeight, 0); // Header

draw_set_color(c_dkgray);
draw_rectangle(0, HeaderHeight, WIDTH, Height, 0); // Background

var _x = ltr ? (WIDTH - 2) : 2;
var w = min(200, string_width(HeaderTextBox.text) + 8);

draw_set_color(HeaderTextColor);
draw_set_halign(ltr ? fa_right : fa_left);
draw_text(w + _x, 2, "- GMCode"); // Header text
draw_text(w + _x - 8, 2, g);

textbox_draw(HeaderTextBox, _x, 2, _x + w, HeaderHeight1 - 2);
#endregion

#region Drag window around
var f = w + string_width(g + "- GMCode");
if( mouse_in_rectangle(f, 0, WIDTH - 128, HeaderHeight1) ) {
    if( mouse_check_button_pressed(mb_left) ) {
        dragWindow = true;
        dragWind = [display_mouse_get_x() - window_get_x(), display_mouse_get_y() - window_get_y()];
    }
}

if( mouse_check_button(mb_left) && dragWindow ) { // Drag window
    window_set_position(
        display_mouse_get_x() - dragWind[0], 
        display_mouse_get_y() - dragWind[1]
    );
}

if( mouse_check_button_released(mb_left) ) {
    dragWindow = false;
}
#endregion

#region Fellout
M_ = false;
draw_set_color(c_black);

matrix_add_translate(0, 0, -1);
    
    fellout_draw(file, 000, HeaderHeight1, 064, HeaderHeight - 1);
    fellout_draw(comp, 064, HeaderHeight1, 192, HeaderHeight - 1);
    fellout_draw(help, 192, HeaderHeight1, 256, HeaderHeight - 1);
    
matrix_add_translate(0, 0, 1);
#endregion

#region Resizing

#endregion

#region Hot keys
#region Window
if( keyboard_check(vk_win) ) {
    if( keyboard_check_direct(vk_up) && !pressed[vk_up] && (!WindowTop || WindowBottom || !WindowFull) ) { // WIN + UP
        var _LastResize = [window_get_x(), window_get_y(), WIDTH, HEIGHT];
        
        // Resize
        var w  = WindowTop ? (display_get_width()  / 2) : display_get_width();
        var h  = WindowTop ? (display_get_height() / 2) : display_get_height();
        var _x = WindowTop ? (WindowLeft ? 0 : w) : 0;
        var _y = WindowTop ? (0) : 0;
        
        ResizeMacro;
        
        if( !WindowFull && !WindowBottom ) {
            LastResize = _LastResize;
            SIDES = SIDE.FULL;
        } else {
            SIDES ^= SIDE.BOTTOM * WindowBottom;
            SIDES |= SIDE.TOP;
        }
        
        keyboard_clear(vk_up); pressed[vk_up] = true;
    }
    
    if( keyboard_check_direct(vk_down) && !pressed[vk_down] && (WindowTop && !WindowBottom || WindowFull) ) { // WIN + DOWN
        // Resize
        var w  = WindowFull ? LastResize[2] : (display_get_width()  / 2);
        var h  = WindowFull ? LastResize[3] : (display_get_height() / 2);
        var _x = WindowFull ? LastResize[0] : (WindowLeft ? 0 : w);
        var _y = WindowFull ? LastResize[1] : (h);
        
        ResizeMacro;
        
        SIDES ^= SIDE.TOP * WindowTop;
        SIDES |= SIDE.BOTTOM;
        keyboard_clear(vk_down); pressed[vk_down] = true;
    }
    
    if( keyboard_check_direct(vk_left) && !pressed[vk_left] ) { // WIN + LEFT
        // Resize
        var w  = display_get_width() / 2;
        var h  = display_get_height() / 2;
        var _x = 0;
        var _y = WindowBottom ? h : 0;
        
        ResizeMacro;
        
        SIDES = SIDE.LEFT;
        if( !WindowBottom ) SIDES |= SIDE.TOP;
        
        show_debug_message(dec_to_bin(SIDES));
        keyboard_clear(vk_left); pressed[vk_left] = true;
    }
    
    if( keyboard_check_direct(vk_right) && !pressed[vk_right] ) { // WIN + RIGHT
        // Resize
        var w  = display_get_width() / 2;
        var h  = display_get_height() / 2;
        var _x = w;
        var _y = WindowBottom ? h : 0;
        
        ResizeMacro;
        
        SIDES = SIDE.RIGHT;
        if( !WindowBottom ) SIDES |= SIDE.TOP;
        
        show_debug_message(dec_to_bin(SIDES));
        keyboard_clear(vk_right); pressed[vk_right] = true;
    }
    
    
}

if( keyboard_check_released(vk_up   ) ) pressed[vk_up   ] = false;
if( keyboard_check_released(vk_down ) ) pressed[vk_down ] = false;
if( keyboard_check_released(vk_left ) ) pressed[vk_left ] = false;
if( keyboard_check_released(vk_right) ) pressed[vk_right] = false;
#endregion

#region Text box
if( keyboard_check_pressed(vk_enter) && textbox_focus == HeaderTextBox ) {
    filenameIsRight();
    textbox_focus = -1;
    keyboard_clear(vk_enter);
}
#endregion

#region File menu
if( keyboard_check(vk_control) ) {
    if( keyboard_check_pressed(ord("S")) ) { // Save
        if( keyboard_check_direct(vk_shift) ) { // W/ Shift
            
        } else {
            
        }
        
        ConsoleTextbox.line[ConsoleTextbox.lines++] = "Saved file " + HeaderTextBox.text + " to " + env + HeaderTextBox.text;
        ConsoleTextbox.start++;
    }
    
    if( keyboard_check_pressed(ord("O")) ) { // Open folder
        
    }
    
    if( keyboard_check_pressed(ord("L")) ) { // Open file
        
    }
}
#endregion

#region Compile menu
if( keyboard_check_pressed(vk_f5) ) {
    var CODE = ContentTextbox.text;
    
    
}

if( keyboard_check_pressed(vk_f6) ) {
    
}

if( keyboard_check_pressed(vk_f7) ) {
    
}
#endregion
#endregion

if( false ) {
#region Code Editor
matrix_add_translate(0, HeaderHeight, 0);

__uiMAX_WIDTH = WIDTH;
__uiMX = mouse_x;
__uiMY = mouse_y;

text = data[1];
flags = data[2];
Tokens = data[3];
isAnalized = data[4];
Analizing = data[5]; // Run time code analization
ErrorList = data[6];
Full = data[8];
vec = [0, 0];

#region Get values
// Check for lists
if( uiFlag(flags, uiFlags.ErrorHightlight) ) {
    if( !ds_exists(ErrorList, ds_type_list) ) ErrorList = ds_list_create();
    data[@ 6] = ErrorList;
} else {
    if( ds_exists(ErrorList, ds_type_list) ) ds_list_destroy(ErrorList);
    data[@ 6] = ErrorList;
}

if( uiFlag(flags, uiFlags.AutoHightlight) ) {
    if( !ds_exists(Tokens, ds_type_list) ) Tokens = ds_list_create();
    data[@ 3] = Tokens;
} else {
    if( ds_exists(Tokens, ds_type_list) ) ds_list_destroy(Tokens);
    data[@ 3] = Tokens;
}

draw_set_color(c_dkgray);
draw_rectangle(2, 2, __uiMAX_WIDTH - 2, data[10] + 2, 0); // Background


// Regions
var lst = data[12];
if( !ds_exists(lst, ds_type_list) ) {
    data[@ 12] = ds_list_create();
    lst = data[12];
}

// Regions position
var lst2 = data[13];
if( !ds_exists(lst2, ds_type_list) ) {
    data[@ 13] = ds_list_create();
    lst2 = data[13];
}

// Line token count
lineTokenCount = data[14];
if( !ds_exists(lineTokenCount, ds_type_list) ) {
    data[@ 14] = ds_list_create();
    lineTokenCount = data[14];
}
#endregion

#region Update
if( textbox_focus == ContentTextbox && (keyboard_string != "" || keyboard_lastkey != -1 ) ) {
    ds_list_clear(Tokens);
    ds_list_clear(lst);
    ds_list_clear(lst2);
    ds_list_clear(lineTokenCount);
    ds_list_clear(ErrorList);
    
    isAnalized = false;
    Analizing = false;
    Full = false;
    
    text = "";
    for( var i = 0; i < array_length_1d(ContentTextbox.line); i++ ) {
        text += ContentTextbox.line[i] + "\n";
    }
    
    Index = 1;
    Index2 = 1;
    
    data[@ 1] = text;
    data[@ 5] = Analizing;
    data[@ 4] = isAnalized;
    data[@ 8] = Full;
    data[@ 7] = Index;
    data[@ 16] = 0;
    data[@ 15] = 1;
    data[@ 9] = Index2;
    
    keyboard_lastkey = -1;
}
#endregion

#region Draw line numbers
var regionCount = data[11];
var __qq = uiFlag(flags, uiFlags.LineNumbers);
if( __qq || regionCount > 0 ) {
    var w = 16 * (regionCount > 0) + 6 + string_width("000"); // Instead of '000' place n number of 0, 
                                                              // to have some space for bigger numbers
    draw_set_color(c_black);
    draw_line(w, 2, w, data[10]);
    
    for( var j = 0; j < ds_list_size(lst); j++ ) {
        var d = lst[| j];
        
        draw_sprite(sprUIGroup, d[0], w - 16, d[1]); // Draw open / close sign
        
        // Close / Open region
        if( mouse_check_button_released(mb_left) && matrix_rect(w - 16, d[1], w - 1, d[1] + h) ) {
            d[@ 0] ^= true;
        }
    }
    
    if( __qq ) {
        draw_set_color(uiCodeHightlight[? uiCode.Number]);
        draw_set_halign(fa_right);
            
            var cnt = 0;
            var z = 0;
            var pr  = "#pragma region";
            var per = "#pragma endregion";
            
            for( var j = 0; j < data[10] / h; j++ ) {
                var f = j + z;
                
                if( ds_list_find_index(lst2, f) > -1 ) {
                    var t = lineTokenCount[| f];
                    line = f;
                    
                    // #pragma region
                    var d = lst[| cnt];
                    
                    if( !d[0] ) {
                        var tok = Tokens[| ++t]; // String
                        var tkn = Tokens[| ++t];
                        
                        while( t < ds_list_size(Tokens) && (tkn[0] != per) ) {
                            // Skip to #pragma endregion or end of code
                            if( tkn[0] == "\n" ) line++;
                            tkn = Tokens[| ++t];
                            
                        }
                    }
                    
                    var delta = line - f;
                    
                    cnt++; // 
                    z += delta;
                }
                
                draw_text(w - 2 - 16 * (regionCount > 0), 2 + j * h, string(j + 1 + z));
            }
            
        draw_set_halign(fa_left);
    }
    
    matrix_add_translate(w + 2, 0, 0);
}
#endregion

if( uiFlag(flags, uiFlags.AutoHightlight) ) {
    #region Run code tokenization
    if( !isAnalized ) {
        if( Analizing ) {
            Index = data[7];
            c = data[16];
            line = data[15];
            
            repeat( 200 ) {
                var char = string_char_at(text, Index);
                var p = string_char_at(text, Index - 1);
                
                if( string_digits(char) == char || char == "." && string_digits(p) == p ) { // Real
                    var kw = char;
                    while( true ) {
                        Index++;
                        char = string_char_at(text, Index);
                        
                        if( (string_digits(char) == char) || char == "." ) {
                            kw += char;
                        } else {
                            Index--;
                            break;
                        }
                    }
                    
                    c++;
                    ds_list_add(Tokens, [real(kw), uiCode.Number]);
                } else if( ord(char) >= ord("a") && ord(char) <= ord("z")
                        || ord(char) >= ord("A") && ord(char) <= ord("Z")
                        || char == "_" ) { // Keyword
                    var kw = char;
                    while( true ) {
                        Index++;
                        char = string_char_at(text, Index);
                        
                        if( ord(char) >= ord("a") && ord(char) <= ord("z")
                         || ord(char) >= ord("A") && ord(char) <= ord("Z")
                         || (string_digits(char) == char) || char == "_" ) {
                            kw += char;
                        } else {
                            Index--;
                            break;
                        }
                    }
                    
                    c++;
                    //show_debug_message(kw);
                    var tok = uiCodeTokens[? kw];
                    ds_list_add(Tokens, [kw, tok == undefined ? uiCode.Word : tok]);
                } else if( char == "'" || char == "\"" ) {
                    var kw = char;
                    var start = char;
                    
                    while( true ) {
                        Index++;
                        char = string_char_at(text, Index);
                        
                        if( char == start ) {
                            kw += char;
                        } else {
                            Index--;
                            break;
                        }
                    }
                    
                    c++;
                    ds_list_add(Tokens, [kw, uiCode.String]);
                } else {
                    var kw, token = uiCode.Other;
                    
                    switch( char ) {
                        case "/": // Comments
                            switch( string_char_at(text, Index + 1) ) {
                                case "/":
                                    var count = 0; Index++;
                                    while( string_char_at(text, Index) != "\n" ) {
                                        Index++;
                                        count++;
                                    }
                                    
                                    Index--;
                                    kw = string_copy(text, Index - count, count);
                                    
                                    token = uiCode.Comment;
                                    break;
                                    
                                case "*":
                                    var count = 0; Index++;
                                    while !( string_char_at(text, Index) == "*" && string_char_at(text, Index + 1) == "/" ) {
                                        Index++;
                                        count++;
                                    }
                                    
                                    kw = string_copy(text, Index - count - 1, count + 3);
                                    Index++;
                                    
                                    token = uiCode.Comment;
                                    break;
                            }
                            break;
                            
                        case "\\": // 
                            kw = char;
                            Index++;
                            
                            switch( string_char_at(kw, Index) ) {
                                case "t" : kw += "    "; break;
                                case "n" : kw += "\n";   show_debug_message("Line: " + string_format(line, 3, 0) + " Count: " + string(c)); lineTokenCount[| line++] = c; break;
                                case "\\": kw += "\\";   break;
                            }
                            break;
                            
                        case "\n":
                            // New line
                            //show_debug_message("\\" + char + " " + string(Index));
                            kw = char;
                            //show_debug_message("Line: " + string_format(line, 3, 0) + " Count: " + string(c)); 
                            lineTokenCount[| line++] = c;
                            break;
                            
                        case "#":
                            // Preprocessor
                            var count = 0; Index++;
                            while( string_char_at(text, Index) != "\n" ) {
                                Index++;
                                count++;
                            }
                            
                            Index--;
                            kw = string_copy(text, Index - count, count);
                            
                            var p = string_rpos(" ", kw);
                            var sbt = string_copy(kw, p + 1, string_length(kw)); // Find additional word
                            
                            token = uiCode.PreProcess;
                            
                            if( ds_list_find_index(uiCodePreProcess, sbt) == -1 ) { // String is apparantly not preprocessor
                                if( string_pos("region", kw) && string_pos("endregion", text) ) {
                                    data[@ 11]++;
                                    ds_list_add(lst, [true, string_height(string_copy(text, 1, Index)) - h]); // Add token, of [x, height]
                                    ds_list_add(lst2, (string_height(string_copy(text, 1, Index))) / h);
                                }
                                
                                kw = string_delete(kw, p + 1, string_length(kw)); // Delete string
                                
                                c++;
                                // Put preprocess
                                ds_list_add(Tokens, [kw, uiCode.PreProcess]);
                                
                                // Put argument
                                kw = sbt;
                                
                                if( (string_pos("'" , kw) && string_rpos("'" , kw) && string_count("'" , kw) > 1)
                                 || (string_pos("\"", kw) && string_rpos("\"", kw) && string_count("\"", kw) > 1) ) {
                                    token = uiCode.String; // Put string
                                } else {
                                    var tok = uiCodeTokens[? sbt];
                                    token = tok == undefined ? uiCode.Word : tok;
                                }
                            }
                            break;
                            
                        default:
                            // Compress string
                            var start = char; kw = char;
                            while( char ) {
                                char = string_char_at(text, Index);
                                
                                if( char == start ) {
                                    kw += char;
                                } else {
                                    Index--;
                                    break;
                                }
                            }
                            
                            //if( char == " " ) show_debug_message(string_length(kw));
                            break;
                    }
                    
                    if( kw != "" ) {
                        ds_list_add(Tokens, [kw, token]);
                        c++;
                    }
                }
                
                Index++;
                
                // Tokenization is done!
                if( Index > string_length(text) ) {
                    isAnalized = true;
                    Analizing = false;
                    
                    break; // Stop the loop
                }
            }
            
            data[@ 7] = Index;
            data[@ 15] = line;
            data[@ 16] = c;
        } else { // Run code tokenization
            Analizing = true;
            Full = false;
            
            ds_list_clear(Tokens);
            data[@ 7] = 1;
            data[@ 9] = 0;
        }
    }
    #endregion
    
    #region Code rendering
    Index2 = data[9];
    if( (Analizing || isAnalized) /*/&& !Full/**/ && ds_list_size(Tokens) > 0 ) {
        // Generate string
        var _x = 2;
        var _y = 2;
        var cnt = 0;
        
        for( var j = 0; j < ds_list_size(Tokens); j++ ) {
            var token = Tokens[| j];
            
            if( token[0] == "\n" ) {
                _y += h;
                _x = 0;
                continue;
            } else {
                var drw = false;
                var pr  = "#pragma region";
                var per = "#pragma endregion";
                var test1 = string_copy(token[0], 1, string_length(pr)) == pr;
                
                if( string_char_at(token[0], 1) == "#"
                 && (test1 || string_copy(token[0], 1, string_length(per)) == per)) {
                    if( test1 ) {
                        // #pragma region
                        var d = lst[| cnt];
                        
                        if( !d[0] ) {
                            var tok = Tokens[| ++j]; // String
                            
                            var tkn = Tokens[| ++j];
                            while( j < ds_list_size(Tokens) && (tkn[0] != per) ) {
                                // Skip to #pragma endregion or end of code
                                tkn = Tokens[| ++j];
                            }
                            
                            drw = true;
                        }
                    }
                    
                    cnt++; // 
                }
                
                draw_set_color(uiCodeHightlight[? token[1]]);
                draw_text(_x, _y, token[0]);                    // Draw text
                
                var l = string_length(token[0]);
                if( string_count(" ", token[0]) == l ) { // The string is long whitespace
                    _x += l * string_width("C");
                } else {
                    _x += string_width(token[0]);
                }
                
                if( token[1] == uiCode.Comment ) {
                    _y += string_height(token[0]) - h;
                }
                
                if( drw ) {
                    draw_set_color(uiCodeHightlight[? tok[1]]);
                    draw_text(_x, _y, tok[0]);                    // Draw text
                    
                    _x += string_width(tok[0]);
                }
            }
        }
        
        vec = [0, _y];
        data[@ 10] = _y + h - 2;
    }
    #endregion
    
    // Update values
    data[@ 5] = Analizing;
    data[@ 4] = isAnalized;
    data[@ 8] = Full;
    data[@ 9] = Index2;
} else {
    data[@ 10] = string_height(text);
    
    draw_set_color(uiCodeHightlight[? uiCode.Word]);
    draw_text(2, 2, text);
}

matrix_set(matrix_world, matrix_build_identity());
#endregion
}

h = string_height("C");
var text = code;

#region Update
if( textbox_focus == ContentTextbox && (keyboard_string != "" || keyboard_lastkey != -1 ) ) {
    ds_list_clear(Tokens);
    ds_list_clear(lineTokenCount);
    //ds_list_clear(ErrorList);
    
    isAnalized = false;
    Analizing = false;
    Full = false;
    
    text = "";
    for( var i = 0; i < ContentTextbox.lines; i++ ) {
        text += ContentTextbox.line[i] + "\n";
    }
    
    Index = 1;
    Index2 = 1;
    
    keyboard_lastkey = -1;
}
#endregion

#region Draw line numbers
var __qq = uiFlag(flags, uiFlags.LineNumbers);
if( __qq ) {
    var _h_ = (ContentTextbox.lines - 0) * h;
    var w = 16 + 4 + string_width("000"); // Instead of '000' place n number of 0, 
                                          // to have some space for bigger numbers
    draw_set_color(c_black);
    draw_line(w, HeaderHeight + 2, w, HeaderHeight + _h_);
    
    if( __qq ) {
        draw_set_color(uiCodeHightlight[? uiCode.Number]);
        draw_set_halign(fa_right);
            
            for( var j = 0; j < _h_ / h; j++ ) {
                draw_text(w - 2 - 16, HeaderHeight + 2 + j * h, j + 1);
            }
            
        draw_set_halign(fa_left);
    }
}
#endregion

#region Run code tokenization
if( !isAnalized ) {
    if( Analizing ) {
#region 
        repeat( 200 ) {
            var char = string_char_at(text, Index);
            var p = string_char_at(text, Index - 1);
            
            if( string_digits(char) == char || char == "." && string_digits(p) == p ) { // Real
                var kw = char;
                while( true ) {
                    Index++;
                    char = string_char_at(text, Index);
                    
                    if( (string_digits(char) == char) || char == "." ) {
                        kw += char;
                    } else {
                        Index--;
                        break;
                    }
                }
                
                c++;
                ds_list_add(Tokens, [real(kw), uiCode.Number]);
            } else if( ord(char) >= ord("a") && ord(char) <= ord("z")
                    || ord(char) >= ord("A") && ord(char) <= ord("Z")
                    || char == "_" ) { // Keyword
                var kw = char;
                while( true ) {
                    Index++;
                    char = string_char_at(text, Index);
                    
                    if( ord(char) >= ord("a") && ord(char) <= ord("z")
                     || ord(char) >= ord("A") && ord(char) <= ord("Z")
                     || (string_digits(char) == char) || char == "_" ) {
                        kw += char;
                    } else {
                        Index--;
                        break;
                    }
                }
                
                c++;
                //show_debug_message(kw);
                var tok = uiCodeTokens[? kw];
                ds_list_add(Tokens, [kw, tok == undefined ? uiCode.Word : tok]);
            } else if( char == "'" || char == "\"" ) {
                var kw = char;
                var start = char;
                
                while( true ) {
                    Index++;
                    char = string_char_at(text, Index);
                    
                    if( char == start ) {
                        kw += char;
                    } else {
                        Index--;
                        break;
                    }
                }
                
                c++;
                ds_list_add(Tokens, [kw, uiCode.String]);
            } else {
                var kw, token = uiCode.Other;
                
                switch( char ) {
                    case "/": // Comments
                        switch( string_char_at(text, Index + 1) ) {
                            case "/":
                                var count = 0; Index++;
                                while( string_char_at(text, Index) != "\n" ) {
                                    Index++;
                                    count++;
                                }
                                
                                Index--;
                                kw = string_copy(text, Index - count, count);
                                
                                token = uiCode.Comment;
                                break;
                                
                            case "*":
                                var count = 0; Index++;
                                while !( string_char_at(text, Index) == "*" && string_char_at(text, Index + 1) == "/" ) {
                                    Index++;
                                    count++;
                                }
                                
                                kw = string_copy(text, Index - count - 1, count + 3);
                                Index++;
                                
                                token = uiCode.Comment;
                                break;
                        }
                        break;
                        
                    case "\\": // 
                        kw = char;
                        Index++;
                        
                        switch( string_char_at(kw, Index) ) {
                            case "t" : kw += "    "; break;
                            case "n" : kw += "\n";   show_debug_message("Line: " + string_format(line, 3, 0) + " Count: " + string(c)); lineTokenCount[| line++] = c; break;
                            case "\\": kw += "\\";   break;
                        }
                        break;
                        
                    case "\n":
                        // New line
                        //show_debug_message("\\" + char + " " + string(Index));
                        kw = char;
                        //show_debug_message("Line: " + string_format(line, 3, 0) + " Count: " + string(c)); 
                        lineTokenCount[| line++] = c;
                        break;
                        
                    case "#":
                        // Preprocessor
                        var count = 0; Index++;
                        while( string_char_at(text, Index) != "\n" ) {
                            Index++;
                            count++;
                        }
                        
                        Index--;
                        kw = string_copy(text, Index - count, count);
                        
                        var p = string_rpos(" ", kw);
                        var sbt = string_copy(kw, p + 1, string_length(kw)); // Find additional word
                        
                        token = uiCode.PreProcess;
                        
                        if( ds_list_find_index(uiCodePreProcess, sbt) == -1 ) { // String is apparantly not preprocessor
                            if( string_pos("region", kw) && string_pos("endregion", text) ) {
                                data[@ 11]++;
                                ds_list_add(lst, [true, string_height(string_copy(text, 1, Index)) - h]); // Add token, of [x, height]
                                ds_list_add(lst2, (string_height(string_copy(text, 1, Index))) / h);
                            }
                            
                            kw = string_delete(kw, p + 1, string_length(kw)); // Delete string
                            
                            c++;
                            // Put preprocess
                            ds_list_add(Tokens, [kw, uiCode.PreProcess]);
                            
                            // Put argument
                            kw = sbt;
                            
                            if( (string_pos("'" , kw) && string_rpos("'" , kw) && string_count("'" , kw) > 1)
                             || (string_pos("\"", kw) && string_rpos("\"", kw) && string_count("\"", kw) > 1) ) {
                                token = uiCode.String; // Put string
                            } else {
                                var tok = uiCodeTokens[? sbt];
                                token = tok == undefined ? uiCode.Word : tok;
                            }
                        }
                        break;
                        
                    default:
                        // Compress string
                        var start = char; kw = char;
                        while( char ) {
                            char = string_char_at(text, Index);
                            
                            if( char == start ) {
                                kw += char;
                            } else {
                                Index--;
                                break;
                            }
                        }
                        
                        //if( char == " " ) show_debug_message(string_length(kw));
                        break;
                }
                
                if( kw != "" ) {
                    ds_list_add(Tokens, [kw, token]);
                    c++;
                }
            }
            
            Index++;
            
            // Tokenization is done!
            if( Index > string_length(text) ) {
                isAnalized = true;
                Analizing = false;
                
                break; // Stop the loop
            }
        }
#endregion
    } else { // Run code tokenization
        Analizing = true;
        Full = false;
        
        ds_list_clear(Tokens);
        
        Index = 1;
        Index2 = 0;
        c = 0;
        line = 1;
    }
}
#endregion

draw_set_color(c_white);
textbox_draw(ContentTextbox, 16 + 6 + string_width("000"), HeaderHeight, WIDTH, Height); // Code

draw_text(WIDTH - 96, 2, ds_list_size(Tokens));

if( M_ ) {
    window_set_cursor(cr_default);
}

#region Console
draw_set_color(HeaderColor);
draw_rectangle(0, Height, WIDTH, Height + HeaderHeight1, 0); // Header

draw_set_color(c_dkgray);
draw_rectangle(0, Height + HeaderHeight1, WIDTH, HEIGHT, 0); // Background

draw_set_color(HeaderTextColor);
draw_text(2, Height + 2, "Output");

textbox_draw(ConsoleTextbox, 2, Height + HeaderHeight1 + 2, WIDTH, HEIGHT); // Textbox
#endregion
