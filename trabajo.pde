import ddf.minim.*;
Minim minim;
AudioPlayer player;
float volumer;
float volumel;
float volume;
float n;
float b;
float c;
float d;
boolean mute = false;
int posx;
int posy;
String cancion;
String[][] canciones = {{"1.mp3","Daft Punk - Harder Better Faster"},{"2.mp3","Los Wachiturros - Tirate un paso"},{"3.mp3","Daddy Yankee - Llamado de emergencia"},{"4.mp3","The Black Eyed Peas - Let's Get It Started"},{"5.mp3","Darude - Sandstorm"}};
int i;
PImage fondo; //imagen fondo
ArrayList<Figura> objetos; //lista con todos los ellipse
void setup() {
  background(0,0,0);
  size(1000,770);
  minim=new Minim(this);
  player=minim.loadFile("1.mp3");//carga del archivo
  player.play();//reproducción del archivo
  objetos = new ArrayList<Figura>(); //creamos una lista
  fondo = loadImage("guide1.png"); //carga de la foto
  i = 0;
  posx = 0;
  posy = 675;
  cancion = canciones[0][1];
}
void draw(){
  background(0); //fondo negro
  n=n+1; //no borrar, es un contador
  b=n%1;//controla la velocidad a la cual se forman las figuras
  c=n%2;//controla la velocidad a la cual desaparecen las figuras
  d=n%3;
  if (b==0 && mute==false){
    volumer = player.right.level();
    volumel = player.left.level();
    volume = (volumer + volumel/2);
    objetos.add(new Figura(mouseX, mouseY, volume*700)); //creamos elipse y la añadimos a la lista
    for (Figura f : objetos){
      f.display(); //mostramos cada elipse guardada en la lista
  }
  }
  if (c == 0 && mute==false){
    objetos.remove(0); //eliminamos el primer elemento de la lista (elipse más antigua)
  }
  if (d == 0 && mute==false){
    objetos.remove(0); //eliminamos el primer elemento de la lista (elipse más antigua)
  }
fill(0,0,0);
rect(0,657,1000,25);
textSize(18);
fill(255,255,255);
text("Reproduciendo:"+cancion,posx,posy);
posx=posx+2;
if (posx > 1000){
  posx = -100;
}
image(fondo, 0, 0);
fondo.resize(1000,770); //configuramos tamaño
}

void mouseClicked(){
  if(mouseX < 450 && mouseX > 430){ //Cambiamos cancion al hacer click en siguiente
    if(mouseY > 700 && mouseY < 730){
      if(i==4){
        i = 0;
      }
      i += 1;
      player.pause();
      player=minim.loadFile(canciones[i][0]);
      cancion=canciones[i][1];
      player.play();
      objetos = new ArrayList<Figura>();
    }
  }  if(mouseX < 375 && mouseX > 355){ //Cambiamos cancion al hacer click en anterior
    if(mouseY > 700 && mouseY < 730){
      if(i==0){
        i = 4;
      }
      i -= 1;
      player.pause();
      player=minim.loadFile(canciones[i][0]);
      cancion=canciones[i][1];
      player.play();
      objetos = new ArrayList<Figura>();
    }
  }
  if(mouseX > 240 && mouseX < 260){ //Jugar con volumen (mutear y desmutear al clickear signo)
    if(mouseY > 700 && mouseY < 730){
      println(mute);
      if (mute == true){
        player.unmute();
        mute = false;
      } else {   
        player.mute();
        objetos = new ArrayList<Figura>();
        mute = true;
      }
    }
  }
}

class Figura { //Clase que crea las elipses
  
  int posx;
  int posy;
  float ancho;
  float largo;
  
  Figura(int x, int y, float vol) { //asignamos variables
    posx = x;
    posy = y;
    ancho = vol;
    largo = vol;
  }
  
  void display() { //funcion que muestra la elipse
    strokeWeight(2);
    stroke(random(255),random(255),random(255));
    fill(0,0,0,0);
    ellipse(posx,posy,ancho,largo); //creamos elipse
  }
}
