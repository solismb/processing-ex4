import processing.opengl.*;
PImage img, img1, img2;

void setup() {
  size(screen.width, 900, P3D);
  frameRate(30);

  img = loadImage("noise500.png");

  textFont(createFont("Century", 30));
  textAlign(LEFT, TOP);
}

void draw() {
  background(0);

  //color a = 0;
  float ar = 0, ag = 0, ab = 0;
  color m[] = new color[9];
  //float mr[] = new float[9], mg = new float[9], mb = new float[9];
  int k = 0;

  img1 = createImage(img.width, img.height, RGB);
  img2 = createImage(img.width, img.height, RGB);

  for (int y = 1; y < img.height - 1; y++) {
    for (int x = 1; x < img.width - 1; x++) {
      for (int ny = y - 1; ny <= y + 1; ny++) {
        for (int nx = x - 1; nx <= x + 1; nx++) {
          float r = red(img.pixels[ny * img.width + nx]);
          float g = green(img.pixels[ny * img.width + nx]);
          float b = blue(img.pixels[ny * img.width + nx]);

          ar += r; 
          ag += g; 
          ab += b;

          m[k] = color(r, g, b);
          k++;
        }
      }
      img1.pixels[y * img.width + x] = color(ar / 9, ag / 9, ab / 9);
      ar = 0; 
      ag = 0; 
      ab = 0;

      for (int i = 0; i < 8; i++) {
        for (int j = i + 1; j < 9; j++) {
          if (m[i] < m[j]) {
            color temp = m[i];
            m[i] = m[j];
            m[j] = temp;
          }
        }
      }
      img2.pixels[y * img.width + x] = m[3];
      k = 0;
    }
  }

  text("Original", 0, 0);
  image(img, 0, 30);

  text("Average", 0, img.height + 40);
  image(img1, 0, img.height + 70);

  text("Median", img.width + 30, img.height + 40);
  image(img2, img.width + 30, img.height + 70);
}

void keyPressed() {
  if (key == '1') {
    img = loadImage("noise500.png");
  } 
  else if (key == '2') {
    img = loadImage("noise5000.png");
  } 
  else if (key == '3') {
    img = loadImage("noise50000.png");
  }
}

