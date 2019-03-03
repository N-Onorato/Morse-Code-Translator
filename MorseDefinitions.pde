class Morse { //<>//
  //Declare Variables
  StringDict encoding;
  StringDict decoding;

  String english;
  String morseCode;
  String translation;

  float speed = 150;
  float frequency = 900.0;
  
  //Initialize StringDicsts so I can convert between alphanumeric and morse.
  Morse() {
    
    
    encoding = new StringDict();
    encoding.set("a", ".-");
    encoding.set("b", "-...");
    encoding.set("c", "-.-.");
    encoding.set("d", "-..");
    encoding.set("e", ".");
    encoding.set("f", "..-.");
    encoding.set("g", "--.");
    encoding.set("h", "....");
    encoding.set("i", "..");
    encoding.set("j", ".---");
    encoding.set("k", "-.-");
    encoding.set("l", ".-..");
    encoding.set("m", "--");
    encoding.set("n", "-.");
    encoding.set("o", "---");
    encoding.set("p", ".--.");
    encoding.set("q", "--.-");
    encoding.set("r", ".-.");
    encoding.set("s", "...");
    encoding.set("t", "-");
    encoding.set("u", "..-");
    encoding.set("v", "...-");
    encoding.set("w", ".--");
    encoding.set("x", "-..-");
    encoding.set("y", "-.--");
    encoding.set("z", "--..");
    encoding.set("0", "-----");
    encoding.set("1", ".----");
    encoding.set("2", "..---");
    encoding.set("3", "...--");
    encoding.set("4", "....-");
    encoding.set("5", ".....");
    encoding.set("6", "-....");
    encoding.set("7", "--...");
    encoding.set("8", "---..");
    encoding.set("9", "----.");
    encoding.set(".", ".-.-.-");
    encoding.set("?", "..--..");
    encoding.set("+", ".-.-.");
    encoding.set("-", "-....-");
    encoding.set("/", "-..-.");
    encoding.set("'", ".----.");
    encoding.set(" ", "  ");

    decoding = new StringDict();
    decoding.set(".-", "a");
    decoding.set("-...", "b");
    decoding.set("-.-.", "c");
    decoding.set("-..", "d");
    decoding.set(".", "e");
    decoding.set("..-.", "f");
    decoding.set("--.", "g");
    decoding.set("....", "h");
    decoding.set("..", "i");
    decoding.set(".---", "j");
    decoding.set("-.-", "k");
    decoding.set(".-..", "l");
    decoding.set("--", "m");
    decoding.set("-.", "n");
    decoding.set("---", "o");
    decoding.set(".--.", "p");
    decoding.set("--.-", "q");
    decoding.set(".-.", "r");
    decoding.set("...", "s");
    decoding.set("-", "t");
    decoding.set("..-", "u");
    decoding.set("...-", "v");
    decoding.set(".--", "w");
    decoding.set("-..-", "x");
    decoding.set("-.--", "y");
    decoding.set("--..", "z");
    decoding.set("-----", "0");
    decoding.set(".----", "1");
    decoding.set("..---", "2");
    decoding.set("...--", "3");
    decoding.set("....-", "4");
    decoding.set(".....", "5");
    decoding.set("-....", "6");
    decoding.set("--...", "7");
    decoding.set("---..", "8");
    decoding.set("----.", "9");
    decoding.set(".-.-.-", ".");
    decoding.set("..--..", "?");
    decoding.set(".-.-.", "+");
    decoding.set("-....-", "-");
    decoding.set("-..-.", "/");
    decoding.set(".----.", "'");
    decoding.set(" ", "");
  }
  
  void setSpeed(float s) {
    speed = s;
  }
  
  void setFreq(int freq) {
    frequency = freq;
  }
  
  String encode(String eng) {
    eng = eng.toLowerCase();
    morseCode = "";
    String characterKey;
    for (int i = 0; i < eng.length(); i++) {
      characterKey = str(eng.charAt(i));
      if (encoding.hasKey(characterKey))
        morseCode += encoding.get(characterKey) + " ";
      else
        morseCode += "KeyNotFound";
    }
    return morseCode;
  }


  String decode(String morse) {
    String eng = "";
    int index = 0;
    String Key = "";
    int next = morse.indexOf(" ", index+1);
    int nextSpace = morse.indexOf("   ", index+1);

    while (next != -1) {
      Key = ""; //Reset key to a blank.
      //Goes from index to next and writes key.
      while (index < next) {
        Key += morse.charAt(index);
        index++;
      }

      if (morse.indexOf(" ", index+1) - next > 1) {
        index++;
      }

      next = morse.indexOf(" ", index+1); //Get next space location

      if (index-1 == nextSpace) {
        eng += " ";
        nextSpace = morse.indexOf("   ", index+1);
      }  

      //Use key to write character.
      if (decoding.hasKey(Key)) {
        eng += decoding.get(Key);
      } else {
        eng += "KeyNotFound";
        print("DecodingError: KeyNotFound\n");
      }
    }
    english = eng;
    return eng;
  }

  String trans(String morse) {
    String trans = "";
    int index = 1;
    int before = 0;
    if (morse.length() < 1)
      return "e^r^r^o^r";
    else
      trans += morse.charAt(before);
    for (index = 1; index < morse.length() -1; ) {
      if (morse.charAt(before) != ' ' && morse.charAt(index) != ' ') { //Both Characters
        trans += "^" + str(morse.charAt(index));
        index++;
        before++;
      } else if (morse.charAt(before) != ' ' && morse.charAt(index) == ' ') { //Character & Space
        trans += "#";
        index++;
        before++;
      } else if (morse.charAt(before) == ' ' && morse.charAt(index) == ' ' && morse.charAt(index+1) == ' ' && morse.charAt(index+2) == ' ') {
        trans += "~";
        index += 3;
        before += 3;
      } else {
        trans += str(morse.charAt(index)); //Space & Character
        index++;
        before++;
      }
    }
    print("\n");
    translation = trans;
    return trans;
  }

  void play(String trans, SinOsc osc) {
    if(trans.length() == 0)
      return;
    if (trans.indexOf("^", 0) == -1) //<>//
      trans(encode(trans));
      
    osc.amp(0.0001);
    osc.freq(frequency);
    osc.play();
    delay(1000);
    for (int i = 0; i < translation.length(); i++) {
      print(translation.charAt(i), " ");
      switch(translation.charAt(i)) {
      case '.':
        osc.amp(1.0);
        delay(int(speed));
        osc.amp(0.0001);
        break;
      case '-':
        osc.amp(1.0);
        delay(int(speed*3));
        osc.amp(0.0001);
        break;
      case '^':
        delay(int(speed));
        break;
      case '#':
        delay(int(speed * 3));
        break;
      case '~':
        delay(int(speed * 7));
        break;
      }
    }
    osc.stop();
  }
}