//放在每一關的set Function裡面，跑一些制式的東西（ex.各球顏色）
void initLevel(int sum, int target, int nowOn,  int Color){
  totalBall = sum;
  targetBall = target;
  onField = nowOn;
  targetColor = Color;
  colorIndex = onField;
  
  //generat the ball color list
  generateBallIndex(totalBall,targetBall,onField,targetColor);
}