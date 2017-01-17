//SET UP AND DRAW FUNCTION OF EACH LEVEL

//LEVEL ONE
void levelOneSet() {
  blockNum = 2;
  speed = 2;

  //timer
  gameStart.start();
  gameCount.start();

  //washBall
  wash[0] = new WashBack(200, 200);
  wash[1] = new WashBack(400, 400);

  //player
  player = new Player(white);
  //initialLevel
  initLevel(10, 4, 2, red);

  //blockBall
  blockBall[0] = new BlockBall(180, 80, 0, speed);
  blockBall[1] = new BlockBall(280, height-80, 0, -speed); 

  //colorBall
  colorBall[0] = new ColorBall(400, 260);
  colorBall[1] = new ColorBall(480, 350);
  for (int i=0; i<onField; i++) {
    colorBall[i].fillTheColor(ballIndexList[i]);
  }
}

void levelOneDraw() {
  //background
  level.show(pink2, 1);

  //player
  player.display();
  if (gameStart.isEnded()) player.move();

  //washBall
  for (int i=0; i<wash.length; i++) {
    wash[i].display();
    player.washBack(wash[i]);
  }
  //player.goToNextLevel(level);
  for (int i=0; i<blockNum; i++) {
    player.OnCollision(blockBall[i]);
  }
  for (int i=0; i<onField; i++) {
    player.OnCollision(colorBall[i]);
  }

  //blockBall
  for (int i=0; i<blockNum; i++) {
    blockBall[i].fillTheColor(block);
  }
  if (gameStart.isEnded()) {
    blockBall[0].move(0, width, 80*0.5, height-80*0.5);
    blockBall[1].move(0, width, 80*0.5, height-80*0.5);
  }
  for (int i=0; i<blockNum; i++) {
    blockBall[i].display();
  }

  //colorBall
  for (int i=0; i<onField; i++) {
    colorBall[i].display();
  }

  //timer
  level.startTimer();
}

