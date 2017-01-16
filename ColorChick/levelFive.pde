void levelFiveSet(){
  blockNum = 8;
  attackNum = 3;  
  initLevel(15,5,5,blue2);
  
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
  attackTimer.start();
  
  //player
  player = new Player(white);
   
  //blockBall
  blockBall[0] = new BlockBall(400,40,0,0);
  blockBall[1] = new BlockBall(400,120,0,0);
  blockBall[2] = new BlockBall(480,120,0,0);
  blockBall[3] = new BlockBall(560,120,0,0);
  blockBall[4] = new BlockBall(400,440,0,0);
  blockBall[5] = new BlockBall(400,360,0,0);
  blockBall[6] = new BlockBall(480,360,0,0);
  blockBall[7] = new BlockBall(560,360,0,0);
  
  //attackBall
  for(int i=0;i<attackBall.length;i++){
    attackBall[i] = new AttackBall(random(startX,width-BAR_SIZE-ATTACK_SIZE/2-1), random(height/2-50,height/2+50), random(1,5),1);
  }
  
  //colorBall
  colorBall[0] = new ColorBall(280,240);
  colorBall[1] = new ColorBall(280,170);
  colorBall[2] = new ColorBall(280,100);
  colorBall[3] = new ColorBall(280,310);
  colorBall[4] = new ColorBall(280,380);
  for(int i=0;i<onField;i++){
    colorBall[i].fillTheColor(ballIndexList[i]);
  }
}

void levelFiveDraw(){
  //background
  level.show(blue3,5);
  
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
  
  //blockBall
  for(int i=0;i<blockNum;i++){
    blockBall[i].fillTheColor(block);
    blockBall[i].display();
  }
  
  //attackBall
  if(gameStart.isEnded()){
    if(attackTimer.arrived()) attackNum++;
  }
  for(int i=0;i<attackNum;i++){
    attackBall[i].fillTheColor(attack);
     if(gameStart.isEnded()) attackBall[i].move(100,width-BAR_SIZE-ATTACK_SIZE/2,0,height);
    attackBall[i].display();
    attackBall[i].OnCollision(player);
    for(int j=0;j<blockNum;j++){
      attackBall[i].OnCollision(blockBall[j]);
    }
  }
  
  //colorBall
  for(int i=0;i<onField;i++){
    colorBall[i].display();
    for(int j=0;j<attackNum;j++){
      colorBall[i].OnCollision(attackBall[j]);
    }
  }
  
  //timer
  level.startTimer();
}