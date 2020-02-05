import processing.video.*;
import javax.imageio.*;
import java.awt.image.*; 
import java.net.*;
import java.io.*;

String machineId = "pc1";

// Config
HashMap<String, String> ipAddresses = new HashMap<String, String>() {{
    put("pc1", "192.168.2.13");
    put("pc2", "192.168.2.15");
}};
HashMap<String,Integer> ports = new HashMap<String, Integer>() {{
    put("pc1", 9100);
    put("pc2", 9101);
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
String location = ipAddresses.get(machineId);
int clientPort = ports.get(machineId); 

// This is our object that sends UDP out
DatagramSocket socket; 
Capture cam;

void setup() { 
  size(1280, 720);
  
  try {
    socket = new DatagramSocket();
  } catch (SocketException e) {
    e.printStackTrace();
  }
  
  cam = new Capture(this, imageWidth, imageHeight, 30);
  cam.start();
}

void captureEvent( Capture c ) {
  c.read();
  broadcast(c);
}

void draw() {
  image(cam,0,0);
}