//LEVEL TWO
void levelTwoSet(){
  attackNum = 3;
  initLevel(30,6,4,pink);
  
  //washBall
  wash[0] = new WashBack(150,200);
  wash[1] = new WashBack(450,450);
  
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
  attackTimer.start();
  
  //player
  player = new Player(yellow);
  player.x=50;
  player.y=240;
  
  //attackBall
  attackBall[0] = new AttackBall(350,190);
  attackBall[1] = new AttackBall(150,200);
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

void levelTwoDraw(){
  //background
  level.show(orange,2);
  
  //wash ball
  for(int i=0;i<wash.length;i++){
    wash[i].display();
    player.washBack(wash[i]);
  }
  
  //player
  player.display();
  if(gameStart.isEnded()) player.move();
  
  //player.goToNextLevel(level);
  for(int i=0;i<onField;i++){
    player.OnCollision(colorBall[i]);
  }
  
  //attackBall
  if(gameStart.isEnded()){
    if(attackTimer.arrived()){
      song2.trigger();
      attackNum ++;
    }    
  }
  for(int i=0;i<attackNum;i++){
    attackBall[i].fillTheColor(attack);
    if(gameStart.isEnded()) attackBall[i].move(startX,width-BAR_SIZE-ATTACK_SIZE/2,0,height);
    attackBall[i].display();
    attackBall[i].OnCollision(player);
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

//LEVEL THREE
void levelThreeSet() {
  blockNum = 8;
  speed = 1;
  initLevel(20, 3, 5, yellow);

  //washBall
  wash[0] = new WashBack(230, 150);
  wash[1] = new WashBack(400, 300);

  //timer
  if (gameCount.remaining()>=10) {
    gameCount.setTime(29);
    bounusTime = true;
  } else {
    gameCount.setTime(26);
    bounusTime = false;
  }
  gameStart.start();
  gameCount.start();

  //player
  player = new Player(yellow2);

  //blockBall
  blockBall[0] = new BlockBall(180, 40, 0, speed);
  blockBall[1] = new BlockBall(180, 200, 0, -speed);
  blockBall[2] = new BlockBall(180, 280, 0, speed);
  blockBall[3] = new BlockBall(180, 440, 0, -speed);
  blockBall[4] = new BlockBall(550, 40, 0, speed);
  blockBall[5] = new BlockBall(550, 200, 0, -speed);
  blockBall[6] = new BlockBall(550, 280, 0, speed);
  blockBall[7] = new BlockBall(550, 440, 0, -speed);

  //colorBall
  colorBall[0] = new ColorBall(390, 420);
  colorBall[1] = new ColorBall(275, 300);
  colorBall[2] = new ColorBall(349, 70);
  colorBall[3] = new ColorBall(437, 253);
  colorBall[4] = new ColorBall(385, 170);
  for (int i=0; i<onField; i++) {
    colorBall[i].fillTheColor(ballIndexList[i]);
  }
}

void levelThreeDraw() {
  //background
  level.show(yellow3, 3);

  //wash ball
  for (int i=0; i<wash.length; i++) {
    wash[i].display();
    player.washBack(wash[i]);
  }  
  //player
  player.display();
  if (gameStart.isEnded()) player.move();

  //player.goToNextLevel(level);
  for (int i=0; i<blockNum; i++) {
    player.OnCollision(blockBall[i]);
  }
  for (int i=0; i<onField; i++) {
    player.OnCollision(colorBall[i]);
  }

  //blockball
  if (gameStart.isEnded()) {
    blockBall[0].move(0, width, 40, 80);
    blockBall[1].move(0, width, 160, 200);
    blockBall[2].move(0, width, 280, 320);
    blockBall[3].move(0, width, 400, 440);
    blockBall[4].move(0, width, 40, 80);
    blockBall[5].move(0, width, 160, 200);
    blockBall[6].move(0, width, 280, 320);
    blockBall[7].move(0, width, 400, 440);
  }
  for (int i=0; i<blockNum; i++) {
    blockBall[i].fillTheColor(block);
    blockBall[i].display();
  }

  //colorBall
  for (int i=0; i<onField; i++) {
    colorBall[i].display();
  }

  //timer
  level.startTimer();
}

//LEVEL FOUR
void levelFourSet() {
  attackNum = 3;
  initLevel(30, 6, 4, yellow);

  //washBall
  wash[0] = new WashBack(230, 200);
  wash[1] = new WashBack(400, 450);

  //timer
  if (gameCount.remaining()>=10) {
    gameCount.setTime(29);
    bounusTime = true;
  } else {
    gameCount.setTime(26);
    bounusTime = false;
  }
  gameStart.start();
  gameCount.start();
  attackTimer.start();

  //player
  player = new Player(blue);

  //attackBall
  attackBall[0] = new AttackBall(350, 180);
  attackBall[1] = new AttackBall(250, 120);
  attackBall[2] = new AttackBall(355, 120);

  //colorBall
  colorBall[0] = new ColorBall(300, 160);
  colorBall[1] = new ColorBall(280, 250);
  colorBall[2] = new ColorBall(340, 350);
  colorBall[3] = new ColorBall(480, 120);
  for (int i=0; i<onField; i++) {
    colorBall[i].fillTheColor(ballIndexList[i]);
  }
}

void levelFourDraw() {
  //background
  level.show(green, 4);

  //wash ball
  for (int i=0; i<wash.length; i++) {
    wash[i].display();
    player.washBack(wash[i]);
  }  
  //player
  player.display();
  if (gameStart.isEnded()) player.move();
  for (int i=0; i<onField; i++) {
    player.OnCollision(colorBall[i]);
  }

  //attackBall
  if (gameStart.isEnded()) {
    if (attackTimer.arrived()) {
      song2.trigger();
      attackNum ++;
    }
  }
  for (int i=0; i<attackNum; i++) {
    attackBall[i].fillTheColor(attack);
    if (gameStart.isEnded()) attackBall[i].move(startX, width-BAR_SIZE-ATTACK_SIZE/2, 0, height);
    attackBall[i].OnCollision(player);
    attackBall[i].display();
  }
  //colorBall
  for (int i=0; i<onField; i++) {
    colorBall[i].display();
    for (int j=0; j<attackNum; j++) {
      colorBall[i].OnCollision(attackBall[j]);
    }
  }

  //timer
  level.startTimer();
}

//LEVEL FIVE
void levelFiveSet(){
  blockNum = 8;
  attackNum = 3;  
  initLevel(15,5,5,blue2);
  
  //washBall
  wash[0] = new WashBack(230,150);
  wash[1] = new WashBack(150,400);
  
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
    if(attackTimer.arrived()){
      song2.trigger();
      attackNum ++;
    }    
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

//LEVEL SIX
void levelSixSet(){
  blockNum = 5;
  speed = 3;
  float speedB = 2;
  initLevel(30,8,5,pink); 

  //washBall
  wash[0] = new WashBack(150,200);
  wash[1] = new WashBack(320,400);  
  
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