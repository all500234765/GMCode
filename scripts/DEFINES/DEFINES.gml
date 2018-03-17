gml_pragma("global", "DEFINES();");

global.__CLIP_RECT = -1;
#macro SV_ClipRectangle global.__CLIP_RECT

enum uiFlags {
    Null                    = 1 << 0 , 
    AutoComplete            = 1 << 29, 
    CodeHightlight          = 1 << 30, 
    AutoHightlight          = 1 << 31, 
    ErrorHightlight         = 1 << 32, 
    LineNumbers             = 1 << 33, 
    
}

enum uiCode {
    Keyword, 
    Number, 
    Const, 
    Comment, 
    Word, 
    String, 
    Other, 
    Function, 
    PreProcess, 
    
    
}

