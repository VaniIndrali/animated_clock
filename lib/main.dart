import 'package:flutter/material.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatefulWidget {
  @override
  _MyappState createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "My Clock",
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;
  // _ represents private fn in dart
  // function created to fetch the server time
  _currentTime() {
    return "${DateTime.now().hour} : ${DateTime.now().minute} : ${DateTime.now().second}";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animationController.addListener(() {
      if (animationController.isCompleted) {
        animationController.reverse();
      } else if (animationController.isDismissed) {
        animationController.forward();
      }
      setState(() {});
    });
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut);
    animation = Tween(begin: -0.5, end: 0.5).animate(animation);
    return Scaffold(
      appBar: AppBar(
          title: Center(child: Text("My Digital Clock")),
          backgroundColor: Colors.deepOrange,
          elevation: 0.0 // to remove the shadow appbar has
          ),
      body: Container(
        color: Colors.deepOrange,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            children: <Widget>[
              Material(
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                color: Colors.brown.shade900,
                elevation: 10.0,
                child: Container(
                  width: 320,
                  height: 320,
                  child: Center(
                    child: Text(
                      _currentTime(),
                      style: TextStyle(
                          fontSize: 50.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Transform(
                alignment: FractionalOffset(0.5, 0.1),
                transform: Matrix4.rotationZ(animation.value),
                child: Container(
                  margin: EdgeInsets.only(top: 8),
                  child: Image.asset(
                    "images/pandulum.png",
                    width: 180,
                    height: 250,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
