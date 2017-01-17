//update by rebecca 2017/1/16 20:22
//update by fanyutin 2017/1/17 00:20
//update by rebecca 2017/1/17/16:43
//新增部分：- 音效：player撞擊彩球、player撞擊阻擋灰球、攻擊灰球生成、攻擊灰撞擊彩球、過關音樂、結局音樂、倒數GO音樂
//        - 遊戲：場上洗色球、player撞擊灰球回到終點線前、攻擊灰球每五秒生成一顆、彩球數極大化、倒數20秒、10秒內過關下一關增加3秒
//        - 美術：開頭動畫更新、失敗結局圖、reatart圖、倒數時間外框（一般與bonus版本）


import ddf.minim.*;
Minim minim;
AudioSample song1, song2, song3, song4, song6, song5, song8, song9;
AudioPlayer song7;

import processing.video.*;
int openingCount=420;
int movieCount=120;
int restartCount=60;

PImage main1;
PImage main2;
PImage startPress1;
PImage startPress2;
PImage onePic, twoPic, threePic, goPic;
PImage playerPic, blockPic;
PImage lose1, lose2;
PImage washBack;
PImage countClock, countClockBonus;
PImage chaos;

Movie story;
Movie start;
Movie intoBall;
Movie redMoive;
Movie orangeMovie;
Movie yellowMovie;
Movie greenMovie;
Movie blueMovie;
Movie purpleMovie;
Movie endMovie;

final int COLOR_SIZE = 40, ATTACK_SIZE = 30, BLOCK_SIZE = 80, PLAYER_SIZE = 40;
final int COLOR_NUMBER = 13;
final float BAR_SIZE = 40;

//save all the color
public int [][] colorTable = { {254, 254, 254}, {254, 0, 50}, {254, 127, 152}, 
  {254, 246, 154}, {242, 158, 194}, {248, 202, 174}, 
  {248, 202, 174}, {251, 224, 164}, {0, 204, 254}, 
  {127, 225, 204}, {52, 102, 254}, {153, 178, 254}, 
  {147, 130, 224}, {190, 190, 190}, {106, 106, 106}, 
};

//index of the color
public int white = 0, red = 1, pink2 =2, 
  yellow = 3, pink = 4, orange=5, 
  yellow2 = 6, yellow3=7, blue =8, 
  green = 9, blue2 = 10, blue3 = 11, 
  purple = 12, block = 13, attack = 14;

public int colorIndex;
public int totalBall, targetBall, onField, targetColor;
public int attackNum, blockNum;
public float speed;
public int [] ballIndexList = new int [30];  
public boolean bounusTime = false;

public float startX = 100;
public Player player = new Player(white);
public WashBack [] wash = new WashBack [2];
public Level level = new Level();
public BlockBall [] blockBall = new BlockBall [15];
public AttackBall [] attackBall = new AttackBall [15];
public ColorBall [] colorBall = new ColorBall [30];

CountDownTimer gameCount = new CountDownTimer(26);
CountDownTimer gameStart = new CountDownTimer(6);
CountDownTimer picCount = new CountDownTimer(5);
IntervalTimer attackTimer = new IntervalTimer(5);

boolean correctcolor() {
  if (player.x>600 && player.r==level.r && player.g==level.g && player.b==level.b) {
    return true;
  } else {
    return false;
  }
}

//levelState
final int LEVEL_OPENING=0;
final int LEVEL_STORY_MOVIE=1;
final int LEVEL_START_MOVIE =2;
final int GAME_PRESS_START=3;

final int LEVEL_RED=4;
final int LEVEL_RED_MOVIE=5;

final int LEVEL_ORANGE=6;
final int LEVEL_ORANGE_MOVIE=7;

final int LEVEL_YELLOW=8;
final int LEVEL_YELLOW_MOVIE=9;

final int LEVEL_GREEN=10;
final int LEVEL_GREEN_MOVIE=11;

final int LEVEL_BLUE=12;
final int LEVEL_BLUE_MOVIE=13;

final int LEVEL_PURPLE=14;
final int LEVEL_PURPLE_MOVIE=15;

final int LEVEL_END=16;

final int LEVEL_RESTART = 17;

int levelState;
int recentLevel;

