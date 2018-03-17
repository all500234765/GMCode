var text = HeaderTextBox.text;
var symbols = "()*&^%$#@![]{}-+?/,\\:;'\"=";
var f = false;

for( var i = 1; i <= string_length(symbols); i++ ) {
    var c = string_char_at(symbols, i);
    if( string_pos(c, text) > 0 ) {
        text = string_replace_all(text, c, "");
        f = true;
    }
}

if( f ) {
    HeaderTextBox.text = text;
    showMessage("Can't use any of this symbols: " + symbols);
    return false;
}

return true;
