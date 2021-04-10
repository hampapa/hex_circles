import java.util.Collections;

int n = 5;
float d = 50;
float center_x, center_y;
ArrayList<HexCircle> cen;
int count = 0;
int draw_iter = 0;
color[] c = {color(150,47,88), color(92,51,82), color(220,220,220),
             color(187,187,187), color(144,144,144)};

void setup() {
  size(900, 900);
  background(230,230,230);
  
  center_x = width/2;
  center_y = height/2;
  cen = new ArrayList<HexCircle>();
  calcCenters(cen, center_x, center_y, d);
  calcAngles(cen);
  Collections.sort(cen);
  count = cen.size();
  println("Number of circles: ", count);
}

void calcCenters(ArrayList<HexCircle> cen, float center_x, float center_y, float d) {
  
  // element 0 (center)
  cen.add( new HexCircle(center_x, center_y, d, 0) );
  
  for (int i=1; i <= n; i=i+1) {
    for (int j=0; j < 6; j=j+1) {
      float x = center_x + float(i)*d*cos(float(j)/6*TWO_PI);
      float y = center_y + float(i)*d*sin(float(j)/6*TWO_PI);
      cen.add(new HexCircle(x,y,d,i));
    }
    float p1_x = cen.get(cen.size()-6).x;
    float p1_y = cen.get(cen.size()-6).y;
    float p2_x = cen.get(cen.size()-5).x;
    float p2_y = cen.get(cen.size()-5).y;
    float p3_x = cen.get(cen.size()-4).x;
    float p3_y = cen.get(cen.size()-4).y;
    float dif_x = p1_x - p2_x;
    float dif_y = p1_y - p2_y;
    float dif_xh = p2_x - p3_x;
    float dif_yh = p2_y - p3_y;
    for (int k=1; k <= i-1; k=k+1) {
      float new_x = p1_x - (float(k)/float(i))*dif_x;
      float new_y = p1_y - (float(k)/float(i))*dif_y;
      cen.add(new HexCircle(new_x,new_y,d,i));
      cen.add(new HexCircle(2*center_x - new_x, new_y,d,i));
      cen.add(new HexCircle(2*center_x - new_x, 2*center_y - new_y,d,i));
      cen.add(new HexCircle(new_x, 2*center_y - new_y,d,i));
      float new_xh = p2_x - (float(k)/float(i))*dif_xh;
      float new_yh = p2_y - (float(k)/float(i))*dif_yh;
      cen.add(new HexCircle(new_xh, new_yh,d,i));
      cen.add(new HexCircle(new_xh, 2*center_y - new_yh,d,i));
    }
  }
}

void calcCenters2(ArrayList<HexCircle> cen, float center_x, float center_y, float d) {
  // element 0 (center)
  cen.add( new HexCircle(center_x, center_y, d, 0) );
  
  
}  

void calcAngles(ArrayList<HexCircle> cen) {
  for (int i=1; i < cen.size(); i++) {
    HexCircle c = cen.get(i);
    float x1 = d/2.0;
    float y1 = 0;
    float x2 = c.x - center_x;
    float y2 = c.y - center_y;
    float dot_product = x1*x2 + y1*y2;
    float l1 = sqrt(x1*x1 + y1*y1);
    float l2 = sqrt(x2*x2 + y2*y2);
    float cos_calc = dot_product/(l1*l2);
    float acos_calc = acos(cos_calc);
    
    if (y2 < 0) {
      acos_calc = TWO_PI - acos_calc;
    }
    println(x2, y2, cos_calc, acos_calc);
    c.setAngle(acos_calc);
  }
}

void draw() {
  background(230,230,230);
  
  if (draw_iter == count) {
    delay(3000);
    draw_iter = 0;
  }
  for (int i=0; i <= draw_iter; i++) { //<>//
    cen.get(i).display();
  }
  delay(60);
  draw_iter++;
}

public class HexCircle implements Comparable<HexCircle> {
  float x=0;
  float y=0;
  float d=0;
  float rad = 0;
  int dist_from_center=0;
  
  HexCircle(float x_in, float y_in, float d_in, int dist_in) {
    this.x = x_in;
    this.y = y_in;
    this.d = d_in;
    this.dist_from_center = dist_in;
  }
  
  void display() {
    fill(c[dist_from_center % c.length]);
    //noFill();
    //stroke(c[dist_from_center % c.length]);
    ellipse(x,y,d,d);
  }
  
  void setAngle(float a) {
    this.rad = a;
  }
  
  @Override
  public int compareTo(HexCircle hc){
     /* 
      * Sorting by last name. compareTo should return < 0 if this(keyword) 
      * is supposed to be less than au, > 0 if this is supposed to be 
      * greater than object au and 0 if they are supposed to be equal.
     */
     int comp = 0;
     if (this.dist_from_center < hc.dist_from_center) {
       comp = -1;
     } else if (this.dist_from_center > hc.dist_from_center) {
       comp = 1;
     } else if (this.dist_from_center == hc.dist_from_center) {
       if (this.rad < hc.rad) {
         comp = -1;
       } else if (this.rad > hc.rad) {
         comp = 1;
       } else if (this.rad == hc.rad) {
         comp = 0;
       }
     }
     return comp;
  }
}
