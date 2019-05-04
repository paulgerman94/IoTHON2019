import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iothon2019/homepage.dart';
//Date

class ControlsPage extends StatefulWidget {
  ControlsPage();

  @override
  ControlsPageState createState() => new ControlsPageState();
}

class ControlsPageState extends State<ControlsPage> {
  ControlsPageState();

  @override
  void initState() {
    super.initState();
//    this.initService();
//    this.getCurrentDate();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(FontAwesomeIcons.arrowLeft),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            }), //IconButton
        title: Text("sss"),
      ), //AppBar

      body: Container(), // <Widget>[]//Scaffold
    );
  }
}
