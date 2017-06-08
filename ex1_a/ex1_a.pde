PImage img, outImg1, outImg2, outImg3, outImg4;

void setup() {
  img = loadImage("tomato.png");
  size(700, 800, P3D);
  frameRate(30);
  textFont(createFont("Century", 30));
  textAlign(LEFT, TOP);

  float t1 = 0.0;
  float t2 = 0.0;

  outImg1 = createImage(img.width, img.height, RGB);
  outImg2 = createImage(img.width, img.height, RGB);
  outImg3 = createImage(img.width, img.height, RGB);
  outImg4 = createImage(img.width, img.height, RGB);

  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      float r = red(img.pixels[y * img.width + x]);
      float g = green(img.pixels[y * img.width + x]);
      float b = blue(img.pixels[y * img.width + x]);

      outImg1.pixels[y * img.width + x] = color(light(r, g, b));
      outImg2.pixels[y * img.width + x] = color(bright(r, g, b));

      t1 += light(r, g, b);
      t2 += bright(r, g, b);
    }
  }

  float s1 = t1 / (img.width * img.height);
  float s2 = t2 / (img.width * img.height);

  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      float r = red(img.pixels[y * img.width + x]);
      float g = green(img.pixels[y * img.width + x]);
      float b = blue(img.pixels[y * img.width + x]);
      if (light(r, g, b) >= s1) {
        outImg3.pixels[y * img.width + x] = color(255);
      } 
      else {
        outImg3.pixels[y * img.width + x] = color(0);
      }
      if (bright(r, g, b) >= s2) {
        outImg4.pixels[y * img.width + x] = color(255);
      } 
      else {
        outImg4.pixels[y * img.width + x] = color(0);
      }
    }
  }
  
}

void draw() {
  background(0);

  text("Original", 0, 0);
  image(img, 0, 30);

  text("Lightness", 0, img.height + 40);
  image(outImg1, 0, img.height + 70);

  text("Brightness", img.width + 30, img.height + 40);
  image(outImg2, img.width + 30, img.height + 70);

  text("Lightness(BW)", 0, img.height * 2 + 80);
  image(outImg3, 0, img.height * 2 + 110);

  text("Brightness(BW)", img.width + 30, img.height * 2 + 80);
  image(outImg4, img.width + 30, img.height * 2 + 110);
}

float light(float r, float g, float b) {
  return (r + g + b) / 3;
}

float bright(float r, float g, float b) {
  return (0.3 * r) + (0.6 * g) + (0.1 * b);
}

