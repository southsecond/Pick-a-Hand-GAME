
import processing.video.*;
import processing.serial.*; 
import processing.opengl.*;


Serial myPort; 



PFont myFont;     
String inString;
String oldStr;

boolean ganhou;
boolean jogoActivo;

boolean ESQ, DTA;
int tempoVideo;

Movie loopEsq, loopDta, vazDta, vazEsq, corDta1, corEsq1;

int duraVAZesq;


void setup() {

  size(640, 240);
  //frame.setResizable(true);
  frameRate(5);
  myFont = loadFont("Times-Bold-48.vlw"); 
  textFont(myFont, 18);

  println(Serial.list()); 
  myPort = new Serial(this, Serial.list()[3], 9600);


  loopEsq = new Movie(this, "loopEsq.mp4");
  loopDta = new Movie(this, "loopDta.mp4");
  vazDta = new Movie(this, "vazDta.mp4");
  vazEsq = new Movie(this, "vazEsq.mp4");
  corDta1 = new Movie(this, "corDta1.mp4");
  corEsq1 = new Movie(this, "corEsq1.mp4");



  background(0);



  playVideos(false);
  jogoActivo = true;
}

void movieEvent(Movie m) {
  m.read();
}

void draw() {

  if (jogoActivo == true) {
    vazEsq.stop();
    vazDta.stop();
    corDta1.stop();
    corEsq1.stop(); 
    loopEsq.loop();
    loopDta.loop();
    image(loopEsq, 0, 0, width/2, height);
    image(loopDta, width/2, 0, width/2, height);
  } else {

    loopEsq.stop();
    loopDta.stop();
    vazEsq.loop();
    vazDta.loop();
    corDta1.loop();
    corEsq1.loop();
  }
}


void serialEvent(Serial p) { 
  inString = p.readStringUntil('\n');
  if (jogoActivo == true) { 
    if (inString != null) {

      inString = trim(inString);
      if (inString.equals(oldStr)) {
      } else {
        oldStr = inString;
        playVideos(false); 
        println(inString);
        if (inString.equals("0")) {
          ESQ = false;
          DTA = false;
          jogoActivo = true;
        } else if (inString.equals("1")) {
          sorteia();
          ESQ = true;
          DTA = false;
          jogoActivo = false;
        } else if (inString.equals("2")) {
          sorteia();
          DTA = true;
          ESQ = false;
          jogoActivo = false;
        }
      }
    }
  }
  if (jogoActivo == false) {

    background(0);
    playVideos(true);
  }
} 

// Ganhou ou Perdeu?
void sorteia() {

  int decisao = int(random(8));
  if (decisao ==1 || decisao ==3) {
    ganhou = true;
  } else {
    ganhou = false;
  }
}



// liga videos e prende o jogo até ao resultado
void playVideos (boolean tipo) {

  if (tipo == true) {

    if (ganhou == true) {

      if (DTA == true) {
        image(vazEsq, 0, 0, width/2, height);
        image(corDta1, width/2, 0, width/2, height);
        delay(6000);
      } else if (ESQ == true) {
        image(corEsq1, 0, 0, width/2, height);
        image(vazDta, width/2, 0, width/2, height);
        delay(6000);
      }
    } else if (ganhou == false) {

      if (DTA ==true) {
        image(corEsq1, 0, 0, width/2, height);
        image(vazDta, width/2, 0, width/2, height);
        delay(6000);
      } else if (ESQ ==true) {
        image(vazEsq, 0, 0, width/2, height);
        image(corDta1, width/2, 0, width/2, height);
        delay(6000);
      }
    }

    background(0);
    ESQ = false;
    DTA = false;
    tipo = false;
    jogoActivo = true;
  }
  if (tipo == false) {
  }
}


void delay(int delay) {

  int time = millis();
  while (millis () - time <= delay);
}


