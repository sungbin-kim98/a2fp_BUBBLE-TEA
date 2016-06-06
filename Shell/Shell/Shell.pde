int frame = 0;
String txt = "";
String data = ""; //storage of txt that will be transmitted to the system.
PFont font;
PShape txtCursor;

void setup() {
  size( 500, 500 );
  background( 255 );
  //for font
  font = createFont( "Arial", 20, true ); //font, size, anti-aliasing(?)
  fill( 0 ); //color txt
  textFont( font, 20 ); //font, size( overrides the default size above )
  textLeading( 20 ); //gap between lines
}

void draw() {
  background(255); //resets the screen
  text( data, 5, 0, 495, 500 );
  text( txt, 5, (textWidth( data ) / 495) * 20, 495, 500 ); //display text within a box 
  println( textWidth( txt ) ); 
  //for txtCursor -----------------------------------------------------
  txtCursor = createShape( ELLIPSE, (textWidth( txt ) % 495) + 10, ((textWidth( data ) / 495) * 20) + 15, 5, 5 );
  txtCursor.setStroke( false ); //noStroke
  if( frame % 30 < 15 ) { //blinking every 15 frames
    txtCursor.setFill( color(0) ); //black
  }
  else {
    txtCursor.setFill( color(255) ); //white
  }
  shape( txtCursor );
  //-------------------------------------------------------------------
  frame++;
}

void keyPressed() {
  if( key == ENTER || key == RETURN ) { //check both ENTER and RETURN for crossplatform
    txt += "\n";
  }
  else if( key == BACKSPACE || key == DELETE ) {
    if( txt.length() <= 0 ) {
    }
    else {
      txt = txt.substring( 0, txt.length()-1 ); //deletes data
    }  
  }
  else {
    if( textWidth( txt + key ) > 495 ) {
      data += txt;
      txt = "";
    }
    txt += key; //update txt
  }
}