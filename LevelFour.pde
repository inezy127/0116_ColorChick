void levelFourSet(){
  attackNum = 3;
  initLevel(30,6,4,yellow);
  
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
  player = new Player(blue);

  //attackBall
  attackBall[0] = new AttackBall(350,180);
  attackBall[1] = new AttackBall(250,120);
  attackBall[2] = new AttackBall(355,120);
  
  //colorBall
  colorBall[0] = new ColorBall(300,160);
  colorBall[1] = new ColorBall(280,250);
  colorBall[2] = new ColorBall(340,350);
  colorBall[3] = new ColorBall(480,120);
  for(int i=0;i<onField;i++){
    colorBall[i].fillTheColor(ballIndexList[i]);
  }
}

void levelFourDraw(){
  //background
  level.show(green,4);
  
  //wash ball
  for(int i=0;i<wash.length;i++){
    wash[i].display();
    player.washBack(wash[i]);
  }  
  //player
  player.display();
  if(gameStart.isEnded()) player.move();
  for(int i=0;i<onField;i++){
    player.OnCollision(colorBall[i]);
  }
  
  //attackBall
  if(gameStart.isEnded()){
    if(attackTimer.arrived()) attackNum++;
  }
  for(int i=0;i<attackNum;i++){
    attackBall[i].fillTheColor(attack);
    if(gameStart.isEnded()) attackBall[i].move(startX,width-BAR_SIZE-ATTACK_SIZE/2,0,height);
    attackBall[i].OnCollision(player);
    attackBall[i].display();
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