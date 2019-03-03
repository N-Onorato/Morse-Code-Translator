import g4p_controls.*; //GUI Library //<>//
import processing.sound.*; //Sound Library

//Global Variables
Sound sound;
SinOsc osc;
Morse myMorse;
float ratio = 1.0;
Boolean varyFrequency = false;
Boolean varySpeed = false;
Boolean complete = true;

//DeclareGUI
GButton playButton;
GCheckbox varySpeedCheckbox;
GSlider speedSlider;
GCheckbox varyFreqCheckbox;
GSlider freqSlider;
GTextField phraseField;

void settings() {
  if (displayDensity() == 1)
    ratio = 2.2;
  size(int(380 * ratio), int(160 * ratio));
}

void setup() {
  size(380, 160);
  smooth(4);
  pixelDensity(displayDensity());
  G4P.setMouseOverEnabled(false);
  frameRate(60);
  background(0);
  textSize(12*ratio);

  //Initialize logic;
  osc = new SinOsc(this);
  myMorse = new Morse();

  //Initialize GUI
  G4P.setGlobalColorScheme(8);


  //Define the GUI
  playButton = new GButton(this, 320.0 * ratio, 15.0 * ratio, 45.0 * ratio, 35.0 * ratio, "PLAY");
  playButton.addEventHandler(this, "playButton_handler");
  StyledString buttonStyle = new StyledString("Play");
  buttonStyle.addAttribute(G4P.SIZE, int(11*ratio));
  buttonStyle.addAttribute(G4P.WEIGHT, G4P.WEIGHT_BOLD);
  playButton.setStyledText(buttonStyle);

  varySpeedCheckbox = new GCheckbox(this, 20.0 * ratio, 65.0 * ratio, 150.0 * ratio, 20.0 * ratio, "Random Speed");
  varySpeedCheckbox.addEventHandler(this, "varySpeedCheckbox_handler");
  StyledString varySpeedStyle = new StyledString("Random Speed");
  varySpeedStyle.addAttribute(G4P.SIZE, int(11*ratio));
  varySpeedStyle.addAttribute(G4P.WEIGHT, G4P.WEIGHT_REGULAR);
  varyFreqCheckbox = new GCheckbox(this, 20.0 * ratio, 115.0 * ratio, 150.0 * ratio, 20.0 * ratio, "Random Frequency");
  varyFreqCheckbox.addEventHandler(this, "varyFreqCheckbox_handler");
  StyledString varyFreqStyle = new StyledString("Random Frequency");
  varyFreqStyle.addAttribute(G4P.SIZE, int(11*ratio));
  varyFreqStyle.addAttribute(G4P.WEIGHT, G4P.WEIGHT_REGULAR);

  speedSlider = new GSlider(this, 150 * ratio, 35 * ratio, 200 * ratio, 80 * ratio, 8.0 * ratio);
  speedSlider.addEventHandler(this, "speedSlider_handler");
  speedSlider.setShowLimits(true);
  speedSlider.setShowValue(true);
  speedSlider.setUnits("ms");
  speedSlider.setLimits(150, 220, 80);
  speedSlider.setNbrTicks(10);
  speedSlider.setShowTicks(true);

  freqSlider = new GSlider(this, 150 * ratio, 85 * ratio, 200 * ratio, 80 * ratio, 8.0 * ratio);
  freqSlider.addEventHandler(this, "freqSlider_handler");
  freqSlider.setLimits(950, 700, 1200);
  freqSlider.setUnits("Hz");
  freqSlider.setNbrTicks(10);
  freqSlider.setShowTicks(true);
  freqSlider.setShowDecor(false, true, true, true);

  phraseField = new GTextField(this, 15.0 * ratio, 15.0 * ratio, 300 * ratio, 35 * ratio, G4P.SCROLLBARS_NONE);
  phraseField.addEventHandler(this, "phraseField_handler");
  StyledString phraseStyle = new StyledString("");
  phraseStyle.addAttribute(G4P.SIZE, int(11*ratio));
  phraseStyle.addAttribute(G4P.WEIGHT, G4P.WEIGHT_REGULAR);
}

void play() {
  complete = false;
  myMorse.play(phraseField.getText(), osc);
  complete = true;
}

void draw() {
  background(0);
}
