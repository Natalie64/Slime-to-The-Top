class Collectable {
  
  int radius;
  PVector pos = new PVector();    //position
  PVector start = new PVector();    //starting position
  PImage sprite;
  boolean collected = false;
  
  Collectable(int radius, float x, float y, String sprite) {
    PVector temp = new PVector();
    temp.x = x;
    temp.y = y;
    create(radius, temp, sprite);
  }
  
  void create(int radius, PVector start, String sprite) {
    this.radius = radius;
    this.start = start;
    pos.x = width/start.x;
    pos.y = height/start.y;
    this.sprite = loadImage(sprite);
    this.sprite.resize(radius * 2, radius * 2);
  }
  
  boolean isCollected(){
    if (!collected){
      
      float dx = slime.pos.x - pos.x;
      float dy = slime.pos.y - pos.y;
      float distance = sqrt((sq(dx)) + sq(dy));
      return distance < slime.radius;
      
    } else {
      return false;
    }
  }
  
  void reset(){
    collected = false;
  }
  
  void draw(){
    if (!collected){
      image(sprite, pos.x - radius, pos.y - radius);
    }
  }
  
}
