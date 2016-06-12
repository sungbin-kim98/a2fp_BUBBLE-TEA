PrintWriter output;
String data = " ";
String name = "journalentry";
int day = 1;

BufferedReader reader;
String lines = "";
String temp = "";

void setup() {
  size(500,500);
  // Open the file from the createWriter() example   
  text("to write press ENTER, to save press ESC, to edit press BACKSPACE", 50, 50);
  text("sorry you cant see anything when you type", 50, 70);
  text("STEP 1: press enter, type something, than esc to save",50,370);
  text("TIP: type something with a few line breaks (ENTERS)",50,390);
  text("STEP 2: run again, press backspace, your text should appear",50,410);  
  text("TIP: pressing esc without typing shouldnt change file",50,430);
  text("STEP 3: typing something will change file",50,450);
}

void draw() {
}

void write() {
  File f = new File(name + day + ".txt");
  while (f.exists()) {
    day++;
  }
  // Create a new file in the sketch directory
  output = createWriter(name + day + ".txt"); 
}

void edit() {
  reader = createReader("journalentry1.txt"); 
  try {
    while (temp != null) {
      temp = reader.readLine();
      if (temp != null) {
        lines += temp + "\n";
      }
    }
  } catch (IOException e) {
    e.printStackTrace();
    lines = null;
  }
  if (lines == null) {
    // Stop reading because of an error or file is empty
    noLoop();  
  } else {
    text(lines,50,90);
  }
}

void keyPressed() {
  if (key == ENTER) {
    write();
  }
  if (key == BACKSPACE) {
    edit();
  }
  if (key == ESC) {
    try{
    output.println(data);
    output.flush(); // Writes the remaining data to the file
    output.close(); // Finishes the file
    }
    catch (Exception e) {
    exit(); // Stops the program
    }
  }
  else {
    data += key;
  }
}