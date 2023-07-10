JSONObject jsonFile;
int quantityPixelsX = 600;
int quantityPixelsY = 600;
float framerate = 60;
float unitPerPixel = 8;
int numberMaxWaves = 30;
float slitWidth = 1500; //Informar o valor em nanometros
float frequencyWaves = 1300; //Informar o valor em nanometros

void setup(){
  size(600, 600);
  frameRate(framerate);
  jsonFile = loadJSONObject("settings.json");
  
  float frequencyWavesInNm = 0;
  float slitsWidthInNm = 0;
  int numberWaves = 0;
  try{
    frequencyWavesInNm = jsonFile.getFloat("frequencyWavesInNm");
    numberWaves = jsonFile.getInt("numberWaves");
    slitsWidthInNm = jsonFile.getFloat("slitsWidthInNm");
  }catch(Exception e){
    print(e);
  }
  
  if(frequencyWavesInNm > 0){
   frequencyWaves = frequencyWavesInNm;
   print("\nConfigurando valor da frequencia de ondas para "+frequencyWaves+ " nanometros.");
  }
  if(numberWaves > 0){
    numberMaxWaves = numberWaves;
    print("\nConfigurando quantas ondas serao desenhadas para "+numberMaxWaves+ ".");
  }
  if(slitsWidthInNm > 0){
    slitWidth = slitsWidthInNm;
    print("\nConfigurando valor da largura da fenda para "+slitWidth+ " nanometros.");
  }
}

void drawCurveWithoutFill(
  float pointOneX,
  float pointOneY,
  float pointTwoX,
  float pointTwoY,
  float curveIntensity,
  int colorLine
){
    float intensity = curveIntensity * unitPerPixel;
    stroke(colorLine); 
    strokeWeight(4);
    noFill();
    curve( 
      map((pointOneX - intensity), -unitPerPixel, unitPerPixel, 0, 600),
      map(pointOneY, -unitPerPixel, unitPerPixel, 0, 600),
      map(pointOneX, -unitPerPixel, unitPerPixel, 0,600),
      map(pointOneY, -unitPerPixel, unitPerPixel, 0, 600),
      map(pointTwoX, -unitPerPixel, unitPerPixel, 0,600),
      map(pointTwoY, -unitPerPixel, unitPerPixel, 0, 600),
      map((pointTwoX -intensity), -unitPerPixel, unitPerPixel, 0,600),
      map(pointTwoY, -unitPerPixel, unitPerPixel, 0, 600)
    );
}
void replicatingWave(
  float slitPosition,
  float slitWidth,
  float waveFrequency,
  int colorLine
){
  float frequency = waveFrequency / 1000; // Convertendo nanometro em unidade de escala
  float ScreenLeftPosition = -8;
  float halfWidthSlit = slitWidth / 2000; // Convertendo nanometro em unidade de escala
  
  for(int i = 1; i <= numberMaxWaves; i++){
    drawCurveWithoutFill(
    ScreenLeftPosition,
    (slitPosition - halfWidthSlit)-(frequency*i), 
    ScreenLeftPosition, 
    (slitPosition + halfWidthSlit)+(frequency*i), 
    (frequency*i),
    colorLine);
  }
}
void draw(){
  float slitOnePosition = -3;
  float slitTwoPosition = 4;
   background(0);
   
   replicatingWave(slitOnePosition, slitWidth, frequencyWaves, #FF0D00);
   replicatingWave(slitTwoPosition, slitWidth, frequencyWaves, #1FFC0D);
}
