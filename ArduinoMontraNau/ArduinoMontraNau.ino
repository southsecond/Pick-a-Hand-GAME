//Montra da NAU
//O joguinho das maos com as bolas e carago


int maoEsq = 0;
int butEsq = A0;
int maoDir = 0;
int butDir = A2;

void setup() {

  Serial.begin(9600);
}


void loop() {

  maoEsq = analogRead(butEsq);
  maoDir = analogRead(butDir);
  
  if (maoEsq == 0 && maoDir != 0) {
  Serial.println(1);
  }
  
  else if (maoDir == 0 && maoEsq != 0) {
  
  Serial.println(2);
  }
  
  else {
  Serial.println(0);
  
  }
  delay(150);
  
}
