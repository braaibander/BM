// Daniel Shiffman
// <http://www.shiffman.net>

// A Thread using receiving UDP to receive images

import java.awt.image.*; 
import javax.imageio.*;
import java.net.*;
import java.io.*;

// Config
Boolean fullScreen = true;

PImage video;
ReceiverThread thread;

void setup() {
  //fullScreen();
  size(640, 480);
  
  video = createImage(640, 480, RGB);
  thread = new ReceiverThread(video.width, video.height);
  thread.start();
}

 void draw() {
  if (thread.available()) {
    video = thread.getImage();
  }

  // Draw the image
  background(0);
  imageMode(CENTER);
  image(video, width/2, height/2);
}
