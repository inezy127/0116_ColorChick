//ATTACK BALL AND BLOCK BALL

class AttackBall extends Ball {
  int threshold = 30;
  AttackBall(float x, float y) {
    super(x, y);
    size = ATTACK_SIZE;
    speedX = random(-5, 5);
    speedY = random(-5, 5);
    if (speedX == 0) speedX = random(-5, 5);
    if (speedY == 0) speedY = random(-5, 5);
  }
  AttackBall(float x, float y, float speedX, float speedY) {
    super(x, y);
    this.speedX = speedX;
    this.speedY = speedY;
    size = ATTACK_SIZE;
  }

  boolean OnCollision(Ball target) {
    if (threshold != 30) return false;
    float distance = dist(x, y, target.x, target.y);
    if (distance <= (size+target.size)/2) {
      speedX *= -1;
      speedY *= -1;
      threshold --;
      return true;
    }
    return false;
  }

  void OnCollision(Player target) {
    float distance = dist(x, y, target.x, target.y);
    if (distance <= (size+target.size)/2) {
      speedX *= -1;
      speedY *= -1;
    }
  }

  void display() {
    noStroke();
    fill(r, g, b);
    ellipse(x, y, size, size);
    if (threshold <30) threshold -= 1;
    if (threshold <0) threshold =30;
  }
}

class BlockBall extends Ball {
  BlockBall(float x, float y, float speedX, float speedY) {
    super(x, y);
    size = BLOCK_SIZE;
    this.speedX = speedX;
    this.speedY = speedY;
  }
  void display() {
    noStroke();
    fill(r, g, b);
    ellipse(x, y, size, size);
    image(blockPic, x-size/2-10, y-size/2+5, size, size);
  }
}