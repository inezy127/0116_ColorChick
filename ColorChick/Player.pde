class Player{
  float x,y;
  float speed;
  float size;
  int r,g,b;
  float easing;
  boolean upPressed = false;
  boolean downPressed = false;
  boolean rightPressed = false;
  boolean leftPressed = false;
  
  int initR,initG,initB;
  
  Player(int colorIndex){
    x = 50;
    y = 240;
    easing = 0.1;
    speed = 4;
    size = PLAYER_SIZE;
    r = colorTable[colorIndex][0];
    g = colorTable[colorIndex][1];
    b = colorTable[colorIndex][2];
    initR = r;
    initG = g;
    initB = b;
  }
  
  void display(){
    if(playerTouch<120) playerTouch--;
    if(playerTouch<0) playerTouch = 120;
    noStroke();
    fill(r,g,b);
    ellipse(x,y,size,size);
    image(playerPic,x-size/2+5,y-size/2+3,size,size);
  }
  
  public void blendOtherCircle(Player player, ColorBall colorball){
    r = (player.r + colorball.r)/2;
    g = (player.g + colorball.g)/2;
    b = (player.b + colorball.b)/2;
    player.x = colorball.x;
    player.y = colorball.y;
  }
  
  void move(){
      if(upPressed && y>size/2) y -= speed;
      if(downPressed && y<height-size/2) y += speed;
      if(rightPressed && x<width-size/2) x += speed;
      if(leftPressed && x>size/2) x -= speed;
    }
  
  void colorBlend(ColorBall target){
    r = (r+target.r)/2;
    g = (g+target.g)/2;
    b = (b+target.b)/2;
  }
  
  int playerTouch = 120;  
  boolean OnCollision(ColorBall target){
    if(playerTouch != 120) return false;
    float distance = dist(x,y,target.x,target.y);
    if(distance<=(size+target.size)/2){
      song4.trigger();
      player.colorBlend(target);
      if(colorIndex<totalBall){
          target.fillTheColor(ballIndexList[colorIndex]);
          colorIndex++;
        }else{
          target.ratio = 0;        
        }
      playerTouch--;
      return true;
    }
    return false;
  }
  
  void washBack(WashBack target){
    float distance = dist(x,y,target.x,target.y);
    if(distance <= (size+target.size)/2){
      song4.trigger();
      r = initR;
      g = initG;
      b = initB;
      target.x = -1000;
      target.y = -1000;
    }
  }
  
  void OnCollision(BlockBall target){
    float distance = dist(x,y,target.x,target.y);
    if(distance<=(size+target.size)/2){
      song8.trigger();
      x = startX;
      y = height/2;
    }    
  }
}