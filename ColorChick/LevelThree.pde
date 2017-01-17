void levelThreeSet(){
  blockNum = 8;
  speed = 1;
  initLevel(20,3,5,yellow);
  
  //washBall
  wash[0] = new WashBack(230,150);
  wash[1] = new WashBack(400,300);
  
  //timer
  if(gameCount.remaining()>=10){
    gameCount.setTime(29);
    bounusTime = true;
  }else{
    gameCount.setTime(26);
    bounusTime = false;
  }
  gameStart.start();
  gameCount.start();
  
  //player
  player = new Player(yellow2);
  
  //blockBall
  blockBall[0] = new BlockBall(180,40,0,speed);
  blockBall[1] = new BlockBall(180,200,0,-speed);
  blockBall[2] = new BlockBall(180,280,0,speed);
  blockBall[3] = new BlockBall(180,440,0,-speed);
  blockBall[4] = new BlockBall(550,40,0,speed);
  blockBall[5] = new BlockBall(550,200,0,-speed);
  blockBall[6] = new BlockBall(550,280,0,speed);
  blockBall[7] = new BlockBall(550,440,0,-speed);
  
  //colorBall
  colorBall[0] = new ColorBall(390,420);
  colorBall[1] = new ColorBall(275,300);
  colorBall[2] = new ColorBall(349,70);
  colorBall[3] = new ColorBall(437,253);
  colorBall[4] = new ColorBall(385,170);
  for(int i=0;i<onField;i++){
    colorBall[i].fillTheColor(ballIndexList[i]);
  }
}

void levelThreeDraw(){
  //background
  level.show(yellow3,3);
  
  //wash ball
  for(int i=0;i<wash.length;i++){
    wash[i].display();
    player.washBack(wash[i]);
  }  
  //player
  player.display();
  if(gameStart.isEnded()) player.move();

  //player.goToNextLevel(level);
  for(int i=0;i<blockNum;i++){
    player.OnCollision(blockBall[i]);
  }
  for(int i=0;i<onField;i++){
    player.OnCollision(colorBall[i]);
  }
  
  //blockball
  if(gameStart.isEnded()){
    blockBall[0].move(0,width,40,80);
    blockBall[1].move(0,width,160,200);
    blockBall[2].move(0,width,280,320);
    blockBall[3].move(0,width,400,440);
    blockBall[4].move(0,width,40,80);
    blockBall[5].move(0,width,160,200);
    blockBall[6].move(0,width,280,320);
    blockBall[7].move(0,width,400,440); 
  }
  for(int i=0;i<blockNum;i++){
    blockBall[i].fillTheColor(block);
    blockBall[i].display();
  }
  
  //colorBall
  for(int i=0;i<onField;i++){
    colorBall[i].display();
  }
  
  //timer
  level.startTimer();

}