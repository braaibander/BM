import java.awt.image.*; 
import javax.imageio.*;
import java.net.*;
import java.io.*;
import java.time.*;

String machineId = "pc1";

// Config
HashMap<String,Integer> ports = new HashMap<String, Integer>() {{
    put("pc1", 9101);
    put("pc2", 9100);
}};
HashMap<String,Integer> widths = new HashMap<String, Integer>() {{
    put("pc1", 640);
    put("pc2", 640);
}};
HashMap<String,Integer> heights = new HashMap<String, Integer>() {{
    put("pc1", 480);
    put("pc2", 480);
}};

int imageWidth = widths.get(machineId);
int imageHeight = heights.get(machineId);
int clientPort = ports.get(machineId); 

PImage video;
ReceiverThread thread;

void setup() {
  //fullScreen();
  size(640, 480, P2D);
  
  println("Listening on port: " + clientPort);
  
  video = createImage(imageWidth, imageHeight, RGB);
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
