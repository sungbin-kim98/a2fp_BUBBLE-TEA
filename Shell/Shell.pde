PrintWriter journal;
int frame = 0;
int textY = 0; //for even vertical spacing out between text boxes
int beg = 0;
//int rectColor1, rectColor2, rectColor3, rectColor4 = 235;
String text = ""; 
String data = ""; //storage of txt that will be transmitted to the system.
String response = "Welcome to Turtle Shell! Here you can talk to me or write journal entries just to get things off your chest."; //computer's response
Boolean compResponding = true;
PFont font, bfont;
PShape textCursor, textBox, leftArc, rightArc, box;
ALStack<String> compResponses = new ALStack<String>();
ALStack<PShape> userTextBoxes = new ALStack<PShape>();
ALStack<PShape> compTextBoxes = new ALStack<PShape>();

void setup() {
  size( 700, 500 ); 
  background( 255 );
  ellipseMode( CORNER );
  //bfont = createFont("fantasy", 15, true);   
  //for font --------------------------------------------------------------------
  font = createFont( "Calibri", 20, true ); //font, size, anti-aliasing(?)
  fill( 255 );
  textFont( font, 20 ); //font, size( overrides the default size above )
  textLeading( 20 ); //gap between lines
  //-----------------------------------------------------------------------------
  journal = createWriter("journalentry.txt"); // Create a new file in the sketch directory
  //menu font
}


void draw() {
  if ( compResponding == true ) {
    if ( beg < response.length() ) {
      background( 255 );
      beg++;
      delay(75);
      //txtBox -------------------------------------------------------------------------------------
      textBox = createShape( GROUP );
      leftArc = createShape( ARC, 355, 20, 20, (textY * 20) + 20, PI / 2, (3 * PI) / 2 );
      if ( textY == 0 ) { //first line
        rightArc = createShape( ARC, (textWidth( text ) % 300) + 355, 20, 20, 20, - PI / 2, PI / 2 );
        box = createShape( RECT, 365, 20, (textWidth( text ) % 300), 20 );
      } else {
        rightArc = createShape( ARC, 655, 20, 20, (textY * 20) + 20, - PI / 2, PI / 2 );
        box = createShape( RECT, 365, 20, 300, (textY * 20) + 20 );
      }
      textBox.addChild( leftArc );
      textBox.addChild( rightArc );
      textBox.addChild( box );
      leftArc.setFill( color(150, 220, 250) ); //For some reason, textBox.setFill and textBox.setStroke doesnt work :(
      rightArc.setFill( color(150, 220, 250) );
      box.setFill( color(150, 220, 250) );
      leftArc.setStroke( color(150, 220, 250) );
      rightArc.setStroke( color(150, 220, 250) );
      box.setStroke( color(150, 220, 250) );
      strokeWeight( 5 );
      shape( textBox );
      //responseManipulation-------------------------------------------------------------------------
      text = response.substring(0, beg);
      textY = (int)(textWidth( text ) / 300);
      text( text, 365, 20, 300, 500 );
    }
    else {
    compTextBoxes.push( textBox );
    compResponses.push( text );
    //reset all the vars
    beg = 0;
    text = "";
    textY = 0;
    compResponding = false;
  } }
  else {
    background( 255 );
    shape( compTextBoxes.peek() );
    text( compResponses.peek(), 365, 20, 300, 500 );
    //txtBox -----------------------------------------------------------
    textBox = createShape( GROUP );
    leftArc = createShape( ARC, 20, 20, 20, (textY * 20) + 20, PI / 2, (3 * PI) / 2 );
    if ( textY == 0 ) { //first line
      rightArc = createShape( ARC, (textWidth( text ) % 300) + 20, 20, 20, 20, - PI / 2, PI / 2 );
      box = createShape( RECT, 30, 20, (textWidth( text ) % 300), 20 );
    } else {
      rightArc = createShape( ARC, 320, 20, 20, (textY * 20) + 20, - PI / 2, PI / 2 );
      box = createShape( RECT, 30, 20, 300, (textY * 20) + 20 );
    }
    textBox.addChild( leftArc );
    textBox.addChild( rightArc );
    textBox.addChild( box );
    leftArc.setFill( color(150, 220, 250) ); //For some reason, textBox.setFill and textBox.setStroke doesnt work :(
    rightArc.setFill( color(150, 220, 250) );
    box.setFill( color(150, 220, 250) );
    leftArc.setStroke( color(150, 220, 250) );
    rightArc.setStroke( color(150, 220, 250) );
    box.setStroke( color(150, 220, 250) );
    strokeWeight( 5 );
    shape( textBox );
    //textCursor --------------------------------------------------------
    textCursor = createShape( ELLIPSE, (textWidth( text ) % 300) + 30, (textY * 20) + 30, 5, 5 );
    textCursor.setStroke( false ); //noStroke
    if ( frame % 30 < 15 ) { //blinking every 15 frames
      textCursor.setFill( color(255) ); //black
    } else {
      textCursor.setFill( color(150, 220, 250) ); //white
    }
    shape( textCursor );
    //-------------------------------------------------------------------
    text( data, 30, 20, 300, 500 );
    text( text, 30, textY * 20 + 20, 300, 500 ); //display text within a box
    frame++;
  }
}


void keyPressed() {
  if ( compResponding == true ) { //If computer is typing don't do anything
  } else {
    if ( key == ENTER || key == RETURN ) { //check both ENTER and RETURN for crossplatform
      textY++;
      for ( int i = 0; i < text.length(); i++ ) {
        if ( text.charAt(i) != ' ' ) {
          while ( textWidth( text ) < 300 ) { // fill up a line
            text += " ";
          }
          data += text;
          text = "";
          return;
        }
      }
      text = "|"; //when a line is empty 
      while ( textWidth( text ) < 300 ) { // fill up a line
        text += " ";
      }
      data += text;
      text = "";
    } else if ( key == BACKSPACE || key == DELETE ) {
      if ( data.length() <= 0 && text.length() <= 0 ) {
      } else if ( text.length() <= 0 ) {
        textY--;
        for ( int i = data.length()-1; i >= 0; i-- ) {
          if ( textWidth( data.substring(i) ) > 300 ) {
            text = data.substring(i).trim();
            /*---------------------------REVISION after discovering 'trim()'----------------------------
             for( int j = txt.length()-1; j >= 0; j-- ) {
             if( txt.charAt(j) != ' ' && txt.charAt(j) != '|' ) { //search for the last consonant
             txt = txt.substring(0, j+1);
             data = data.substring(0, i);
             return;
             }
             }*/
            if ( text.equals( "|" ) ) {
              text = ""; // this is when you skipped a line using enter or return
            }
            data = data.substring(0, i);
            break;
          }
        }
      } else {
        text = text.substring( 0, text.length()-1 ); //deletes data
      }
    } else if (key == ESC) { 
      journal.print(data);
      journal.flush(); // Writes the remaining data to the file
      journal.close(); // Finishes the file
      exit(); // Stops the program
    } else if ( key == CODED ) {
    } else {
      if ( textWidth( text + key ) > 300 ) { //to prevent cursor misplacement
        textY++;
        for ( int i = text.length()-1; i >= 0; i-- ) {
          if ( text.charAt(i) == ' ' ) {
            String tmp = "";
            tmp = text.substring(0, i);
            while ( textWidth( tmp ) < 300 ) {
              tmp += " ";
            }
            data += tmp;
            text = text.substring(i+1); //i+1 because of a random space
            text += key;           
            return;
          }
        }   
        data += text;
        text = "";
      }  
      text += key; //update txt
    }
  }
}