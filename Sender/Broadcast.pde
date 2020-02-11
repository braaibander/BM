
void broadcast(PImage input) {

  try{
    // Create buffered image for JPG encoding
    BufferedImage bufferedImg = new BufferedImage(input.width, input.height, BufferedImage.TYPE_INT_RGB);
  
    // Load localFrame to the BufferedImage
    input.loadPixels();
    bufferedImg.setRGB(0, 0, input.width, input.height, input.pixels, 0, input.width);
  
    // Need these output streams to get image as bytes for UDP communication
    ByteArrayOutputStream outputStream  = new ByteArrayOutputStream();
    ImageIO.write(bufferedImg, "jpg", new BufferedOutputStream(outputStream));
  
    // Get the byte array, which we will send out via UDP!
    byte[] packet = outputStream.toByteArray();
  
    udp.send(packet, location, clientPort);
    // Send JPEG data as a datagram
    //socket.send(new DatagramPacket(
    //  packet,packet.length, 
    //  InetAddress.getByName(location),
    //  clientPort
    //));
  } 
  catch (Exception e) {
     println("Exception at: " + LocalDate.now() + " " + LocalTime.now());
     e.printStackTrace();
  }
}
