void levelOneSet(){
  blockNum = 2;
  speed = 2;
  
  //timer
  gameStart.start();
  gameCount.start();
  
  //washBall
  wash[0] = new WashBack(200,200);
  wash[1] = new WashBack(400,400);
  
  //player
  player = new Player(white);
  //initialLevel
  initLevel(10,4,2,red);
  
  //blockBall
  blockBall[0] = new BlockBall(180,80,0,speed);
  blockBall[1] = new BlockBall(280,height-80,0,-speed); 
  
  //colorBall
  colorBall[0] = new ColorBall(400,260);
  colorBall[1] = new ColorBall(480,350);
  for(int i=0;i<onField;i++){
    colorBall[i].fillTheColor(ballIndexList[i]);
  }
  
}

void levelOneDraw(){
  //background
  level.show(pink2,1);
  
  //player
  player.display();
  if(gameStart.isEnded()) player.move();
  
  //washBall
  for(int i=0;i<wash.length;i++){
    wash[i].display();
    player.washBack(wash[i]);
  }
  //player.goToNextLevel(level);
  for(int i=0;i<blockNum;i++){
    player.OnCollision(blockBall[i]);
  }
  for(int i=0;i<onField;i++){
    player.OnCollision(colorBall[i]);
  }
  
  //blockBall
  for(int i=0;i<blockNum;i++){
    blockBall[i].fillTheColor(block);
  }
  if(gameStart.isEnded()){
    blockBall[0].move(0,width,80*0.5,height-80*0.5);
    blockBall[1].move(0,width,80*0.5,height-80*0.5);
  }
  for(int i=0;i<blockNum;i++){
    blockBall[i].display();
  }
  
  //colorBall
  for(int i=0;i<onField;i++){
    colorBall[i].display();
  }
  
  //timer
  level.startTimer();
  
}