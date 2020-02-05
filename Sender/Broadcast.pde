
void broadcast(PImage input) {

  // Create buffered image for JPG encoding
  BufferedImage bufferedImg = new BufferedImage(input.width, input.height, BufferedImage.TYPE_INT_RGB);

  // Load localFrame to the BufferedImage
  input.loadPixels();
  bufferedImg.setRGB(0, 0, input.width, input.height, input.pixels, 0, input.width);

  // Need these output streams to get image as bytes for UDP communication
  ByteArrayOutputStream outputStream  = new ByteArrayOutputStream();

  // Turn the BufferedImage into a JPG and put it in the BufferedOutputStream
  // Requires try/catch
  try {
    ImageIO.write(bufferedImg, "jpg", new BufferedOutputStream(outputStream));
  } 
  catch (IOException e) {
    e.printStackTrace();
  }

  // Get the byte array, which we will send out via UDP!
  byte[] packet = outputStream.toByteArray();

  // Send JPEG data as a datagram
//  println("Sending datagram with " + packet.length + " bytes");
  try {
    socket.send(new DatagramPacket(
      packet,packet.length, 
      InetAddress.getByName(location),
      clientPort
    ));
  } 
  catch (Exception e) {
    e.printStackTrace();
  }
}
