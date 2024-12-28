#include <graphics.h>

int main() {
   int gd = DETECT, gm;
   initgraph(&gd, &gm, "");

   circle(100, 100, 50); 
   line(200, 200, 300, 300); 
   outtextxy(100, 200, "Hello, RenderX!"); 

   getch(); // Wait for a key press
   closegraph(); 
   return 0;
}
