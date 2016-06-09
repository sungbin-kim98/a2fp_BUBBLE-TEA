PrintWriter journal;
int frame = 0;
int txtY = 0; //for even vertical spacing out between text boxes
int beg = 0; //printing first line 
int rectColor1, rectColor2, rectColor3, rectColor4 = 235;
String txt = ""; 
String data = ""; //storage of txt that will be transmitted to the system.
String welcome = "Welcome to Turtle Shell! Here you can talk to me or write journal entries just to get things off your chest."; 
PFont font, bfont;
PShape txtCursor, option1, option2, option3 ,option4;  



void setup() {
  size( 500, 500 );
  background( 255 );
//  bfont = createFont("fantasy", 15, true);   
  //for font
  font = createFont( "Calibri", 20, true ); //font, size, anti-aliasing(?)
  fill( 0 ); //color txt
  textFont( font, 20 ); //font, size( overrides the default size above )
  textLeading( 20 ); //gap between lines
  journal = createWriter("journalentry.txt"); // Create a new file in the sketch directory
//menu font 
}


void draw() {
  background(160,160,260); //resets the screen
  text( data, 5, 0, 495, 500 );
  text( txt, 5, txtY * 20, 495, 500 ); //display text within a box
  //for txtCursor -----------------------------------------------------
  txtCursor = createShape( ELLIPSE, (textWidth( txt ) % 495) + 10, (txtY * 20) + 15, 5, 5 );
  txtCursor.setStroke( false ); //noStroke
  
   if (beg < welcome.length()) {
    beg++; 
   // delay(75);
    text(welcome.substring(0,beg), 5, 1, 495, 500 );
    fill(255); 
  }
  else { 
    delay(100); 
    text(welcome,5,0,495,500);
    option1 = createShape(RECT, 50, 115, 170, 100);
    option1.setStroke(0); 
    option1.setFill(rectColor1); 
    option2 = createShape(RECT, 275, 115, 170, 100);
    option2.setStroke(0); 
    option2.setFill(rectColor2); 
    option3 = createShape(RECT, 50, 280, 170, 100);
    option3.setStroke(0); 
    option3.setFill(rectColor3); 
    option4 = createShape(RECT, 275, 280, 170, 100);
    option4.setStroke(0); 
    option4.setFill(rectColor4); 
    textSize(40);
    text("TURTLE SHELL", 130, 100); 
    textSize(20);
    shape(option1); 
    text("Journal Entry", 80, 170); 
    shape(option2); 
    text("Game", 320, 175); 
    shape(option3); 
    text("Something", 80, 340); 
    shape(option4);
    text("Another thing", 290, 340); 
    textAlign(CORNER); 
    
    if (mouseX > 50 && mouseX < 220 && mouseY > 115 && mouseY < 215) { 
    rectColor1 = 10;  
    } 
    else if (mouseX > 275 && mouseX < 475 && mouseY > 115 && mouseY < 215) { 
    rectColor2 = 10; 
  }
   else if (mouseX > 50 && mouseX < 220 && mouseY > 280 && mouseY < 380) { 
    rectColor3 = 10;
   } 
   else if (mouseX > 275 && mouseX < 475 && mouseY > 280 && mouseY < 380) { 
     rectColor4 = 10;
   }
  else { 
    rectColor1 = 235; 
    rectColor2 = 235; 
    rectColor3 = 235; 
    rectColor4 = 235; 
  }
  

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


}

void keyPressed() {
  if( key == ENTER || key == RETURN ) { //check both ENTER and RETURN for crossplatform
    txtY++;
    for( int i = 0; i < txt.length(); i++ ) {
      if( txt.charAt(i) != ' ' ) {
        while( textWidth( txt ) < 495 ) { // fill up a line
          txt += " ";
        }
        data += txt;
        txt = "";
        return;
      }
    }
    txt = "|"; //when a line is empty 
    while( textWidth( txt ) < 495 ) { // fill up a line
      txt += " ";
    }
    data += txt;
    txt = "";
  }
  else if( key == BACKSPACE || key == DELETE ) {
    if( data.length() <= 0 && txt.length() <= 0 ) {
    }
    else if( txt.length() <= 0 ) {
      txtY--;
      for( int i = data.length()-1; i >= 0; i-- ) {
        if( textWidth( data.substring(i) ) > 495 ) {
          txt = data.substring(i);
          for( int j = txt.length()-1; j >= 0; j-- ) {
            if( txt.charAt(j) != ' ' && txt.charAt(j) != '|' ) { //search for the last consonant
              txt = txt.substring(0, j+1);
              data = data.substring(0, i);
              return;
            }
          }
          txt = ""; // this is when you skipped a line using enter or return
          data = data.substring(0, i);
          break;
        }
      }
    }
    else {
      txt = txt.substring( 0, txt.length()-1 ); //deletes data
    }  
  }
  else if (key == ESC) { 
    journal.print(data);
    journal.flush(); // Writes the remaining data to the file
    journal.close(); // Finishes the file
    exit(); // Stops the program
  }
  else if( key == CODED ) {
  }
  else {
    if( textWidth( txt + key ) > 495 ) { //to prevent cursor misplacement
      txtY++;
      for( int i = txt.length()-1; i >= 0; i-- ) {
        if( txt.charAt(i) == ' ' ) {
          String tmp = "";
          tmp = txt.substring(0,i);
          while( textWidth( tmp ) < 495 ) {
            tmp += " ";
          }
          data += tmp;
          txt = txt.substring(i+1); //i+1 because of a random space
          txt += key;           
          return;
        }
      }   
      data += txt;
      txt = "";   
    }  
    txt += key; //update txt
  }

}