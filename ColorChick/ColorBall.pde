//COLOR BALL AND WASH BALL

class ColorBall extends Ball {
  float ratio = 1f;
  float initRatio = 1f;
  float transformRatio = 0.5f;
  float minRatio = 0.25f;
  int threshold = 30;
  int playerTouch = 100;


  ColorBall(float x, float y) {
    super(x, y);
    size = COLOR_SIZE;
  }

  Boolean OnCollision(Ball target) {
    if (threshold != 30) return false;
    float distance = dist(x, y, target.x, target.y);
    if (distance<=(size+target.size)/2) {
      song5.trigger();
      ratio = ratio * transformRatio;
      if (ratio == minRatio) {
        if (colorIndex<totalBall) {
          ratio = initRatio;
          fillTheColor(ballIndexList[colorIndex]);
          colorIndex++;
        } else {
          ratio = 0;
        }
      }
      threshold --;
      return true;
    }
    return false;
  }

  void display() {
    noStroke();
    fill(r, g, b);
    ellipse(x, y, size * ratio, size * ratio);
    if (threshold <30) threshold -= 1;
    if (threshold <0) threshold =30;
  }
}


//get the color list in advance
void generateBallIndex(int total, int targetNumber, int onField, int targetColor) {
  int pickIndex = -1;
  //initial
  for (int i=0; i<ballIndexList.length; i++) {
    ballIndexList[i] = 0;
  }
  //pickNumber
  ballIndexList[0] = targetColor;
  targetNumber--;
  while (targetNumber>0) {
    pickIndex = int(random(onField, total));
    if (ballIndexList[pickIndex] == 0) {
      ballIndexList[pickIndex] = targetColor;
      targetNumber--;
    }
  }
  //fill other color
  for (int i=0; i<ballIndexList.length; i++) {
    if (ballIndexList[i] != targetColor) {
      int pickColor = int(random(0, COLOR_NUMBER));
      if (pickColor != targetColor) {
        ballIndexList[i] = pickColor;
      } else {
        pickColor = int(random(0, COLOR_NUMBER));
      }
    }
  }
}


class WashBack extends Ball {
  WashBack(float x, float y) {
    super(x, y);
    size = COLOR_SIZE;
  }
  void display() {
    image(washBack, x-size/2, y-size/2, size, size);
  }
}