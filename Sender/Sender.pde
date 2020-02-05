import hypermedia.net.*;

import processing.video.*;

import javax.imageio.*;
import java.awt.image.*; 
import java.net.*;
import java.io.*;

// Config
int clientPort = 9100; 
int imageWidth = 640;
int imageHeight = 480;
String location = "192.168.2.15";

// This is our object that sends UDP out
DatagramSocket socket; 
Capture cam;

void setup() {
  println(Capture.list());
  
  size(1280, 720);
  // Setting up the DatagramSocket, requires try/catch
  try {
    socket = new DatagramSocket();
  } catch (SocketException e) {
    e.printStackTrace();
  }
  
  // Initialize Camera
  cam = new Capture(this, imageWidth, imageHeight, 30);
  cam.start();
}

void captureEvent( Capture c ) {
  c.read();
  // Whenever we get a new image, send it!
  broadcast(c);
}

void draw() {
  image(cam,0,0);
}
