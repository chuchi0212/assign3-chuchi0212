final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;

final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;

PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage bg, soil8x24;

PImage [] soil;
int soilLayer = 24;
int soilX[], soilY[];
int soilStart = 160;

PImage [] life;
int lifeMax = 5;
int lifeX, lifeY;

PImage groundhogDown, groundhogIdle, groundhogLeft, groundhogRight;
float groundhogX = 320;
float groundhogY = 80;
int speed1 = 5;
int speed2 = 6;

boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

int time;

int grassStart = 160;

PImage stone1,stone2;
int stone1X,stone1Y,stone2X,stone2Y;
int stoneStart = 160;

// For debug function; DO NOT edit or remove this!
int playerHealth = 0;
float cameraOffsetY = 0;
boolean debugMode = false;

void setup() {
	size(640, 480, P2D);
	// Enter your setup code here (please put loadImage() here or your game will lag like crazy)
	bg = loadImage("img/bg.jpg");
	title = loadImage("img/title.jpg");
	gameover = loadImage("img/gameover.jpg");
	startNormal = loadImage("img/startNormal.png");
	startHovered = loadImage("img/startHovered.png");
	restartNormal = loadImage("img/restartNormal.png");
	restartHovered = loadImage("img/restartHovered.png");
  groundhogDown = loadImage("img/groundhogDown.png");
  groundhogIdle = loadImage("img/groundhogIdle.png");
  groundhogLeft = loadImage("img/groundhogLeft.png");
  groundhogRight = loadImage("img/groundhogRight.png");
  stone1 = loadImage("img/stone1.png");
  stone2 = loadImage("img/stone2.png");
  
  // soil
  soil = new PImage[soilLayer];
  soilX = new int [8];
  soilY = new int [24];
  for (int i=0; i < soilLayer ; i++){
    if(0 <= i && i< 4){
      soil[i] = loadImage("img/soil0.png");      
    }
    else if(4 <= i && i< 8){
      soil[i] = loadImage("img/soil1.png");      
    }
    else if(8 <= i && i< 12){
      soil[i] = loadImage("img/soil2.png");      
    }
    else if(12 <= i && i< 16){
      soil[i] = loadImage("img/soil3.png");      
    }
    else if(16 <= i && i< 20){
      soil[i] = loadImage("img/soil4.png");      
    }
    else if(20 <= i && i< 24){
      soil[i] = loadImage("img/soil5.png");      
    }
  }
  // Life
  life = new PImage[lifeMax];
  for(int i=0; i <lifeMax ; i++){
    life[i] = loadImage("img/life.png"); 
  }
  playerHealth = 2;

}

