PrintWriter journal;

void setup() {
  // Create a new file in the sketch directory
  journal = createWriter("journalentry.txt"); 
}

void draw() {
}

void keyPressed() {
  
  journal.print(key);
  
  if (key == ESC) { 
    journal.flush(); // Writes the remaining data to the file
    journal.close(); // Finishes the file
    exit(); // Stops the program
  }
}