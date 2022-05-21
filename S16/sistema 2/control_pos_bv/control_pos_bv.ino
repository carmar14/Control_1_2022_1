#include <DueTimer.h>
//Se definen las variables que se usarán en el programa
// Contador de muestras
double Samples = 0;
// Tiempo de muestreo para realizar cambios automáticamente
double Ts = 0.005; //0.05;
//---------------cantidad de muestras para hacer cambios de referencia---
double cambios = 20 / Ts;

//------------controlador a implementar------------

//----------ecuación en diferencia-------------
//u(k)-u(k-1)=K_p (e(k)-e(k-1)+T_D  (e(k)-2e(k-1)+e(k-2))/T+T/T_i  e(k))
//accion de control u(k)
double uk = 0;
//accion de control pasada u(k-1)
double uk1 = 0;
//erro actual e(k)
double ek = 0;
//error pasado e(k-1)
double ek1 = 0;
//error pasado e(k-2)
double ek2 = 0;
double yk = 0;

double K_p = -208.7489;
double T_D = 0.4040;
double T_i = 0.7810;
double T = Ts;

//referencia
double rk = 0;

unsigned long tiempo1 = 0;
unsigned long tiempo2 = 0;

//-----------implementación del controlador-----------
void controlador() {
  //----------referencia----------
  Samples = Samples + 1;

  // Si el contador de muestras es 1 (uno) se modifica la entrada al sistema generando un número randómico
  if (Samples == 1)
  {
    //Se genera un número randómico entre -5 y 5
    rk = 0.05;//random(-5, 5);
  }

  // Si el contador de muestras supera un valor se resetea el contador para que se vuelva a generar una nueva entrada
  if (Samples > cambios)
  {
    Samples = 0;
  }

  //-----------medir la variable del proceso-------
  //-------normalmente mediante un ADC-------------
  //----------aqui se recibirá por Serial-----------
  //------por efecto de emular la planta en matlab--
  while(Serial.available() > 0) {
    String str = Serial.readStringUntil('\n');
    yk = str.toFloat();
  }

  
  //-------calcular el error actual----

  ek = rk - yk;
  //---------calcular acción de control---
  uk = K_p * (ek - ek1 + T_D * (ek - 2 * ek1 + ek2) / T + (T / T_i) * ek) + uk1;

  //---------actualizo valores-----------

  uk1 = uk;
  ek2 = ek1;
  ek1 = ek;
  //-----generar la salida hacia la planta---
  //-------normalmente mediante un DAC-------
  Serial.print(uk);
  Serial.print(',');
  Serial.print(rk);
  Serial.print('\n');



}

void setup() {
  Serial.begin(115200);
  //Timer2.attachInterrupt(controlador);
  //Timer3.start(50000); // Calls every 50ms
  //Timer2.start(50000);
}

void loop() {

  while (1) {
    
    controlador();
    delay(Ts * 1000);
    //delay(Ts);
  }


}
