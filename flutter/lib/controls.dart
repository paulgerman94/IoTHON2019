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
              Navigator.pop(context);
            }), //IconButton
        title: Text("Information"),
      ), //AppBar

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(scrollDirection: Axis.vertical, children: <Widget>[
          _pollution(context),
          _discount(context),
          _brightness(context),
        ]),
      ), // <Widget>[]//Scaffold
    );
  }

  // ############ POLLUTION ############
  //Swichers
  bool _zero_switched = true;
  bool _eco_switched = true;
  bool _b_switched = true;
  bool _c_switched = true;

  // Pollution Layout
  Widget _pollution(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: _pollutionBox(),
    );
  }

  //Pollution Box
  Widget _pollutionBox() {
    return Padding(
        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "Pollution",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Categorie",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Allowed",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
            ),

            // Zero switcher row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      "0",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "(blue sticker)",
                      style: TextStyle(color: Colors.black, fontSize: 18.0),
                    ),
                  ),
                ]),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: new Switch(
                    value: _zero_switched,
                    onChanged: (bool value) {
                      setState(() {
                        _zero_switched = value;
                      });
                    },
                    activeTrackColor: Colors.lightBlueAccent,
                    activeColor: Colors.blue,
                  ),
                ),
              ],
            ),
            // ECO switcher row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Eco",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "(green & blue sticker)",
                      style: TextStyle(color: Colors.black, fontSize: 18.0),
                    ),
                  ),
                ]),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: new Switch(
                    value: _eco_switched,
                    onChanged: (bool value) {
                      setState(() {
                        _eco_switched = value;
                      });
                    },
                    activeTrackColor: Colors.lightBlueAccent,
                    activeColor: Colors.blue,
                  ),
                ),
              ],
            ),
            // B switcher row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      "B",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "(yellow sticker)",
                      style: TextStyle(color: Colors.black, fontSize: 18.0),
                    ),
                  ),
                ]),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: new Switch(
                    value: _b_switched,
                    onChanged: (bool value) {
                      setState(() {
                        _b_switched = value;
                      });
                    },
                    activeTrackColor: Colors.lightBlueAccent,
                    activeColor: Colors.blue,
                  ),
                ),
              ],
            ),
            // C switcher row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      "C",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "(green sticker)",
                      style: TextStyle(color: Colors.black, fontSize: 18.0),
                    ),
                  ),
                ]),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: new Switch(
                    value: _c_switched,
                    onChanged: (bool value) {
                      setState(() {
                        _c_switched = value;
                      });
                    },
                    activeTrackColor: Colors.lightBlueAccent,
                    activeColor: Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ));
  }

// ############ Public Transport discount ############
  double _sliderDiscountValue = 0.0;

  Widget _discount(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: _discountBox(),
    );
  }

  //Brightness Box
  Widget _discountBox() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "Public Transport Discount",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text(
                      'Value: ${(_sliderDiscountValue * 100).round()}' + " %",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                    new Slider(
                      value: _sliderDiscountValue,
                      onChanged: (double value) {
                        setState(() {
                          _sliderDiscountValue = value;
                        });
                      },
                      divisions: 100,
                    ),
                  ]),
            ),
          ]),
    );
  }

// ############ Brightness ############

  double _sliderBrightnessValue = 0.0;

  Widget _brightness(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: _brightnessBox(),
    );
  }

  //Brightness Box
  Widget _brightnessBox() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "Light poles brightness",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text(
                      'Value: ${(_sliderBrightnessValue * 100).round()}' + " %",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                    new Slider(
                      value: _sliderBrightnessValue,
                      onChanged: (double value) {
                        setState(() {
                          _sliderBrightnessValue = value;
                        });
                      },
                      divisions: 100,
                    ),
                  ]),
            ),
            RaisedButton(
              elevation: 4.0,
              onPressed: () {},
              textColor: Colors.white,
              padding: const EdgeInsets.all(0.0),
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.blue,
                ),
                padding: const EdgeInsets.all(10.0),
                child: Text('     SAVE     '),
              ),
            ),
          ]),
    );
  }
}