void setup() {
  size(640, 480);
  //song set
  minim = new Minim(this);
  song1 = minim.loadSample("playsound/buttonSelect.wav", 128);
  song2 = minim.loadSample("playsound/attack1.mp3");
  song3 = minim.loadSample("playsound/gameFail.wav", 128);
  song4 = minim.loadSample("playsound/eatBall2.wav", 128);
  song5 = minim.loadSample("playsound/bounce.wav");
  song6 = minim.loadSample("playsound/pass1.mp3", 512);
  song7 = minim.loadFile("playsound/pass4.wav");
  song8 = minim.loadSample("playsound/block2.mp3");
  song9 = minim.loadSample("playsound/start1.wav");

  //movie set
  story = new Movie(this, "story.mov");
  start = new Movie(this, "start.mov");
  redMoive = new Movie(this, "Red.mp4");
  orangeMovie = new Movie(this, "Orange.mp4");
  yellowMovie = new Movie(this, "Yellow.mp4");
  greenMovie = new Movie(this, "Green.mp4");
  blueMovie = new Movie(this, "Blue.mp4");
  purpleMovie = new Movie(this, "Purple.mp4");
  intoBall = new Movie(this, "ChickenIntoBall.mp4");
  endMovie = new Movie(this, "newEnd.mov");

  //image set
  main1 = loadImage("img/cover1.png");
  main2 = loadImage("img/cover2.png");
  onePic = loadImage("img/one.png");
  twoPic = loadImage("img/two.png");
  threePic = loadImage("img/three.png");
  goPic = loadImage("img/go.png");
  playerPic = loadImage("img/player.png");
  blockPic = loadImage("img/block.png");
  lose1 = loadImage("img/lose1.png");
  lose2 = loadImage("img/lose2.png");
  chaos = loadImage("img/chaos.png");
  washBack = loadImage("img/washback.png");
  countClock = loadImage("img/count.png");
  countClockBonus =loadImage("img/bonuscount.png");

  //initial variable
  for (int i=0; i<attackBall.length; i++) {
    attackBall[i] = new AttackBall(random(startX, width-BAR_SIZE), random(height));
    blockBall[i] = new BlockBall(40, 20, random(-3, 3), random(-3, 3));
  }
  for (int i=0; i<colorBall.length; i++) {
    colorBall[i] = new ColorBall(50+i*50, 200);
    colorBall[i].fillTheColor(ballIndexList[i]);
  }

  //player set
  player= new Player(white);
  player.x= 50;
  player.y= 240;
}

void movieEvent(Movie m) {
  m.read();
}

