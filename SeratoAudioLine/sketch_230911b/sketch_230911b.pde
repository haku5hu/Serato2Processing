import javax.sound.sampled.*;
void setup() {

  // Open the virtual audio cable
  Mixer.Info[] mixerInfos = AudioSystem.getMixerInfo();
  Mixer mixer = null;
  for (Mixer.Info info : mixerInfos) {
    println(info.getName());
    if (info.getName().equalsIgnoreCase("Output 1/2 (2- Audient iD14)"));
    mixer = AudioSystem.getMixer(info);
    println("connected vac");
    //if (info.getName().equalsIgnoreCase("Line 1 (Virtual Audio Cable)"));
    //mixer = AudioSystem.getMixer(info);
    //println("connected vac");
    break;
  }

  if (mixer == null) {
    println("Virtual Audio Cable not found!");
    return;
  }

  Mixer.Info m = mixer.getMixerInfo();
  println(m.getName());
  TargetDataLine.Info l = mixer.();
  println(l.());

  // Set up the data line info for capturing audio
  //DataLine.Info dataLineInfo = new DataLine.Info(TargetDataLine.class, null);
  AudioFormat audioFormat = new AudioFormat(44100, 16, 2, true, true);
  DataLine.Info dataLineInfo = new DataLine.Info(TargetDataLine.class, audioFormat);

  // Open the data line for capturing audio
  try {
    TargetDataLine targetDataLine = (TargetDataLine) mixer.getLine(dataLineInfo);
    targetDataLine.open(audioFormat);
    targetDataLine.start();
  }
  catch (LineUnavailableException e) {
    e.printStackTrace();
  }
  // Get available audio formats
  //AudioFormat[] formats = ((DataLine.Info) dataLineInfo).getFormats();

  //println(formats[0]);

  // Choose the first available format
  //AudioFormat audioFormat = formats[0];
  //println(audioFormat.getSampleRate());

  // Open the data line for capturing audio


  //// Set up the audio format for capturing audio data

  //DataLine.Info dataLineInfo = new DataLine.Info(TargetDataLine.class, audioFormat);

  //// Open the data line for capturing audio
  //try{
  //TargetDataLine targetDataLine = (TargetDataLine) mixer.getLine(dataLineInfo);
  //targetDataLine.open(audioFormat);
  //targetDataLine.start();
  //} catch (LineUnavailableException e) {
  //e.printStackTrace();
  //}
}
