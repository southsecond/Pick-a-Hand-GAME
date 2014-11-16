
import processing.video.*;
import processing.serial.*; 
import processing.opengl.*;

Serial myPort; 

PFont myFont;     
String inString;
String oldStr;

boolean ganhou;
boolean esperaJogo;
boolean ESQ, DTA;
boolean tipo;

Animation corEsq, vazEsq, loopEsq, corDta, vazDta, loopDta;

void setup() {
  size(640, 240);
  frameRate(14);

  myFont = loadFont("Times-Bold-48.vlw"); 
  textFont(myFont, 18);

  //Serial com
  println(Serial.list()); 
  myPort = new Serial(this, Serial.list()[3], 9600);

  corEsq = new Animation("corEsq", 21);
  loopEsq = new Animation("loopEsq", 20);
  loopDta = new Animation("loopEsq", 20);
  vazEsq = new Animation("vazEsq", 31);


  //initial states
  background(0);
  tipo = false;
  esperaJogo = true;
}


void draw() {



  if (esperaJogo == false) {

    if (ganhou == true) {

      if (DTA == true) {
        background(0);
        vazEsq.display(0, 0, width/2, height,false);
        corEsq.displayInv(width, 0, width/2, height,true);
        println("Ganhou com Dta");
    
   
      } if (ESQ == true) {
        background(0);
        corEsq.display(0, 0, width/2, height,true);
        vazEsq.displayInv(width, 0, width/2, height,false);
        println("Ganhou com Esq");
  

        
      }
    } else if (ganhou == false) {

      if (DTA ==true) {
        background(0);
        corEsq.display(0, 0, width/2, height,true);
        vazEsq.displayInv(width, 0, width/2, height,false);
        println("Perdeu com Dta");
      

      } else if (ESQ ==true) {
        background(0);
        vazEsq.display(0, 0, width/2, height,false);
        corEsq.displayInv(width, 0, width/2, height,true);
        println("Perdeu com Esq");
        

      }
    }
  
  }
  if (esperaJogo == true) {
    background(0);  
    loopEsq.display(0, 0, width/2, height,true);
    loopDta.displayInv(width, 0, width/2, height,true);
  }
}




void serialEvent(Serial p) { 

  inString = p.readStringUntil('\n');
  if (esperaJogo == true) { 
    if (inString != null) {

      inString = trim(inString);
      if (inString.equals(oldStr)) {
      } else {
        oldStr = inString;
        tipo= false; 
        println(inString);
        if (inString.equals("0")) {
          ESQ = false;
          DTA = false;
          esperaJogo = true;
        } else if (inString.equals("1")) {
          sorteia();
          ESQ = true;
          DTA = false;
          esperaJogo = false;
        } else if (inString.equals("2")) {
          sorteia();
          DTA = true;
          ESQ = false;
          esperaJogo = false;
        }
      }
    }
  }
  if (esperaJogo == false) {

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

void delay(int delay) {

  int time = millis();
  while (millis () - time <= delay);
}

