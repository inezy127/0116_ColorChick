class Ball{
  float x,y,size,speedX,speedY;
  int r,g,b;
  
  Ball(float x, float y){
    this.x = x;
    this.y = y;
    this.size = COLOR_SIZE;
    this.speedX = 0;
    this.speedY = 0;
  }
  
  void move(float left, float right, float up, float down){
    x += speedX;
    y += speedY;
    if(x>=right || x<=left){
      speedX *= -1;
    }
    if(y>=down || y<= up){
      speedY *= -1;
    }
  }
  
  void fillTheColor(int colorIndex){
    r = colorTable[colorIndex][0];
    g = colorTable[colorIndex][1];
    b = colorTable[colorIndex][2];
  }
}

class WashBack extends Ball{
  WashBack(float x, float y){
    super(x,y);
    size = COLOR_SIZE;
  }
  void display(){
    image(washBack,x-size/2,y-size/2,size,size);
  }
}