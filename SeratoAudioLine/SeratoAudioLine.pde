import beads.*;

AudioContext fromSerato; //virtural hardware connection
AudioContext toSpeakers; //physical hardware connection
Gain g;                  //audio signal chain
BiquadFilter f;
Glide gGlide, fGlide;    //rt control on signal chain

int bars; //visual feedback of audio frame
int audioChunk; //divide the audio frame into chunks

//JSONObject json;

void setup() {
  //drawing
  size(500, 500);
  frameRate(24);
  rectMode(CENTER);
  noStroke();

  //separate interfaces for different hardware
  JavaSoundAudioIO jSoundInput = new JavaSoundAudioIO(4096); //should be a Capture/TargetDataLine
  JavaSoundAudioIO jSoundOutput = new JavaSoundAudioIO(4096); //should be SourceDataLine

  //jSoundInput.printMixerInfo(); exit();//uncomment to find interfaces on this computer

  //for on laptop
  jSoundInput.selectMixer(10); //JavaSoundAudioIO: Chosen mixer is Line 1 (Virtual Audio Cable).
  jSoundInput.selectMixer(9); //JavaSoundAudioIO: Chosen mixer is Line 1 (Virtual Audio Cable).


  //jSoundInput.selectMixer(21); //JavaSoundAudioIO: Chosen mixer is Line 1 (Virtual Audio Cable).
  //jSoundOutput.selectMixer(22); //JavaSoundAudioIO: Chosen mixer is Output 1/2 (2- Audient iD14).

  IOAudioFormat ioFormat = new IOAudioFormat(44100, 16, 1, 1); //same format for virtual/real audio interfaces

  fromSerato = new AudioContext(jSoundInput, 4096, ioFormat);  //getting from Virtual Audio Cable
  toSpeakers = new AudioContext(jSoundOutput, 4096, ioFormat); //going to physical audio interface

  //signal chain
  UGen lineFromSerato = fromSerato.getAudioInput(); //read from Virtual Audio Cable
  gGlide = new Glide(toSpeakers, 1, 10f); //control gain -> updates in draw loop but slides at audio rate with 10ms latency
  fGlide = new Glide(toSpeakers, 1, 10f); //control lp cutoff

  g = new Gain(toSpeakers, 1, gGlide);    //UGens in toSpeakers context
  f = new BiquadFilter(toSpeakers, 1, BiquadFilter.LP);
  f.setQ(1).setFrequency(fGlide);         //cant case this constructor for whatever reason

  g.addInput(lineFromSerato);             //connect em
  f.addInput(g);
  toSpeakers.out.addInput(f);             //pass from virtual to physical hardware

  fromSerato.start();
  toSpeakers.start();

  //audio-visual
  bars = 10;
  audioChunk = toSpeakers.getBufferSize() / bars;

  //text from php scrobbler
  //json = loadJSONObject("http://localhost:8080/nowplaying.json"); //the php script gets serato data on a local server
  textFont(createFont("Arial", 16));
}

void draw() {
  //bg
  fill(0, 40);
  rect(width/2, height/2, width, height);

  if (frameCount % 5 == 0) drawBars();
  updateAudioFromDrawLoop();
  //displaySeratoValues(json);
}

void drawBars() {

  for (int i = 0; i < bars; i++) { //average audio frame into each bar
    float averageForThisBar = 0;
    for (int j = 0; j < audioChunk; j++) { //draw bars off buffer frame
      float sampleAmplitude = ((toSpeakers.out.getValue(0, j + i * audioChunk)));
      averageForThisBar += sampleAmplitude;
    }
    averageForThisBar /= audioChunk;

    fill(255);//draw bars using the average for the last audioChunk samples in the audio buffer
    rect((width/bars * 0.5) + width/bars * i, height/2, 10, averageForThisBar * height * 0.5);
  }
}

void displaySeratoValues(JSONObject jsonObject) {
  //int vDist = 20;
  //for (Object obj : jsonObject.keys()) {
  //  int hDist = 0;
  //  String property = obj.toString() + ": ";
  //  if (!property.startsWith("UNKNOWN")) {
  //    fill(255, 0, 0);
  //    text(property, hDist, vDist); //red label
  //    hDist += textWidth(property); //step across for val
  //    String val = json.get(obj.toString()).toString();
  //    fill(255);//white text for vals
  //    text(val, hDist, vDist);
  //    vDist += 32; //step down for next obj
  //  }
  //}
}

void updateAudioFromDrawLoop() {
  if (pmouseX == mouseX && pmouseY == mouseY) return; //bail if mouse is still
  gGlide.setValue((float)mouseX/width); //otherwise update audio
  fGlide.setValue(20+((float)mouseY/height * 5000));
}
