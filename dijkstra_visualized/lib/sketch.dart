// import 'dart:collection';

import "package:p5/p5.dart";
import "dart:math";
import "dart:ui";

// import "min_priority_queue.dart";
// import "node.dart";


var cols = 10;
var rows = 10;
List<List<Spot>> grid;

class MySketch extends PPainter {
  Set<Spot> _q;
  List<Spot> solution;


  var start;
  var end;
  var w;
  var h;

  void setup() {
    //Use the devices full screen as the canvas size
    fullScreen();
    width*=4;
    height*=4;


    //find size of width and height
    w = width / cols;
    h = height / rows;

    //create the grid
    grid = new List(cols);

    //create a list for the solution
    solution = new List<Spot>();

  
    //Make the 2D array for the grid
    for(var i=0; i< cols; i++){
      grid[i] = new List<Spot>(rows);
    }

    for(var i=0; i< cols; i++){
      for(var j=0; j<rows; j++){
         grid[i][j] = new Spot(i,j);
      }
    }

    //add each Spot's neighbors to it
    for(var i=0; i< cols; i++){
      for(var j=0; j<rows; j++){
         grid[i][j].addNeighbors(grid);
      }
    }


    //Create a vertex set Q, distance List, and Previous List
    _q = new Set<Spot>();

    //set each vertex's distance to a max value and add it to the queue
    for(var i=0; i< cols; i++){
      for(var j=0; j<rows; j++){
        _q.add(grid[i][j]);
      }
    }

    //set the initial start distance to zero
    grid[0][0].distance = 0;

  }

  void draw() {
    //acts as the while loop in dijkstra's algorithm

    //clear with white for rendered frames
    background(color(0,0,0));

    for(var i=0; i< cols; i++){
      for(var j=0; j<rows; j++){
         showGridSquare(grid[i][j], color(255,255,255));
      }
    }

    int alt;
    if(_q.length > 0){
      //find the vertex with the minimum distance in the queue
      Spot u = _q.elementAt(0);
      for (Spot e in _q) {
        if(e.distance < u.distance) u = e;
      }
      //remove that vertex from Q
      _q.remove(u);

      showGridSquare(u, color(0,0,255));

      //for each neighbor of u that is still in Q
      for (Spot neighbor in u.neighbors) {
        if(_q.contains(neighbor)){
          showGridSquare(neighbor, color(255,0,0));
          //find the edge length
          alt = u.distance + edgeLength(u, neighbor);
          //if the path through u to neighbor is shorter than it current dist
          if(alt < neighbor.distance){
            neighbor.distance = alt;
            neighbor.prev = u;
          }
        }
        //otherwise neighbor isn't in Q and can be ignored
      }
    } else {
      //backtrack through path to find a solution
      Spot s = grid[cols -1][rows-1];
      showGridSquare(s, color(0,255,0));
      if(s.prev == null){
        showGridSquare(s, color(0,0,255));
      }
      while(s.prev != null){
        //add the previous node in the path to the solution
        solution.add(s.prev);
        //switch to that node
        s = s.prev;
      }
      //output the final path
      for(int i=solution.length-1;i>=0;i--){
        showGridSquare(solution[i], color(0,255,0));
      }
    }
    //
  
  }

  void showGridSquare(Spot spot, Color c){
    fill(c);
    noStroke();
    rect(spot.i*w, spot.j*h, w -1, h -1);
  }

  int edgeLength(Spot u, Spot v){
    return sqrt(pow(v.i - u.i, 2) +  pow(v.j - u.j, 2) * 1.0).round(); 
  }
  


}

class Spot{
  //properties
  var i;
  var j;
  int distance;
  List<Spot> neighbors;
  Spot prev;

  //constructor
  Spot(var i, var j){
    this.i=i;
    this.j=j;
    distance = 5000;
    prev=null;
    neighbors = new List<Spot>();
  }

  //function to keep track of adjacent nodes
  void addNeighbors(List<List<Spot>> grid){
    //grab the coordinates for writability/readability
    var i = this.i;
    var j = this.j;
    //add neighbors surrounding spot
    if(i < cols-1){
      this.neighbors.add(grid[i+1][j]);
    }
    if(i > 0){
      this.neighbors.add(grid[i-1][j]);
    }
    if(j < rows-1){
      this.neighbors.add(grid[i][j+1]);
    }
    if(j > 0){
      this.neighbors.add(grid[i][j-1]);
    }
    if(i > 0 && j > 0){
      this.neighbors.add(grid[i-1][j-1]);
    }
    if(i < cols-1 && j > 0){
      this.neighbors.add(grid[i+1][j-1]);
    }
    if(i > 0 && j < rows-1){
      this.neighbors.add(grid[i-1][j+1]);
    }
    if(i < cols-1 && j < rows-1){
      this.neighbors.add(grid[i+1][j+1]);
    }

  }

}

class Vertex{
  int i;
  int j;
  Vertex(int i, int j){
    this.i = i;
    this.j = j;
  }

}