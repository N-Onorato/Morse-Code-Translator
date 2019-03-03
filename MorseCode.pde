import processing.sound.*;
Sound sound;
SinOsc osc;


//------OPTIONS--------
String phrase = "Hello";
Boolean varyFrequency = false;
Boolean varySpeed = false;
//----------------------


Morse myMorse;

//An enum to help the finite state machine work.
public enum states {
  MAINMENU, 
    TRANSCRIBING, 
    TRANSMITTING
}
states state;

String encoded;
String decoded;
String trans;


void setup() {
  size(400, 400);
  background(0);
  frameRate(5);
  
  state = states.MAINMENU;
  
  osc = new SinOsc(this);
  myMorse = new Morse(); 
}

void draw() {
  switch(state) {
    case MAINMENU:
      //////////////
      break;
    case TRANSCRIBING:
      /////////////
      break;
    case TRANSMITTING:
      ////////////
      break;
    
    
  }

}

void mouseClicked() {
    if(varyFrequency)
      myMorse.setFreq(int(random(800.0, 1100.0)));
    if(varySpeed)
      myMorse.setSpeed(random(100, 200));
    myMorse.play(phrase, osc);
}
