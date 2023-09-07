JSONObject json;
int vOffset = 20;

void setup() {
  size(1000, 1000);
  json = loadJSONObject("http://localhost:8080/nowplaying.json"); //the php script gets serato data on a local server
  textFont(createFont("Arial", 16));
  fill(255);
}

void draw() {
  background(0);
  if (json.size() < 1) return;
  displaySeratoValues(json);
}

void mousePressed() {
  json = loadJSONObject("http://localhost:8080/nowplaying.json"); //update serato data
  printArray(json.keys()); //to console
}

void displaySeratoValues(JSONObject jsonObject) {
  int vDist = vOffset;
  for (Object obj : jsonObject.keys()) {
    int hDist = 0;
    String property = obj.toString() + ": ";
    if (!property.startsWith("UNKNOWN")) {
      fill(255, 0, 0);
      text(property, hDist, vDist); //red label
      hDist += textWidth(property); //step across for val
      String val = json.get(obj.toString()).toString();
      fill(255);//white text for vals
      text(val, hDist, vDist);
      vDist += 32; //step down for next obj
    }
  }
}
