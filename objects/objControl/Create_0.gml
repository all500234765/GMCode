HeaderColor = make_color_rgb(255 * .7, 255 * .9, 255 * 0);
HeaderHeight1 = 24; HeaderHeight2 = 16;
HeaderHeight = HeaderHeight1 + HeaderHeight2;
HeaderTextColor = c_white;
HeaderText = "Unnamed.gml";

HeaderTextBox = textbox_create();
HeaderTextBox.text = HeaderText;
HeaderTextBox.single_line = true;

ContentTextbox = textbox_create();
ContentTextbox.single_line = false;

#macro A 0xA
#macro B 0xB
#macro C 0xC
#macro D 0xD

ltr = false; // Left to right

draw_set_font(fRegular);

#macro WIDTH window_get_width()
#macro HEIGHT window_get_height()
#macro vk_win 0x5B

#region Resize macro
#macro ResizeMacro \
        surface_resize(application_surface, w, h);\
        window_set_size(w, h);\
        window_set_position(_x, _y);\
        matrix_set(matrix_projection, matrix_build_projection_ortho(w, h, 0, 100));\
        camera_set_view_size(view_camera, w, h);
#endregion

#region Resizing window
enum SIDE {
    LEFT   = 1 << 0, 
    RIGHT  = 1 << 1, 
    TOP    = 1 << 2, 
    BOTTOM = 1 << 3, 
    FULL   = 1 << 4, 
}

#macro WindowFull   ((SIDES & SIDE.FULL  ) == SIDE.FULL  )
#macro WindowTop    ((SIDES & SIDE.TOP   ) == SIDE.TOP   )
#macro WindowBottom ((SIDES & SIDE.BOTTOM) == SIDE.BOTTOM)
#macro WindowLeft   ((SIDES & SIDE.LEFT  ) == SIDE.LEFT  )
#macro WindowRight  ((SIDES & SIDE.RIGHT ) == SIDE.RIGHT )

SIDES = 0;

LastResize = [window_get_x(), window_get_y(), WIDTH, HEIGHT];

pressed[vk_up   ] = false;
pressed[vk_down ] = false;
pressed[vk_left ] = false;
pressed[vk_right] = false;
#endregion

#region Code
code = @"
meow = 32 + 64;

";
#endregion

#region Saving
FileSaved = ds_map_create();
FileSaved[? "Unnamed.gml"] = false;
#endregion

#region Code scheme
uiCodeHightlight = ds_map_create();
uiCodeTokens = ds_map_create();

lineTokenCount = ds_list_create();

isAnalized = false;
Analizing = false;

Tokens = ds_list_create();

#region GML Loader 4
uiCodeTokens[? "abs"] = uiCode.Function;

uiCodeTokens[? "struct"] = uiCode.Keyword;
uiCodeTokens[? "if"] = uiCode.Keyword;
uiCodeTokens[? "else"] = uiCode.Keyword;
uiCodeTokens[? "return"] = uiCode.Keyword;
uiCodeTokens[? "for"] = uiCode.Keyword;
uiCodeTokens[? "const"] = uiCode.Keyword;
uiCodeTokens[? "var"] = uiCode.Keyword;
#endregion

