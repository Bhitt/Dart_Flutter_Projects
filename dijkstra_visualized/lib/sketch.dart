import "package:p5/p5.dart";

class MySketch extends PPainter {
  var strokes = new List<List<PVector>>();
  int cols = 5;
  int rows = 5;
  var grid = List();

  void setup() {
    //Use the devices full screen as the canvas size
    fullScreen();
  
    //Make the 2D array for the grid
    for(var i=0; i< cols; i++){
      grid[i] = new List(rows);
    }

    for(var i=0; i< cols; i++){
      grid[i] = new List(rows);
    }

  }

  void draw() {
  }

  void dijkstra(var graph, var source){

  }


}