void draw() {
  background(255);  
  switch(levelState) {
    //main game
  case LEVEL_OPENING:
    image(main1, 0, 0, 640, 480);
    if (mouseX>320-80 && mouseX<320+80 && mouseY>400 && mouseY<450) {
      image(main2, -1, 0, 640, 480);
      if (mousePressed) {
        song1.trigger();
        levelState=LEVEL_STORY_MOVIE;
      }
    }  
    break;

    //click to start
  case LEVEL_STORY_MOVIE:
    story.play();
    image(story, 0, 0, 640, 480);
    if ( openingCount== 420) {
      openingCount --;
    }
    if (openingCount <420) {
      openingCount --;
    }
    if (openingCount<0) {
      openingCount = 420;
      levelState = LEVEL_START_MOVIE;
    }
    break;

    //chicken let's go save our frineds
  case LEVEL_START_MOVIE:
    start.play();
    image(start, 0, 0, 640, 480);
    if (mousePressed) {
      song1.trigger();
      openingCount = 420; 
      levelState = LEVEL_RED;
      levelOneSet();
    }

    break;

  case LEVEL_RED:
    levelOneDraw();
    if (gameCount.isEnded()) {
      song3.trigger();
      picCount.start();
      levelState = LEVEL_RESTART;
    }
    recentLevel = LEVEL_RED;
    if (correctcolor()==true) {
      song6.trigger();
      levelTwoSet();
      player.x=50;
      player.y=240;
      levelState=LEVEL_RED_MOVIE;
    }
    break;

  case LEVEL_RED_MOVIE:
    redMoive.play();
    image(redMoive, 0, 0, 640, 480);
    if ( movieCount== 120) {
      movieCount --;
    }
    if (movieCount <120) { 
      movieCount --;
    }
    if (movieCount<0) {
      movieCount = 120;
      levelState = LEVEL_ORANGE;
    }
    break;

  case LEVEL_ORANGE:
    levelTwoDraw();
    movieCount = 120;
    if (gameCount.isEnded()) {
      picCount.start();
      song3.trigger();
      levelState = LEVEL_RESTART;
    }
    recentLevel = LEVEL_ORANGE;
    if (correctcolor()==true) {
      song6.trigger();
      levelThreeSet();
      player.x=50;
      player.y=240;
      levelState=LEVEL_ORANGE_MOVIE;
    }
    break;

  case LEVEL_ORANGE_MOVIE:
    orangeMovie.play();
    image(orangeMovie, 0, 0, 640, 480);
    if ( movieCount== 120) {
      movieCount --;
    }
    if (movieCount <120) {
      movieCount --;
    }
    if (movieCount<0) {
      movieCount = 120;
      levelState = LEVEL_YELLOW;
    }
    break;

  case LEVEL_YELLOW:
    levelThreeDraw();
    if (gameCount.isEnded()) {
      picCount.start();
      song3.trigger();
      levelState = LEVEL_RESTART;
    }
    recentLevel = LEVEL_YELLOW;
    if (correctcolor()==true) {
      song6.trigger();
      levelFourSet();
      player.x=50;
      player.y=240;
      levelState=LEVEL_YELLOW_MOVIE;
    }     
    break;

  case LEVEL_YELLOW_MOVIE:
    yellowMovie.play();
    image(yellowMovie, 0, 0, 640, 480);
    if ( movieCount== 120) {
      movieCount --;
    }
    if (movieCount <120) {
      movieCount --;
    }
    if (movieCount<0) {
      levelState = LEVEL_GREEN;
      movieCount = 120;
    }
    break;

  case LEVEL_GREEN:
    levelFourDraw();
    if (gameCount.isEnded()) {
      picCount.start();
      song3.trigger();
      levelState = LEVEL_RESTART;
    }
    recentLevel = LEVEL_GREEN;
    if (correctcolor()==true) {
      song6.trigger();
      levelFiveSet();
      player.x=50;
      player.y=240;
      levelState=LEVEL_GREEN_MOVIE;
    } 
    break;

  case LEVEL_GREEN_MOVIE:
    greenMovie.play();
    image(greenMovie, 0, 0, 640, 480);
    if ( movieCount== 120) {
      movieCount --;
    }
    if (movieCount <120) {
      movieCount --;
    }
    if (movieCount<0) {
      levelState = LEVEL_BLUE;
      movieCount = 120;
    }
    break;

  case LEVEL_BLUE:
    levelFiveDraw();
    if (gameCount.isEnded()) {
      picCount.start();
      song3.trigger();
      levelState = LEVEL_RESTART;
    }
    recentLevel = LEVEL_BLUE;
    if (correctcolor()==true) {
      song6.trigger();
      levelSixSet();
      player.x=50;
      player.y=240;
      levelState=LEVEL_BLUE_MOVIE;
    } 
    break;

  case LEVEL_BLUE_MOVIE:
    blueMovie.play();
    image(blueMovie, 0, 0, 640, 480);
    if ( movieCount== 120) {
      movieCount --;
    }
    if (movieCount <120) {
      movieCount --;
    }
    if (movieCount<0) {
      levelState = LEVEL_PURPLE;
      movieCount = 120;
    }
    break;  

  case LEVEL_PURPLE:
    levelSixDraw();
    if (gameCount.isEnded()) {
      picCount.start();
      song3.trigger();
      levelState = LEVEL_RESTART;
    }
    recentLevel = LEVEL_PURPLE;
    if (correctcolor()==true) {
      song6.trigger();
      levelState=LEVEL_PURPLE_MOVIE;
    } 
    break;

  case LEVEL_PURPLE_MOVIE:
    song7.play();
    purpleMovie.play();
    image(purpleMovie, 0, 0, 640, 480);
    if ( movieCount== 120) {
      movieCount --;
    }
    if (movieCount <120) {
      movieCount --;
    }
    if (movieCount<0) {
      levelState = LEVEL_END;
      movieCount = 120;
    }
    break;

  case LEVEL_END:
    endMovie.play();
    image(endMovie, 0, 0, 640, 480);
    break;

  case LEVEL_RESTART:
    if (picCount.isEnded()== false) {
      image(chaos, 0, 0, width, height);
    } else {
      image(lose1, 0, 0, width, height);
      if (mouseX<413 && mouseX>232 && mouseY<276 && mouseY>229) {
        image(lose2, 0, 0, width, height);
        if (mousePressed) {
          switch(recentLevel) {
          case LEVEL_RED:
            levelOneSet();
            break;
          case LEVEL_ORANGE:
            levelTwoSet();
            break;
          case LEVEL_YELLOW:
            levelThreeSet();
            break;
          case LEVEL_GREEN:
            levelFourSet();
            break;
          case LEVEL_BLUE:
            levelFiveSet();
            break;
          case LEVEL_PURPLE:
            levelSixSet();
            break;
          }
          song1.trigger();
          levelState = recentLevel;
          restartCount = 60;
        }
      }
    }
  }
}

void keyPressed () {
  if (key == CODED) { 
    switch ( keyCode ) {
    case UP :
      player.upPressed = true ;
      break ;
    case DOWN :
      player.downPressed = true ;
      break ;
    case LEFT :
      player.leftPressed = true ;
      break ;
    case RIGHT :
      player.rightPressed = true ;
      break ;
    }
  }
}

void keyReleased () {
  if (key == CODED) { 
    switch ( keyCode ) {
    case UP : 
      player.upPressed = false ;
      break ;
    case DOWN :
      player.downPressed = false ;
      break ;
    case LEFT :
      player.leftPressed = false ;
      break ;
    case RIGHT :
      player.rightPressed = false ;
      break ;
    }
  }
}