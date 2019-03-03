void playButton_handler(GButton source, GEvent event) {
  if (complete)
    thread("play");
}

void varySpeedCheckbox_handler(GCheckbox source, GEvent event) {
  switch(event) {
  default:
    if (source.isSelected())
      myMorse.setSpeed(random(100, 200));
    break;
  }
}

void varyFreqCheckbox_handler(GCheckbox source, GEvent event) {
  switch(event) {
  default:
    if (source.isSelected())
      myMorse.setFreq(int(random(800.0, 1100.0)));
    break;
  }
}

void phraseField_handler(GTextField source, GEvent event) {
  switch(event) {
  case GETS_FOCUS:
    break;
  case CHANGED:
    break;
  case ENTERED:
    if (complete)
      thread("play");
    break;
  default:
    break;
  }
}

void speedSlider_handler(GSlider source, GEvent event) {
  myMorse.setSpeed(source.getValueF());
}

void freqSlider_handler(GSlider source, GEvent event) {
  myMorse.setFreq(source.getValueI());
}