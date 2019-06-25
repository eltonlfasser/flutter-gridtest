import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grid Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: "Flutter Grid Drag Test"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  List gridData = [
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j',
    'k',
    'l',
    'm',
    'o',
    'p',
    'q'
  ];

  Widget buildGrid(int index) {
    final track = gridData[index];
    Card card = Card(
      key: ValueKey(index),
      child: Container(
        color: Colors.amber,
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Text(
                '${gridData[index]}',
                style: TextStyle(
                  fontSize: 30.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    Draggable dragGridCard = LongPressDraggable(
      data: track,
      maxSimultaneousDrags: 1,
      child: card,
      childWhenDragging: Opacity(
        opacity: 0.2,
        child: card,
      ),
      feedback: Material(
        color: Colors.black.withOpacity(0.2),
        child: card,
        elevation: 4.0,
      ),
    );

    return DragTarget(
      onWillAccept: (track) {
        return gridData.indexOf(track) != index;
      },
      onAccept: (track) {
        setState(() {
          var changefromValue = track;
          var changeToValue = gridData[index];
          int changeFromIndex = gridData.indexOf(track);
          int changeToIndex = index;
          gridData[changeToIndex] = changefromValue;
          gridData[changeFromIndex] = changeToValue;
        });
        print('index after   $track $gridData]');
      },
      builder:
          (BuildContext context, selectedData, List<dynamic> rejectedData) {
        return Column(
          children: <Widget>[
            AnimatedSize(
              duration: Duration(milliseconds: 100),
              vsync: this,
              child: selectedData.isEmpty
                  ? Container()
                  : Opacity(
                      opacity: 0.0,
                      child: card,
                    ),
            ),
            Container(
              // color: Colors.orange,
              child: selectedData.isEmpty ? dragGridCard : card,
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            child: new GridView.builder(
                itemCount: gridData.length,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (BuildContext context, int index) {
                  return buildGrid(index);
                })));
  }
}
