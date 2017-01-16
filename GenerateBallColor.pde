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