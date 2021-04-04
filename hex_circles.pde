void setup() {
  size(900, 900);
  noLoop();
}

void draw() {
  float center_x = width/2;
  float center_y = height/2;
  float d = 50;

  ArrayList<PVector> cen = new ArrayList<PVector>();

  // element 0 (center)
  cen.add(new PVector(center_x, center_y));

  for (int i=1; i <= 6; i=i+1) {
    for (int j=0; j < 6; j=j+1) {
      float x = center_x + float(i)*d*cos(float(j)/6*TWO_PI);
      float y = center_y + float(i)*d*sin(float(j)/6*TWO_PI);
      cen.add(new PVector(x,y));
    }
    float p1_x = cen.get(cen.size()-6).x; //<>//
    float p1_y = cen.get(cen.size()-6).y; //<>//
    float p2_x = cen.get(cen.size()-5).x; //<>//
    float p2_y = cen.get(cen.size()-5).y; //<>//
    float p3_x = cen.get(cen.size()-4).x;
    float p3_y = cen.get(cen.size()-4).y;
    float dif_x = p1_x - p2_x; //<>//
    float dif_y = p1_y - p2_y; //<>//
    float dif_xh = p2_x - p3_x;
    float dif_yh = p2_y - p3_y;
    for (int k=1; k <= i-1; k=k+1) { //<>//
      float new_x = p1_x - (float(k)/float(i))*dif_x; //<>//
      float new_y = p1_y - (float(k)/float(i))*dif_y; //<>//
      cen.add(new PVector(new_x, new_y));
      cen.add(new PVector(2*center_x - new_x, new_y));
      cen.add(new PVector(2*center_x - new_x, 2*center_y - new_y));
      cen.add(new PVector(new_x, 2*center_y - new_y));
      float new_xh = p2_x - (float(k)/float(i))*dif_xh;
      float new_yh = p2_y - (float(k)/float(i))*dif_yh;
      cen.add(new PVector(new_xh, new_yh));
      cen.add(new PVector(new_xh, 2*center_y - new_yh));
    }
  }

  for (PVector c : cen) {
    println(c);
    ellipse(c.x, c.y, d, d);
  }
}
