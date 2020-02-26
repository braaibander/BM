class AudioReceiver extends Thread implements AudioSignal
{
  DatagramSocket ds; 
  byte[] buffer = new byte[65536]; 
  
  AudioReceiver()
  {   
    try {
      ds = new DatagramSocket(clientPort);
    } catch (SocketException e) {
      println("SocketException at: " + LocalDate.now() + " " + LocalTime.now());
      e.printStackTrace();
    }
  }
  
  // This part is implementing AudioSignal interface, see Minim reference
  void generate(float[] samp)
  {
    byte[] bytes = this.getData();
    float[] data = this.byteToFloat(bytes);
    arrayCopy(data, samp);
  }
  
  void generate(float[] left, float[] right){}

  private byte[] getData() 
  {
    DatagramPacket p = new DatagramPacket(buffer, buffer.length); 
    try {
      ds.receive(p);
    } 
    catch (IOException e) {
      println("IOException at: " + LocalDate.now() + " " + LocalTime.now());
      e.printStackTrace();;
    } 
    return p.getData();
  }

  public float[] byteToFloat(byte[] input) {
    float[] ret = new float[input.length/4];
    for (int x = 0; x < input.length; x+=4) {
        ret[x/4] = ByteBuffer.wrap(input, x, 4).getFloat();
    }
    return ret;
  }
} 
