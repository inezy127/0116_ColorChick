void levelSixSet(){
  blockNum = 5;
  speed = 3;
  float speedB = 2;
  initLevel(30,8,5,pink); 

  //washBall
  wash[0] = new WashBack(200,200);
  wash[1] = new WashBack(400,400);  
  
  //timer
  if(gameCount.remaining()>=10){
    gameCount.setTime(29);
  }else{
    gameCount.setTime(26);
  }
  gameStart.start();
  gameCount.start();

  //player
  player = new Player(blue2);
  
  //blockBall
  blockBall[0] = new BlockBall(460,70,-speed,0);
  blockBall[1] = new BlockBall(140,160,speedB,0);
  blockBall[2] = new BlockBall(460,240,-speed,0);
  blockBall[3] = new BlockBall(140,330,speedB,0);
  blockBall[4] = new BlockBall(460,410,-speed,0);
  
  //colorBall
  colorBall[0] = new ColorBall(550,240);
  colorBall[1] = new ColorBall(550,170);
  colorBall[2] = new ColorBall(550,100);
  colorBall[3] = new ColorBall(550,310);
  colorBall[4] = new ColorBall(550,380);
  for(int i=0;i<onField;i++){
    colorBall[i].fillTheColor(ballIndexList[i]);
  }
}

void levelSixDraw(){
  //background
  level.show(purple,6);
  
  //washBall
  for(int i=0;i<wash.length;i++){
    wash[i].display();
    player.washBack(wash[i]);
  }
  
  //player
  player.display();
  if(gameStart.isEnded()) player.move();
  for(int i=0;i<blockNum;i++){
    player.OnCollision(blockBall[i]);
  }
  
  //blockBall
  for(int i=0;i<blockNum;i++){
    blockBall[i].fillTheColor(block);
    if(gameStart.isEnded()) blockBall[i].move(140,460,0,height);
    blockBall[i].display();
  }
  
  //colorBall
  for(int i=0;i<onField;i++){
    colorBall[i].display();
    player.OnCollision(colorBall[i]);
  }
  
  //timer
  level.startTimer();
}