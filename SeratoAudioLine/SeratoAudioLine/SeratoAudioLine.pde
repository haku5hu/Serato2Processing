import javax.sound.sampled.*;
import java.io.ByteArrayOutputStream;
import java.io.AudioInputStream;
import java.io.ByteArrayInputStream;

void setup() {
  // Open the virtual audio cable
  Mixer.Info[] mixerInfos = AudioSystem.getMixerInfo();
  Mixer mixer = null;
  for (Mixer.Info info : mixerInfos) {
    //println(info.getName());
    //pulling the 'output'? how do I tell if its an input or output
    if (info.getName().equals("Line 1 (Virtual Audio Cable)")) {
      mixer = AudioSystem.getMixer(info);
      println("connected vac");
      //break;
      //printArray(AudioSystem.getLine(info));
    }
  }

  if (mixer == null) {
    println("Virtual Audio Cable not found!");
    return;
  }

  //DataLine.Info dataLineInfo = new DataLine.Info(getSourceLineInfo.class, null);
  AudioFormat audioFormat = new AudioFormat(44100, 16, 1, true, true);
  DataLine.Info dataLineInfo = new DataLine.Info(TargetDataLine.class, audioFormat);
  try {
    println("chk2");
    final int bufferSize = 2200; // in Bytes
    TargetDataLine tLine = (TargetDataLine) mixer.getLine(dataLineInfo);
    tLine.open(audioFormat, bufferSize);

    int frameSizeInBytes = audioFormat.getFrameSize();
    int bufferLengthInFrames = tLine.getBufferSize() / 8;
    final int bufferLengthInBytes = bufferLengthInFrames * frameSizeInBytes;
    buildByteOutputStream(out, line, frameSizeInBytes, bufferLengthInBytes);
    this.audioInputStream = new AudioInputStream(line);

    setAudioInputStream(convertToAudioIStream(out, frameSizeInBytes));
    audioInputStream.reset();

    tLine.start();
    byte counter = 0;
    final byte[] buffer = new byte[bufferSize];
    byte sign = 1;
    while (true) {
      int threshold = (int)audioFormat.getFrameRate();
      for (int i = 0; i < bufferSize; i++) {
        if (counter > threshold) {
          sign = (byte) -sign;
          counter = 0;
        }
        buffer[i] = (byte) (sign * 30);
        counter++;
        if (counter == 0) {
          println(buffer[32]);
        }
      }
    }
  }
  catch (LineUnavailableException e) {
    e.printStackTrace();
  }
}

void buildByteOutputStream(final ByteArrayOutputStream out, final TargetDataLine line, int frameSizeInBytes, final int bufferLengthInBytes) throws IOException {
  final byte[] data = new byte[bufferLengthInBytes];
  int numBytesRead;

  line.start();
  while (thread != null) {
    if ((numBytesRead = line.read(data, 0, bufferLengthInBytes)) == -1) {
      break;
    }
    out.write(data, 0, numBytesRead);
  }
}
AudioInputStream convertToAudioIStream(final ByteArrayOutputStream out, int frameSizeInBytes) {
  byte audioBytes[] = out.toByteArray();
  ByteArrayInputStream bais = new ByteArrayInputStream(audioBytes);
  AudioInputStream audioStream = new AudioInputStream(bais, format, audioBytes.length / frameSizeInBytes);
  long milliseconds = (long) ((audioInputStream.getFrameLength() * 1000) / format.getFrameRate());
  duration = milliseconds / 1000.0;
  return audioStream;
}

// Set up the data line info for capturing audio
//DataLine.Info dataLineInfo = new DataLine.Info(TargetDataLine.class, null);
////AudioFormat audioFormat = new AudioFormat(48000, 16, 1, true, true);
//DataLine.Info dataLineInfo = new DataLine.Info(TargetDataLine.class, audioFormat);

//  printArray(dataLineInfo.getFormats());
//  // Open the data line for capturing audio
//  try {
//    TargetDataLine targetDataLine = (TargetDataLine) mixer.getLine(dataLineInfo);
//    targetDataLine.open(audioFormat);
//    targetDataLine.start();
//  }
//  catch (LineUnavailableException e) {
//    e.printStackTrace();
//  }
//  //Get available audio formats
//  AudioFormat[] formats = ((DataLine.Info) dataLineInfo).getFormats();

//  //println(formats[0]);

//  // Choose the first available format
//  //AudioFormat audioFormat = formats[0];
//  //println(audioFormat.getSampleRate());

//  // Open the data line for capturing audio


//  //// Set up the audio format for capturing audio data

//  //DataLine.Info dataLineInfo = new DataLine.Info(TargetDataLine.class, audioFormat);

//  //// Open the data line for capturing audio
//  //try{
//  //TargetDataLine targetDataLine = (TargetDataLine) mixer.getLine(dataLineInfo);
//  //targetDataLine.open(audioFormat);
//  //targetDataLine.start();
//  //} catch (LineUnavailableException e) {
//  //e.printStackTrace();
//}
