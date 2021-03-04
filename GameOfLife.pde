import de.bezier.guido.*;
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private Life[][] buttons;
private boolean[][] buffer;
private boolean running = true;

public void setup(){
  size(400, 400);
  frameRate(6);
  Interactive.make(this);
  buttons = new Life[NUM_ROWS][NUM_COLS];
  for(int i = 0; i < NUM_ROWS; i++){
    for(int j = 0; j < NUM_COLS; j++){
      buttons[i][j] = new Life(i, j);
    }
  }
  buffer = new boolean[NUM_ROWS][NUM_COLS];
  for(int i = 0; i < NUM_ROWS; i++){
    for(int j = 0; j < NUM_COLS; j++){
      buffer[i][j] = buttons[i][j].getLife();
    }
  }
}

public void draw(){
  background( 0 );
  if (running == false)
    return;
  copyFromButtonsToBuffer();
  for(int i = 0; i < NUM_ROWS; i++){
    for(int j = 0; j < NUM_COLS; j++){
     if(countNeighbors(i, j) == 3){
       buffer[i][j] = true;
     }
     else if(countNeighbors(i, j) == 2 && buttons[i][j].getLife()){
       buffer[i][j] = true;
     }
     else{
       buffer[i][j] = false;
     }
     buttons[i][j].draw();
     }
   }
  copyFromBufferToButtons();
}

public void keyPressed() {
  if(key == 's'){
    running = !running;
  }
  if(key == 'n'){
    frameRate(6);
  }
  if(key == 'w'){
    frameRate(2);
  }
  if(key == 't'){
    frameRate(70);
  }
}

public void copyFromBufferToButtons(){
  for(int i = 0; i < NUM_ROWS; i++){
    for(int j = 0; j < NUM_COLS; j++){
      buttons[i][j].setLife(buffer[i][j]);
    }
  }
}

public void copyFromButtonsToBuffer(){
  for(int i = 0; i < NUM_ROWS; i++){
    for(int j = 0; j < NUM_COLS; j++){
      buffer[i][j] = buttons[i][j].getLife();
    }
  }
}

public boolean isValid(int r, int c){
  if(r >= NUM_ROWS || r < 0 || c >= NUM_COLS || c < 0){
    return false;
  }
  return true;
}

public int countNeighbors(int row, int col){
  int neighbors = 0;
  if(isValid(row - 1,col - 1) && buttons[row - 1][col - 1].getLife() == true){
    neighbors ++;
  }
  if(isValid(row - 1,col) && buttons[row - 1][col].getLife() == true){
    neighbors ++;
  }
  if(isValid(row - 1,col + 1) && buttons[row - 1][col + 1].getLife() == true){
    neighbors ++;
  }
  if(isValid(row,col - 1) && buttons[row][col - 1].getLife() == true){
    neighbors ++;
  }
  if(isValid(row,col + 1) && buttons[row][col + 1].getLife() == true){
    neighbors ++;
  }
  if(isValid(row + 1,col - 1) && buttons[row + 1][col - 1].getLife() == true){
    neighbors ++;
  }
  if(isValid(row + 1,col) && buttons[row + 1][col].getLife() == true){
    neighbors ++;
  }
  if(isValid(row + 1,col + 1) && buttons[row + 1][col + 1].getLife() == true){
    neighbors ++;
  }
  return neighbors;
}

public class Life{
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean alive;
  public Life (int row, int col){
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    myRow = row;
    myCol = col; 
    x = myCol*width;
    y = myRow*height;
    alive = Math.random() < 0.5;
    Interactive.add(this);
  }
  public void mousePressed(){
    alive = !alive;
  }
  public void draw(){    
    if (alive != true)
      fill(0);
    else 
      fill(150);
    rect(x, y, width, height);
  }
  public boolean getLife(){
    return alive;
  }
  public void setLife(boolean living){
    alive = living;
  }
}
