import hypermedia.net.*;
import processing.video.*;
import javax.imageio.*;
import java.awt.image.*; 
import java.net.*;
import java.io.*;
import java.time.*;

// Config
HashMap<String, String> ipAddresses = new HashMap<String, String>() {{
    put("pc1", "192.168.2.101");
    put("pc2", "192.168.2.102");
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

String machineId;
int imageWidth;
int imageHeight;
String location;
int clientPort; 

Capture cam;
UDP udp;

void setup() { 
  size(320, 240, P2D);
  
  machineId = getId();
  imageWidth = widths.get(machineId);
  imageHeight = heights.get(machineId);
  location = ipAddresses.get(machineId);
  clientPort = ports.get(machineId); 
  
  udp = new UDP(this);
  
  println("Sending to: " + location + ":" + clientPort);
  println("Dimensions: " + imageWidth + "x" + imageHeight);
  
  cam = new Capture(this, imageWidth, imageHeight, 30);
  cam.start();
}

void captureEvent( Capture c ) {
  c.read();
  broadcast(c);
}
