class EnemySlime {
  
  int radius;
  PVector pos = new PVector();  //position
  float speed; //pixels per second
  PVector start = new PVector();    //starting position
  PImage sprite;
  
  EnemySlime(int radius, float speed, float x, float y, String sprite){ 
    PVector temp = new PVector();
    temp.x = x;
    temp.y = y;
    create(radius, speed, temp, sprite);
  }
  
  void create(int radius, float speed, PVector start, String sprite){ 
    this.radius = radius;
    this.speed = speed;
    this.start = start;
    pos.x = width/start.x;
    pos.y = height/start.y;
    this.sprite = loadImage(sprite);
    this.sprite.resize(radius * 2, radius * 2);
  }
  
  void chaseTarget(float dt, PVector target){
    PVector diff = PVector.sub(target, pos);
    pos.add(diff.limit(speed * dt));
  }
  
  boolean caughtSlime(){
    float dx = slime.pos.x - pos.x;
    float dy = slime.pos.y - pos.y;
    float distance = sqrt((sq(dx)) + sq(dy));
    return distance < slime.radius;
  }
  
  void reset(){
    pos.x = width/start.x;
    pos.y = height/start.y;
  }
  
  void draw(){
    image(sprite, pos.x - radius, pos.y - radius);
  }
  
}
