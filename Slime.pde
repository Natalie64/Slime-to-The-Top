class Slime {
  
  float radius = 25;
  int startRadius = 25;
  PVector pos = new PVector();  //position
  float speed = 125; //pixels per second
  float start = 2;    //starting position
  PImage sprite;
  boolean crowned = false;
  boolean armed = false;
  
  Slime(){ 
    pos.x = width/start;
    pos.y = height/start;
    sprite = loadImage("Slime to The Top - Assests/Slime.png");
    sprite.resize(startRadius * 2, startRadius * 2);
  }
  
  void chaseMouse(float dt){
    PVector target = new PVector(mouseX, mouseY);
    PVector diff = PVector.sub(target, pos);
    pos.add(diff.limit(speed * dt));
  }
  
  void grow(float radius){
    this.radius += radius / 2;
    update();
  }
  
  boolean shrink(float dt){
    float stepSize;
    if (crowned && radius >= 15){
      stepSize = 4 * dt;
      radius -= stepSize;
    } else if (radius >= 15){
      stepSize = 6 * dt;
      radius -= stepSize;
    } else {
      return true;
    }
    update();
    return false;
  }
  
  void update(){
    
    if (armed){
      speed = 145;
    } else {
      speed = 125;
    }
    
    if (crowned){
      sprite = loadImage("Slime to The Top - Assests/Slime Crown.png");
      sprite.resize(int(radius * 2),int(radius * 2));
    } else {
      sprite = loadImage("Slime to The Top - Assests/Slime.png");
      if (int(radius * 2) <= 15){
        radius = startRadius;
      }
      sprite.resize(int(radius * 2),int(radius * 2));
    }
    
  }
  
  void reset(){
    pos.x = width/start;
    pos.y = height/start;
    radius = startRadius;
    crowned = false;
    sprite = loadImage("Slime to The Top - Assests/Slime.png");
    sprite.resize(startRadius * 2, startRadius * 2);
  }
  
  void draw(){
    image(sprite, pos.x - radius, pos.y - radius);
  }
  
  PVector getTarget(){
    return pos;
  }
  
}