void draw() {
    /* ------ Debug Function ------ 

      Please DO NOT edit the code here.
      It's for reviewing other requirements when you fail to complete the camera moving requirement.

    */
    if (debugMode) {
      pushMatrix();
      translate(0, cameraOffsetY);
    }
    /* ------ End of Debug Function ------ */

    
	switch (gameState) {

		case GAME_START: // Start Screen
		image(title, 0, 0);

		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(startHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
			}

		}else{

			image(startNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;

		case GAME_RUN: // In-Game

		// Background
		image(bg, 0, 0);

		// Sun
	    stroke(255,255,0);
	    strokeWeight(5);
	    fill(253,184,19);
	    ellipse(590,50,120,120);

		// Grass
		fill(124, 204, 25);
		noStroke();
		rect(0, grassStart - GRASS_HEIGHT, width, GRASS_HEIGHT);

		// Soil - REPLACE THIS PART WITH YOUR LOOP CODE!
    for(int i=0; i < 24 ; i++){
      for(int p=0 ; p<8 ; p++ ){
        soilX[p] = p*80;
        soilY[i] = i*80;
        image(soil[i], soilX[p], soilY[i] + soilStart);
      }
    }
    // Stone
    for (int i=0; i < 24 ; i++){
      // 1-8
      if(i >= 0 && i < 8){
        stone1X = i*80;
        stone1Y = i*80;
        image(stone1, stone1X, stone1Y+stoneStart);
      }
      // 9-16
      if(i >= 8 && i < 16){ 
        if(i % 4 == 0 || i % 4 == 3){
          for(int p=0 ; p<8 ; p++ ){
            if(p % 4 == 1 || p % 4 == 2){
              stone1X = p*80;              
            }else{
              stone1X = 640;
            }
            stone1Y = i*80;
            image(stone1, stone1X, stone1Y+stoneStart);  
          }
        }else if(i % 4 == 1 || i % 4 == 2){
          for(int p=0 ; p<8 ; p++ ){
            if(p % 4 == 0 || p % 4 == 3){
              stone1X = p*80;
            }else{
              stone1X = 640;
            }
            stone1Y = i*80;
            image(stone1, stone1X, stone1Y+stoneStart); 
          }
        }     
      }
      // 17-24
      if(i >= 16 && i< 24){
        if(i % 3 == 1){
          for(int p=0 ; p<8 ; p++ ){
            if(p % 3 == 1 || p % 3 == 2){
              stone1X = p*80;              
            }else{
              stone1X = 640;
            }
            stone1Y = i*80;
            image(stone1, stone1X, stone1Y+stoneStart);  
          }
          for(int p=0 ; p<8 ; p++ ){
            if(p % 3 == 2){
              stone2X = p*80;              
            }else{
              stone2X = 640;
            }
            stone2Y = i*80;
            image(stone2, stone2X, stone2Y+stoneStart);  
          }
        }else if(i % 3 == 2){
          for(int p=0 ; p<8 ; p++ ){
            if(p % 3 == 0 || p % 3 == 1){
              stone1X = p*80;
            }else{
              stone1X = 640;
            }
            stone1Y = i*80;
            image(stone1, stone1X, stone1Y+stoneStart); 
          }
          for(int p=0 ; p<8 ; p++ ){
            if(p % 3 == 1){
              stone2X = p*80;              
            }else{
              stone2X = 640;
            }
            stone2Y = i*80;
            image(stone2, stone2X, stone2Y+stoneStart);  
          }
        }else if(i % 3 == 0){
          for(int p=0 ; p<8 ; p++ ){
            if(p % 3 == 0 || p % 3 == 2){
              stone1X = p*80;
            }else{
              stone1X = 640;
            }
            stone1Y = i*80;
            image(stone1, stone1X, stone1Y+stoneStart); 
          }
          for(int p=0 ; p<8 ; p++ ){
            if(p % 3 == 0){
              stone2X = p*80;              
            }else{
              stone2X = 640;
            }
            stone2Y = i*80;
            image(stone2, stone2X, stone2Y+stoneStart);  
          }
        }
      }
      
    }

		// Player
    if(time == 0){
      image(groundhogIdle ,groundhogX, groundhogY);
     }
     
     if(downPressed){
       if(soilStart == -1440){
         if(groundhogY + 80 < height ){
           time++;
           if(time >= 1 && time <= 14){
             leftPressed = false;
             rightPressed = false;
             if(time % 3 == 1 || time % 3 == 2){
               groundhogY += speed1;
             }else if (time % 3 == 0){
               groundhogY += speed2;
             }
             image(groundhogDown, groundhogX, groundhogY);
           }
           if(time == 15){
             groundhogY += speed2;
             image(groundhogIdle, groundhogX, groundhogY);
             time = 0 ;
             downPressed = false;
             leftPressed = false;
             rightPressed = false;
           }
         }else{
           downPressed = false;
           groundhogY = height - 80;
         }
       }
       if(soilStart > -1440){
         if(groundhogY + 80 < height ){
           time++;
           if(time >= 1 && time <= 14){
             leftPressed = false;
             rightPressed = false;
             if(time % 3 == 1 || time % 3 == 2){
               soilStart -= speed1;
               stoneStart -= speed1;
               grassStart -= speed1;
             }else if (time % 3 == 0){
               soilStart -= speed2;
               stoneStart -= speed2;
               grassStart -= speed2;
             }
             image(groundhogDown, groundhogX, groundhogY);
           }
           if(time == 15){
             soilStart -= speed2;
             stoneStart -= speed2;
             grassStart -= speed2;
             image(groundhogIdle, groundhogX, groundhogY);
             time = 0 ;
             downPressed = false;
             leftPressed = false;
             rightPressed = false;
           }
         }else{
           downPressed = false;
           groundhogY = height - 80;
         }
       }
     }
     
     if(leftPressed){
       if(groundhogX > 0 ){
         time++;
         if(time >= 1 && time <= 14){
           downPressed = false;
           rightPressed = false;
           if(time % 3 == 1 || time % 3 == 2){
             groundhogX -= speed1;
           }else if (time % 3 == 0){
             groundhogX -= speed2;
           }
           image(groundhogLeft, groundhogX, groundhogY);
         }
         if(time == 15){
           groundhogX -= speed2;
           image(groundhogIdle, groundhogX, groundhogY);
           time = 0 ;
           downPressed = false;
           leftPressed = false;
           rightPressed = false;
         }
       }else{
         leftPressed = false;
         groundhogX = 0;
       }
     }
      
     if(rightPressed){
       if (groundhogX < width - 80){
         time++;
         if(time >= 1 && time <= 14){
           downPressed = false;
           leftPressed = false;
           if(time % 3 == 1 || time % 3 == 2){
             groundhogX += speed1;
           }else if (time % 3 == 0){
             groundhogX += speed2;
           }
           image(groundhogRight, groundhogX, groundhogY);
         }
         if(time == 15){
           groundhogX += speed2;
           image(groundhogIdle, groundhogX, groundhogY);
           time = 0 ;
           downPressed = false;
           leftPressed = false;
           rightPressed = false;
         }
       }else{
         rightPressed = false;
         groundhogX = width - 80;
       }
     }

		// Health UI
    if( playerHealth != 0){
      for(int i=0; i < min(playerHealth,5) ; i++){
        lifeX = 10 + 20*i + 50*i ;
        lifeY = 10;
        image(life[i], lifeX, lifeY); 
      }
    }else if(playerHealth == 0){
      gameState = GAME_OVER;
    }

		break;

		case GAME_OVER: // Gameover Screen
		image(gameover, 0, 0);
		
		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
				// Remember to initialize the game here!
        playerHealth = 2;
        rightPressed = false;
        leftPressed = false;
        downPressed = false;
        groundhogX = 320;
        groundhogY = 80;
        soilStart = 160;
        stoneStart = 160;
        grassStart = 160;
			}
		}else{

			image(restartNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;
		
	}

    // DO NOT REMOVE OR EDIT THE FOLLOWING 3 LINES
    if (debugMode) {
        popMatrix();
    }
}

void keyPressed(){
	// Add your moving input code here
switch(keyCode){
  case DOWN: 
  if(groundhogX % 80 == 0 && groundhogY % 80 ==0 && soilStart % 80 ==0 && stoneStart % 80 == 0 && grassStart % 80 == 0){
   downPressed = true;
   leftPressed = false;
   rightPressed = false;
  }
   break;
  case LEFT:
  if(groundhogX % 80 == 0 && groundhogY % 80 ==0 && soilStart % 80 ==0 && stoneStart % 80 == 0 && grassStart % 80 == 0){
   leftPressed = true;
   downPressed = false;
   rightPressed = false;
  }
   break;
  case RIGHT:
  if(groundhogX % 80 == 0 && groundhogY % 80 ==0 && soilStart % 80 ==0 && stoneStart % 80 == 0 && grassStart % 80 == 0){
   rightPressed = true;
   leftPressed = false;
   downPressed = false;
  }
   break;      
 }
	// DO NOT REMOVE OR EDIT THE FOLLOWING SWITCH/CASES
    switch(key){
      case 'w':
      debugMode = true;
      cameraOffsetY += 25;
      break;

      case 's':
      debugMode = true;
      cameraOffsetY -= 25;
      break;

      case 'a':
      if(playerHealth > 0) playerHealth --;
      break;

      case 'd':
      if(playerHealth < 5) playerHealth ++;
      break;
    }
}
