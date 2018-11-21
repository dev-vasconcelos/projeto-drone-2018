String test[3];
bool flag = false;
int count = 0;
int motor, vel;
void setup() {
  Serial.begin(9600);
}

void loop() {
  int r = Serial.read();
 
  if(r > 47 && r < 58 ){
    vel = map(r, 48, 57, 0, 9);
  }else if(r != -1 && r != 10){
    motor = r;
  }
  if (vel != 0 && r!= -1){
    Serial.print("velocidade");
    Serial.print(vel);
    Serial.print("motor:");
    Serial.print(motor);
    vel = 0;
    motor = 0;
  }
}
