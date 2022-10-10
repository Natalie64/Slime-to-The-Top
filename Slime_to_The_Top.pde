/**
* Slime to The Top!
* 
* Slime to the Top is a game where you rescue baby slimes to grow bigger,
* but will shrink if an enemy catches you.
*
* The goal is to reach a certain size before you shrink down too much.
**/

Slime slime;  //Player Slime
EnemySlime smallEnemy;  //Basic Enemy
EnemySlime bigEnemy;  //Larger Enemy
EnemySlime godEnemy;  //Instant loss Enemy
Collectable crown;  //Crown that reduces shrinkage
Collectable sword;  //Sword that increases speed
int lastFrame;  //Most recent frame
float low = 1.1;  //Low multiplier representing being closer to the bottom right, used as a base for random numbers.
float high = 5;  //High multiplier representing being closer to the top left, used as a base for random numbers.
boolean gameOver;
boolean winGame;
ArrayList<Collectable> bSlimes = new ArrayList();  //A list of baby slimes

void setup(){
  size(1400, 800);
  slime = new Slime();
  smallEnemy = new EnemySlime(20, 120, 6, 6, "Slime to The Top - Assests/Cat-Eye Slime.png");
  bigEnemy = new EnemySlime(50, 110, 1.1, 1.1, "Slime to The Top - Assests/Big Cat-Eye Slime.png");
  godEnemy = new EnemySlime(15, 85, 6, 1, "Slime to The Top - Assests/Dark God.png");
  crown = new Collectable(20, random(low, low + 5), random(low, low + 5), "Slime to The Top - Assests/Crown.png");
  sword = new Collectable(20, random(low, low + 5), random(low, low + 5), "Slime to The Top - Assests/Slime Blade.png");
  gameOver = false;
  winGame = false;
  spawnBSlimes();
}

//Creates all baby slimes at random locations
void spawnBSlimes(){
  Collectable newBSlime = new Collectable(15, random(low, low * 1.2), random(low, low * 1.2),"Slime to The Top - Assests/Baby Slime.png");
  bSlimes.add(newBSlime);
    
  newBSlime = new Collectable(15, random(low, low * 1.2), random(high, high * 2),"Slime to The Top - Assests/Baby Slime.png");
  bSlimes.add(newBSlime);
  
  newBSlime = new Collectable(15, random(high, high * 2), random(high, high * 2),"Slime to The Top - Assests/Baby Slime.png");
  bSlimes.add(newBSlime);
  
  newBSlime = new Collectable(15, random(high, high * 2), random(low, low * 1.2),"Slime to The Top - Assests/Baby Slime.png");
  bSlimes.add(newBSlime);
}


//////////////////////
//Main gameplay loop//
//////////////////////
void continueGame(){
  background(#001020);
  float dt = calcDeltaTime();  //Keeps time
  slime.chaseMouse(dt);
  smallEnemy.chaseTarget(dt, slime.getTarget());
  bigEnemy.chaseTarget(dt, slime.getTarget());
  godEnemy.chaseTarget(dt, slime.getTarget());
  
  if (smallEnemy.caughtSlime()){
    gameOver = slime.shrink(dt);  //Shrinks the player until they reach a certain size. If reached, game ends.
  }
  
  if (bigEnemy.caughtSlime()){
    gameOver = slime.shrink(dt * 1.5);  //Shrinks the player until they reach a certain size. If reached, game ends.
  }
  
  if (godEnemy.caughtSlime()){  //Instant Game Over
    gameOver = true;
  }
  
  //Checks if a baby slime has been collected and removes it if true. Also checks to see if the player has reached the winning size.
  for (int i = bSlimes.size() - 1; i >= 0; i--){
    if (bSlimes.get(i).isCollected() && !bSlimes.get(i).collected){
      bSlimes.get(i).collected = true;
      slime.grow(bSlimes.get(i).radius); //Player grows in size
      bSlimes.remove(i);
      if (slime.radius >= 85){
        winGame = true;
      }
    }
  }
  
  if (crown.isCollected() && !crown.collected){  //Crown reduces shrinkage that player receives.
    crown.collected = true;
    slime.crowned = true;
    slime.update();
  }
  
  if (sword.isCollected() && !sword.collected){  //Sword increases the speed the player moves at.
    sword.collected = true;
    slime.armed = true;
    slime.update();
  }
  
  if (bSlimes.size() == 0) {  //If there are no baby slimes on screen, spawn new ones.
    spawnBSlimes();
  }
  
  
  //Draws all actors with priority given bottom up.
  for (int i = 0; i < bSlimes.size(); i++){
    bSlimes.get(i).draw();
  }
  bigEnemy.draw();
  smallEnemy.draw();
  godEnemy.draw();
  slime.draw();
  crown.draw();
  sword.draw();
}
////////////////////////
//End of gameplay loop//
////////////////////////


//Ends the game with either a win or loss.
void endGame(){
  if (gameOver){
    background(#990000);
    textSize(128);
    textAlign(CENTER);
    fill(0, 0, 0);
    text("Game Over", width/2, height/2);
    slime.draw();
  }
  else if (winGame){
    background(#009900);
    textSize(128);
    textAlign(CENTER);
    fill(255, 255, 255);
    text("You Win!", width/2, height/2);
    slime.draw();
  }
  
}

//Checks to see if the game is over. If not, continue.
void draw(){
  if (gameOver || winGame){
    endGame();
  }
  else {
    continueGame();
  }
}

//Keeps time
float calcDeltaTime(){
  int now = millis();
  int delta = now - lastFrame;
  lastFrame = now;
  return delta / 1000.0;
}

//Resets the game after it ends.
void mousePressed(){
  if (gameOver || winGame){
    if (bSlimes.size() < 4){  //Removes all remaining baby slimes
      for (int i = bSlimes.size() - 1; i >= 0; i--){
        bSlimes.remove(i);
      }
      spawnBSlimes();  //Respawns all baby slimes for the new round
    }
    gameOver = false;
    winGame = false;
    slime.reset();
    smallEnemy.reset();
    bigEnemy.reset();
    godEnemy.reset();
    crown.reset();
    sword.reset();
  }
}
