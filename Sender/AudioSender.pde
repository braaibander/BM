class Audiosender implements AudioListener
{
  Audiosender(){}
  
  // This part is implementing AudioListener interface, see Minim reference
  synchronized void samples(float[] samp)
  {
     byte[] bytes = this.floatToByte(samp);
     udp.send(bytes, location, clientPort + 1);
  }
  
  synchronized void samples(float[] sampL, float[] sampR){
    print("Stereo not supported");
  }  
  
  public byte[] floatToByte(float[] input) {
    byte[] ret = new byte[input.length*4];
    for (int x = 0; x < input.length; x++) {
        ByteBuffer.wrap(ret, x*4, 4).putFloat(input[x]);
    }
    return ret;
  }
} 
