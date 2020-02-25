class InputOutputBind implements AudioSignal, AudioListener
{
  private float[] leftChannel ;
  private float[] rightChannel;
  
  InputOutputBind(int sample)
  {
    leftChannel = new float[sample];
    rightChannel= new float[sample];
  }
  
  // This part is implementing AudioSignal interface, see Minim reference
  void generate(float[] samp)
  {
    arrayCopy(leftChannel, samp);
  }
  
  void generate(float[] left, float[] right)
  {
     arrayCopy(leftChannel, left);
     arrayCopy(rightChannel, right);
  }
  
  // This part is implementing AudioListener interface, see Minim reference
  synchronized void samples(float[] samp)
  {
     arrayCopy(samp, leftChannel);
  }
  
  synchronized void samples(float[] sampL, float[] sampR)
  {
    arrayCopy(sampL, leftChannel);
    arrayCopy(sampR, rightChannel);
  }  
} 