#region HLSL
/*uiCodeTokens[? "struct"] = uiCode.Keyword;
uiCodeTokens[? "if"] = uiCode.Keyword;
uiCodeTokens[? "else"] = uiCode.Keyword;
uiCodeTokens[? "return"] = uiCode.Keyword;
uiCodeTokens[? "for"] = uiCode.Keyword;
uiCodeTokens[? "sampler2D"] = uiCode.Keyword;
uiCodeTokens[? "samplerCUBE"] = uiCode.Keyword;
uiCodeTokens[? "static"] = uiCode.Keyword;
uiCodeTokens[? "const"] = uiCode.Keyword;

uiCodeTokens[? "mul"] = uiCode.Function;
uiCodeTokens[? "dfdx"] = uiCode.Function;
uiCodeTokens[? "dfdy"] = uiCode.Function;
uiCodeTokens[? "transpose"] = uiCode.Function;
uiCodeTokens[? "fmod"] = uiCode.Function;
uiCodeTokens[? "modf"] = uiCode.Function;
uiCodeTokens[? "tex2D"] = uiCode.Function;
uiCodeTokens[? "texCUBE"] = uiCode.Function;
uiCodeTokens[? "abs"] = uiCode.Function;

uiCodeTokens[? "register"] = uiCode.Keyword;

uiCodeTokens[? "float"] = uiCode.Keyword; uiCodeTokens[? "float2"] = uiCode.Keyword;
uiCodeTokens[? "float3"] = uiCode.Keyword; uiCodeTokens[? "float4"] = uiCode.Keyword;

uiCodeTokens[? "float4x4"] = uiCode.Keyword;

uiCodeTokens[? "int"] = uiCode.Keyword; uiCodeTokens[? "int2"] = uiCode.Keyword;
uiCodeTokens[? "int3"] = uiCode.Keyword; uiCodeTokens[? "int4"] = uiCode.Keyword;

uiCodeTokens[? "uint"] = uiCode.Keyword; uiCodeTokens[? "uint2"] = uiCode.Keyword;
uiCodeTokens[? "uint3"] = uiCode.Keyword; uiCodeTokens[? "uint4"] = uiCode.Keyword;

uiCodeTokens[? "SV_Position"] = uiCode.Const;
uiCodeTokens[? "SV_Target"] = uiCode.Const;

uiCodeTokens[? "Texture2D"] = uiCode.Keyword;
uiCodeTokens[? "SamplerState"] = uiCode.Keyword;

for( var i = 0; i < 10; i++ ) {
    // Const
    if( i <= 3 ) uiCodeTokens[? "SV_Target" + string(i)] = uiCode.Const;
    uiCodeTokens[? "SV_Position" + string(i)] = uiCode.Const;
    uiCodeTokens[? "SV_POSITION" + string(i)] = uiCode.Const;
    
    uiCodeTokens[? "t" + string(i)] = uiCode.Const;
    uiCodeTokens[? "s" + string(i)] = uiCode.Const;
    
    // Keywords
    uiCodeTokens[? "POSITION" + string(i)] = uiCode.Keyword;
    uiCodeTokens[? "NORMAL" + string(i)] = uiCode.Keyword;
    uiCodeTokens[? "TEXCOORD" + string(i)] = uiCode.Keyword;
    uiCodeTokens[? "BINORMAL" + string(i)] = uiCode.Keyword;
    uiCodeTokens[? "TANGENT" + string(i)] = uiCode.Keyword;
    uiCodeTokens[? "COLOR" + string(i)] = uiCode.Keyword;
}*/
#endregion

// Colors
uiCodeHightlight[? uiCode.Keyword] = 14064726;
uiCodeHightlight[? uiCode.Number] = 10737592;
uiCodeHightlight[? uiCode.Const] = 11454029;
uiCodeHightlight[? uiCode.Comment] = 4825685;
uiCodeHightlight[? uiCode.Word] = 14474460;
uiCodeHightlight[? uiCode.Other] = 14474460;
uiCodeHightlight[? uiCode.String] = 6781089;
uiCodeHightlight[? uiCode.Function] = 5553311;
uiCodeHightlight[? uiCode.PreProcess] = 9868950;

// Preprocessors
uiCodePreProcess = ds_list_create();
ds_list_add(uiCodePreProcess, 
    "region", "endregion", "pragma", 
    "include"
);
#endregion

#region Code editor settings
flags = uiFlags.LineNumbers | uiCode.Comment | uiFlags.AutoComplete | uiFlags.AutoHightlight | uiFlags.ErrorHightlight;
data = [0, code, flags, 
        ds_list_create(), false, false, ds_list_create(), 1, false, 1, 0, 0, noone, noone, noone, 1, 0];
#endregion

#region Code to textbox
var text = code + "\n";
for( var i = 0, c = string_count("\n", text); i < c; i++ ) {
    var j = string_pos("\n", text);
    
    ContentTextbox.line[i] = string_copy(text, 1, j - 1);
    text = string_delete(text, 1, j);
}

for( var i = 0; i < array_length_1d(ContentTextbox.line); i++ ) {
    ContentTextbox.text += ContentTextbox.line[i];
}
#endregion

#region Console
ConsoleTextbox = textbox_create();
ConsoleTextbox.lines = 0;
ConsoleTextbox.read_only = true;
#endregion

#region Fellout
global.Values = ds_map_create();
global.Values[? "autoSave"] = false;

fellout_setup();
file = fellout_create("File");
    fellout_add(file, "Auto save: {[disabled|enabled]:autoSave}", toggleAutoSave);
    fellout_add(file, "-", noone);
    fellout_add(file, "Save|Ctrl + S", noone);
    fellout_add(file, "Save as|Ctrl + Shift + S", noone);
    fellout_add(file, "Load|Ctrl + L", noone);
    fellout_add(file, "Open folder|Ctrl + O", noone);

comp = fellout_create("Compile");
    fellout_add(comp, " - GML|F5", noone);
    fellout_add(comp, " - GML Debug|F6", noone);
    fellout_add(comp, " - HLSL 9|F7", noone);
    fellout_add(comp, " - Custom|F8", noone);

help = fellout_create("Help");
    fellout_add(help, "About", noone);
#endregion

#macro c_ltblue make_color_rgb(176, 216, 230)

gpu_set_ztestenable(true);

// Saving file Unnamed.gml to C:\Users\SweetCelestia\AppData\Local\GMCode\Unnamed.gml
env = environment_get_variable("LOCALAPPDATA") + "\\" + game_project_name + "\\";

dragWindow = false;
