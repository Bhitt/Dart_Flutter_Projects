import 'package:flutter/material.dart';

import "package:p5/p5.dart";
import "sketch.dart";

void main() => runApp(MyApp());

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() {
    return new _MyHomePageState();
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Dijkstra\'s',
      theme: new ThemeData(
        // This is the theme of the application.
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Dijkstra\'s'),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  MySketch sketch;
  PAnimator animator;

  @override
  void initState() {
    super.initState();
    sketch = new MySketch();
    // Need an animator to call the draw() method in the sketch continuously,
    // otherwise it will be called only when touch events are detected.
    animator = new PAnimator(this);
    animator.addListener(() {
      setState(() {
        sketch.redraw();
      });
    });
    animator.run();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Dijkstra\s Visualized!")),
      backgroundColor: const Color.fromRGBO(200, 200, 200, 1.0),
      body: new Center(
        child:new PWidget(sketch),
      ),
    );
  }
}
